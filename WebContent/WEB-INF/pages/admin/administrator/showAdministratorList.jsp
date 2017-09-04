<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script src="${root}/WEB-INF/pages/js/administrator/script.js" type="text/javascript"></script>
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
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">查询结果</h4>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>工号</th>
												<th>姓名</th>
												<th>部门</th>
												<th>岗位</th>
												<th>状态</th>
												<th>入职日期</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td><p ng-bind="item.userName"></p></td>
												<td><p ng-bind="item.realName"></p></td>
												<td><p ng-bind="item.username"></p></td>
												<td><p ng-bind="item.username"></p></td>
												<td><p ng-bind="item.workStatus"></p></td>
												<td><p ng-bind="item.createTime"></p></td>
												<td><p ng-bind="item.username"></p></td>
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

	</script>
	
	<script type="text/javascript">
	 $(document).ready(function(){
		$("#addOrgUser").click(function(){
			Win.open({id:"addOrgUserWin",url:"${root}/admin/adminuser/toaddadminuser.html",title:"新增账号",width:600,height:450,mask:true});
		});
		var splitPage;
		search();
	});
	
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
	
	function orgUserImport(){
		Win.open({id:"uploadExcel",width:500,height:260,title:"批量导入机构用户",url:"${root}/admin/commons/importUserPage.do?userType=area",mask:true});
	}
	</script>
</body>
</html>