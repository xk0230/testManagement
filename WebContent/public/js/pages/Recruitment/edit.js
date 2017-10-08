var myAppModule = angular.module("myApp",['ui.bootstrap','jcs-autoValidate']);
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location,$document, $filter,$uibModal){
		var self = this;
		self.Recruitment = {
				id:"",
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
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		//拒绝理由输入框显示Flag
		$scope.RefuseFlag = false;
		//拒绝理由
		$scope.RefuseReason = "";
		
		//初期化
		self.$onInit = function(){
			//设置部门下拉框
			this.getDepList();
			//设置胜任特征
			this.getAllCompetency();
			//获取用户ID
			self.Recruitment.id = $location.search().id;
			if(self.Recruitment.id != "" && typeof(self.Recruitment.id)!="undefined"){
				//招聘需求详细信息
				this.getRecruitmentInfo();
				//招聘需求候选人
				this.getCandidatePageList();
			}
		}
		
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
					if($scope.vm.Recruitment.depId != null){
						//选择部门对应的岗位
						self.getPostionByDepId();
					}
					$.each(self.Recruitment.competencys,function(n,value) {
						var check = $("#competency" + value.id);
						if(typeof(check)!="undefined"){
							check[0].checked = true;
						}
				    });
					
				}else{
					self.Recruitment = {};
				}
			})
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
					depId: $scope.vm.Recruitment.depId
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
					id: $scope.vm.Recruitment.postid
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
		
		//保存
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
				if(res.data.result){
					alert("保存成功！");
				}else{
					alert("保存失败！");
				}
			})
		}
		
		//提交审核
		self.putAuditRecruit = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/recruit/putAuditRecruit.do',
				params:{
					id : self.Recruitment.id,
					auditIds:""
				}
			}).then(function(res){
				if(res){
					alert("提交审批成功！")
					self.$onInit();
				}else{
					alert("提交审批失败！")
				}
			})
		}
		
		//审核通过
		self.accept = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/recruit/auditRecruit.do',
				params:{
					recruitId : self.Recruitment.id,
					result:"1"
				}
			}).then(function(res){
				if(res){
					alert("审核提交成功！")
					self.$onInit();
				}else{
					alert("审核提交失败！")
				}
			})
		}
		
		//审核拒绝
		self.refuse = function(){
			if(!$scope.RefuseFlag){
				$scope.RefuseFlag = true;
				return;
			}
			if($scope.RefuseReason ==""){
				alert("驳回理由不能为空！");
				return;
			}
			
			$http({
				method:'POST',
				url:'/ccydManagement/admin/recruit/auditRecruit.do',
				params:{
					recruitId : self.Recruitment.id,
					result:"-1",
					remark:$scope.RefuseReason
				}
			}).then(function(res){
				if(res){
					alert("驳回提交成功！")
					self.$onInit();
				}else{
					alert("驳回提交失败！")
				}
			})
		}
		
		//候选人编辑
		this.editCost = function (id,name, parentSelector) {
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
		    	          return [$scope.vm.Recruitment.id,id,name];
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	
		    	    	//ok的回调函数
		    	    	if(selectedItem == '0'){
		    	    		self.getCandidatePageList();
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
	//需求ID
	$ctrl.id = items[0];
	//候选人id
	$ctrl.candidateId = items[1];
	$ctrl.candidateName = items[2];
	//分页
	$scope.totalItems = 0;
	$scope.currentPage = 1;
	$scope.itemsPerPage = 10;
	//显示面试官编辑
	$scope.showEdit = false;
	
	$scope.Interview = {
			depId:"",
			postId:"",
			interviewerId:"",
			place:"",
			interviewTime:"",
			interviewDetail:"",

	}
	
	//页面初期化
	this.$onInit = function(){
		//候选人ID不为空(编辑)
		if($ctrl.candidateId!=''){
			$scope.candidateName = $ctrl.candidateName;
			//获取面试官列表
			$scope.getInterViewList();
		}
		
		// 获取部门List
		$scope.getDepList();
	  };
	
	//获取面试官列表
	$scope.getInterViewList = function(){
		$http({
			method:'POST',
			url:"/ccydManagement/admin/candidate/getCandidateRInterviewerPageList.do",
			params:{
				candidateId:$ctrl.candidateId,
				start:(($scope.currentPage - 1) * $scope.itemsPerPage),
				end:$scope.currentPage * $scope.itemsPerPage -1
			}
		}).then(function(res){
			if(res){
				$scope.InterviewList = res.data.data || [];
			}else{
				$scope.InterviewList = [];
			}
		});
	}
	  
	//新增面试官
	$scope.addInterview = function(){
		$scope.showEdit = true;
		$scope.Interview = {};
		// 日期控件
		$('.form_datetime').datetimepicker({
		    //language:  'fr',
		    weekStart: 1,
		    todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
		    showMeridian: 1
		});
	}
	
	//编辑面试官
	$scope.editInterview = function(Interview){
		$scope.showEdit = true;
		//设置面试官信息
		$scope.Interview = Interview;
		$scope.Interview.interviewTime = $filter('date')($scope.Interview.interviewTime, 'yyyy-MM-dd hh:mm:ss');
		//获取岗位列表
		$scope.getPostionById();
		//获取面试官列表
		$scope.getFinancingInfoList();
		// 日期控件
		$('.form_datetime').datetimepicker({
		    language:  'zh-CN',
		    weekStart: 1,
		    todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
		    showMeridian: 1
		});
	}
	
	//获取部门
	$scope.getDepList = function(){
		$http({
			method:'POST',
			url:'/ccydManagement/admin/dep/getAlldep.do',
			params:{
			}
		}).then(function(res){
			if(res){
				$scope.deplist = res.data || [];
			}else{
				$scope.deplist = [];
			}
		})
	}
	
	//获取岗位
	$scope.getPostionById = function(){
		$http({
			method:'POST',
			url:'/ccydManagement/admin/position/getPositionByDepId.do',
			params:{
				depId: $scope.Interview.interviewerDepId
			}
		}).then(function(res){
			if(res){
				$scope.postlist = res.data || [];
			}else{
				$scope.postlist = [];
			}
		})
	}
	
	// 获取数据列表
	$scope.getFinancingInfoList = function(){
		$http({
			method:'POST',
			url:'/ccydManagement/admin/adminuser/getadminlist.do',
			params:{
				userName: "",
				realName: "",
				depId   : $scope.Interview.interviewerDepId,
				postId  : $scope.Interview.interviewerPostId,
				start:0,
				end:1000
			}
		}).then(function(res){
			if(res){
				$scope.userList = res.data.data || [];
			}else{
				$scope.userList = [];
			}
		})
	};
	
	//保存操作
	$ctrl.ok = function () {
		if($scope.showEdit){
			var params = {
					//id
					id:$scope.Interview.id,
					// 候选人ID
					candidateId:$ctrl.candidateId,
					interviewerId:$scope.Interview.interviewerId,
					place:$scope.Interview.place,
					interviewTime:$filter('date')($scope.Interview.interviewTime, "yyyy-MM-dd hh:mm:ss"),
					interviewDetail:$scope.Interview.interviewDetail,
				}
				$http({
					method:'POST',
					url:"/ccydManagement/admin/candidate/saveOrUpdateCandidateRInterviewer.do",
					params:params
				
				}).then(function(res){
					if(res.data.result){
						//获取面试官列表
						$scope.getInterViewList();
						//隐藏编辑框
						$scope.showEdit = false;
					}else{
						alert("保存失败！");
					}
			});

		}else{
			var params = {
				id:$ctrl.candidateId,
				recruitId:$ctrl.id,
				name:$scope.candidateName
			}
			$http({
				method:'POST',
				url:"/ccydManagement/admin/candidate/saveOrUpdateCandidate.do",
				params:params
			
			}).then(function(res){
				if(res.data.result){
					$uibModalInstance.close('0');
				}
			});
		}
		
	};

	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };

		//日期模块加载
		$scope.today = function() {
			$scope.dt = new Date();
		};
		$scope.clear = function() {
			$scope.dt = null;
		};

		$scope.dateOptions = {
			dateDisabled: "",
			formatYear: 'medium',
			maxDate: new Date(9999, 12, 31),
			minDate: new Date(1000, 1,1),
			startingDay: 1,
		};

		
		$scope.open = function(mode) {
			if(mode == 1){
				$scope.popup.opened1 = true;
			}
		};
	
		$scope.popup = {
			opened1: false,
		};
	  
	  
	});



angular.bootstrap(document.getElementById("content"), ['myApp']);