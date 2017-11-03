var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('CostController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getDeparts();
			$scope.costTypeList = [
				{costType : "0", name : "收入"},
				{costType : "1", name : "支出"}
			];
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getCostList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getCostList();
		};
		
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
		
		// 获取数据列表
		this.getCostList = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/page.do',
				params:{
					depId:$scope.dep,
					costType:$scope.costType,
					costSubtypeId:$scope.costSubType,
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
		
		this.addCost = function(costId, parentSelector){
			var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
    	    var modalInstance = $uibModal.open({
    	      animation: true,
    	      ariaLabelledBy: 'modal-title',
    	      ariaDescribedBy: 'modal-body',
    	      templateUrl: 'myModalAddContent.html',
    	      controller: 'ModalAddInstanceCtrl',
    	      controllerAs: '$ctrl',
    	      size: 'lg',
    	      appendTo: parentElem,
    	      //参数
    	      resolve: {
    	    	  //好像必须得这么写
    	        items: function () {
    	          return costId;
    	        }
    	      }
    	    });

    	    modalInstance.result.then(function (selectedItem) {
    	    	//ok的回调函数
    	    	if(selectedItem == '0'){
    	    		self.getCostList();
    	    	}
    	    	
    	    }, function () {
    	    	//取消的回调函数
    	    });
		};
		
		
		this.editCost = function (costId, parentSelector) {
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
		    	          return costId;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	
		    	    	//ok的回调函数
		    	    	if(selectedItem == '0'){
		    	    		self.getCostList();
		    	    	}
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		    	  
		   this.delCost = function (costId, parentSelector) {
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
			    	          return costId;
			    	        }
			    	      }
			    	    });

			    	    modalInstance.result.then(function (selectedItem) {
			    	    	
			    	    	//ok的回调函数
			    	    	if(selectedItem == '0'){
			    	    		self.getCostList();
			    	    	}
			    	    	
			    	    }, function () {
			    	    	//取消的回调函数
			    	    });
			   };
		
	}
);

//添加页面的control
angular.module('myApp').controller('ModalAddInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, items) {
	
	var $ctrl = this;
	
	this.$onInit = function(){
		 $ctrl.getDeparts();
	};
	
	this.getDeparts = function(){
		
		$http({
			method:'POST',
			url:$("#rootUrl").val()+'/admin/dep/getAlldep.do',
			params:{
			}
		
		}).then(function(res){
			if(res){
				var depList = res.data;
				var html = "";
				for(var i = 0;i<depList.length;i++){
					
					if(i % 2 == 0){
						if(html != ''){
							html += '</div>';
						}
						
						html += '<div class="form-group">';
					}
					
					html += '<div class="col-lg-6">';
					html += '<label class="col-lg-4 control-label">';
					html += depList[i].name;
					html += '-金额</label>';
					html += '<div class="col-lg-8">';
					html += '<input type="hidden" name="depIds" class="form-control" value="'+depList[i].depId+'"/>';
					html += '<input type="text" name="depNums" class="form-control" />';
					html += '</div></div>';
					
				}
				
				html += '</div>';
				
				html += '<div class="form-group">';
				html += '<div class="col-lg-6">';
				html += '<label class="col-lg-4 control-label">成本详情</label>';
				html += '<div class="col-lg-8">';
				html += '<textarea class="form-control" id="remark" rows="3" Placeholder="请输入成本详情"></textarea>';
				html += '</div></div></div>';
				
				$('#addDepNum').append(html);
			}
		});
		
	};
	
	$scope.costTypeChange = function() {
		
		var costTypeValue = $scope.costEntity.costType;
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
	
	$ctrl.ok = function () {
		  if(!$scope.costEntity){
			  alert("请填写完整信息");
			  return ;
		  }
		  
		  if(!$scope.costEntity.costType){
			  alert("请填写收支类型");
			  return ;
		  }
		  if(!$scope.costEntity.costSubtypeId){
			  alert("请填写分类名称");
			  return ;
		  }
		  if(!$scope.costEntity.costTime){
			  alert("请填写成本产生时间");
			  return ;
		  }
		  
		  var depId = "";
		  var depAmount = "";
		  
		  var depIdList = $("input[name='depIds']");
		  var depNumList = $("input[name='depNums']");
		  for(var i = 0;i<depNumList.length;i++){
			  var depVal = depNumList[i].value;
			  if(!(depVal == "" || depVal.trim() == "")){
				  depId = depId + depIdList[i].value +",";
				  depAmount = depAmount + depVal +",";
			  }
		  }
		  
		  if(depAmount == ""){
			  alert("至少填写一个部门金额");
			  return ;
		  }
		  
		 var params = {
				depId:depId,
				costType:$scope.costEntity.costType,
				costSubtypeId:$scope.costEntity.costSubtypeId,
				costTime:$filter('date')($scope.costEntity.costTime, "yyyy-MM-dd"),
				depAmount:depAmount,
				remark:$('#remark').val()
			};
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/saveOrUpdate.do",
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

//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, items) {
	  var $ctrl = this;
	  $ctrl.items = items;
	  $ctrl.costEntity = {
				
			};
	  
	  this.$onInit = function(){
		  
		  if(items != ''){
			  
			  $http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/cost/get/"+items+".do",
					params:{
					}
				
				}).then(function(res){
					
					if(res.data.code == 0){
						
						$scope.costEntity = res.data.objData;
						
						$http({
							method:'POST',
							url:$("#rootUrl").val()+"/admin/cost/subType/"+res.data.objData.costType+".do",
							params:{
							}
						
						}).then(function(res){
							
							if(res.data.code == 0){
								$scope.costSubTypeList = res.data.objData;
							}else{
								$scope.costSubTypeList = [];
							}
							
						});
					}
				});
		  }
		
		  $ctrl.getDeparts();
		  
	  };
		
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  
		  if(!$scope.costEntity){
			  alert("请填写完整信息");
			  return ;
		  }
		  if(!$scope.costEntity.depId){
			  alert("请填写所属部门");
			  return ;
		  }
		  if(!$scope.costEntity.costType){
			  alert("请填写收支类型");
			  return ;
		  }
		  if(!$scope.costEntity.costSubtypeId){
			  alert("请填写分类名称");
			  return ;
		  }
		  if(!$scope.costEntity.costTime){
			  alert("请填写成本产生时间");
			  return ;
		  }
		  if(!$scope.costEntity.costNum){
			  alert("请填写金额");
			  return ;
		  }
		 var params = {
				costId:$scope.costEntity.costId,
				depId:$scope.costEntity.depId,
				costType:$scope.costEntity.costType,
				costSubtypeId:$scope.costEntity.costSubtypeId,
				costTime:$filter('date')($scope.costEntity.costTime, "yyyy-MM-dd"),
				costNum:$scope.costEntity.costNum,
				remark:$scope.costEntity.remark
			}; 
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/saveOrUpdate.do",
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
	  
	  $scope.costTypeChange = function() {
			
			var costTypeValue = $scope.costEntity.costType;
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
				url:$("#rootUrl").val()+"/admin/cost/del/"+items+".do",
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