var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker'])

myAppModule.controller('TransferPositionController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getTransferPositionList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getTransferPositionList();
		};
		
		// 获取数据列表
		this.getTransferPositionList = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/transferPosition/page.do',
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
					angular.forEach(self.list, function(item, key) {
						item.editMode = 'view';
					});
					$scope.totalItems = res.data.total;
				}else{
					self.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		this.add = function(){
			var newItem = {
				id:"",
				editMode:"edit",
				transferTime:$filter('date')(new Date(), "yyyy-MM-dd"),
				remark:""
			};
			var myArray=new Array()
			myArray.push(newItem);
			
			$.each(self.list,
				function(index, value) {
					myArray.push(value);
				}
			);
			self.list = myArray;
		}
		
		this.save = function (item) {
			if(!item){
				swal("请填写完整信息");
				return ;
			}
			if(!item.postOld){
				swal("请填写调整前岗位");
				return ;
			}
			if(!item.postNew){
				swal("请填写调整后岗位");
				return ;
			}
			if(!item.salaryOld){
				swal("请填写调整前薪酬");
				return ;
			}
			if(!item.salaryNew){
				swal("请填写调整后薪酬");
				return ;
			}
			if(!item.transferTime){
				swal("请选择调整时间");
				return ;
			}
			var params = {
				id:item.id,
				postOld:item.postOld,
				postNew:item.postNew,
				salaryOld:item.salaryOld,
				salaryNew:item.salaryNew,
				transferTime:$filter('date')(item.transferTime, "yyyy-MM-dd"),
				remark:item.remark,
				userId:$('#userId').val()
			}; 
			 $http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/transferPosition/saveOrUpdate.do",
					params:params
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getTransferPositionList();
				}else{
					swal(res.data.msg);
				}
			});
			
		};
		
		//报废
		this.scrap = function (item) {
			swal({ 
					title: "确定删除吗？", 
					text: "你将无法恢复该数据！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/transferPosition/del/"+item.id+".do",
					params:{}
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getTransferPositionList();
					}else{
						swal(res.data.msg);
					}
				})
			});
			return false;
		};
		
		/*编辑*/
		this.edit = function(item){
			item.editMode = "edit"
			item.transferTime = $filter('date')(item.transferTime, "yyyy-MM-dd")
		}

		this.addTransferPosition = function (id, parentSelector) {
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
		    	    		self.getTransferPositionList();
		    	    	}
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		    	  
		   this.delTransferPosition = function (id, parentSelector) {
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
			    	    		self.getTransferPositionList();
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
	  $ctrl.transferPositionEntity = {
				
			};
	  
	  this.$onInit = function(){
		  
		  if(items != ''){
			  
			  $http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/transferPosition/get/"+items+".do",
					params:{
					}
				
				}).then(function(res){
					
					if(res.data.code == 0){
						
						$scope.transferPositionEntity = res.data.objData;
						
					}
				});
		  }
		  
	  };
		
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  
		  if(!$scope.transferPositionEntity){
			  alert("请填写完整信息");
			  return ;
		  }
		  if(!$scope.transferPositionEntity.postOld){
			  alert("请填写调整前部门");
			  return ;
		  }
		  if(!$scope.transferPositionEntity.postNew){
			  alert("请填写调整后部门");
			  return ;
		  }
		  if(!$scope.transferPositionEntity.salaryOld){
			  alert("请填写调整前薪酬");
			  return ;
		  }
		  if(!$scope.transferPositionEntity.salaryNew){
			  alert("请填写调整后薪酬");
			  return ;
		  }
		  if(!$scope.transferPositionEntity.transferTime){
			  alert("请选择调整时间");
			  return ;
		  }
		 var params = {
				id:$scope.transferPositionEntity.id,
				postOld:$scope.transferPositionEntity.postOld,
				postNew:$scope.transferPositionEntity.postNew,
				salaryOld:$scope.transferPositionEntity.salaryOld,
				salaryNew:$scope.transferPositionEntity.salaryNew,
				transferTime:$filter('date')($scope.transferPositionEntity.transferTime, "yyyy-MM-dd"),
				remark:$scope.transferPositionEntity.remark,
				userId:$('#userId').val()
			}; 
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/transferPosition/saveOrUpdate.do",
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
				url:$("#rootUrl").val()+"/admin/transferPosition/del/"+items+".do",
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