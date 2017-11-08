var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.controller('UserListController',
	function UserListController($scope,$http){
		var self = this;
		self.sessionUserId =$("#sessionUserId").val();
		
		this.$onInit = function(){
		}
		
		// 用户信息
		this.userInfo = function(id){
			window.location.href="/ccydManagement/admin/adminuser/toAddOrEditUser.do?id="+self.sessionUserId; 
		};
		// 添加岗位
		this.addPostion = function(id){
			window.location.href="/ccydManagement/admin/position/toPostionList.do?type=mypost&mode=add"; 
		};
		
		// 添加用户
		this.addUser = function(id){
			window.location.href="/ccydManagement/admin/adminuser/toAddOrEditUser.do"; 
		};
		// 用户列表
		this.userList = function(){
			window.location.href="/ccydManagement/admin/adminuser/toadminlist.do"; 
		};
		// 面试
		this.Recruitment = function(id){
			window.location.href="/ccydManagement/admin/recruit/Recruitment.do?type=''"; 
		};
		// 实时成本
		this.cost = function(id){
			window.location.href="/ccydManagement/admin/cost/chart.do"; 
		};
		// 新增成本
		this.addCost = function(id){
			window.location.href="/ccydManagement/admin/cost/manager.do?mode=add"; 
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);
