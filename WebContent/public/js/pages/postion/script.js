var myAppModule = angular.module("myApp",['ui.bootstrap'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('PostionController',
	function costListController($scope,$http,$location,$uibModal,$document){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 50;
		
		this.$onInit = function(){
			$scope.type = $location.search().type;
			$scope.mode = $location.search().mode;
			self.getDeparts();
			self.statusList = [
				{status: "audited", statusName : "审批通过"},
				{status: "auditing", statusName : "审批中"},
				{status: "reject", statusName : "审批拒绝"}
				];
			self.resultList = [
				{result: 0, resultName : "未审批"},
				{result: 1, resultName : "已通过"},
				{result: -1, resultName : "已拒绝"}
				];
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.depId =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			
//			if($location.search().result == 0){
//				$scope.result = "0";
//				console.log("dddd");
//			}
			self.getList();
			if($scope.mode == 'add'){
				self.edit('', '.outlet');
			}
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
				var statusVal = $("#status").val();
				if($scope.type == "list"){
					statusVal = 'audited'
				}
				if($scope.mode == 'empty'){
					$scope.onlykq = true;
				}
				$http({
					method:'POST',
					url:$("#rootUrl").val()+'/admin/position/getPositionPageList.do',
					params:{
						name:$scope.name,
						depId:$scope.depId,
						status:statusVal,
						onlykq:$scope.onlykq,
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
						//参数
						resolve: {
							//好像必须得这么写
						items: function () {
							return id;
						}
					
						}
					});

					modalInstance.result.then(function (selectedItem) {
						self.getList();
					}, function () {
						//取消的回调函数
						
					});
					};
					
					this.auditReg = function (id, parentSelector) {
						var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
								var auditmodalInstance = $uibModal.open({
									animation: true,
									ariaLabelledBy: 'modal-title',
									ariaDescribedBy: 'modal-body',
									templateUrl: 'myAuditContent.html',
									controller: 'AuditModalInstanceCtrl',
									controllerAs: '$ctrl',
									size: 'lg',
									appendTo: parentElem,
									//参数
									resolve: {
										//好像必须得这么写
									items: function () {
										return id;
									}
								
									}
								});

								auditmodalInstance.result.then(function (selectedItem) {
									self.getList();
								}, function () {
									//取消的回调函数
								});
								};
								
		this.auditDetailReg = function (id, parentSelector) {
			var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
					var auditmodalInstance = $uibModal.open({
						animation: true,
						ariaLabelledBy: 'modal-title',
						ariaDescribedBy: 'modal-body',
						templateUrl: 'myAuditDetailContent.html',
						controller: 'AuditDetailModalInstanceCtrl',
						controllerAs: '$ctrl',
						size: 'lg',
						appendTo: parentElem,
						//参数
						resolve: {
							//好像必须得这么写
						items: function () {
							return id;
						}
					
						}
					});

					auditmodalInstance.result.then(function (selectedItem) {
					}, function () {
						//取消的回调函数
					});
					};
								
								
								
								
								
								
								
								
								
					
		this.delCost = function (costId,size) {

			
			
		};
		
		this.userList = function(id){
			window.location.href="/ssc/admin/adminuser/toadminlist.do?postId="+id; 
		};
		
		this.audit = function (id,result, parentSelector) {
			$http({
				method:'POST',
				url:'/ssc/admin/position/auditPosition.do',
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
			url:'/ssc/admin/position/saveOrUpdatePosition.do',
			params:{
				postId:$scope.costEntity.postId,
				name:$scope.costEntity.name,
				depId:$scope.costEntity.depId,
				onDuty:$scope.costEntity.onDuty,
				organization:$scope.costEntity.organization,
				vacancy:$scope.costEntity.vacancy,
				salaryScale:$scope.costEntity.salaryScale,
				recruitA:$scope.costEntity.recruitA,
				recruitB:$scope.costEntity.recruitB,
				recruitC:$scope.costEntity.recruitC,
				recruitD:$scope.costEntity.recruitD,
				recruitE:$scope.costEntity.recruitE,
				recruitF:$scope.costEntity.recruitF,
				
				education:$scope.costEntity.education,
				educationRemark:$scope.costEntity.educationRemark,
				professional:$scope.costEntity.professional
				
				
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
	/*	if(typeof($scope.costEntity.organization) == "undefined"){
			$scope.costEntity.organization = 0;
			}
			$scope.costEntity.vacancy = $scope.costEntity.onDuty - $scope.costEntity.organization;*/
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
		
	//获取岗位
		$ctrl.getPostionById = function(){
		$http({
			method:'POST',
			url:'/ssc/admin/position/getPositionByDepId.do',
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
		
		//日期模块加载
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




//驳回审批的control
angular.module('myApp').controller('AuditModalInstanceCtrl', function ($scope,$http,$uibModalInstance, items) {
		var $ctrl = this;
		$ctrl.id = items;
		$ctrl.auditEntity = {
			};

		$ctrl.okaudit = function () {
				console.log($ctrl.id);
				console.log($scope.auditEntity.remark);

				$http({
					method:'POST',
					url:'/ssc/admin/position/auditPosition.do',
					params:{
						positionAuditId:$ctrl.id,
						result:'-1',
						remark:$scope.auditEntity.remark
					}
				}).then(function(res){
					if(res.data.result == true){
						getNewsNum();
					}else{
						alert("操作失败 ");
					}
				})
				 var params = {
						id:$scope.auditEntity.id,
						remark:$scope.auditEntity.remark
					} 
					
				$uibModalInstance.close(params);
		};
		

		$ctrl.cancel = function () {
		$uibModalInstance.dismiss('cancel');
		};
		
	});



//驳回审批详情的control
angular.module('myApp').controller('AuditDetailModalInstanceCtrl', function ($scope,$http,$uibModalInstance, items) {
	var self = this;
	$scope.totalItems = 0;
	$scope.currentPage = 1;
	$scope.itemsPerPage = 10;
	this.$onInit = function(){
			self.getAuditList($ctrl.id);
	};
	
	this.getAuditList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/position/getPositionAuditDetailPageList.do',
				params:{
					postId:$ctrl.id,
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
	
	
	var $ctrl = this;
		$ctrl.id = items;
		$ctrl.auditEntity = {
			};
		$ctrl.ok = function () {
			$uibModalInstance.dismiss('cancel');
		};
		$ctrl.cancel = function () {
			$uibModalInstance.dismiss('cancel');
		};
		
		$scope.pageChanged = function() {
			self.getAuditList();
		};
		
		//页数变化
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};
		
	});

angular.bootstrap(document.getElementById("content"), ['myApp']);