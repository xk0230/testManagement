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
					<div class="col-lg-12 heading">
		                <ul class="nav navbar-nav pull-left">
		                    <li id="toggle-sidebar-li">
		                        <a href="#" id="toggle-sidebar"><i class="im-users"></i></a>
		                    </li>
		                    <li id="toggle-sidebar-li">
		                        <h1 class="page-header">成本管理</h1>
		                    </li>
		                </ul>
					</div>
				</div>
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
                                    <h4 class="panel-title"><i class="ec-search"></i> 查询条件</h4>
								</div>
								<div class="panel-body">
								
							<ul class="searchWrap borderBox">
								<li>
									<label class="labelText">所属部门：</label>
									<input type="text" name="userName" ng-model="userName" id="userName" />
									&nbsp;&nbsp;&nbsp;
									<label class="labelText">收支类型：</label>
									<input type="text" name="userName" ng-model="userName" id="userName" />
									
									&nbsp;&nbsp;&nbsp;
									<label class="labelText">分类名称：</label>
									<input type="text" name="position" ng-model="position" id="position" />
									&nbsp;&nbsp;&nbsp;
									<label class="labelText">归属日期：</label>
									<input type="text" name="position" ng-model="position" id="position" />
									
									<input type="button" class="submit btn" name="query" ng-click="vm.getFinancingInfoList()" value="查询"  style="margin-left: 30px;"/>
								</li>
							</ul>
								</div>
							</div>
						</div>
						
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-primary toggle">
							
									<input type="button" class="submit btn" name="query" ng-click="vm.getFinancingInfoList()" value="查询"  style="margin-left: 30px;"/>
								
							</div>
						</div>
						
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
									<h4 class="panel-title"><i class="ec-list"></i>查询结果</h4>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>所属部门</th>
												<th>收支类型</th>
												<th>分类名称</th>
												<th>归属日期</th>
												<th>金额</th>
												<th>更新时间</th>
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
									<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
									<%@ include file="../../common/page.jsp"%>
								</div>

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
	 $(document).ready(function(){
		
		 
		 
	 });
	
	
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
	<script src="${root}/public/js/pages/cost/script.js" type="text/javascript"></script>
</body>
</html>