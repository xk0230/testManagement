var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 50;
		
		$scope.userId = "";
		
		this.$onInit = function(){
			$scope.type = $location.search().type;
			//查询操作
			self.search();
			//设置部门下拉框
			this.getDepList();
			//当前用户ID
			$scope.userId = $("#sessionUserId").val();
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.search();
		};
		
		this.search = function() {
			if($scope.type != "myApproval"){
				self.getFinancingInfoList();
			}else{
				self.getMyApprovalList();
			}
		};
		
		// 获取数据列表
		this.getFinancingInfoList = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/recruit/getRecruitPageList.do',
				params:{
					postid: $scope.postId,
					createUser: $("#sessionUserId").val(),
					status   : "",
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			}).then(function(res){
				if(res){
					self.list = res.data.data || [];
					angular.forEach(self.list, function(item, key) {
						item.editMode = 'view';
					});
					$scope.totalItems = res.data.total
				}else{
					self.list = [];
					$scope.totalItems = 0
				}
			})
		};
		
		// 获取待我审批的列表
		this.getMyApprovalList = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/recruit/getMyAuditRecruitPageList.do',
				params:{
					postid: $scope.postId,
					createUser: "",
					status   : "",
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
		
		//获取部门
		self.getDepList = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/dep/getAlldep.do',
				params:{
				}
			}).then(function(res){
				if(res){
					self.deplist = res.data || [];
				}else{
					self.list = [];
				}
			})
		}
		
		//获取岗位
		self.getPostionById = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/position/getPositionByDepId.do',
				params:{
					depId: $scope.depId
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.postlistpostlist = [];
				}
			})
		}
		
		// 添加新用户
		this.addNewRecruitment = function(){
			window.location.href="/ssc/admin/recruit/EditRecruitment.do"; 
		};
		
		this.edit = function(id){
			window.location.href="/ssc/admin/recruit/EditRecruitment.do?id="+id; 
		};
		this.evaluation = function(id){
			window.location.href="/ssc/admin/recruit/AdminEvaluation.do?id="+id; 
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);