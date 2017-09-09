﻿var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('CostController',
	function costListController($scope,$http,$uibModal,$document){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getCostList();
			self.getDeparts();
			$scope.costTypeList = [
			                       {value : "0", name : "收入"},
			                       {value : "1", name : "支出"}
			                   ];
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
				$.post($("#rootUrl").val()+"/admin/cost/subType/"+costTypeValue+".do",{},function(data){
					if(data.code == 0){
						$scope.costSubTypeList = data.objData;
						$scope.$apply();
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
					startDate:$scope.costStartDate,
					endDate:$scope.costEndDate,
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
			
			$.post($("#rootUrl").val()+"/admin/dep/getAlldep.do",{},function(data){
				
				$scope.depList = data;
				
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
		
		
		this.editCost = function (costId, parentSelector) {
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
		    	          return costId;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	//ok的回调函数
		    	    	
		    	    	$.post($("#rootUrl").val()+"/admin/cost/saveOrUpdate.do",selectedItem,function(data){
		    					if(data.code == 0){
		    						self.getCostList();
		    					}
		    			});
		    			
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		    	  };
		    	  
		this.delCost = function (costId,size) {

			alert("删除");
			
        };
		
	}
);

//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', function ($scope,$uibModalInstance, items) {
	  var $ctrl = this;
	  $ctrl.items = items;
	  
	  this.$onInit = function(){
		  
		  var costEntity;
		  if(items != ''){
			  $.post($("#rootUrl").val()+"/admin/cost/get/"+items+".do",{},function(data){
					if(data.code == 0){
						costEntity = data.objData;
					}
			  });
			  
		  }
		
		  $ctrl.getDeparts();
		  
		  $scope.costTypeList = [
		                         {value : "0", name : "收入"},
		                         {value : "1", name : "支出"}
		                         ];
		  
	  };
		
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  
		 var params = {
				costId:'',
				depId:$scope.dep,
				costType:$scope.costType,
				costSubtypeId:$scope.costSubType,
				costTime:$scope.costDate,
				costNum:$scope.costNum
			} 
		  
	    $uibModalInstance.close(params);
	  };

	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	  
	  this.getDeparts = function(){
			$.post($("#rootUrl").val()+"/admin/dep/getAlldep.do",{},function(data){
				 $scope.depList = data;
			});
	  };
	  
	  $scope.costTypeChange = function() {
			
			var costTypeValue = $scope.costType;
			if(costTypeValue == 0 || costTypeValue == 1){
				$.post($("#rootUrl").val()+"/admin/cost/subType/"+costTypeValue+".do",{},function(data){
					if(data.code == 0){
						$scope.costSubTypeList = data.objData;
						$scope.$apply();
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