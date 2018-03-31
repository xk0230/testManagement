var myAppModule = angular.module("myApp",['ui.bootstrap','ngSanitize'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('ProjectController',
	function projectListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 20;
		
		this.$onInit = function(){

			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getProjectList();
			//设置时间控件
			setDatepicker("datepickerS")
			setDatepicker("datepickerE")
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getProjectList();
		};
		
		// 获取数据列表
		this.getProjectList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/project/page.do',
				params:{
					name:$scope.name,
					startTime:$scope.startTime,
					endTime:$scope.endTime,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
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
		
		this.editProject = function (item, parentSelector, mode) {
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
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		
		//添加新申请
		this.addProject = function(){
			var newItem = {
				costDate:new Date()
				,createDate:new Date()
				,name:""
				,startTime:new Date()
				,endTime:new Date()
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
		this.editProject = function (projectItem,index) {
			projectItem.editMode = "edit";
			setDatepicker("datepicker" + index)
		};
		
		//点击保存
		this.save = function (projectItem) {
			if(!projectItem.name){
				alert("请填写项目名");
				return ;
			}
			if(!projectItem.startTime){
				alert("请填写项目开始时间");
				return ;
			}
			if(!projectItem.endTime){
				alert("请填写项目结束时间");
				return ;
			}
			var params = {
				id:projectItem.id,
				name:projectItem.name,
				startTime:$filter('date')(projectItem.startTime, "yyyy-MM-dd"),
				endTime:$filter('date')(projectItem.endTime, "yyyy-MM-dd"),
//				costTime:$filter('date')(contractItem.costDate, "yyyy-MM-dd")
//				createTime:$filter('date')(contractItem.createDate, "yyyy-MM-dd hh:mm:ss")
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/project/saveOrUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getProjectList();
					//costItem.editMode="view";
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		//报废
		this.scrap = function (ProjectItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: true, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						id:ProjectItem.id
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/project/deleteProject.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getProjectList();
						//costItem.editMode="view";
					}else{
						swal(res.data.msg);
					}
				})
			});
		};
		
		//提交
		this.submitProject = function (projectItem) {
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
						id:projectItem.id,
						status:"01"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/project/deleteProject.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal("提交成功！");
						self.getProjectList();
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
				$ctrl.getPaymentList();

			};
			
			$ctrl.setPage = function (pageNo) {
				$scope.currentPage = pageNo;
			};

			$ctrl.pageChanged = function() {
				$ctrl.getPaymentList();
			};
			
			// 获取数据列表
			$ctrl.getPaymentList = function(){
				$http({
					method:'POST',
					url:$("#rootUrl").val()+'/payment/page.do',
					params:{
						name:$scope.company,
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
			};
				
			$scope.Choose = function (item) {
				var selectItem = {id : item.name, company:item.id};
				$uibModalInstance.close(selectItem);
			};

			$scope.cancel = function () {
				$uibModalInstance.dismiss('cancel');
			};
			
		});

angular.bootstrap(document.getElementById("content"), ['myApp']);