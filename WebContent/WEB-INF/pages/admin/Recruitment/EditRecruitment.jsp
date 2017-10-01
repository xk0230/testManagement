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
									<select class="form-control select2" ng-model="vm.Recruitment.depId" ng-change="vm.getPostionByDepId()" ng-required="true">
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
										<div  class="col-lg-12">
											<div class="form-group" >
												<textarea class="form-control" ng-model="vm.Recruitment.educationRemark" rows="3" Placeholder="点击输入学历备注"></textarea>
											</div>
										</div>
										<div class="form-group" >
											<div class="col-lg-3">
												<input type="checkbox" value="0">专业资格
											</div>
										</div>
										<div class="col-lg-12">
											<div class="form-group" >
											<textarea class="form-control" ng-model="vm.Recruitment.professional" rows="3" Placeholder="点击输入专业资格备注备注"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 候选人列表 -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-info toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>候选人</h3>
								</div>
								<div class="panel-body">
									<div>
										<button type="button" class="btn btn-success" ng-click="vm.editCost('','','.lead')"><i class="en-user-add">添加候选人</i></button>
									</div>
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>候选人名</th>
												<th>创建时间</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td><p ng-bind="item.name"></p></td>
												<td><p ng-bind="item.createTime | date:'yyyy-MM-dd'"></p></td>
												<td>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.editCost(item.id,item.name,'.lead')"><i class="br-pencil"></i></button>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
									<%@ include file="../../common/page.jsp"%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</form>
			
			
	<!-- 候选人，面试官编辑 -->
    <script type="text/ng-template" id="myModalEditContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 候选人和面试计划</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>

				<!-- 个人信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>候选人信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-12">
												<label class="col-lg-4 control-label">候选人姓名</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="candidateName" />
												</div>
											</div>
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 面试官列表 -->
					<div class="row" ng-if="$ctrl.candidateId">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-info toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>面试官</h3>
								</div>
								<div class="panel-body">
									<div>
										<button type="button" class="btn btn-success" ng-click="addInterview()"><i class="en-user-add">添加面试官</i></button>
									</div>
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>面试官名</th>
												<th>面试时间</th>
												<th>面试地点</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in InterviewList">
												<td><p ng-bind="item.interviewerName"></p></td>
												<td><p ng-bind="item.interviewTime | date:'yyyy-MM-dd'"></p></td>
												<td><p ng-bind="item.place"></p></td>
												<td>
													<button type="button" class="btn btn-xs btn-success" ng-click="editInterview(item)"><i class="br-pencil"></i></button>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
									<%@ include file="../../common/page.jsp"%>
								</div>
							</div>
						</div>
					</div>

					<div class="row" ng-if="showEdit">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>编辑面试官</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >部门</label>
												<div class="col-lg-8">
													<div class="form-group">
														<select class="form-control select2" ng-model="Interview.interviewerDepId"  ng-change="getPostionById()" ng-required="true" >
															<option value="">请选择</option>
															<option value="{{dep.depId}}" ng-repeat="dep in deplist">{{dep.name}}</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >岗位</label>
												<div class="col-lg-8">
													<div class="form-group">
													<select class="form-control select2" ng-model="Interview.interviewerPostId" ng-change="getFinancingInfoList()" ng-required="true">
														<option value="">请选择</option>
														<option value="{{pos.postId}}" ng-repeat="pos in postlist">{{pos.name}}</option>
													</select>
												</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >面试官</label>
												<div class="col-lg-8">
													<div class="form-group">
													<select class="form-control select2" ng-model="Interview.interviewerId" ng-required="true">
														<option value="">请选择</option>
														<option value="{{user.userId}}" ng-repeat="user in userList">{{user.realName}}</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >面试日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="Interview.interviewTime" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
													     ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >面试地点</label>
												<div class="col-lg-8">
													<div class="form-group">
														<input type="text" class="form-control" ng-model="Interview.place"  value="" ng-required="true" />
													</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >面试内容</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="Interview.interviewDetail"  value=""  ng-required="true" />
												</div>
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
			
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->

	<script src="${root}/public/js/pages/Recruitment/edit.js" type="text/javascript"></script>
</body>
</html>