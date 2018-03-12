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
			self.getCostAuditList();

		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getCostList();
		};
		
		// 获取数据列表
		this.getCostAuditList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/auditPage.do',
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
				status:costItem.status
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/saveOrUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getCostAuditList();
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
					self.getCostAuditList();
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
						self.getCostAuditList();
					}else{
						swal(res.data.msg);
					}
				})
			});
		};
		
		
		
		
		
		
		
		
	}
);


angular.bootstrap(document.getElementById("content"), ['myApp']);