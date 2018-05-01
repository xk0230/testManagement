var myAppModule = angular.module("myApp",['ui.bootstrap','materialDatePicker'])

myAppModule.controller('AttachmentController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		$scope.totalItems = 0;
		$scope.currentPage = 1;
		$scope.itemsPerPage = 10;
		
		this.$onInit = function(){
			
			self.getAttachmentEntityPageList();
		};
		
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			self.getAttachmentEntityPageList();
		};
		
		// 获取数据列表
		this.getAttachmentEntityPageList = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/attachment/page.do',
				params:{
					fId:$("#userId").val(),
					name:$scope.name,
					type:$scope.type,
					startDate:$filter('date')($scope.startDate, "yyyy-MM-dd"),
					endDate:$filter('date')($scope.endDate, "yyyy-MM-dd"),
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
		this.save = function (item,index) {
			
			if(!item){
				swal("错误提示", "请填写完整信息！", "warning");
				return ;
			}
			if(!item.type){
				swal("错误提示", "请填写类型！", "warning");
				return ;
			}
			
			
			var files = $("#fileUpload" + index)[0].files;
			if(!item.id && files.length == 0){
				swal("错误提示", "请选择文件！", "warning");
				return ;
			}
			var fd = new FormData();
			
			fd.append('uploadFile', files[0]);
			fd.append('fId', $('#userId').val());
			fd.append('type', item.type);
			if(item.id){
				fd.append('id',item.id);
			}
			
			$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/attachment/saveOrUpdate.do",
					data: fd,
					headers: {'Content-Type':undefined},
				
				}).then(function(res){
					if(res.data.code == 0){
						swal(res.data.msg);
						self.getAttachmentEntityPageList();
					}else{
						swal(res.data.msg);
					}
			});
		};
			
		/*编辑*/
		this.edit = function(item){
			item.editMode = "edit"
		}
			
		/*删除*/
		this.del = function (item) {
			swal({ 
					title: "确定删除吗？", 
					text: "你将无法恢复该附件信息！", 
					type: "warning", 
					showCancelButton: true, 
					closeOnConfirm: false, 
					showLoaderOnConfirm: true, 
			},
			function(){ 
				$http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/attachment/del/"+item.id+".do",
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
		
		/*添加*/
		this.add = function(){
			var newItem = {
				name:""
				,type:""
				,editMode:"edit"
				,createTime:$filter('date')(new Date(), "yyyy-MM-dd")
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
		
	}
);


//编辑页面的control
angular.module('myApp').controller('ModalInstanceCtrl', 
		function ($scope,$http,$uibModalInstance,$filter, items) {
	  var $ctrl = this;
	  $ctrl.items = items;
	  $ctrl.attachmentEntity = {
				
			};
	  
	  this.$onInit = function(){
		  
		  if(items != ''){
			  
			  $http({
					method:'POST',
					url:$("#rootUrl").val()+"/admin/attachment/get/"+items+".do",
					params:{
					}
				
				}).then(function(res){
					
					if(res.data.code == 0){
						
						$scope.attachmentEntity = res.data.objData;
						
					}
				});
		  }
		  
	  };
		
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  
		  if(!$scope.attachmentEntity){
			  alert("请填写完整信息");
			  return ;
		  }
		  if(!$scope.attachmentEntity.type){
			  alert("请填写类型");
			  return ;
		  }
		  
		 var fd = new FormData();
	     var file = document.querySelector('input[type=file]').files[0];
	     fd.append('uploadFile', file);
	     fd.append('fId', $('#userId').val());
	     fd.append('type', $scope.attachmentEntity.type);
	     if($scope.attachmentEntity.id){
	    	 fd.append('id',$scope.attachmentEntity.id);
	     }
		 
		 $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/attachment/saveOrUpdate.do",
				data: fd,
				headers: {'Content-Type':undefined},
			
			}).then(function(res){
				
				if(res.data.code == 0){
					$uibModalInstance.close('0');
				}
				
			});
	    
	  };

	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	  
	  
		$scope.today = function() {
			$scope.dt = new Date();
		};
		$scope.clear = function() {
			$scope.dt = null;
		};

		$scope.dateOptions = {
			dateDisabled: "",
			formatYear: 'yyyy',
			maxDate: new Date(9999, 12, 31),
			minDate: new Date(1000, 1,1),
			startingDay: 1,
		};

		$scope.open = function(mode) {
			if(mode == 1){
				$scope.popup.opened1 = true;
			}else if (mode == 2){
				$scope.popup.opened2 = true;
			}else if (mode == 3){
				$scope.popup.opened3 = true;
			}else if (mode == 4){
				$scope.popup.opened4 = true;
			}
			
		};
	
		$scope.popup = {
			opened1: false,
			opened2: false,
			opened3: false,
			opened4: false
		};
	  
	});


//删除页面的control
angular.module('myApp').controller('ModalInstanceDel', 
		function ($scope,$http,$uibModalInstance,items) {
	  var $ctrl = this;
	  $ctrl.items = items;
	  
	  $ctrl.selected = {
	    item: $ctrl.items[0]
	  };

	  $ctrl.ok = function () {
		  $http({
				method:'POST',
				url:$("#rootUrl").val()+"/admin/attachment/del/"+items+".do",
				params:{}
			
			}).then(function(res){
				
				if(res.data.code == 0){
					$uibModalInstance.close('0');
				}
				
			});
	  };

	  $ctrl.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	  
	});

angular.bootstrap(document.getElementById("content"), ['myApp']);