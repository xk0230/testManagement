var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.controller('UserListController',
	function UserListController($scope,$http){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getFinancingInfoList();
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getFinancingInfoList();
		};
		
		// 获取数据列表
		this.getFinancingInfoList = function(){
			var userId = $("#sessionUserId").val();
			$http({
				method:'POST',
				url:'/ccydManagement/admin/candidate/getCandidateRInterviewerPageList.do',
				params:{
					interviewerId: userId,
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
		
		this.edit = function(id){
			window.location.href="/ccydManagement/admin/test/EditRecruitment.do?id="+id; 
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);