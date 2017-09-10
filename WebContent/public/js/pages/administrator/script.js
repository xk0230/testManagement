var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.controller('UserListController',
	function UserListController($scope,$http){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getFinancingInfoList();
			//设置部门下拉框
			this.getDepList();
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getFinancingInfoList();
		};
		
		// 获取数据列表
		this.getFinancingInfoList = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/adminuser/getadminlist.do',
				params:{
					userName: $scope.userName,
					realName: $scope.realName,
					depId   : $scope.depId,
					position: $scope.postId,
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			}).then(function(res){
				if(res){
					self.list = res.data.data || [];
					$scope.totalItems = res.data.total
				}else{
					self.list = [];
					$scope.totalItems = 0
				}
			})
		};
		
		//获取部门
		self.getDepList = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/dep/getAlldep.do',
				params:{
				}
			}).then(function(res){
				if(res){
					self.deplist = res.data || [];
				}else{
					self.list = [];
				}
			})
		}
		
		//获取岗位
		self.getPostionById = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/position/getPositionByDepId.do',
				params:{
					depId: $scope.depId
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.postlistpostlist = [];
				}
			})
		}
		
		// 添加新用户
		this.addNewUser = function(id){
			window.location.href="/ccydManagement/admin/adminuser/toAddOrEditUser.do"; 
		};
		
		this.edit = function(id){
			window.location.href="/ccydManagement/admin/adminuser/toAddOrEditUser.do?id="+id; 
		};
	}
);


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
