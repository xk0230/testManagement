var myAppModule = angular.module("myApp",['ui.bootstrap'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('CostController',
	function costListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){

			$scope.costTypeList = [
				{costType : "0", name : "收入"},
				{costType : "1", name : "支出"}
			];
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getCostList();
			self.getCostViewChart();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getCostList();
		};
		
		// 获取数据列表
		this.getCostList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/viewPage.do',
				params:{
					costType:$scope.costType,
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
		
		// 获取数据列表
		this.getCostViewChart = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/viewChart.do',
				params:{
					costType:$scope.costType,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
				}
			}).then(function(res){
				if(res){
					var objData = res.data.objData;
					var inNum = parseFloat(0);
					var outNum = parseFloat(0);
					angular.forEach(objData, function(data,index,array){
						if(data.costType == "0"){
							inNum = parseFloat(data.costNum);
						}else{
							outNum = parseFloat(data.costNum);
						}
					});
					$scope.inPercent = inNum / (inNum + outNum) * 100;
					$scope.outPercent = inNum / (inNum + outNum) * 100;
					$scope.inStr = "收入：" + inNum;
					$scope.outStr = "支出：" + outNum;
					
					$scope.totalItems = res.data.total;
				}else{
					self.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		
		//点击编辑
		this.editCost = function (costItem) {
			costItem.editMode = "edit";
			costItem.costDate = new Date(costItem.costDate);
		};
		
		//点击保存
		this.save = function (costItem) {
			if(!costItem.costType){
				alert("请填写收支类型");
				return ;
			}
			if(!costItem.costDate){
				alert("请填写成本产生时间");
				return ;
			}
			if(!costItem.costNum){
				alert("请填写金额");
				return ;
			}
			
			var params = {
				costId:costItem.costId,
				costType:costItem.costType,
				costTime:$filter('date')(costItem.costDate, "yyyy-MM-dd"),
				createTime:$filter('date')(costItem.createDate, "yyyy-MM-dd hh:mm:ss"),
				costNum:costItem.costNum,
				remark:costItem.remark,
				status:costItem.status,
				cosDepList:JSON.stringify(self.list[0].costDepList),
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/adminUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getCostList();
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		//经理审核提交
		this.managerSubCost = function (costItem) {
			swal({ 
					title: "确定提交吗？", 
					text: "将提交给管理员审核！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"03"
					};
				self.updateStatus(params);
			});
		};

		//经理驳回
		this.managerRejCost = function (costItem) {
			swal({ 
					title: "确定驳回吗？", 
					text: "将驳回给申请者修改！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"02"
					};
				self.updateStatus(params);
			});
		};
		
		//管理员审核提交
		this.adminSubCost = function (costItem) {
			swal({ 
					title: "确定提交吗？", 
					text: "将通过审核并计入成本！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"05"
					};
				self.updateStatus(params);
			});
		};

		//管理员驳回
		this.adminRejCost = function (costItem) {
			swal({ 
					title: "确定驳回吗？", 
					text: "将驳回至部门经理！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"04"
					};
				self.updateStatus(params);
			});
		};
		
		//更新状态
		this.updateStatus = function (params) {
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/updateCostStatus.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					//重新加载列表
					self.getCostList();
				}else{
					swal(res.data.msg);
				}
			})
		};
		
		//报废
		this.scrap = function (costItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该成本信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"99"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/cost/updateCostStatus.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getCostList();
					}else{
						swal(res.data.msg);
					}
				})
			});
		};

	}
);


angular.bootstrap(document.getElementById("content"), ['myApp']);