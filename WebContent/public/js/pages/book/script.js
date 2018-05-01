var myAppModule = angular.module("myApp",['ui.bootstrap'])
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]); 
myAppModule.controller('CostController',
	function costListController($scope,$http,$location,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 50;
		
		this.$onInit = function(){
			self.getBookList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getBookList();
		};
		
		// 获取数据列表
		this.getBookList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/book/page.do',
				cache:false,
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
		
		/*上传*/
		this.save = function (item) {
			
			if(!item){
				swal("错误提示", "请填写完整信息！", "warning");
				return ;
			}
			if(!item.name){
				swal("错误提示", "请填写图书名称！", "warning");
				return ;
			}
			
			var params = {
				id:item.id,
				name:item.name
			};
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/book/saveOrUpdate.do",
				params:params
			}).then(function(res){
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getBookList();
				}else{
					swal(res.data.msg);
				}
			});
		};
		
		/*添加*/
		this.add = function(){
			var newItem = {
				name:""
				,editMode:"edit"
			};
			var myArray=new Array()
			myArray.push(newItem);
			
			$.each(self.list,
				function(index, value) {
					myArray.push(value);
				}
			);
			self.list = myArray;
		}
		
		/*编辑*/
		this.edit = function(item){
			item.editMode = "edit"
		}
		
		this.pullOrBackBook = function (item) {
			$http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/book/getOrBack/"+item.id+".do",
				params:{}
			}).then(function(res){
				
				if(res.data.code == 0){
					swal(res.data.msg);
					self.getBookList();
				}else{
					swal(res.data.msg);
				}
				
			});
		};
		
	}
);


angular.bootstrap(document.getElementById("content"), ['myApp']);