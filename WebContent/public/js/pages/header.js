var myAppModule2 = angular.module("headerApp",['ui.bootstrap']);
myAppModule2.controller('HeaderController',
	function HeaderController($scope,$http,$location,$document,$uibModal){
		var self = this;
		$scope.pageId = "";
		self.$onInit = function(){
		}
		
		this.ChangePwd = function (costId,parentSelector) {
			var parentElem = parentSelector ? angular.element($document[0].querySelector('#header ' + parentSelector)) : undefined;
					var modalInstance = $uibModal.open({
					  animation: true,
					  ariaLabelledBy: 'modal-title',
					  ariaDescribedBy: 'modal-body',
					  templateUrl: 'myModalEditContent.html',
					  controller: 'ModalInstanceCtrl',
					  controllerAs: '$ctrl',
					  size: 'modal-sm',
					  appendTo: parentElem,
					  //参数
					  resolve: {
						  //好像必须得这么写
						  userId: function () {
						  return costId;
						}
					  }
					});

					modalInstance.result.then(function (selectedItem) {
						//ok的回调函数
						if(selectedItem == '0'){
							//登出
							 $http({
									method:'POST',
									url:"/ccydManagement/logOut.do",
									params:{
									}
								
								}).then(function(res){
								});
						}
						
					}, function () {
						//取消的回调函数
						
					});
		   };
	}
);
//编辑页面的control
myAppModule2.controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, userId) {
	  var $ctrl = this;
	  //用户名
	  $scope.userId = userId;
	  
	  this.$onInit = function(){
		
		if(userId != ''){
			
		}
	  };
		

	  $ctrl.ok = function () {
		
		if($scope.newPwd1 != $scope.newPwd2){
			alert("两次输入的密码不一致！")
			return;
		}
		
		 $http({
				method:'POST',
				url:"/ccydManagement/admin/adminuser/updatePasswd.do",
				params:{
					userId:$scope.userId,
					password:$scope.newPwd1
				}
			
			}).then(function(res){
				
				if(res.data.result){
					alert("密码修改成功！")
					$uibModalInstance.close('0');
				}
				
			});
	  };

	  $ctrl.cancel = function () {
		$uibModalInstance.dismiss('cancel');
	  };

	});