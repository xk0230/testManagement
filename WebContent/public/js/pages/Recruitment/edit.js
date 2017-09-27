var myAppModule = angular.module("myApp",['ui.bootstrap','jcs-autoValidate']);
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location, $filter){
		var self = this;

		self.$onInit = function(){
			//设置部门下拉框
			this.getDepList();
			//设置胜任特征
			this.getAllCompetency();
			//获取用户ID
			//self.user.userId = $location.search().id;
		}
		
		self.Recruitment = {
				postid:"",
				recruitA:"",
				recruitB :"",
				recruitC :"",
				recruitD :"",
				recruitE :"",
				recruitF :"",
				education :"",
				educationRemark :"",
				professional:""
		}
		
		//获取部门
		self.getDepList = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/dep/getAlldep.do',
				params:{
				}
			}).then(function(res){
				if(res){
					self.deplist = res.data || [];
				}else{
					self.deplist = [];
				}
			})
		}
		
		//获取全部胜任特征
		self.getAllCompetency = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/recruit/getAllCompetency.do',
				params:{
				}
			}).then(function(res){
				if(res){
					self.AllCompetency = res.data || [];
				}else{
					self.AllCompetency = [];
				}
			})
		}

		//获取部门下岗位
		self.getPostionByDepId = function(){
			//获取部门岗位
			$http({
				method:'POST',
				url:'/ccydManagement/admin/position/getPositionByDepId.do',
				params:{
					depId: $scope.depId
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.postlist = [];
				}
			})
		}
		
		//获取岗位详情
		self.getPostionInfo = function(){
			//获取部门岗位
			$http({
				method:'POST',
				url:'/ccydManagement/admin/position/getPositionById.do',
				params:{
					id: $scope.postId
				}
			}).then(function(res){
				if(res){
					self.Recruitment.recruitA = res.data.recruitA;
					self.Recruitment.recruitB = res.data.recruitB;
					self.Recruitment.recruitC = res.data.recruitC;
					self.Recruitment.recruitD = res.data.recruitD;
					self.Recruitment.recruitE = res.data.recruitE;
					self.Recruitment.recruitF = res.data.recruitF;
				}else{
					
				}
			})
		}
		self.onSubmit = function(){
			var push = Array.prototype.push;

			var CompetencyList = $(".Competency");
			var par = "";
			$.each(CompetencyList,function(n,value) {  
				if(value.checked){
					par = par + value.value + "@";
				}
		    });  
			if(par.length > 1){
				par = par.substring(0,par.length -1)
			}
			
			$http({
				method:'POST',
				url:'/ccydManagement/admin/recruit/saveOrUpdateRecruit.do',
				params:{
					id               : $scope.vm.Recruitment.id             , 
					postid           : $scope.vm.Recruitment.postid         , 
					education        : $scope.vm.Recruitment.education      , 
					createUser       : $scope.vm.Recruitment.createUser     , 
					recruitA         : $scope.vm.Recruitment.recruitA       , 
					recruitB         : $scope.vm.Recruitment.recruitB       , 
					recruitC         : $scope.vm.Recruitment.recruitC       , 
					recruitD         : $scope.vm.Recruitment.recruitD       , 
					recruitE         : $scope.vm.Recruitment.recruitE       , 
					recruitF         : $scope.vm.Recruitment.recruitF       , 
					educationRemark  : $scope.vm.Recruitment.educationRemark, 
					professional     : $scope.vm.Recruitment.professional   ,
					competencysStr   : par
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.postlist = [];
				}
			})
		}
		
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);