var myAppModule = angular.module("myApp",['ui.bootstrap'])
.controller('CostController',
	function costListController($scope,$http){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getCostList();
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getCostList();
		};
		
		// 获取数据列表
		this.getCostList = function(){
			$http({
				method:'POST',
				url:'page.do',
				params:{
					
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			
			}).then(function(res){
				if(res){
					self.list = res.data.data || [];
					$scope.totalItems = res.data.total
				}else{
					self.list = [];
					$scope.totalItems = 0
				}
			})
		}
	}
);