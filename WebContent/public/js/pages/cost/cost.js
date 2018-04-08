var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker']);

myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('CostController',
	function costListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		
		this.$onInit = function(){

			$scope.costTypeList = [
				{costType : "0", name : "收入"},
				{costType : "1", name : "支出"}
			];
			$scope.costClassList = [
				{costClass : "0", name : "日常"},
				{costClass : "1", name : "合同"},
				{costClass : "2", name : "出差"}
			];
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getCostList();
			//设置时间控件
			setDatepicker("datepickerS")
			setDatepicker("datepickerE")
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getCostList();
		};
		
		// 获取数据列表
		this.getCostList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/page.do',
				params:{
					costType:$scope.costType,
					costClass:$scope.costClass,
					costNo:$scope.costNo,
					remark:$scope.remark,
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
		this.addCost = function(){
			var newItem = {
				costDate:$filter('date')(new Date(), "yyyy-MM-dd")
				,costNum:0
				,costType:""
				,costClass:""
				,remark:""
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
		this.editCost = function (costItem,index) {
			costItem.editMode = "edit";
			
			//设置时间控件
			setDatepicker("datepicker" + index)
		};
		
		//点击保存
		this.save = function (costItem) {
			if(!costItem.costType){
				alert("请填写收支类型");
				return ;
			}
			if(!costItem.costDate){
				alert("请填写成本产生时间");
				return ;
			}
			if(!costItem.costNum){
				alert("请填写金额");
				return ;
			}
			var params = {
				costId:costItem.costId,
				costType:costItem.costType,
				costClass:costItem.costClass,
				costTime:$filter('date')(costItem.costDate, "yyyy-MM-dd"),
				createTime:$filter('date')(costItem.createDate, "yyyy-MM-dd hh:mm:ss"),
				costNum:costItem.costNum,
				remark:costItem.remark,
				status:costItem.status,
				contractId:costItem.contractId
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/saveOrUpdate.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getCostList();
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		//报废
		this.scrap = function (costItem) {
			swal({ 
					title: "确定报废吗？", 
					text: "你将无法恢复该成本信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"99"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/cost/updateCostStatus.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getCostList();
					}else{
						swal(res.data.msg);
					}
				})
			});
		};
		
		//提交
		this.submitCost = function (costItem) {
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
						costId:costItem.costId,
						status:"01"
					};
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/cost/updateCostStatus.do",
					params:params
					
				}).then(function(res){
					if(res.data.code == 0){
						swal("提交成功！");
						self.getCostList();
					}else{
						swal("提交失败！");
					}
				})
			});
		};
		
		this.editPayment = function (item, parentSelector, mode) {
		    var parentElem = parentSelector ? angular.element($document[0].querySelector(parentSelector)) : undefined;
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
		    	        item: function () {
		    	        	item.mode = mode;
		    	        	return item;
		    	        }
		    	      }
		    	    });

		    	    modalInstance.result.then(function (selectedItem) {
		    	    	
		    	    	item.contractId = selectedItem.contractId;
		    	    	item.contractContent = selectedItem.contractContent;
		    	    	
		    	    }, function () {
		    	    	//取消的回调函数
		    	    	
		    	    });
		   };
		
	}
);

//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, item) {
		var $ctrl = this;
		$scope.item = item;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		$ctrl.$onInit = function(){
			//合同号
			$scope.contractId = item.contractId;
			$scope.mode = item.mode;
			
			$ctrl.contractTypeList = [
				{contractType : "收入", name : "收入"},
				{contractType : "支出", name : "支出"}
			];
				
			$ctrl.getContractList();

		};
		
		$ctrl.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$ctrl.pageChanged = function() {
			$ctrl.getContractList();
		};
		
		// 获取数据列表
		$ctrl.getContractList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/contract/page.do',
				params:{
					contractType:$scope.contractType,
					content:$scope.content,
					contractId:$scope.contractId,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
					start:(($scope.currentPage - 1) * $scope.itemsPerPage),
					end:$scope.currentPage * $scope.itemsPerPage -1
				}
			}).then(function(res){
				if(res){
					$scope.list = res.data.data || [];
					$scope.totalItems = res.data.total;
				}else{
					$scope.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		
	$scope.Choose = function (item) {
		var selectItem = {contractId : item.contractId, contractContent : item.content};
		$uibModalInstance.close(selectItem);
	};

	$scope.cancel = function () {
		$uibModalInstance.dismiss('cancel');
	};

	});


angular.bootstrap(document.getElementById("content"), ['myApp']);