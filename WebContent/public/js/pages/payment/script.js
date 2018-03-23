var myAppModule = angular.module("myApp",['ui.bootstrap','ngSanitize'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('PaymentController',
	function paymentListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 20;
		
		this.$onInit = function(){

			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getPaymentList();

		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getPaymentList();
		};
		
		// 获取数据列表
		this.getPaymentList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/payment/page.do',
				params:{
					name:$scope.name,
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
		this.addPayment = function(){
			var newItem = {
				createDate:new Date()
				,id:""
				,name:""
				,taxNo:""
				,bankName:""
				,bankNo:""
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
		this.editPayment = function (paymentItem) {
			paymentItem.editMode = "edit";
		};
		
		//点击保存
		this.save = function (paymentItem) {
			if(!paymentItem.bankName){
				alert("请填写开户行");
				return ;
			}
			if(!paymentItem.bankNo){
				alert("请填写银行账号");
				return ;
			}
			if(!paymentItem.name){
				alert("请填写公司名称");
				return ;
			}
			var params = {
				id:paymentItem.id,
				name:paymentItem.name,
				taxNo:paymentItem.taxNo,
				bankNo:paymentItem.bankNo,
				bankName:paymentItem.bankName,
//				costTime:$filter('date')(contractItem.costDate, "yyyy-MM-dd")
//				createTime:$filter('date')(paymentItem.createDate, "yyyy-MM-dd hh:mm:ss")
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/payment/saveOrUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getPaymentList();
					//costItem.editMode="view";
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		//报废
		this.scrap = function (paymentItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: true, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						id:paymentItem.id
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/payment/deletePayment.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getPaymentList();
						//costItem.editMode="view";
					}else{
						swal(res.data.msg);
					}
				})
			});
		};
		
		//提交
		this.submitPayment = function (paymentItem) {
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
						id:paymentItem.id,
						status:"01"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/payment/deletePayment.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal("提交成功！");
						self.getPaymentList();
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