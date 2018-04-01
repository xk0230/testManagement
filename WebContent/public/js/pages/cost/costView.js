var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker'])
myAppModule.filter('Chinese',function(){  
    return function(input){  
        var numberValue=new String(Math.round(input*100)); // 数字金额  
        var chineseValue=""; // 转换后的汉字金额  
        var String1 = "零壹贰叁肆伍陆柒捌玖"; // 汉字数字  
        var String2 = "万仟佰拾亿仟佰拾万仟佰拾元角分"; // 对应单位  
        var len=numberValue.length; // numberValue 的字符串长度  
        var Ch1; // 数字的汉语读法  
        var Ch2; // 数字位的汉字读法  
        var nZero=0; // 用来计算连续的零值的个数  
        var String3; // 指定位置的数值  
        if(len>15){  
        alert("超出计算范围");  
        return "";  
        }  
        if (numberValue==0){  
        chineseValue = "零元整";  
        return chineseValue;  
        }  
  
        String2 = String2.substr(String2.length-len, len); // 取出对应位数的STRING2的值  
        for(var i=0; i<len; i++){  
        String3 = parseInt(numberValue.substr(i, 1),10); // 取出需转换的某一位的值  
        if ( i != (len - 3) && i != (len - 7) && i != (len - 11) && i !=(len - 15) ){  
        if ( String3 == 0 ){  
        Ch1 = "";  
        Ch2 = "";  
        nZero = nZero + 1;  
        }  
        else if ( String3 != 0 && nZero != 0 ){  
        Ch1 = "零" + String1.substr(String3, 1);  
        Ch2 = String2.substr(i, 1);  
        nZero = 0;  
        }  
        else{  
        Ch1 = String1.substr(String3, 1);  
        Ch2 = String2.substr(i, 1);  
        nZero = 0;  
        }  
        }  
        else{ // 该位是万亿，亿，万，元位等关键位  
        if( String3 != 0 && nZero != 0 ){  
        Ch1 = "零" + String1.substr(String3, 1);  
        Ch2 = String2.substr(i, 1);  
        nZero = 0;  
        }  
        else if ( String3 != 0 && nZero == 0 ){  
        Ch1 = String1.substr(String3, 1);  
        Ch2 = String2.substr(i, 1);  
        nZero = 0;  
        }  
        else if( String3 == 0 && nZero >= 3 ){  
        Ch1 = "";  
        Ch2 = "";  
        nZero = nZero + 1;  
        }  
        else{  
        Ch1 = "";  
        Ch2 = String2.substr(i, 1);  
        nZero = nZero + 1;  
        }  
        if( i == (len - 11) || i == (len - 3)){ // 如果该位是亿位或元位，则必须写上  
        Ch2 = String2.substr(i, 1);  
        }  
        }  
        chineseValue = chineseValue + Ch1 + Ch2;  
        }  
  
        if ( String3 == 0 ){ // 最后一位（分）为0时，加上“整”  
        chineseValue = chineseValue + "整";  
        }  
  
        return chineseValue;  
  
    };  
});  
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
			
			//获取角色
			self.admin =$("#sessionUserType").val();
			if(self.admin=="MANAGER"){
				$scope.dep =$("#sessionUserDepId").val();
				$scope.depIdChangeAble = true;
			}else if(self.admin=="ADMIN"){
				$scope.depIdChangeAble = false;
			}
			self.getCostList();
			self.getCostViewChart();
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
				url:$("#rootUrl").val()+'/admin/cost/viewPage.do',
				params:{
					costType:$scope.costType,
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
					
					self.chkValue = false;
					angular.forEach(self.list, function(item, key) {
						item.chk = false;
					});
					
					$scope.totalItems = res.data.total;
					if(self.list.length > 0){
						$scope.depLength = self.list[0].costDepList.length > 5?350:180;
					}else{
						$scope.depLength = 180;
					}
				}else{
					self.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		
		this.search= function(){
			self.getCostList();
			self.getCostViewChart();
		}
		this.chkAll = function(){
			angular.forEach(self.list, function(item, key) {
				item.chk = self.chkValue;
			});
			this.createPrintList();
		}
		//选择变化
		this.chkChange = function(){
			this.createPrintList();
		}
		
		this.createPrintList = function(){
			self.printList = [];
			var choseContractList = [];
			self.date = new Date();
			//遍历所有选中的项目，组成list
			angular.forEach(self.list, function(item, key) {
				if(item.chk){
					if(item.contract != null){
						choseContractList.push(item);
					}else{
						if(self.printList.length == 0){
							self.printList.push({
								"subUser": item.subUser,
								"subUserName": item.subUserName,
								"auditUserName": item.auditUserName,
								"depName": item.depName,
								"sum":0,
								"list":[item]
							})
						}else{
							var hasPrint = false;
							angular.forEach(self.printList, function(printItem, key) {
								if(printItem.subUser == item.subUser){
									hasPrint = true;
									printItem.list.push(item);
								}
							});
							if(!hasPrint){
								self.printList.push({
									"subUser": item.subUser,
									"subUserName": item.subUserName,
									"auditUserName": item.auditUserName,
									"depName": item.depName,
									"sum":0,
									"list":[item]
								});
							}
						}
					}
				}
			});
			
			//设定日常打印
			var printPageList=[];
			var lengthPerPage = 6;
			//按每页显示数据条数拆分数据
			angular.forEach(self.printList, function(item, key) {
				var itemList = [];
				var tempList = [];
				//按每页显示数分割List并填满存到itemList中去
				angular.forEach(item.list, function(subitem, subkey) {
					if(subkey % lengthPerPage == 0){
						tempList = [];
					}
					
					tempList.push(subitem);

					if(subkey % lengthPerPage == lengthPerPage -1 || subkey == item.list.length -1 ){
						for(i = tempList.length;i<lengthPerPage;i++){
							tempList.push({"costNum":null});
						}
						itemList.push({"list":tempList});
					}
				});
				//填上主属性，并填充到printPageList中
				angular.forEach(itemList, function(subitem, subkey) {
					//计算合计
					var sum = parseFloat(0);
					angular.forEach(subitem.list, function(subSubItem, subSubkey) {
						if(null != subSubItem.costNum)
							sum += parseFloat(subSubItem.costNum);
					});
					
					printPageList.push({
						"subUser": item.subUser,
						"subUserName": item.subUserName,
						"auditUserName": item.auditUserName,
						"depName": item.depName,
						"sum":sum,
						"list":subitem.list
					});
				});
			});
			
			//分成两页一组
			self.printListPage = [];
			var tempPerPage = [];
			angular.forEach(printPageList, function(item, key) {
				if(key % 2 ==0){
					tempPerPage = [];
				}
				tempPerPage.push(item);
				if(key % 2 ==1 || key == printPageList.length - 1 ){
					self.printListPage.push({"pageList":tempPerPage});
				}
			});
			
			//合同打印分成两页一组
			self.printContractList = [];
			tempPerPage = [];
			angular.forEach(choseContractList, function(item, key) {
				if(key % 2 ==0){
					tempPerPage = [];
				}
				tempPerPage.push(item);
				if(key % 2 ==1 || key == choseContractList.length - 1 ){
					self.printContractList.push({"pageList":tempPerPage});
				}
			});
			

		}
		
		//打印
		this.print= function(){
			angular.forEach(self.printListPage, function(item, key) {
				$("#printDiv" + key).print({
				    globalStyles: true,
				    mediaPrint: false,
				    stylesheet: null,
				    noPrintSelector: ".no-print",
				    iframe: true,
				    append: null,
				    prepend: null,
				    manuallyCopyFormValues: true,
				    deferred: $.Deferred()
            });
			});
			
			angular.forEach(self.printContractList, function(item, key) {
				$("#printContract" + key).print({
				    globalStyles: true,
				    mediaPrint: false,
				    stylesheet: null,
				    noPrintSelector: ".no-print",
				    iframe: true,
				    append: null,
				    prepend: null,
				    manuallyCopyFormValues: true,
				    deferred: $.Deferred()
            });
			});
			
		}
		
		// 获取数据列表
		this.getCostViewChart = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/viewChart.do',
				params:{
					costType:$scope.costType,
					costNo:$scope.costNo,
					remark:$scope.remark,
					startDate:$filter('date')($scope.costStartDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.costEndDate, "yyyy-MM-dd"),
				}
			}).then(function(res){
				if(res){
					var objData = res.data.objData;
					var inNum = parseFloat(0);
					var outNum = parseFloat(0);
					angular.forEach(objData, function(data,index,array){
						if(data.costType == "0"){
							inNum = parseFloat(data.costNum);
						}else{
							outNum = parseFloat(data.costNum);
						}
					});
					$scope.inPercent = inNum / (inNum + outNum) * 100 + '%';
					$scope.outPercent = outNum / (inNum + outNum) * 100 + '%';
					$scope.inStr = "" + inNum;
					$scope.outStr = "" + outNum;
					
					$scope.totalItems = res.data.total;
				}else{
					self.list = [];
					$scope.totalItems = 0;
				}
			});
		};
		
		//点击编辑
		this.editCost = function (costItem) {
			costItem.editMode = "edit";
			costItem.costDate = new Date(costItem.costDate);
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
				costTime:$filter('date')(costItem.costDate, "yyyy-MM-dd"),
				createTime:$filter('date')(costItem.createDate, "yyyy-MM-dd hh:mm:ss"),
				costNum:costItem.costNum,
				remark:costItem.remark,
				status:costItem.status,
				cosDepList:JSON.stringify(self.list[0].costDepList),
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/adminUpdate.do",
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
		
		//经理审核提交
		this.managerSubCost = function (costItem) {
			swal({ 
					title: "确定提交吗？", 
					text: "将提交给管理员审核！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"03"
					};
				self.updateStatus(params);
			});
		};

		//经理驳回
		this.managerRejCost = function (costItem) {
			swal({ 
					title: "确定驳回吗？", 
					text: "将驳回给申请者修改！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"02"
					};
				self.updateStatus(params);
			});
		};
		
		//管理员审核提交
		this.adminSubCost = function (costItem) {
			swal({ 
					title: "确定提交吗？", 
					text: "将通过审核并计入成本！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"05"
					};
				self.updateStatus(params);
			});
		};

		//管理员驳回
		this.adminRejCost = function (costItem) {
			swal({ 
					title: "确定驳回吗？", 
					text: "将驳回至部门经理！", 
					type: "info", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				var params = {
						costId:costItem.costId,
						status:"04"
					};
				self.updateStatus(params);
			});
		};
		
		//更新状态
		this.updateStatus = function (params) {
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/cost/updateCostStatus.do",
				params:params
				
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					//重新加载列表
					self.getCostList();
				}else{
					swal(res.data.msg);
				}
			})
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

		this.editBook = function (item, parentSelector, mode) {
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