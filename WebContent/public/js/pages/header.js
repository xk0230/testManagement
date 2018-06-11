var myAppModule2 = angular.module("headerApp",['ui.bootstrap']);
myAppModule2.controller('HeaderController',
	function HeaderController($scope,$http,$location,$document,$uibModal){
		var self = this;
		$scope.pageId = "";
		self.$onInit = function(){
		    var url = window.location.href;
		    
		    var lis = $('.mainnav li');
		    
		    var element = lis.find("a").filter(function() {
		        return this.href == url;
		    }).parents(".mainLi").addClass('active');
		}
		this.goDefault =  function () {
			window.location.href = "/ssc/admin/index.html";
		}

		this.ChangePwd = function (costId,parentSelector) {
			var parentElem = parentSelector ? angular.element($document[0].querySelector(parentSelector)) : undefined;
					var modalInstance = $uibModal.open({
					  animation: true,
					  ariaLabelledBy: 'modal-title',
					  ariaDescribedBy: 'modal-body',
					  templateUrl: 'myModalEditContent.html',
					  controller: 'ModalInstanceCtrl',
					  controllerAs: '$ctrl',
					  size: 'sm',
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
									url:"/ssc/logOut.do",
									params:{
									}
								
								}).then(function(res){
								});
						}
						
					}, function () {
						//取消的回调函数
						
					});
		   };
		   
		  this.addOc = function (id, parentSelector) {
				console.log("上传组织架构图")
			    var parentElem = parentSelector ? angular.element($document[0].querySelector(parentSelector)) : undefined;
			    	var modalInstance = $uibModal.open({
			    		  animation: true,
			    		  ariaLabelledBy: 'modal-title',
			    	      ariaDescribedBy: 'modal-body',
			    	      templateUrl: 'myOcEditContent.html',
			    	      controller: 'OcInstanceCtrl',
			    	      controllerAs: '$ctrl',
			    	      size: 'lg',
			    	      appendTo: parentElem,
			    	      //参数
			    	      resolve: {
			    	    	  //好像必须得这么写
			    	        id: function () {
			    	          return id;
			    	        }
			    	      }
			    	    });

			    	    modalInstance.result.then(function (selectedItem) {
			    	    	
			    	    	//ok的回调函数
//			    	    	if(selectedItem == '0'){
//			    	    		self.getAttachmentEntityPageList();
//			    	    	}
			    	    	
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
		
		  if($scope.oldPwd == '' || $scope.oldPwd == null){
			  alert("请输入原始密码！")
				return;
		  }
		  
		if($scope.newPwd1 != $scope.newPwd2){
			alert("两次输入的密码不一致！")
			return;
		}
		
		 $http({
				method:'POST',
				url:"/ssc/admin/adminuser/updatePasswd.do",
				params:{
					userId:$scope.userId,
					password:$scope.newPwd1,
					oldpsd:$scope.oldPwd
				}
			
			}).then(function(res){
				
				if(res.data.result){
					alert("密码修改成功！")
					$uibModalInstance.close('0');
				}else{
					alert(res.data.message)
				}
				
			});
	  };

	  $ctrl.cancel = function () {
		$uibModalInstance.dismiss('cancel');
	  };

	});


myAppModule2.controller('OcInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, userId) {
	  var $ctrl = this;
	  //用户名
	  $scope.userId = userId;
	  
	  this.$onInit = function(){
		
		if(userId != ''){
			
		}
	  };
		

	  $ctrl.ok = function () {
		  alert("上传成功")
	  };

	  $ctrl.cancel = function () {
		$uibModalInstance.dismiss('cancel');
	  };

	});