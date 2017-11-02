var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.controller('AdminUserTrianController',
	function UserListController($scope,$http){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){

			//查询
			self.getUserTrainList();
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getUserTrainList();
		};
		
		// 获取数据列表
		this.getUserTrainList = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/adminuser/getadminlist.do',
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
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);