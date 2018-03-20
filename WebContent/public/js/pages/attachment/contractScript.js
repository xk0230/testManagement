var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('AttachmentController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			
			self.getAttachmentEntityPageList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getAttachmentEntityPageList();
		};
		
		// 获取数据列表
		this.getAttachmentEntityPageList = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/attachment/page.do',
				params:{
					fId:$("#contractId").val(),
					name:$scope.name,
					type:$scope.type,
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
		
		
		this.addAttachment = function (id, parentSelector) {
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
		    	        id: function () {
		    	          return id;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	
		    	    	//ok的回调函数
		    	    	if(selectedItem == '0'){
		    	    		self.getAttachmentEntityPageList();
		    	    	}
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		   
		 //报废
			this.scrap = function (id) {
				swal({ 
						title: "确定报废吗？", 
						text: "你将无法恢复该附近信息！", 
						type: "warning", 
						showCancelButton: true, 
						closeOnConfirm: true, 
						showLoaderOnConfirm: true, 
				},
				function(){ 
					var params = {
							id:id
						};
					$http({
						method:'POST',
						url:$("#rootUrl").val()+"/admin/attachment/del/"+id+".do",
						params:{}
						
					}).then(function(res){
						if(res.data.code == 0){
//							swal(res.data.msg);
							self.getAttachmentEntityPageList();
							//costItem.editMode="view";
						}else{
							swal(res.data.msg);
						}
					})
				});
			};

		    	  
		   this.delAttachment = function (id, parentSelector) {
			    var parentElem = parentSelector ? angular.element($document[0].querySelector(parentSelector)) : undefined;
			    	    var modalInstance = $uibModal.open({
			    	      animation: true,
			    	      ariaLabelledBy: 'modal-title',
			    	      ariaDescribedBy: 'modal-body',
			    	      templateUrl: 'myModalDelContent.html',
			    	      controller: 'ModalInstanceDel',
			    	      controllerAs: '$ctrl',
			    	      size: 'sm',
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
			    	    		self.getAttachmentEntityPageList();
			    	    	}
			    	    	
			    	    }, function () {
			    	    	//取消的回调函数
			    	    });
			   };
		
	}
);


//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, id) {
	  var $ctrl = this;
	  $scope.attachmentEntity = {
				id:''
			};
	  
	  this.$onInit = function(){
		  
		  if(id != ''){
			  $scope.attachmentEntity.id = id;
			  $http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/attachment/get/"+$scope.attachmentEntity.id+".do",
					params:{
					}
				
				}).then(function(res){
					
					if(res.data.code == 0){
						
						$scope.attachmentEntity = res.data.objData;
						
					}
				});
		  }
		  
	  };
		

	  $ctrl.ok = function () {
		  
		  if(!$scope.attachmentEntity){
			  alert("请填写完整信息");
			  return ;
		  }
		  if(!$scope.attachmentEntity.type){
			  alert("请填写类型");
			  return ;
		  }
		  
		 var fd = new FormData();
	     var file = document.querySelector('input[type=file]').files[0];
	     fd.append('uploadFile', file);
	     fd.append('fId', $('#contractId').val());
	     fd.append('type', $scope.attachmentEntity.type);
	     if($scope ){
	    	 fd.append('id',$scope.attachmentEntity.id);
	     }
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/attachment/saveOrUpdate.do",
				data: fd,
				headers: {'Content-Type':undefined},
			
			}).then(function(res){
				
				if(res.data.code == 0){
					$uibModalInstance.close('0');
				}
				
			});
	    
	  };

	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
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


//删除页面的control
angular.module('myApp').controller('ModalInstanceDel', 
		function ($scope,$http,$uibModalInstance,items) {
	  var $ctrl = this;
	  $ctrl.items = items;
	  
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/attachment/del/"+items+".do",
				params:{}
			
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