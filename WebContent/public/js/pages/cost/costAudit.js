var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker'])
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
			$scope.costClassList = [
				{costClass : "0", name : "日常"},
				{costClass : "1", name : "合同"},
				{costClass : "2", name : "出差"}
			];
			
			$scope.auditStatusList = [
				{costType : "0", name : "未审核"},
				{costType : "1", name : "已审核"}
			];
			
			if($("#auditStatus").val() != null && $("#auditStatus").val()!= ''){
				$scope.auditStatus = $("#auditStatus").val();
			}
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getCostAuditList();
			//取成本分类
			this.getCostSubTypeList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getCostAuditList();
		};
		
		//收支类型变更
		$scope.costTypeChange = function() {
			var costTypeValue = $scope.costType;
			if(costTypeValue == 0) {
				$scope.costSubTypeList = $scope.IncomeList;
			}else if (costTypeValue == 1){
				$scope.costSubTypeList = $scope.ExpensesList;
			}
			else{
				$scope.costSubTypeList = [];
			}
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
		
		//成本分类查询
		this.getCostSubTypeList = function(){
			//收入
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/subType/0.do",
				params:{
				}
			}).then(function(res){
				if(res.data.code == 0){
					$scope.IncomeList = res.data.objData;
				}else{
					$scope.IncomeList = [];
				}
			});
			//支出
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/subType/1.do",
				params:{
				}
			}).then(function(res){
				if(res.data.code == 0){
					$scope.ExpensesList = res.data.objData;
				}else{
					$scope.ExpensesList = [];
				}
			});
		};
		
		// 获取数据列表
		this.getCostAuditList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/auditPage.do',
				params:{
					costType:$scope.costType,
					costSubtypeId:$scope.costSubtypeId,
					costNo:$scope.costNo,
					remark:$scope.remark,
					auditStatus:$scope.auditStatus,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			}).then(function(res){
				if(res){
					self.list = res.data.data || [];
					$scope.totalItems = res.data.total;
					angular.forEach(self.list, function(item, key) {
						$scope.costTypeChangeInList(item);
						item.checked = false;
					});
				}else{
					self.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		
		//点击编辑
		this.editCost = function (costItem,index) {
			costItem.editMode = "edit";
		};
		
		//点击保存
		this.save = function (costItem) {
			if(!costItem.costType){
				swal("错误提示", "请填写收支类型！", "warning")
				return ;
			}
			if(!costItem.costDate){
				swal("错误提示", "请填写成本产生时间！", "warning")
				return ;
			}
			if(!costItem.costSubtypeId){
				swal("错误提示", "请填写成本分类！", "warning")
				return ;
			}
			if(!costItem.costNum){
				swal("错误提示", "请填写金额！", "warning")
				return ;
			}
			var depList = costItem.costDepList;
			var sum = parseFloat(0);
			angular.forEach(depList, function(dep, key) {
				if (typeof(dep.costNum) == "undefined")
				{ 
					dep.costNum = parseFloat(0);
				}
				sum = sum + parseFloat(dep.costNum);
			});
			if(sum != parseFloat(costItem.costNum)){
				swal("错误提示", "各部门金额必须等于总金额！", "warning")
				return ;
			}
				
				
			var params = {
				costId:costItem.costId,
				costType:costItem.costType,
				costSubtypeId:costItem.costSubtypeId,
				costTime:$filter('date')(costItem.costDate, "yyyy-MM-dd"),
				createTime:$filter('date')(costItem.createDate, "yyyy-MM-dd hh:mm:ss"),
				costNum:costItem.costNum,
				remark:costItem.remark,
				status:costItem.status,
				cosDepList:JSON.stringify(costItem.costDepList),
				contractId:costItem.contractId,
				projectId:costItem.projectId
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/adminUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getCostAuditList();
				}else{
					swal(res.data.msg);
				}
			});
			return false;
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
		
		//经理批量审核提交
		this.managebatchSub = function () {
			swal({ 
					title: "确定提交吗？", 
					text: "将提交给管理员审核！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				angular.forEach(self.list, function(item, key) {
					if(item.checked){
						var params = {
								costId:item.costId,
								status:"03"
							};
						self.updateStatus(params);
					}
				});
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
		
		//经理批量驳回
		this.managebatchRej = function () {
			swal({ 
					title: "确定驳回吗？", 
					text: "将驳回给申请者修改！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				angular.forEach(self.list, function(item, key) {
					if(item.checked){
						var params = {
								costId:item.costId,
								status:"02"
							};
						self.updateStatus(params);
					}
				});
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
		
		//管理员批量审核提交
		this.batchSub = function () {
			swal({ 
					title: "确定提交吗？", 
					text: "将通过审核并计入成本！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				angular.forEach(self.list, function(item, key) {
					if(item.checked){
						var params = {
								costId:item.costId,
								status:"05"
							};
						self.updateStatus(params);
					}
				});
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
		
		//管理员批量驳回
		this.batchRej = function (costItem) {
			swal({ 
					title: "确定驳回吗？", 
					text: "将驳回至部门经理！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				angular.forEach(self.list, function(item, key) {
					if(item.checked){
						var params = {
								costId:item.costId,
								status:"04"
							};
						self.updateStatus(params);
					}
				});
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
			return false;
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
		    	    	
		    	    	item.contractId = selectedItem.contractId;
		    	    	item.contractContent = selectedItem.contractContent;
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		
			this.editProject = function (item, parentSelector, mode) {
			    var parentElem = parentSelector ? angular.element($document[0].querySelector(parentSelector)) : undefined;
			    	    var modalInstance = $uibModal.open({
			    	      animation: true,
			    	      ariaLabelledBy: 'modal-title',
			    	      ariaDescribedBy: 'modal-body',
			    	      templateUrl: 'myModalProjectContent.html',
			    	      controller: 'ModalProjectCtrl',
			    	      controllerAs: '$project',
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
			    	    	
			    	    	item.projectId = selectedItem.id;
			    	    	item.projectName = selectedItem.name;
			    	    	
			    	    }, function () {
			    	    	//取消的回调函数
			    	    	
			    	    });
			   };
		   
	}
);


//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, item) {
		var $ctrl = this;
		$scope.item = item;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 5;
		$ctrl.$onInit = function(){
			//合同号
			$scope.contractId = item.contractId;
			$scope.mode = item.mode;
			
			$ctrl.contractTypeList = [
				{contractType : "收入", name : "收入"},
				{contractType : "支出", name : "支出"}
			];
				
			$ctrl.getContractList();

		};
		
		$ctrl.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$ctrl.pageChanged = function() {
			$ctrl.getContractList();
		};
		
		// 获取数据列表
		$ctrl.getContractList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/contract/page.do',
				params:{
					contractType:$scope.contractType,
					content:$scope.content,
					contractId:$scope.contractId,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
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
		$ctrl.contractAttachmentList = function(id){
			window.open("/ssc/admin/attachment/contractManager.do?contractId="+id);  
		};
		
		$scope.Choose = function (item) {
			var selectItem = {contractId : item.contractId, contractContent : item.content};
			$uibModalInstance.close(selectItem);
		};
		$scope.ChooseNull = function (item) {
			var selectItem = {contractId : "", contractContent : ""};
			$uibModalInstance.close(selectItem);
		};
	
		$scope.cancel = function () {
			$uibModalInstance.dismiss('cancel');
		};

	});

//项目页面的control
angular.module('myApp').controller('ModalProjectCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, item) {
		var $project = this;
		var self = $project;
		$scope.item = item;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		$project.$onInit = function(){
			//合同号
			$scope.contractId = item.contractId;
			$scope.mode = item.mode;
				
			$project.getProjectList();

		};
		
		$project.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$project.pageChanged = function() {
			$project.getProjectList();
		};
		
		// 获取数据列表
		$project.getProjectList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/project/page.do',
				params:{
					pjNo:$scope.pjNo,
					name:$scope.name,
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
		
		$scope.Choose = function (item) {
			var selectItem = {id : item.pjNo, name : item.name};
			$uibModalInstance.close(selectItem);
		};
	
		$scope.cancel = function () {
			$uibModalInstance.dismiss('cancel');
		};

	});


angular.bootstrap(document.getElementById("content"), ['myApp']);