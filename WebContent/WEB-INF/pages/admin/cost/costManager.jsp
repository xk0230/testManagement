<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script src="${root}/pages/js/cost/script.js" type="text/javascript"></script>
</head>
<body ng-app = "myApp" >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-controller="CostController as cost">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<!-- Start .row -->
					<!-- Start .page-header -->
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-table2"></i>成本管理</h1>
						<!-- Start .bredcrumb -->
						<ul id="crumb" class="breadcrumb">
						</ul>
						<ul class="searchWrap borderBox">
							<li>
								<label class="labelText">所属部门：</label>
								<select class="mr20" id="depart" ng-model="depart">
										<option value="-1">-- 请选择 --</option>
										
								</select>
								
								<label class="labelText">收支类型：</label>
								<select class="mr20" id="state" ng-model="state">
										<option value="-1">-- 请选择 --</option>
										<option value="0">收入</option>
										<option value="1">支出</option>
								</select>
								
								<label class="labelText">分类名称：</label>
								<select class="mr20" id="state" ng-model="state">
										<option value="-1">-- 请选择 --</option>
								</select>
								
								
								<label class="labelText">归属日期：</label>
								<input type="text" name="costTime" ng-model="position" id="costTime" />
								
								<input type="button" class="submit btn" name="query" ng-click="vm.getFinancingInfoList()" value="查询"  style="margin-left: 30px;"/>
								<input type="button" class="submit btn" name="query" ng-click="vm.getFinancingInfoList()" value="新增成本"  style="margin-left: 30px;"/>
								
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
												<th>所属部门</th>
												<th>收支类型</th>
												<th>分类名称</th>
												<th>录入金额</th>
												<th>归属日期</th>
												<th>更新时间</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<!-- <tr class="odd gradeX" ng-repeat="item in cost.list">
												<td><p ng-bind="item.userName"></p></td>
												<td><p ng-bind="item.realName"></p></td>
												<td><p ng-bind="item.username"></p></td>
												<td><p ng-bind="item.username"></p></td>
												<td><p ng-bind="item.workStatus"></p></td>
												<td><p ng-bind="item.createTime"></p></td>
												<td><p ng-bind="item.username"></p></td>
											</tr> -->
											<tr class="odd gradeX" ng-repeat="item in cost.list">
												<td>YSEC</td>
												<td>支出</td>
												<td>研发费</td>
												<td>1000</td>
												<td>2017-09</td>
												<td>2017-09-04 20:30</td>
												<td>
													<a href="#">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<a href="#">删除</a>
												</td>
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
	
</body>

<script type="text/javascript">

	 $(document).ready(function(){
		 alert(123);
		 /* $.post("${root}/admin/dep/getAlldep",{},function(data){
				if(data){
					
					alert(data.size);
					
				}
		}); */
		 
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

</html>