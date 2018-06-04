var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker','ngSanitize'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('TravelDetailController',
	function travelListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 20;
//		self.travelItem.travelId = $location.search().travelId;

		$scope.travelId = GetQueryString("travelId");
		
		this.$onInit = function(){
			self.getTravelDetailTypeList();
			self.getDeparts();
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getTravelDetailList();
			//设置时间控件
			setDatepicker("datepickerS")
			setDatepicker("datepickerE")
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getTravelDetailList();
		};
		
		
		//出差详情分类查询
		this.getTravelDetailTypeList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/traveldetail/getTravelDetailType.do",
				params:{
				}
			}).then(function(res){
				if(res.data.code == 0){
					$scope.travelDetailTypeList = res.data.objData;
				}else{
					$scope.travelDetailTypeList = [];
				}
			});
		};
		$scope.costTypeChangeInList = function(item) {
			var costTypeValue = item.costType;
			if(costTypeValue == 0) {
				item.costSubTypeList = $scope.IncomeList;
			}else if (costTypeValue == 1){
				item.costSubTypeList = $scope.ExpensesList;
			}
			else{
				item.costSubTypeList = [];
			}
		};
		// 获取数据列表
		this.getTravelDetailList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/traveldetail/page.do',
				params:{
					travelId:$scope.travelId,
					type:$scope.travelDetailType,
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
				startTime:$filter('date')(new Date(), "yyyy-MM-dd")
				,createTime:$filter('date')(new Date(), "yyyy-MM-dd")
				,create_user:""
				,startPlace:""
				,endPlace:""
				,costNum:""
				,type:""
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
			var type;
			for(var i=0;i<$scope.travelDetailTypeList.length;i++){
				 if ($scope.travelDetailTypeList[i].name == travelItem.typeName){
				    	type = $scope.travelDetailTypeList[i].id;
				    	break;
				 };
			}
			travelItem.type = type;

		};
		
		self.updSucess = false;
		//点击保存
		this.save = function (travelItem) {
			self.updSucess = false;
			this.updateData(0);
		};
		
		//报废
		this.updateData = function (index) {
			if(index == self.list.length){
				if(self.updSucess){
					swal("保存成功！")
					self.getTravelDetailList();
					return;
				}else{
					swal("保存失败！")
					return;
				}
			}
			var travelItem = self.list[index];
			if(travelItem.editMode == "edit"){
				if(!travelItem.type){
					alert("请填写类型");
					return ;
				}
				if(!travelItem.startPlace){
					alert("请填写起始地");
					return ;
				}
				if(!travelItem.startTimeStr){
					alert("请填写时间");
					return ;
				}
				
				if(travelItem.costNum<0){
					alert("请填写金额");
					return ;
				}
				var params = {
					id:travelItem.id,
					travelId:$scope.travelId,
					createUser:travelItem.createUser,
					type:travelItem.type,
					startPlace:travelItem.startPlace,
					endPlace:travelItem.endPlace,
					startTime:$filter('date')(travelItem.startTimeStr, "yyyy-MM-dd"),
					costNum:travelItem.costNum,
					remark:travelItem.remark
				};
			
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/traveldetail/saveOrUpdate.do",
					params:params
				}).then(function(res){
					if(res.data.code == 0){
						self.updSucess = true;
					}else{
						self.updSucess = false;
					}
					self.updateData(index+1);
				});
			}else{
				self.updateData(index+1);
			}
		};
		
		//报废
		this.scrap = function (TravelItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该出差详情信息！", 
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
					url:$("#rootUrl").val()+"/traveldetail/deleteTravelDetail.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getTravelDetailList();
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
					url:$("#rootUrl").val()+"/traveldetail/deleteTravelDetail.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal("提交成功！");
						self.getTravelDetailList();
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
				var selectItem = {id : item.id, company:item.name};
				$uibModalInstance.close(selectItem);
			};

			$scope.cancel = function () {
				$uibModalInstance.dismiss('cancel');
			};
			
		});

angular.bootstrap(document.getElementById("content"), ['myApp']);