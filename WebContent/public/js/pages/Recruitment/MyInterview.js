var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$document, $filter,$uibModal){
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
				url:'/ssc/admin/candidate/getCandidateRInterviewerPageList.do',
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
		
		//候选人编辑
		this.edit = function (item, parentSelector) {
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
	//页面初期化
	this.$onInit = function(){
		$http({
			method:'POST',
			url:"/ssc/admin/candidate/getCandidateRInterviewerById.do",
			params:{
				id:items.id
			}
		
		}).then(function(res){
			if(res.status == "200"){
				$scope.items.crrs = res.data.crrs;
			}else{
				alert("获取信息失败！");
			}
		});
	};
	
	//保存操作
	$scope.save = function () {

		var recRComIdsStr = "";
		var valuesStr = "";
		
		$.each($scope.items.crrs,function(n,value) {
			recRComIdsStr = recRComIdsStr + value.recRComId + "@";
			valuesStr = valuesStr + value.value + "@@@"
	    });
		
		if(recRComIdsStr.length>0){
			recRComIdsStr = recRComIdsStr.substring(0,recRComIdsStr.length-1)
		}
		if(valuesStr.length>0){
			valuesStr = valuesStr.substring(0,valuesStr.length-3)
		}
		var params = {
				//id
				id:$scope.items.id,
				workDetail:items.workDetail,
				skillDetail:items.skillDetail,
				wordScore:items.wordScore,
				skillScore:items.skillScore,
				recRComIdsStr :recRComIdsStr,
				valuesStr     :valuesStr
			}
			$http({
				method:'POST',
				url:"/ssc/admin/candidate/saveOrUpdateCandidateRInterviewer.do",
				params:params
			
			}).then(function(res){
				if(res.data.result){
					$uibModalInstance.close('0');
				}else{
					alert("保存失败！");
				}
			});
	};
	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	  
	});



angular.bootstrap(document.getElementById("content"), ['myApp']);