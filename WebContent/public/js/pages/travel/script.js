var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker','ngSanitize'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('TravelController',
	function travelListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 20;
		
		this.$onInit = function(){

			self.getDeparts();
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getTravelList();
			//设置时间控件
			setDatepicker("datepickerS")
			setDatepicker("datepickerE")
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getTravelList();
		};
		
		// 获取数据列表
		this.getTravelList = function(){
			console.log("查询啦");
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/travel/page.do',
				params:{
//					createUser:$scope.createUser,
					place:$scope.place,
					startDate:$filter('date')($scope.startDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.endDate, "yyyy-MM-dd"),
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			}).then(function(res){
				if(res){
					self.list = res.data.data || [];
					$scope.totalItems = res.data.total;
				}else{
					self.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		
		this.editPayment = function (item, parentSelector, mode) {
		    var parentElem = parentSelector ? angular.element($document[0].querySelector(parentSelector)) : undefined;
		    	    var modalInstance = $uibModal.open({
		    	      animation: true,
		    	      ariaLabelledBy: 'modal-title',
		    	      ariaDescribedBy: 'modal-body',
		    	      templateUrl: 'myModalEditContent.html',
		    	      controller: 'ModalInstanceCtrl',
		    	      controllerAs: '$ctrl',
		    	      size: 'lg',
		    	      appendTo: parentElem,
		    	      //参数
		    	      resolve: {
		    			//好像必须得这么写
		    	        item: function () {
		    	        	item.mode = mode;
		    	        	return item;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	item.mode = mode;
		    	    	item.company = selectedItem.company;
		    	    	item.companyid = selectedItem.id;
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };

		
		this.getDeparts = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/dep/getAlldep.do',
				params:{
				}
			
			}).then(function(res){
				if(res){
					$scope.depList = res.data || [];
				}else{
					$scope.depList = [];
				}
			});
			
			
		};
		
		//添加新申请
		this.addTravel = function(){
			var newItem = {
				startTime:new Date()
				,createTime:new Date()
				,create_user:""
				,place:""
				,dept:""
				,endTime:new Date()
				,remark:""	
				,editMode:"edit"
			};
			var myArray=new Array()
			myArray.push(newItem);
			
			$.each(self.list, function(index, value) {
				myArray.push(value);
			}
			);
			self.list = myArray;
		};
		
		//点击编辑
		this.editTravel = function (travelItem,index) {
			travelItem.editMode = "edit";
			//设置时间控件
			setDatepicker("datepicker" + index)
			var depid;
			for(var i=0;i<$scope.depList.length;i++){
				 if ($scope.depList[i].name == travelItem.dept){
				    	depid = $scope.depList[i].depId;
				    	break;
				 };
			}
			travelItem.dept = depid;

		};
		
		//查看出差详情
		this.toDetail = function (travelItem,index) {
			window.open("/ssc/traveldetail/traveldetailApply.do?travelId="+travelItem.id);  
		};
		
		//点击保存
		this.save = function (travelItem) {
			/*if(!travelItem.createUser){
				alert("请填写创建用户");
				return ;
			}*/
			if(!travelItem.place){
				alert("请填写出差地");
				return ;
			}
			if(!travelItem.depName){
				alert("请填写部门");
				return ;
			}
			if(!travelItem.startTime){
				alert("请填写开始时间");
				return ;
			}
			if(!travelItem.endTime){
				alert("请填写结束时间");
				return ;
			}
			if(!travelItem.remark){
				alert("请填写备注");
				return ;
			}
			/*	if(!travelItem.url){
				alert("请填写签订时间");
				return ;
			}
			if(!travelItem.serialid){
				alert("请填写外部订单号");
				return ;
			}
			if(!travelItem.remarks){
				alert("请填写备注");
				return ;
			}*/
			var params = {
				id:travelItem.id,
				createUser:travelItem.createUser,
				place:travelItem.place,
				depId:travelItem.depName,
				startTime:$filter('date')(travelItem.startTime, "yyyy-MM-dd"),
				endTime:$filter('date')(travelItem.endTime, "yyyy-MM-dd"),
				status:travelItem.status,
				remark:travelItem.remark
//				costTime:$filter('date')(travelItem.costDate, "yyyy-MM-dd")
//				createTime:$filter('date')(travelItem.createDate, "yyyy-MM-dd hh:mm:ss")
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/travel/saveOrUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getTravelList();
					//costItem.editMode="view";
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		//报废
		this.scrap = function (TravelItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该合同信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: true, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						id:TravelItem.id
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/travel/deleteTravel.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getTravelList();
						//costItem.editMode="view";
					}else{
						swal(res.data.msg);
					}
				})
			});
		};
		
		//提交
		this.submitTravel = function (travelItem) {
			swal({ 
					title: "确定提交吗？", 
					text: "将提交给您的部门领导审核！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						id:travelItem.id,
						status:"01"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/travel/deleteTravel.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal("提交成功！");
						self.getTravelList();
						//costItem.editMode="view";
					}else{
						swal("提交失败！");
					}
				})
			});
		};
		
	}
);

angular.module('myApp').controller('ModalInstanceCtrl',
		function ($scope,$http,$uibModalInstance,$filter, item){
			var $ctrl = this;
			$scope.item = item;
			$scope.totalItems = 0;
			$scope.currentPage = 1;
			$scope.itemsPerPage = 10;
			
			$ctrl.$onInit = function(){
				$scope.mode = item.mode;
				$scope.name = item.name;
				$ctrl.getTravelList();

			};
			
			$ctrl.setPage = function (pageNo) {
				$scope.currentPage = pageNo;
			};

			$ctrl.pageChanged = function() {
				$ctrl.getTravelList();
			};
			
			// 获取数据列表
			/*$ctrl.getTravelList = function(){
				console.log("查询啦");
				
				$http({
					method:'POST',
					url:$("#rootUrl").val()+'/payment/page.do',
					params:{
						place:$scope.place,
						start:(($scope.currentPage - 1) * $scope.itemsPerPage),
						end:$scope.currentPage * $scope.itemsPerPage -1
					}
				}).then(function(res){
					if(res){
						$scope.list = res.data.data || [];
						$scope.totalItems = res.data.total;
					}else{
						$scope.list = [];
						$scope.totalItems = 0;
					}
				});
			};*/
				
			$scope.Choose = function (item) {
				var selectItem = {id : item.id, company:item.name};
				$uibModalInstance.close(selectItem);
			};

			$scope.cancel = function () {
				$uibModalInstance.dismiss('cancel');
			};
			
		});

angular.bootstrap(document.getElementById("content"), ['myApp']);