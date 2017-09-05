<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body	>
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 用户新增</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
						
					</div>
				</div>
				<!-- 个人信息 start here -->
				<div class="outlet" ng-if="vm.edit == true">
					<div class="row">
						<div class="col-lg-12">
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
				<div class="outlet" ng-if="vm.add">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default toggle">
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>岗位信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">用户名</label>
												<div class="col-lg-8 ">
													<input type="text" class="form-control"  ng-model="vm.user.userName" id="userName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">姓名</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="realName" id="realName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">部门</label>
												<div class="col-lg-8">
	                                               <select class="form-control select2" ng-model="vm.user.depid" name="select2" ng-change="vm.getPostionById()" id="select2">
	                                                    <option value="">请选择</option>
														<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
	                                                </select>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">岗位</label>
												<div class="col-lg-8">
	                                               <select class="form-control select2" ng-model="post_id" name="select2"  id="select2">
	                                                    <option value="">请选择</option>
														<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
	                                                </select>
												</div>
											</div>
										</div>
										<!-- 第2行 -->
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">状态</label>
												<div class="col-lg-8 ">
													<input type="text" class="form-control"  ng-model="userName" id="userName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">薪级</label>
												<div class="col-lg-8 ">
													<input type="text" class="form-control" ng-model="realName" id="realName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">入职日期</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.entry_date" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">工龄</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="position" id="position" />
												</div>
											</div>
										</div>
										<!-- 第3行 -->
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">起薪日</label>
												<div class="col-lg-8 ">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.salary_begin_date" is-open="popup.opened2" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(2)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">试用期限</label>
												<div class="col-lg-8 ">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.probation_period" is-open="popup.opened3" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(3)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">预计转正日</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.expected_date" is-open="popup.opened4" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(4)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">服务期协议</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="position" id="position" />
												</div>
											</div>
										</div>
										<!-- 第4行 -->
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">服务期金额</label>
												<div class="col-lg-8 ">
													<input type="text" class="form-control"  ng-model="userName" id="userName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">劳动合同起</label>
												<div class="col-lg-8 ">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.labour_begin_time" is-open="popup.opened5" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(5)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">劳动合同止</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.labour_end_time" is-open="popup.opened6" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(6)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">签订次数</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="position" id="position" />
												</div>
											</div>
										</div>
										<!-- 第5行 -->
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">缴费基数</label>
												<div class="col-lg-8 ">
													<input type="text" class="form-control"  ng-model="userName" id="userName" />
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">备案日期</label>
												<div class="col-lg-8 ">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.filing_date" is-open="popup.opened7" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(7)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">离职日期</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.leave_date" is-open="popup.opene8" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(8)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_name">退工日期</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.retired_date" is-open="popup.opened9" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true" close-text="Close" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(9)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
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