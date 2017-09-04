var myAppModule = angular.module("myApp",[])
.controller('CostController',
	function UserListController($scope,$http){
		var self = this;
		
		this.$onInit = function(){
			self.getFinancingInfoList();
		}
		
		// 默认分页参数对象
		this.pages = {
			totalCount : 0,
			currentPage : 1,
			recordNumber : 10
		}
		// 分页操作发生变化时
		$scope.$on('currentPageChange',function(evt,page){
			self.getFinancingInfoList();
		});
		
		// 获取数据列表
		this.getFinancingInfoList = function(){
			alert($scope.userName + $scope.realName + $scope.contact +$scope.position +$scope.state)
			$http({
				method:'POST',
				url:'${root}/admin/adminuser/getadminlist.do',
				data:JSON.stringify({
					'userName': $scope.userName,
					'realName': $scope.realName,
					'contact': $scope.contact,
					'position': $scope.position,
					'state': $scope.state
				})
			}).then(function(res){
				if(res){
					self.list = res.data.data || [];
					self.pages.totalCount = res.data.totalCount || 0;
				}else{
					self.list = [];
					self.pages.totalCount = 0;
				}
			})
		}
		
	}
);