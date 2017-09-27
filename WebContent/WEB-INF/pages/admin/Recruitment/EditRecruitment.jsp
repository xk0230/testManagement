<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body	>
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<form ng-submit="vm.onSubmit()" novalidate="novalidate">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 招聘需求</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>
				<div class="lead">
					<div class="row">
						<div class="col-lg-12 ">
							<div>
								<div class="col-lg-3 form-group">
									<select class="form-control select2" ng-model="vm.depId" ng-change="vm.getPostionByDepId()" ng-required="true">
										<option value="">请选择部门</option>
										<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
									</select>
								</div>
								<div class="col-lg-3 form-group">
									<select class="form-control select2" ng-model="vm.Recruitment.postid" ng-change="vm.getPostionInfo()" ng-required="true">
										<option value="">请选择岗位</option>
										<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
									</select>
								</div>
								<div class="col-lg-3">
								</div>
								<div class="col-lg-3">
									<label class="col-lg-4 control-label" ></label>
									<div class="col-lg-8">
										<input type="submit" class="btn btn-lg btn-success col-lg-12" ladda = "submitting"  value="保存" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<input type="text" class="form-control"  ng-model="vm.user.userId" ng-show="false"  />
				<!-- 岗位信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>相关经历/成就要求</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div>
											<div class="col-lg-4">
												<div class="form-group">
												<label class="control-label" >过往职业：</label>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
												<label class="control-label" >工作经验：</label>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
												<label class="control-label" >关键成就：</label>
												</div>
											</div>
										</div >
										<div>
											<div class="col-lg-4">
												<div class="form-group">
													<textarea class="form-control" ng-model="vm.Recruitment.recruitA" rows="3" Placeholder="点击输入过往职业"  ng-required="true"></textarea>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
													<textarea class="form-control" ng-model="vm.Recruitment.recruitB"  rows="3" Placeholder="点击输入工作经验" ng-required="true"></textarea>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
													<textarea class="form-control" ng-model="vm.Recruitment.recruitC"  rows="3" Placeholder="点击输入关键成就"  ng-required="true"></textarea>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>技术/岗位要求</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div>
											<div class="col-lg-4">
												<div class="form-group">
												<label class="control-label" >基本要求1：</label>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
												<label class="control-label" >基本要求2：</label>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
												<label class="control-label" >基本要求3：</label>
												</div>
											</div>
										</div>
										<div>
											<div class="col-lg-4">
												<div class="form-group">
												<textarea class="form-control" ng-model="vm.Recruitment.recruitD"  rows="3" Placeholder="点击输入基本要求1"></textarea>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
												<textarea class="form-control" ng-model="vm.Recruitment.recruitE"  rows="3" Placeholder="点击输入基本要求2"></textarea>
												</div>
											</div>
											<div class="col-lg-4">
												<div class="form-group">
												<textarea class="form-control" ng-model="vm.Recruitment.recruitF"  rows="3" Placeholder="点击输入基本要求3"></textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>胜任特征</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="form-group" >
											<div class="col-lg-4 pull-left" ng-repeat="Competency in vm.AllCompetency">
	                                            <div class="checkbox">
	                                                <label>
	                                                    <input type="checkbox" class="Competency" id="competency{{Competency.id}}" value="{{Competency.id}}">{{Competency.name}}
	                                                </label>
	                                            </div>
                                            </div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>教育背景</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="form-group" >
											<div class="col-lg-3">
												<select class="form-control select2" ng-model="vm.Recruitment.education" ng-change="" >
													<option value="">请选择学历</option>
													<option value="博士">学士</option>
													<option value="硕士">硕士</option>
													<option value="学士">学士</option>
													<option value="专科">专科</option>
												</select>
											</div>
											<div class="col-lg-9">
											</div>
										</div>
										<div>
											<div class="form-group" >
											<textarea class="form-control" ng-model="vm.Recruitment.educationRemark" rows="3" Placeholder="点击输入学历备注"></textarea>
											</div>
										</div>
										<div class="form-group" >
											<div class="col-lg-3">
												<input type="checkbox" value="0">专业资格
											</div>
										</div>
										<div>
											<div class="form-group" >
											<textarea class="form-control" ng-model="vm.Recruitment.professional" rows="3" Placeholder="点击输入专业资格备注备注"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</form>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->

	<script src="${root}/public/js/pages/Recruitment/edit.js" type="text/javascript"></script>
</body>
</html>