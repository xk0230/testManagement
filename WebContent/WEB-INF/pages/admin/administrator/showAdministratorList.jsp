<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body ng-app = "myApp" >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-controller="UserListController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<!-- Start .row -->
					<!-- Start .page-header -->
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-table2"></i> 用户管理</h1>
						<!-- Start .bredcrumb -->
						<ul id="crumb" class="breadcrumb">
						</ul>
						<ul class="searchWrap borderBox">
							<li>
								<label class="labelText">用户名：</label>
								<input type="text" name="userName" ng-model="userName" id="userName" />
								<label class="labelText">姓名：</label>
								<input type="text" name="realName" ng-model="realName" id="realName" />
								<label class="labelText">联系电话：</label>
								<input type="text" name="contact"  ng-model="contact" id="contact" />
								<label class="labelText">职位：</label>
								<input type="text" name="position" ng-model="position" id="position" />
								<label class="labelText">请选择：</label>
								<select class="mr20" id="state" ng-model="state">
										<option value="-1">-- 请选择 --</option>
										<option value="N">开启</option>
										<option value="Y">关闭</option>
								</select>
								<input type="button" class="submit btn" name="query" ng-click="vm.getFinancingInfoList()" value="查询"  style="margin-left: 30px;"/>
							</li>
						</ul>
						<!-- End .breadcrumb -->
					</div>
					<!-- End .page	-header -->
				</div>
				<!-- End .row -->
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default plain toggle panelClose panelRefresh">
								<!-- Start .panel -->
								<div class="panel-heading white-bg">
									<h4 class="panel-title">Data table</h4>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>工号</th>
												<th>姓名</th>
												<th>部门s)</th>
												<th>岗位</th>
												<th>状态</th>
												<th>入职日期</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">

												
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- End .panel -->
						</div>
						<!-- col-lg-12 end here -->
					</div>
					<!-- Page End here -->
				</div>
				<!-- End .outlet -->
			</div>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
	</div>
		<script type="text/javascript">
			var myAppModule = angular.module("myApp",[])
			.controller('UserListController',
				function UserListController($scope,$http){
					var self = this;
					
					this.$onInit = function(){
						self.getFinancingInfoList();
					}
					
					// 默认分页参数对象
					this.pages = {
						totalCount : 0,
						currentPage : 1,
						recordNumber : 10
					}
					// 分页操作发生变化时
					$scope.$on('currentPageChange',function(evt,page){
						self.getFinancingInfoList();
					});
					
					// 获取数据列表
					this.getFinancingInfoList = function(){
						alert($scope.userName + $scope.realName + $scope.contact +$scope.position +$scope.state)
						$http({
							method:'POST',
							url:'${root}/admin/adminuser/getadminlist.do',
							data:JSON.stringify({
								'userName': $scope.userName,
								'realName': $scope.realName,
								'contact': $scope.contact,
								'position': $scope.position,
								'state': $scope.state
							})
						}).then(function(res){
							if(res){
								self.list = res.list || [];
								self.pages.totalCount = res.totalCount || 0;
							}else{
								self.list = [];
								self.pages.totalCount = 0;
							}
						})
						.finally(function(){
							layer.close(loading);
						});
					}
					
				}
			)
	</script>
	
	<script type="text/javascript">
	 $(document).ready(function(){
		$("#addOrgUser").click(function(){
			Win.open({id:"addOrgUserWin",url:"${root}/admin/adminuser/toaddadminuser.html",title:"新增账号",width:600,height:450,mask:true});
		});
		var splitPage;
		search();
	});
	
	
	function getOrgUserList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var baseUser;
				for(var i = 0,j = data.length;i<j;i++){
					baseUser = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+(start==null?'-':start)+'</td>';
					html+='<td>'+(baseUser.userName==null?'-':baseUser.userName)+'</td>';
					html+='<td>'+(baseUser.realName==null?'-':baseUser.realName)+'</td>';
					html+='<td>'+(baseUser.contact==null?'-':baseUser.contact)+'</td>';
					html+='<td>'+(baseUser.position==null?'-':baseUser.position)+'</td>';
					html+='<td>'+(getState(baseUser.locked)==null?'-':getState(baseUser.locked))+'</td>';
					html+='<td><a href="javascript:;" onclick="editOrgUser(\''+baseUser.adminUserId+'\');">编辑</a></td>';
					html+='</tr>';
					/* if('admin'==baseUser.adminUserId.trim()){
						html+='</td>';
					}else{
						html+='<a href="javascript:;" class="delLink" onclick="deleteOrgUser(\''+baseUser.adminUserId+'\');" style="">删除</a></td>';	
					} */
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='7'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='7'>抱歉，未查询到相关记录!</td></tr>");
			$("#totalNum").html("0");
		}
	}
	function getCreateRealName(createRealName){
		if(createRealName == null || createRealName == 'null' || createRealName == ''){
			return '无';
		}
		return createRealName;
	}
	
	function getUserType(adminFlag){
		if('Y' == adminFlag){
			return '超级管理员';
		}else{
			return '用户';
		}
	}
	function getState(locked){
		if('Y' == locked){
			return '关闭';
		}else{
			return '开启';
		}
	}
	
	function deleteOrgUser(id){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/adminuser/",{'adminUserId':id},function(data){
				if(data){
					if(data.result){
						Win.alert('删除成功');
						splitPage.reload();
					}else{
						Win.alert('删除失败！');
					}
				}else{
					Win.alert('删除失败！');
				}
			});
		},function(){});
	}
	
	function editOrgUser(baseUserId){
		Win.open({id:"addOrgUserWin",url:"${root}/admin/adminuser/getselbyid.do?userId="+baseUserId,title:"编辑账号",width:600,height:450,mask:true});
	}
	function search(){
		var userName = $.trim($("#userName").val());
		var realName = $.trim($("#realName").val());
		var contact=$.trim($("#contact").val());
		var position=$.trim($("#position").val());
		var state=$("#state").val();
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/adminuser/getadminlist.do",
				count : 20,
				type :"post",
				callback:getOrgUserList,
				data:{
					userName:userName,
					realName:realName,
					contact:contact,
					position:position,
					state:state
				}
			};
			splitPage = new SplitPage(config);
	}
	function exportOrgUserList(){
		var adminFlag = $("#adminFlag").val();
		var userName = $("#userName").val();
		var locked = $("#locked").val();
		var containFlag = "NO";
		if($('#containFlag').is(':checked')){
			containFlag = 'YES';
		}else{
			containFlag = 'NO';
		}
		var areas = $("#areaSelect select");
		var areaLength = areas.length;
		var baseAreaId = "";
		var baseAreaId1 = "";
		if(areaLength == 1){
			baseAreaId = $(areas[0]).val();
		}else{
			baseAreaId = $(areas[areaLength-2]).val();
			baseAreaId1 =$(areas[areaLength-1]).val();
			if("-1" != baseAreaId1){
				baseAreaId = baseAreaId1;
			}
		}
		var url = "${root }/admin/orgUser/exportOrgUserList.do?adminFlag="+adminFlag
				+"&userName="+encodeURIComponent(encodeURIComponent(userName))+"&locked="+locked+"&containFlag="+containFlag+"&baseAreaId="+baseAreaId;
		window.location.href = url;
	}
	
	function orgUserImport(){
		Win.open({id:"uploadExcel",width:500,height:260,title:"批量导入机构用户",url:"${root}/admin/commons/importUserPage.do?userType=area",mask:true});
	}
	</script>
</body>
</html>