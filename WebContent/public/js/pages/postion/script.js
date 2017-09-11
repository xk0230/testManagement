var myAppModule = angular.module("myApp",['ui.bootstrap'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('PostionController',
	function costListController($scope,$http,$location,$uibModal,$document){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			$scope.type = $location.search().type;
			self.getDeparts();
			self.statusList = [
				{status: "audited", statusName : "审批完成"},
				{status: "auditing", statusName : "审批中"},
				{status: "reject", statusName : "审批拒绝"}
				];
			self.resultList = [
				{result: 0, resultName : "未审批"},
				{result: 1, resultName : "已通过"},
				{result: -1, resultName : "已拒绝"}
				];
//			if($location.search().result == 0){
//				$scope.result = "0";
//				console.log("dddd");
//			}
				self.getList();
		};
		
		//页数变化
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};
		
		//换页
		$scope.pageChanged = function() {
			self.getList();
		};
		
		// 获取数据列表
		this.getList = function(){
//			var type = $("#type").val();
			if($scope.type == "audit"){
				//如果是审批
				$http({
					method:'POST',
					url:$("#rootUrl").val()+'/admin/position/getPositionAuditPageList.do',
					params:{
						'audit.postName':$scope.name,
						depId:$scope.depId,
						'audit.result':$("#result").val(),
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
			}else{
				$http({
					method:'POST',
					url:$("#rootUrl").val()+'/admin/position/getPositionPageList.do',
					params:{
						name:$scope.name,
						depId:$scope.depId,
						status:$("#status").val(),
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
			}
		};
		
		//获取部门下拉框
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
		//编辑岗位
		this.edit = function (id, parentSelector) {
			var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
					var modalInstance = $uibModal.open({
						animation: true,
						ariaLabelledBy: 'modal-title',
						ariaDescribedBy: 'modal-body',
						templateUrl: 'myModalContent.html',
						controller: 'ModalInstanceCtrl',
						controllerAs: '$ctrl',
						size: 'lg',
						appendTo: parentElem,
						resolve: {
						items: function () {
							return id;
						}
					
						}
					});

					modalInstance.result.then(function (selectedItem) {
						self.getList();
					}, function () {
						
					});
					};
					
		this.delCost = function (costId,size) {

			
			
		};
		
		this.audit = function (id,result, parentSelector) {
			$http({
				method:'POST',
				url:'/ccydManagement/admin/position/auditPosition.do',
				params:{
					positionAuditId:id,
					result:result
				}
			}).then(function(res){
				if(res.data.result == true){
					if(result == 1){
						alert("通过成功");
					}else{
						alert("驳回成功");
					}
					self.getList();
					getNewsNum();
				}else{
					alert("操作失败 ");
				}
			})
		};
		
	}
);

//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', function ($scope,$http,$uibModalInstance, items) {
		var $ctrl = this;
		$ctrl.id = items;
		$ctrl.costEntity = {
			};
		
		$ctrl.$onInit = function(){
			
			if($ctrl.id != ''){
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/position/getPositionById.do",
					params:{
						id:$ctrl.id
					}
				
				}).then(function(res){
					if(res.status){
						$scope.costEntity = res.data;
					}
					
				}).catch(function(res){
					if(res.data.code == 0){
						$scope.costEntity = res.data.objData;
					}
					
				});
			}
		
			$ctrl.getDeparts();
			
		};

		$ctrl.ok = function () {

		$http({
			method:'POST',
			url:'/ccydManagement/admin/position/saveOrUpdatePosition.do',
			params:{
				postId:$scope.costEntity.postId,
				name:$scope.costEntity.name,
				depId:$scope.costEntity.depId,
				onDuty:$scope.costEntity.onDuty,
				organization:$scope.costEntity.organization,
				vacancy:$scope.costEntity.vacancy
			}
		}).then(function(res){
			if(res){
				self.postlist = res.data || [];
			}else{
				self.list = [];
			}
		})
		
		 var params = {
				postId:$scope.costEntity.postId,
				name:$scope.costEntity.name,
				depId:$scope.costEntity.depId,
				result:$scope.costEntity.result,
				status:$scope.costEntity.status,
				onDuty:$scope.costEntity.onDuty,
				organization:$scope.costEntity.organization,
				vacancy:$scope.costEntity.vacancy
			} 
			
		$uibModalInstance.close(params);
		};
		
		
		//计算空缺人数
		$ctrl.cau = function () {
		if(typeof($scope.costEntity.organization) == "undefined"){
			$scope.costEntity.organization = 0;
			}
			$scope.costEntity.vacancy = $scope.costEntity.onDuty - $scope.costEntity.organization;
		};
		
		

		$ctrl.cancel = function () {
		$uibModalInstance.dismiss('cancel');
		};
		
		$ctrl.getDeparts = function(){
			
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
		
		$ctrl.getPostionById = function(){
		$http({
			method:'POST',
			url:'/ccydManagement/admin/position/getPositionByDepId.do',
			params:{
				depId: $scope.costEntity.depId
			}
		}).then(function(res){
			if(res){
				$ctrl.postlist = res.data || [];
			}else{
				$ctrl.postlist = [];
			}
		})
	}
		
		$scope.costTypeChange = function() {
			
			var costTypeValue = $scope.costType;
			if(costTypeValue == 0 || costTypeValue == 1){
				
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/cost/subType/"+costTypeValue+".do",
					params:{
					}
				
				}).then(function(res){
					
					if(res.data.code == 0){
						$scope.costSubTypeList = res.data.objData;
					}else{
						$scope.costSubTypeList = [];
					}
					
				});
				
			}else{
				$scope.costSubTypeList = [];
			}
			
		};
		
		$scope.today = function() {
			$scope.dt = new Date();
		};
		$scope.clear = function() {
			$scope.dt = null;
		};

		$scope.dateOptions = {
			dateDisabled: "",
			formatYear: 'yyyy',
			maxDate: new Date(9999, 12, 31),
			minDate: new Date(1000, 1,1),
			startingDay: 1,
		};

		$scope.open = function(mode) {
			if(mode == 1){
				$scope.popup.opened1 = true;
			}else if (mode == 2){
				$scope.popup.opened2 = true;
			}else if (mode == 3){
				$scope.popup.opened3 = true;
			}else if (mode == 4){
				$scope.popup.opened4 = true;
			}
			
		};
	
		$scope.popup = {
			opened1: false,
			opened2: false,
			opened3: false,
			opened4: false
		};
		
	});

//Header
myAppModule.controller('HeaderController',
function HeaderController($scope,$http,$location,$uibModal,$document){
		this.ChangePassWord = function (parentSelector) {
			var userId = $("#sessionUserId").val();
			var parentElem = parentSelector ? angular.element($document[0].querySelector( parentSelector)) : undefined;
					var modalInstance = $uibModal.open({
					  animation: true,
					  ariaLabelledBy: 'modal-title',
					  ariaDescribedBy: 'modal-body',
					  templateUrl: 'ChangePassword.html',
					  controller: 'ChangePasswordCtrl',
					  controllerAs: '$ctrl',
					  size: 'xs',
					  appendTo: parentElem,
					  //参数
					  resolve: {
		    	    	  //好像必须得这么写
			    	        items: function () {
			    	          return userId;
			    	        }
					  }
					});

					modalInstance.result.then(function (selectedItem) {
						
						
					}, function () {
						//取消的回调函数
					});
		   };
		
	}
);

//修改密码
angular.module('myApp').controller('ChangePasswordCtrl', 
	function ($scope,$http,$uibModalInstance,items) {
		var $ctrl = this;
		$ctrl.items = items;
		$ctrl.ok = function () {
			$http({
					method:'POST',
					url:"/ccydManagement/admin/adminuser/updatePasswd.do",
					params:{
						userId:items,
						password:$scope.newPwd
					}
				}).then(function(res){
					
					if(res.data.result){
						$ctrl.logOut();
						//$uibModalInstance.close('0');
					}else{
						//提示失败
					}
					
				});
		};

		$ctrl.logOut = function () {
			$http({
				method:'POST',
				url:"/ccydManagement/logOut.do",
				params:{
				}
			}).then(function(res){
				
			});
		};
		
		$ctrl.cancel = function () {
			$uibModalInstance.dismiss('cancel');
		};
	});
