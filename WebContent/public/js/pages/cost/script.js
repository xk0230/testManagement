﻿var myAppModule = angular.module("myApp",['ui.bootstrap'])
.controller('CostController',
	function costListController($scope,$http){
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
				url:'page.do',
				params:{
					depId:$scope.dep,
					costType:$scope.costType,
					costSubtypeId:$scope.costSubType,
					startDate:$("#costStartTime").val(),
					endDate:$("#costEndTime").val(),
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
		
		this.delCost = function(costId){
			
			 $("#dialog-confirm" ).dialog({
			      resizable: false,
			      height:170,
			      modal: true,
			      buttons: {
			        "确定": function() {
		        		$.post($("#rootUrl").val()+"/admin/cost/del/"+costId+".do",{},function(data){
		        			if(data.code == 0){
		        				self.getCostList();
		        				jAlert("删除成功");
		        			}
		    			});
		        		
			        	$( this ).dialog( "close" );
			        },
			        "取消": function() {
			        	$( this ).dialog( "close" );
			        }
			      }
			 
			  });
		};
		
		this.editCost = function(costId){
			
			$("#dialog-save" ).dialog({
			      resizable: false,
			      height:300,
			      width:350,
			      modal: true
			      
			      
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
			}else if (mode == 5){
				$scope.popup.opened5 = true;
			}else if (mode == 6){
				$scope.popup.opened6 = true;
			}else if (mode == 7){
				$scope.popup.opened7 = true;
			}else if (mode == 8){
				$scope.popup.opened8 = true;
			}else if (mode == 9){
				$scope.popup.opened9 = true;
			}else if (mode == 10){
				$scope.popup.opened10 = true;
			}
			
		};
	
		$scope.popup = {
			opened1: false,
			opened2: false,
			opened2: false,
			opened4: false,
			opened5: false,
			opened6: false,
			opened7: false,
			opened8: false,
			opened9: false,
			opened10: false,
		};
		
	}
);