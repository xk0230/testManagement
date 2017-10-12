var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location,$document, $filter,$uibModal){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		self.Recruitment = {
		}
		
		self.evaluation = {
				
		}
		
		this.$onInit = function(){
			//招聘需求Id
			var xxx = $location.search();
			self.Recruitment.id = $location.search().id;
			if(self.Recruitment.id != "" && typeof(self.Recruitment.id)!="undefined"){
				//招聘需求详情
				self.getRecruitmentInfo();
				//面试得分表
				self.getCandidatePageList();
			}
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getFinancingInfoList();
		};
		
		//获取招聘需求详情
		self.getRecruitmentInfo = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/recruit/getById.do',
				params:{
					id : self.Recruitment.id
				}
			}).then(function(res){
				if(res){
					//设置招聘需求
					self.Recruitment = res.data || {};

					/*$.each(self.Recruitment.competencys,function(n,value) {
						var check = $("#competency" + value.id);
						if(typeof(check)!="undefined"){
							check[0].checked = true;
						}
				    });*/
					
				}else{
					self.Recruitment = {};
				}
			})
		}
		
		//获取获选人列表
		self.getCandidatePageList = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/candidate/getCandidatePageList.do',
				params:{
					recruitId : self.Recruitment.id,
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
			})
		}
		
		//获取获选人列表
		self.save = function(item){
			var recRComIdsStr = "";
			var valuesStr = "";
			
			$.each(item.crrs,function(n,value) {
				recRComIdsStr = recRComIdsStr + value.recRComId + "@";
				valuesStr = valuesStr + value.value + "@@@"
		    });
			
			if(recRComIdsStr.length>0){
				recRComIdsStr = recRComIdsStr.substring(0,recRComIdsStr.length-1)
			}
			if(valuesStr.length>0){
				valuesStr = valuesStr.substring(0,valuesStr.length-3)
			}
			
			$http({
				method:'POST',
				url:'/ccydManagement/admin/candidate/saveOrUpdateCandidate.do',
				params:{
					id            :item.id        ,
					name          :item.name      ,
					recruitId     :item.recruitId ,
					pdpSjA        :item.pdpSjA    ,
					pdpSjB        :item.pdpSjB    ,
					pdpSjC        :item.pdpSjC    ,
					pdpSjD        :item.pdpSjD    ,
					pdpNjA        :item.pdpNjA    ,
					pdpNjB        :item.pdpNjB    ,
					pdpNjC        :item.pdpNjC    ,
					pdpNjD        :item.pdpNjD    ,
					wordScore     :item.wordScore ,
					skillScore    :item.skillScore,
					edu           :item.edu       ,
					other         :item.other     ,
					evaluating    :item.evaluating,
					sort          :item.sort      ,
					pc            :item.pc        ,
					recRComIdsStr :recRComIdsStr,
					valuesStr     :valuesStr
				}
			}).then(function(res){
				if(res.data.result){
					alert("保存成功！");
					self.getCandidatePageList();
				}else{
					alert(res.data.message);
				}
			})
		}
		

		
		//候选人编辑
		this.show = function (item, parentSelector) {
		    var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
		    	    var modalInstance = $uibModal.open({
		    	      animation: true,
		    	      ariaLabelledBy: 'modal-title',
		    	      ariaDescribedBy: 'modal-body',
		    	      templateUrl: 'myModalEditContent.html',
		    	      controller: 'ModalInstanceCtrl',
		    	      controllerAs: '$ctrl',
		    	      size: 'lg',
		    	      appendTo: parentElem,
		    	      //参数
		    	      resolve: {
		    	    	  //好像必须得这么写
		    	        items: function () {
		    	          return item;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	
		    	    	//ok的回调函数
		    	    	if(selectedItem == '0'){
		    	    		alert("保存成功！");
		    	    		self.getFinancingInfoList();
		    	    	}
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		
	}
);

//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
function ($scope,$http,$uibModalInstance,$filter, items) {
	var $ctrl = this;
	//获取页面参数
	$scope.items = items;
	$scope.items.interviewTime = $filter('date')(items.interviewTime, 'yyyy-MM-dd hh:mm:ss');

	//分页
	$scope.totalItems = 0;
	$scope.currentPage = 1;
	$scope.itemsPerPage = 10;
	
	//页面初期化
	this.$onInit = function(){
		$http({
			method:'POST',
			url:"/ccydManagement/admin/candidate/getCandidateRInterviewerPageList.do",
			params:{
				candidateId:items.id,
				start:0,
				end:1000
			}
		}).then(function(res){
			if(res){
				$scope.InterviewList = res.data.data || [];
			}else{
				$scope.InterviewList = [];
			}
		});
	};
	
	
	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	  
	});



angular.bootstrap(document.getElementById("content"), ['myApp']);