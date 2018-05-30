<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	<style>
		.lineMargin {
			margin-top:5px;
		}
		.btn-right{
			margin-right:5px;
		}
	</style>
	<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<form ng-submit="vm.onSubmit()" novalidate="novalidate">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>招聘需求</h3>
							</div>
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span359 form-group pull-right">
										<input type="button" class="btn btn-large btn-right btn-danger pull-right" value="驳回" ng-click="vm.refuse()" ng-if="vm.Recruitment.status== 'auditing'&&ButtonShow" />
										<input type="button" class="btn btn-large btn-right btn-warning pull-right" value="提交审批" ng-click="vm.putAuditRecruit()" ng-if="vm.Recruitment.status== 'unaudit'" />
										<input type="button" class="btn btn-large btn-right btn-success pull-right" value="通过" ng-click="vm.accept()" ng-if="vm.Recruitment.status== 'auditing'&&ButtonShow" />
										<input type="submit" class="btn btn-large btn-right btn-success pull-right" value="保存" ng-if="vm.Recruitment.status!= 'auditing' && vm.Recruitment.status!='audited' && !ButtonShow" />
									</div>
								</div>
								
								<div class="row">
									<h3 class="panel-title span359"><i class="icon-play  "></i> 部门/岗位</h3>
									
								</div>
								<hr>
								<div class="row lineMargin">
									<div class="span359 form-group">
										<span class="searchSpan">部门 :</span>
										<select class="form-control select2" ng-model="vm.Recruitment.depId" ng-change="vm.getPostionByDepId()" ng-required="true">
											<option value="">请选择部门</option>
											<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
										</select>
									</div>
									
									<div class="span359 form-group">
										<span class="searchSpan">岗位 :</span>
										<select class="form-control select2" ng-model="vm.Recruitment.postid" ng-change="vm.getPostionInfo()" ng-required="true">
											<option value="">请选择岗位</option>
											<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
										</select>
									</div>
								</div>
								<br>
								<!-- 驳回理由 -->
								<div class="row lineMargin" ng-show="RefuseFlag">
									<div class="span6 form-group">
										<span class="searchSpan">驳回理由 :</span>
										<textarea class="form-control" ng-model="RefuseReason" rows="3" Placeholder="请输入驳回理由后再点击驳回按钮"></textarea>
									</div>
								</div>
								<!-- 请选择审批管理员 -->
								<div class="row lineMargin" ng-show="${adminUser.userId == 'admin'}&&AdminAcceptFlag">
									<div class="span10 form-group">
										<h3 class="pull-left">请选择审批管理员 :</h3>
										<div ng-show="admin.userId!='admin'" ng-repeat="admin in vm.adminlist" class="col-lg-2 pull-left" style="margin-left:15px;">
											<input type="checkbox" class="adminList" id="{{admin.userId}}" value="{{admin.id}}">&nbsp;&nbsp;{{admin.realName}}
										</div>
									</div>
								</div>
								<br>
								<!-- 相关经历/成就要求 -->
								<div class="row lineMargin">
									<h3 class="panel-title span359"><i class="icon-play"></i> 相关经历/成就要求</h3>
								</div>
								<hr>
								<div class="row lineMargin">
									<div class="span359 form-group">
										<span class="searchSpan">过往职业 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.recruitA" rows="3" Placeholder="点击输入过往职业"  ng-required="true"></textarea>
									</div>
									<div class="span359 form-group">
										<span class="searchSpan">工作经验 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.recruitB"  rows="3" Placeholder="点击输入工作经验" ng-required="true"></textarea>
									</div>
									<div class="span359 form-group">
										<span class="searchSpan">关键成就 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.recruitC"  rows="3" Placeholder="点击输入关键成就"  ng-required="true"></textarea>
									</div>
								</div>
								<br>
								<!-- 技术/岗位要求 -->
								<div class="row lineMargin">
									<h3 class="panel-title span359"><i class="icon-play"></i> 技术/岗位要求</h3>
								</div>
								<hr>
								<div class="row lineMargin">
									<div class="span359 form-group">
										<span class="searchSpan">基本要求1 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.recruitD"  rows="20" Placeholder="点击输入基本要求1"></textarea>
									</div>
									<div class="span359 form-group">
										<span class="searchSpan">基本要求2 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.recruitE"  rows="20" Placeholder="点击输入基本要求2"></textarea>
									</div>
									<div class="span359 form-group">
										<span class="searchSpan">IPE要求 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.recruitF"  rows="20" Placeholder="非必填"></textarea>
									</div>
								</div>
								<br>
								<!-- 胜任特征 -->
								<div class="row lineMargin">
									<h3 class="panel-title span359"><i class="icon-play"></i>胜任特征</h3>
								</div>
								<hr>
								<div class="row lineMargin">
									<div class="span359 form-group" ng-repeat="Competency in vm.AllCompetency">
										<input type="checkbox" class="Competency" id="competency{{Competency.id}}" value="{{Competency.id}}">{{Competency.name}}
									</div>
								</div>
								<br>
								<!-- 教育背景 -->
								<div class="row lineMargin">
									<h3 class="panel-title span359"><i class="icon-play"></i>教育背景</h3>
								</div>
								<hr>
								<div class="row lineMargin">
									<div class="span359 form-group">
										<span class="searchSpan">学历 :</span>
										<select class="form-control select2" ng-model="vm.Recruitment.education" ng-change="" >
											<option value="">请选择学历</option>
											<option value="博士">博士</option>
											<option value="硕士">硕士</option>
											<option value="学士">学士</option>
											<option value="专科">专科</option>
										</select>
									</div>
									<div class="span359 form-group">
										<span class="searchSpan">学历备注 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.educationRemark" rows="3" Placeholder="点击输入学历备注"></textarea>
									</div>
									<div class="span359 form-group">
										<span class="searchSpan">专业资格 :</span>
										<textarea class="form-control" ng-model="vm.Recruitment.professional" rows="3" Placeholder="点击输入专业资格备注备注"></textarea>
									</div>
								</div>
							</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="${root}/public/js/pages/Recruitment/edit.js" type="text/javascript"></script>
</body>
</html>