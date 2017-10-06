var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('IpeController',
	function ipeController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			
			self.getIpeList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getIpeList();
		};
		
		// 获取数据列表
		this.getIpeList = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/ipe/page.do',
				params:{
					userId:$('#userId').val(),
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
		
		
		this.editIpe = function (id, parentSelector) {
		    var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
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
		    	        items: function () {
		    	          return id;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	
		    	    	//ok的回调函数
		    	    	if(selectedItem == '0'){
		    	    		self.getIpeList();
		    	    	}
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
	}
);

//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, items) {
	  var $ctrl = this;
	  $ctrl.items = items;
	  $ctrl.ipe = {
				
			};
	  
	  this.$onInit = function(){
		  
		  $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/ipe/getIpeById.do?id="+items,
				params:{}
			}).then(function(res){
				
				if(res.data.code == 0){
					 $scope.ipe = res.data.objData;
				}
				
			});
		  
	  };
		
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  if(!$scope.ipe){
			  alert("请填写完整信息");
			  return ;
		  }
		  if(!$scope.ipe.workStatus){
			  alert("请填写阶段");
			  return ;
		  }
		  if(!$scope.ipe.yx){
			  alert("请选择影响");
			  return ;
		  }
		  if(!$scope.ipe.gx){
			  alert("请选择贡献");
			  return ;
		  }
		  if(!$scope.ipe.gt){
			  alert("请选择沟通");
			  return ;
		  }
		  if(!$scope.ipe.kj){
			  alert("请选择框架");
			  return ;
		  }
		  if(!$scope.ipe.cx){
			  alert("请选择创新");
			  return ;
		  }
		  if(!$scope.ipe.fzd){
			  alert("请选择复杂度");
			  return ;
		  }
		  
		  if(!$scope.ipe.zs){
			  alert("请选择知识");
			  return ;
		  }
		  if(!$scope.ipe.td){
			  alert("请选择团队");
			  return ;
		  }
		  if(!$scope.ipe.salary){
			  alert("请填写实际年薪");
			  return ;
		  }
		  
		 var params = {
				id:$scope.ipe.id,
				userId:$('#userId').val(),
				workStatus:$scope.ipe.workStatus,
				salary:$scope.ipe.salary,
				yx:$scope.ipe.yx,
				gx:$scope.ipe.gx,
				gt:$scope.ipe.gt,
				kj:$scope.ipe.kj,
				cx:$scope.ipe.cx,
				fzd:$scope.ipe.fzd,
				zs:$scope.ipe.zs,
				td:$scope.ipe.td
			} 
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/ipe/saveOrUpdate.do",
				params:params
			
			}).then(function(res){
				
				if(res.data.code == 0){
					$uibModalInstance.close('0');
				}
				
			});
	    
	  };

	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	  
	  
	  
	});


angular.bootstrap(document.getElementById("content"), ['myApp']);