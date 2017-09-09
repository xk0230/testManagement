<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="PostionController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="im-users2"></i> 岗位管理</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><i class="ec-search"></i>查询条件</h3>
                                </div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">岗位名称</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="name"/>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">所属部门</label>
												<div class="col-lg-8">
													<select id="depId" ng-model="depId"  class="form-control select2" 
															ng-options="dep.depId as dep.name group by dep.group for dep in depList">
															<option value="">--请选择--</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">岗位状态</label>
												<div class="col-lg-8">
													<select ng-model="status" class="form-control">
														<option value="">--请选择--</option>
														<option value="{{status.statusId}}" ng-repeat="status in vm.statusList">{{status.statusName}}</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3 pull-left">
												<ul class="nav navbar-nav pull-left">
													<li id="toggle-sidebar-li" class="ui-buttonset">
														<input type="button"  class="btn btn-primary" name="query" ng-click="vm.getList()" value="查询" />
													</li>
													<li id="toggle-sidebar-li">
														<input type="button"  class="btn btn-success " name="query" ng-click="vm.edit('', '.outlet')" value="新增岗位" />
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
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
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>查询结果</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>所属部门</th>
												<th>岗位名称</th>
												<th>编制</th>
												<th>在岗人数</th>
												<th>空缺</th>
												<th colspan="3">操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td class="col-lg-2"><p ng-bind="item.depName"></p></td>
												<td class="col-lg-3"><p ng-bind="item.name"></p></td>
												<td class="col-lg-1"><p ng-bind="item.onDuty"></p></td>
												<td class="col-lg-1"><p ng-bind="item.organization"></p></td>
												<td class="col-lg-1"><p ng-bind="item.vacancy"></p></td>
												<td>
													<button type="button" class="btn btn-sm btn-success" ng-click="vm.edit(item.postId,'.outlet')">查看岗位</i></button>
													<button type="button" class="btn btn-sm btn-success" ng-click="">招聘进度</i></button>
													<button type="button" class="btn btn-sm btn-success" ng-click="">查看员工</button>
												</td>
												
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
		
    <script type="text/ng-template" id="myModalContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i>岗位信息</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>

				<!-- 个人信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>成本记录</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">

										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">所属部门</label>
												<div class="col-lg-8">
													<select ng-model="costEntity.depId"  class="form-control select2" 
															ng-options="dep.depId as dep.name group by dep.group for dep in depList"
															ng-change="$ctrl.getPostionById()">
															<option value="">--请选择--</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >岗位</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="costEntity.name" ng-blur="$ctrl.cau()" />
												</div>
											</div>
										</div>

										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">编制人数</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="costEntity.onDuty" ng-blur="$ctrl.cau()" />
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >在岗人数</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="costEntity.organization" ng-blur="$ctrl.cau()" />
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">空缺人数</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="costEntity.vacancy" ng-readonly="true" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">保存</button>
            <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        </div>
    </script>
	</div>

	
	
	<input type="hidden" id="rootUrl" value="${root}">
			
	<script src="${root}/public/js/pages/postion/script.js" type="text/javascript"></script>
</body>
</html>