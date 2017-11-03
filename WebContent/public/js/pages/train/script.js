var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('AdminUserTrianController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			
			self.getTrainList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getTrainList();
		};
		
		// 获取数据列表
		this.getTrainList = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/train/page.do',
				params:{
					userId:$("#userId").val(),
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
		
		
		this.addTrain = function (id, parentSelector) {
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
		    	    		self.getTrainList();
		    	    	}
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		    	  
		   this.delTrain= function (id, parentSelector) {
			    var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
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
			    	    		self.getTrainList();
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
	  $ctrl.trainEntity = {
				
			};
	  
	  this.$onInit = function(){
		  
		  if(items != ''){
			  
			  $http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/train/get/"+items+".do",
					params:{
					}
				
				}).then(function(res){
					
					if(res.data.code == 0){
						
						$scope.trainEntity = res.data.objData;
						
					}
				});
		  }
		  
	  };
		
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  
		  if(!$scope.trainEntity){
			  alert("请填写完整信息");
			  return ;
		  }
		  if(!$scope.trainEntity.project){
			  alert("请填写培训项目");
			  return ;
		  }
		  if(!$scope.trainEntity.place){
			  alert("请填写培训地点");
			  return ;
		  }
		  if(!$scope.trainEntity.form){
			  alert("请填写培训形式");
			  return ;
		  }
		  if(!$scope.trainEntity.result){
			  alert("请填写培训结果");
			  return ;
		  }
		  if(!$scope.trainEntity.trainTime){
			  alert("请选择培训时间");
			  return ;
		  }
		 var params = {
				id:$scope.trainEntity.id,
				project:$scope.trainEntity.project,
				place:$scope.trainEntity.place,
				form:$scope.trainEntity.form,
				result:$scope.trainEntity.result,
				trainTime:$filter('date')($scope.trainEntity.trainTime, "yyyy-MM-dd"),
				userId:$('#userId').val()
			}; 
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/train/saveOrUpdate.do",
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
				url:$("#rootUrl").val()+"/admin/train/del/"+items+".do",
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