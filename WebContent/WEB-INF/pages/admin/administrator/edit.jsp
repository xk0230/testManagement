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
                        <h1 class="page-header"><i class="im-users2"></i> 用户新增</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
				<!-- 个人信息 start here -->
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
                            <div class="panel panel-default toggle">
                                <!-- Start .panel -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><i class="ec-pencil"></i>个人信息</h3>
                                </div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" for="ds_host">用户名</label>
												<div class="col-lg-9 ">
													<input type="text" class="form-control" name="userName" ng-model="userName" id="userName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" for="ds_name">姓名</label>
												<div class="col-lg-9 ">
													<input type="text" class="form-control" name="realName" ng-model="realName" id="realName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" for="ds_name">部门</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" name="position" ng-model="position" id="position" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 个人信息 end here -->
				
				<!-- 岗位信息 start here -->
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
                            <div class="panel panel-default toggle">
                                <!-- Start .panel -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><i class="ec-pencil"></i>岗位信息</h3>
                                </div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" for="ds_host">用户名</label>
												<div class="col-lg-9 ">
													<input type="text" class="form-control" name="userName" ng-model="userName" id="userName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" for="ds_name">姓名</label>
												<div class="col-lg-9 ">
													<input type="text" class="form-control" name="realName" ng-model="realName" id="realName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-3 control-label" for="ds_name">部门</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" name="position" ng-model="position" id="position" />
												</div>
											</div>
											<div class="col-lg-3 pull-left">
												<ul class="nav navbar-nav pull-left">
													<li id="toggle-sidebar-li" class="ui-buttonset">
														<input type="button"  class="btn btn-primary" name="query" ng-click="vm.getFinancingInfoList()" value="查询" />
													</li>
													<li id="toggle-sidebar-li">
														<input type="button"  class="btn btn-success" name="query" ng-click="vm.addNewUser('')" value="新增用户" />
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
				<!-- 岗位信息 end here -->
			</div>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
	</div>

	<script src="${root}/public/js/pages/administrator/edit.js" type="text/javascript"></script>
</body>
</html>