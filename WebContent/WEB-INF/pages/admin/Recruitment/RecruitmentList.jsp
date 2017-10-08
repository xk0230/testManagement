<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="im-users2"></i> 招聘需求列表</h1>
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
												<label class="col-lg-3 control-label" >部门</label>
												<div class="col-lg-9">
													<select class="form-control select2" ng-model="depId"  ng-change="vm.getPostionById()" >
														<option value="">请选择</option>
														<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
													</select>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" >岗位</label>
												<div class="col-lg-9">
													<select class="form-control select2" ng-model="postId" >
														<option value="">请选择</option>
														<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
													</select>
												</div>
											</div>
											<div class="col-lg-3">
											</div>
											<div class="col-lg-3">
												<div class="col-lg-6">
													<input type="button"  class="btn btn-lg btn-primary col-lg-12" name="query" ng-click="vm.search()" value="查询" />
												</div>
												<div class="col-lg-6">
													<input type="button"  class="btn btn-lg btn-success col-lg-12" name="query" ng-click="vm.addNewRecruitment()" value="新增招聘需求" ng-if="type!='myApproval'" />
												</div>
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
												<th>岗位名称</th>
												<th>状态</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td><p ng-bind="item.postName"></p></td>
												<td><p ng-bind="item.statusStr"></p></td>
												<td>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.edit(item.id)"><i class="br-pencil"></i> 编辑</button>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.evaluation(item.id)" ng-if="${adminUser.position == 'ADMIN'}"><i class="fa-thumbs-up"></i> 管理员评估</button>
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
	</div>
	<script src="${root}/public/js/pages/Recruitment/script.js" type="text/javascript"></script>
</body>
</html>