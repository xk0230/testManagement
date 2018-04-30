var myAppModule = angular.module("myApp",['ui.bootstrap']);
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 50;
		
		this.$onInit = function(){
			$scope.postId = $location.search().postId;
			//设置部门下拉框
			this.getDepList();
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.depId =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
				self.getPostionById();
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			//查询
			self.getFinancingInfoList();
			
			//获取图表
			self.getChartsData();
		}
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getFinancingInfoList();
		};
		
		
		//获取图表数据
		this.getChartsData = function(){
			console.log("获取图表");
			$http({
				method:'POST',
				url:'/ssc/admin/adminuser/getchartsdata.do'
			}).then(function(res){
				if(res){
					var ls = [];
					//学历
					$.each(res.data, function(index, value) {
						if(value.name=='education_bkyx'){
							ls.push(['本科以下',value.value])
						}
						if(value.name=='education_bk'){
							ls.push(['本科',value.value])
						}
						if(value.name=='education_ss'){
							ls.push(['硕士',value.value])
						}
						if(value.name=='education_bs'){
							ls.push(['博士',value.value])
						}
						}
					);
					self.writeChart('c1','学历',ls);
					
					
					//婚姻
					ls = [];
					$.each(res.data, function(index, value) {
						if(value.name=='marrage_yh'){
							ls.push(['已婚',value.value])
						}
						if(value.name=='marrage_wh'){
							ls.push(['未婚',value.value])
						}
						}
					);
					self.writeChart('c2','婚姻',ls);
					
					//年龄
					ls = [];
					$.each(res.data, function(index, value) {
						if(value.name=='age_30'){
							ls.push(['30以下',value.value])
						}
						if(value.name=='age_35'){
							ls.push(['30~35',value.value])
						}
						if(value.name=='age_40'){
							ls.push(['35~40',value.value])
						}
						if(value.name=='age_40up'){
							ls.push(['40以上',value.value])
						}
						}
					);
					self.writeChart('c3','年龄',ls);
					
					//工龄
					ls = [];
					$.each(res.data, function(index, value) {
						if(value.name=='work_yesr_1'){
							ls.push(['1年以下',value.value])
						}
						if(value.name=='work_yesr_2'){
							ls.push(['1~2年',value.value])
						}
						if(value.name=='work_yesr_5'){
							ls.push(['2~5年',value.value])
						}
						if(value.name=='work_yesr_10'){
							ls.push(['5~10年',value.value])
						}
						if(value.name=='work_yesr_10up'){
							ls.push(['10年以上',value.value])
						}
						}
					);
					self.writeChart('c4','工龄',ls);
					
					//部门
					ls = [];
					$.each(res.data, function(index, value) {
						if(value.name=='dep_ysec'){
							ls.push(['YSEC',value.value])
						}
						if(value.name=='dep_gmo'){
							ls.push(['GMO',value.value])
						}
						if(value.name=='dep_atd'){
							ls.push(['ATD',value.value])
						}
						if(value.name=='dep_ces'){
							ls.push(['CES',value.value])
						}
						if(value.name=='dep_ssc'){
							ls.push(['SSC',value.value])
						}
						}
					);
					self.writeChart('c5','部门',ls);
					
				}
			});
			
			
		}
		
		
		this.writeChart = function(id,title,data){
			$('#'+id).highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: title
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    //format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    format:'{point.name}: <b>{point.y}</b>',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: title,
		            data:data
		            	/*[
		                ['Firefox',   45.0],
		                ['IE',       26.8],
		                {
		                    name: 'Chrome',
		                    y: 12.8,
		                    sliced: true,
		                    selected: true
		                },
		                ['Safari',    8.5],
		                ['Opera',     6.2],
		                ['其他',   0.7]
		            ]*/
		        }]
		    });
		}
		
		
		
		// 获取数据列表
		this.getFinancingInfoList = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/adminuser/getadminlist.do',
				params:{
					userName: $scope.userName,
					realName: $scope.realName,
					depId   : $scope.depId,
					postId: $scope.postId,
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
		this.addNewUser = function(id){
			window.location.href="/ssc/admin/adminuser/toAddOrEditUser.do"; 
		};
		
		this.edit = function(id){
			window.location.href="/ssc/admin/adminuser/toAddOrEditUser.do?id="+id; 
		};
		
		this.userTrainList = function(id){
			window.location.href="/ssc/admin/train/manager.do?userId="+id; 
		};
		this.userTransferPositionList = function(id){
			window.location.href="/ssc/admin/transferPosition/manager.do?userId="+id; 
		};
		this.userAttachmentList = function(id){
			window.location.href="/ssc/admin/attachment/manager.do?userId="+id; 
		};
		
		this.bookHis = function (id, parentSelector) {
			var parentElem = parentSelector ? angular.element($document[0].querySelector('.content-wrapper ' + parentSelector)) : undefined;
					var auditmodalInstance = $uibModal.open({
						animation: true,
						ariaLabelledBy: 'modal-title',
						ariaDescribedBy: 'modal-body',
						templateUrl: 'myAuditDetailContent.html',
						controller: 'AuditModalInstanceCtrl',
						controllerAs: '$ctrl',
						size: 'lg',
						appendTo: parentElem,
						//参数
						resolve: {
							//好像必须得这么写
						items: function () {
							return id;
						}
					
						}
					});

					auditmodalInstance.result.then(function (selectedItem) {
					}, function () {
				//取消的回调函数
			});
		};
		
		
		
	}
);

//驳回审批的control
angular.module('myApp').controller('AuditModalInstanceCtrl', function ($scope,$http,$uibModalInstance, items) {
	var self = this;
	$scope.totalItems = 0;
	$scope.currentPage = 1;
	$scope.itemsPerPage = 9999;
	this.$onInit = function(){
		self.getAuditList($ctrl.id);
	};
	
	this.getAuditList = function(){
			$http({
				method:'POST',
				url:'ssc/admin/book/gethistory.do',
				params:{
					userId:$ctrl.id,
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			}).then(function(res){
				if(res){
					$.each(res.data, function(index, value) {
						if(value.type=='get'){
							value.type = "借阅";
						}else{
							value.type = "归还";
						}
						});
					$scope.list = res.data || [];
					$scope.totalItems = res.data.length;
				}else{
					$scope.list = [];
					$scope.totalItems = 0;
				}
			});
	};	
	
	
	var $ctrl = this;
		$ctrl.id = items;
		$ctrl.auditEntity = {
			};
		$ctrl.ok = function () {
			$uibModalInstance.dismiss('cancel');
		};
		$ctrl.cancel = function () {
			$uibModalInstance.dismiss('cancel');
		};
		
		$scope.pageChanged = function() {
			self.getAuditList();
		};
		
		//页数变化
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};
		
	});


angular.bootstrap(document.getElementById("content"), ['myApp']);
