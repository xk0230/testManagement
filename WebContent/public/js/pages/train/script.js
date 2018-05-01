var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker'])

myAppModule.controller('AdminUserTrianController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			self.getTrainList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getTrainList();
		};
		
		// 获取数据列表
		this.getTrainList = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/train/page.do',
				params:{
					userId:$("#userId").val(),
					project:$scope.project,
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
		this.addTrain = function(){
			var newItem = {
				trainTime:$filter('date')(new Date(), "yyyy-MM-dd")
				,trainEndTime:$filter('date')(new Date(), "yyyy-MM-dd")
				,project:""
				,place:""
				,form:""
				,result:""
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
		};
		/*保存*/
		this.save = function (trainItem) {
			if(!trainItem.project){
				swal("错误提示", "请填写培训项目！", "warning")
				return ;
			}
			if(!trainItem.place){
				swal("错误提示", "请填写培训地点！", "warning")
				return ;
			}
			if(!trainItem.form){
				swal("错误提示", "请填写培训形式！", "warning")
				return ;
			}
			if(!trainItem.result){
				swal("错误提示", "请填写培训结果！", "warning")
				return ;
			}
			if(!trainItem.trainTime){
				swal("错误提示", "请选择培训开始时间！", "warning")
				return ;
			}if(!trainItem.trainEndTime){
				swal("错误提示", "请选择培训结束时间！", "warning")
				return ;
			}
			var params = {
					id:trainItem.id,
					project:trainItem.project,
					place:trainItem.place,
					form:trainItem.form,
					result:trainItem.result,
					trainTime:$filter('date')(trainItem.trainTime, "yyyy-MM-dd"),
					trainEndTime:$filter('date')(trainItem.trainEndTime, "yyyy-MM-dd"),
					userId:$('#userId').val()
				}; 
			
			$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/train/saveOrUpdate.do",
					params:params
				
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg,"","success");
						self.getTrainList();
					}else{
						swal(res.data.msg,"","error");
					}
			});
		}
		
		/*编辑*/
		this.edit = function (trainItem) {
			trainItem.editMode = "edit";
		};
		
		//删除
		this.delTrain = function (trainItem) {
			swal({ 
					title: "确定删除吗？", 
					text: "你将无法恢复该培训信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				$http({
						method:'POST',
						url:$("#rootUrl").val()+"/admin/train/del/"+trainItem.id+".do",
						params:{}
					}).then(function(res){
						if(res.data.code == 0){
							swal(res.data.msg,"","success");
							self.getTrainList();
						}else{
							swal(res.data.msg,"","error");
						}
				});
			});
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);