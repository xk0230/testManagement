var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('IpeController',
	function ipeController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		
		self.ipe = {
				
				};
		
		this.$onInit = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/ipe/getIpeById.do?id=",
				params:{}
			}).then(function(res){
				
				if(res.data.code == 0){
					 $scope.ipe = res.data.objData;
				}
				
			});
			
		};
		
		this.calIpe = function() {
			
			var flag = true;
			if(!$scope.ipe.score1){
				 flag = false;
			}
			if(!$scope.ipe.score2){
				 flag = false;
			}
			if(!$scope.ipe.score3){
				 flag = false;
			}
			if(!$scope.ipe.score4){
				 flag = false;
			}
			
			if(flag){
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/ipe/calIpe.do",
					params:{
						score1:$scope.ipe.score1,
						score2:$scope.ipe.score2,
						score3:$scope.ipe.score3,
						score4:$scope.ipe.score4
					}
				}).then(function(res){
					$scope.ipe.pc = res.data.pc;
					$scope.ipe.adviseSalary = res.data.adviseSalary;
					$scope.ipe.totalScore = res.data.totalScore;
				});
				
			}
			
			
		};
		
		$scope.yxAndGxChange = function() {
			
			var flag = true;
			if(!$scope.ipe.org){
				  flag = false;
			}
			if(!$scope.ipe.yx){
				  flag = false;
			}
			if(!$scope.ipe.gx){
				  flag = false;
			}
			
			if(flag){
				
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/ipe/alYxAndOrg.do",
					params:{
						org:$scope.ipe.org,
						yx:$scope.ipe.yx,
						gx:$scope.ipe.gx
					}
				}).then(function(res){
					$scope.ipe.score1 = res.data;
					
					self.calIpe();
				});
				
			}else{
				$scope.ipe.score1 = "";
			}
			
		};
		
		
		$scope.gtAndKjChange = function() {
			
			var flag = true;
			if(!$scope.ipe.gt){
				  flag = false;
			}
			if(!$scope.ipe.kj){
				  flag = false;
			}
			
			if(flag){
				
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/ipe/calGtAndKj.do",
					params:{
						gt:$scope.ipe.gt,
						kj:$scope.ipe.kj
					}
				}).then(function(res){
					$scope.ipe.score2 = res.data;
					self.calIpe();
				});
				
			}else{
				$scope.ipe.score2 = "";
			}
			
		};
		
		$scope.cxAndFzdChange = function() {
			
			var flag = true;
			if(!$scope.ipe.cx){
				  flag = false;
			}
			if(!$scope.ipe.fzd){
				  flag = false;
			}
			
			if(flag){
				
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/ipe/calCxAndFzd.do",
					params:{
						cx:$scope.ipe.cx,
						fzd:$scope.ipe.fzd
					}
				}).then(function(res){
					$scope.ipe.score3 = res.data;
					self.calIpe();
				});
				
			}else{
				$scope.ipe.score3 = "";
			}
			
		};
		
		$scope.zsAndTdChange = function() {
			
			var flag = true;
			if(!$scope.ipe.zs){
				  flag = false;
			}
			if(!$scope.ipe.td){
				  flag = false;
			}
			
			if(flag){
				
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/ipe/calZsAndTd.do",
					params:{
						zs:$scope.ipe.zs,
						td:$scope.ipe.td
					}
				}).then(function(res){
					$scope.ipe.score4 = res.data;
					self.calIpe();
				});
				
			}else{
				$scope.ipe.score4 = "";
			}
			
		};
		
		
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);