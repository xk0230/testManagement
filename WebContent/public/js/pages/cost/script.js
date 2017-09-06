var myAppModule = angular.module("myApp",['ui.bootstrap'])
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
		
	}
);