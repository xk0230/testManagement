var myAppModule = angular.module("myApp",['ui.bootstrap'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('ContractController',
	function contractListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 20;
		
		this.$onInit = function(){

			$scope.contractTypeList = [
				{type : "收入", name : "收入"},
				{type : "支出", name : "支出"}
			];
			
			$scope.deptList = [
			   	{type : "YSEC", name : "YSEC"},
				{type : "GMO", name : "GMO"},
				{type : "ATD", name : "ATD"},
				{type : "CES", name : "CES"},
			    {type : "SSC", name : "SSC"}
			];
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getContractList();

		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getContractList();
		};
		
		// 获取数据列表
		this.getContractList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/contract/page.do',
				params:{
					type:$scope.type,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
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
			});
		};
		
		//添加新申请
		this.addContract = function(){
			var newItem = {
				costDate:new Date()
				,createDate:new Date()
				,id:""
				,contractId:$filter('date')(new Date(), "yyyyMMddhhmmss")
				,type:""
				,content:""
				,dept:""
				,cost:0
				,company:""
				,url:""
				,serialid:""	
				,remakes:""	
				,editMode:"edit"
			};
			var myArray=new Array()
			myArray.push(newItem);
			
			$.each(self.list, function(index, value) {
				myArray.push(value);
			}
			);
			self.list = myArray;
		};
		
		//点击编辑
		this.editContract = function (contractItem) {
			contractItem.editMode = "edit";
			contractItem.costDate = new Date(costItem.costDate);
		};
		
		//点击保存
		this.save = function (contractItem) {
			if(!contractItem.contractId){
				alert("请填写合同订单");
				return ;
			}
			if(!contractItem.type){
				alert("请填写合同类别");
				return ;
			}
			if(!contractItem.content){
				alert("请填写合同内容");
				return ;
			}
			if(!contractItem.dept){
				alert("请填写对方部门");
				return ;
			}
			if(contractItem.cost<0){
				alert("请填写金额");
				return ;
			}
			if(!contractItem.company){
				alert("请填写对方公司");
				return ;
			}
			if(!contractItem.url){
				alert("请填写地址");
				return ;
			}
			if(!contractItem.serialid){
				alert("请填写外部订单号");
				return ;
			}
			if(!contractItem.remakes){
				alert("请填写备注");
				return ;
			}
			var params = {
				id:contractItem.id,
				contractId:contractItem.contractId,
				type:contractItem.type,
				content:contractItem.content,
				cost:contractItem.cost,
				dept:contractItem.dept,
				company:contractItem.company,
				url:contractItem.url,
				status:contractItem.status,
				serialid:contractItem.serialid,
				remakes:contractItem.remakes
//				costTime:$filter('date')(contractItem.costDate, "yyyy-MM-dd")
//				createTime:$filter('date')(contractItem.createDate, "yyyy-MM-dd hh:mm:ss")
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/contract/saveOrUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getContractList();
					//costItem.editMode="view";
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		//报废
		this.scrap = function (ContractItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该合同信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: true, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						id:ContractItem.id
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/contract/deleteContract.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getContractList();
						//costItem.editMode="view";
					}else{
						swal(res.data.msg);
					}
				})
			});
		};
		
		//提交
		this.submitContract = function (contractItem) {
			swal({ 
					title: "确定提交吗？", 
					text: "将提交给您的部门领导审核！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						id:contractItem.id,
						status:"01"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/contract/deleteContract.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal("提交成功！");
						self.getContractList();
						//costItem.editMode="view";
					}else{
						swal("提交失败！");
					}
				})
			});
		};
		
	}
);


angular.bootstrap(document.getElementById("content"), ['myApp']);