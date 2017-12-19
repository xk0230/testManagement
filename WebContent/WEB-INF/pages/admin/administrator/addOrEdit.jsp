<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
<script type="text/javascript" src="${root}/public/highcharts/highcharts-more.js"></script>
<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<form ng-submit="vm.onSubmit()" novalidate="novalidate">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 员工信息</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>

				<!-- 岗位信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-success toggle">
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>岗位信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div  class="col-lg-12">

											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">用户名</label>
												<div class="col-lg-8 ">
													<div class="form-group">
														<input type="hidden" class="form-control"  ng-model="vm.user.userId" ng-show="false"  />
														<input type="text" class="form-control"  ng-model="vm.user.userName"  ng-readonly="vm.readOnly" ng-required="true" />
													</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >姓名</label>
												<div class="col-lg-8">
													<div class="form-group">
														<input type="text" class="form-control" ng-model="vm.user.realName"  value="" ng-readonly="vm.readOnly" ng-required="true" />
													</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >部门</label>
												<div class="col-lg-8">
													<div class="form-group">
														<select class="form-control select2" ng-model="vm.user.depId"  ng-change="vm.getPostionById()" ng-disabled="vm.readOnly" ng-required="true" >
															<option value="">请选择</option>
															<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >角色</label>
												<div class="col-lg-8">
													<div class="form-group">
														<select class="form-control select2" ng-model="vm.user.position" ng-disabled="vm.readOnly" ng-required="true">
															<option value="">请选择</option>
															<option value="ADMIN" >管理员</option>
															<option value="MANAGER" ng-if="hasManager=='N'">部门经理</option>
															<optgroup label="部门经理" ng-if="hasManager=='Y'" style="color:#D0D0D0"></optgroup>
															<option value="STAFF" >员工</option>
														</select>
													</div>
												</div>
											</div>
										</div>
										<!-- 第2行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >岗位</label>
												<div class="col-lg-8">
													<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.postId" ng-disabled="vm.readOnly" ng-required="true">
														<option value="">请选择</option>
														<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
													</select>
												</div>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">状态</label>
												<div class="col-lg-8 ">
													<div class="form-group">
														<select class="form-control select2" ng-model="vm.user.workStatus">
															<option value="">请选择</option>
															<option value="试用期" >试用期</option>
															<option value="正式" >正式</option>
															<option value="离职" >离职</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >入职日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.entryDate" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
													     ng-disabled="vm.readOnly"  ng-change="vm.rzDayChanged()" ng-required="true"/>
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3" >
												<label class="col-lg-4 control-label" >工龄</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input  class="form-control" ng-model="vm.user.workingYears" id="position" ng-readonly="true" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第3行 -->
										<div  class="col-lg-12">	
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">起薪日</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.salaryBeginDate" is-open="popup.opened2" name="salaryBeginDate"
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false"  ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(2)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >试用期限</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.probationPeriod" is-open="popup.opened3"  name = "probationPeriod"
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(3)"><i class="glyphicon glyphicon-calendar" ng-readonly="vm.readOnly"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >转正日</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.expectedDate" is-open="popup.opened4" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(4)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >服务期协议</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.fwqAgreement" id="position" ng-readonly="vm.readOnly" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第4行 -->
										<div  class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">服务期金额</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<input type="number" class="form-control"  ng-model="vm.user.fwqNum" id="userName" ng-readonly="vm.readOnly"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >劳动合同起</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.labourBeginTime" is-open="popup.opened5" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(5)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >劳动合同止</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.labourEndTime" is-open="popup.opened6" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(6)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >已签订次数</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="number" class="form-control" ng-model="vm.user.signTime" id="position" ng-readonly="vm.readOnly" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第5行 -->
										<div  class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" for="ds_host">缴费基数</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<input type="number" class="form-control"  ng-model="vm.user.insuranceBase" id="userName" ng-readonly="vm.readOnly" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >备案日期</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.filingDate" is-open="popup.opened7" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(7)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >离职日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.leaveDate" is-open="popup.opened8" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(8)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >退工日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.retiredDate" is-open="popup.opened9" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(9)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
										</div>
										<div class="col-lg-12" ng-if="${adminUser.position == 'ADMIN'}" >
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >薪级</label>
												<div class="col-lg-8 ">
												<div class="form-group">
													<input type="number" class="form-control" ng-model="vm.user.salaryScale" ng-readonly="vm.readOnly" />
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

				<!-- 个人信息 start here -->
				<div class="outlet" ng-if="vm.edit == true">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-success toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>个人信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">姓名</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.realName" id="realname" value="${user.realName}"/>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">性别</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.sex">
														<option value="">请选择</option>
														<option value="0" >男</option>
														<option value="1" >女</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >出生日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.adminUserDetail.birthday" is-open="popup.opened10" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空" ng-change="vm.birthDayChanged()"
														ng-required="false"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(10)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >年龄</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.age"  readonly="readonly" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第2行 -->
										<div  class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >出生月份</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.birthdayMonth" readonly="readonly"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >身份证号</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.idNumber"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >籍贯</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.origin"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >户籍地</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.domicile"  />
												</div>
												</div>
											</div>
										</div>
										<!-- 第3行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >民族</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.nation"/>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >婚姻</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.marriage">
														<option value="">请选择</option>
														<option value="已婚" >已婚</option>
														<option value="未婚" >未婚</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >政治面貌</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.political">
														<option value="">请选择</option>
														<option value="群众" >群众</option>
														<option value="团员" >团员</option>
														<option value="党员" >党员</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >学历</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.education">
														<option value="">请选择</option>
														<option value="本科以下" >本科以下</option>
														<option value="本科" >本科</option>
														<option value="硕士" >硕士</option>
														<option value="博士" >博士</option>
													</select>
												</div>
												</div>
											</div>
										</div>
										<!-- 第4行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >专业</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.major" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >毕业院校</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.university" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >手机号码</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.phone1" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >备用手机号码</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.phone2" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第5行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >英语水平</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.english" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >其他语言水平</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.otherLanguage" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">参加工作日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.adminUserDetail.firstWorkTime" is-open="popup.opened22" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(22)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >家庭住址</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.address" />
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

				<!-- 银行信息 start here -->
				<div class="outlet" ng-if="vm.edit == true">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-success toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>银行信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="col-lg-12">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">市民卡</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.citizenCard"  />
												</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">工资卡</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.payrollCard"  />
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
				
				<!-- 家庭情况 start here -->
				<div class="outlet" ng-if="vm.edit == true">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-success toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>家庭情况</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">配偶姓名</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeName"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">学历</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeXl"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">专业</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeZy"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">出生日期</label>
												<div class="col-lg-8">
												<div class="form-group">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.adminUserDetail.homeBirthday" is-open="popup.opened11" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(11)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
												</div>
											</div>
										</div>
										<!-- 第2行 -->
										<div class="col-lg-12">
											<div class="col-lg-2">
												<label class="col-lg-12 control-label pull-left">工作单位及地址</label>
											</div>
											<div class="col-lg-10">
												<div class="col-lg-12">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeWork"  />
												</div>
												</div>
											</div>
										</div>
										<!-- 第3行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">职务</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeZw"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">联系电话</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homePhone"  />
												</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">身份证号</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeIdcard"  />
												</div>
												</div>
											</div>
										</div>
										
										<!-- 第3行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">子女姓名</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child1Name"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">出生日期</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.adminUserDetail.child1Birthday" is-open="popup.opened13" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(13)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">性别</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.child1Sex">
														<option value="">请选择</option>
														<option value="0" >男</option>
														<option value="1" >女</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">学习/工作单位</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child1Work"  />
												</div>
												</div>
											</div>
										</div>
										<!-- 第4行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">子女姓名</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child2Name"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">出生日期</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.adminUserDetail.child2Birthday" is-open="popup.opened14" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(14)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">性别</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.child2Sex">
														<option value="">请选择</option>
														<option value="0" >男</option>
														<option value="1" >女</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">学习/工作单位</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child2Work"  />
												</div>
												</div>
											</div>
										</div>
										<!-- 第5行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">子女姓名</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child3Name"  />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">出生日期</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="vm.user.adminUserDetail.child3Birthday" is-open="popup.opened15" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="false" ng-disabled="vm.readOnly" />
														<span class="input-group-btn">
															<button type="button" class="btn btn-default" ng-click="open(15)" ng-readonly="vm.readOnly"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">性别</label>
												<div class="col-lg-8">
												<div class="form-group">
													<select class="form-control select2" ng-model="vm.user.adminUserDetail.child3Sex">
														<option value="">请选择</option>
														<option value="0" >男</option>
														<option value="1" >女</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">学习/工作单位</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child3Work"  />
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
				
				<!-- 工作经历 start here -->
				<div class="outlet" ng-if="vm.edit == true">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-success toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>工作经历</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<table class="col-lg-12 table">
											<tr>
												<th width="10%" rowspan="7"  style="vertical-align:middle">工作简历</th>
												<th width="18%">时间</th>
												<th width="18%">就职单位</th>
												<th width="18%">离职原因</th>
												<th width="18%">职务</th>
												<th width="18%">重要业绩</th>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work1Time"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work1Place"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work1Reason"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work1Job"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work1Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work2Time"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work2Place"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work2Reason"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work2Job"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work2Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work3Time"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work3Place"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work3Reason"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work3Job"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work3Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work4Time"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work4Place"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work4Reason"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work4Job"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work4Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work5Time"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work5Place"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work5Reason"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work5Job"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work5Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work6Time"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work6Place"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work6Reason"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work6Job"  />
												</td>
												<td>
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.work6Zyyj"  />
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
					<!-- PDP信息 start here -->
				<div class="outlet" ng-if="${adminUser.position != 'STAFF'}" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-success toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>PDP信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<!-- 第1行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >顺境-谦和</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpSjA" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >顺境-韧性</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpSjB" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >顺境-理性</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpSjC" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >顺境-自信</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpSjD" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第2行 -->
										<div class="col-lg-12">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >逆境-谦和</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpNjA" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >逆境-韧性</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpNjB" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >逆境-理性</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpNjC" />
												</div>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >逆境-自信</label>
												<div class="col-lg-8">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.pdpNjD" />
												</div>
												</div>
											</div>
										</div>
										<!-- 第三行 -->
										<div class="col-lg-12" ng-show='false' >
											<div class="col-lg-6">
												<label class="col-lg-2 control-label">共享中心后续验证</label>
												
												<div class="col-lg-10">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.gx"  />
												</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-2 control-label">直接上级后续验证</label>
												<div class="col-lg-10">
												<div class="form-group">
													<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.sj"  />
												</div>
												</div>
											</div>
										</div>
										
									<!-- 第四行 -->
									<div class="col-lg-12">
									
									</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
						<!-- 	<div class="outlet">
												<td style="vertical-align:middle;"><h5>PDP:</h5></td>
												<td colspan="5" style="padding-right:0px;">
													<table class="col-lg-12 table display" >
														<tr class="odd gradeX">
															<th style="width:12%" >情景</th>
															<th style="width:22%" class="container">谦和</th>
															<th style="width:22%" class="container">韧性</th>
															<th style="width:22%" class="container">理性</th>
															<th style="width:22%" class="container">自信</th>
														</tr>
														<tr class="odd gradeX">
															<th>顺境</th>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjA" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjB" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjC" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjD" /></td>
														</tr>
														<tr class="odd gradeX" >
															<th>逆境</th>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjA" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjB" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjC" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjD" /></td>
														</tr>
													</table>
												</td>
				</div> -->
				<div id="containerpdp"  ng-if="${adminUser.position != 'STAFF'}"></div> 
				
				
				<div class="lead">
					<div class="row">
						<div class="col-lg-12 ">
							<div class="col-lg-9">
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
				
	
				<c:if test="${not empty user.userId }">
					<!-- 附件信息 start here -->
					<div class="outlet">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default toggle">
									<!-- Start .panel -->
									<div class="panel-heading">
										<h3 class="panel-title"><i class="ec-pencil"></i>附件信息</h3>
									</div>
									<div class="panel-body">
										<div class="form-horizontal group-border" role="form">
											<!-- 第1行 -->
											<div class="col-lg-12">
												<table class="table display" id="datatable">
													<thead>
														<tr>
															<th>文件名称</th>
															<th>类型</th>
															<th>创建日期</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody>
														<tr class="odd gradeX" ng-repeat="item in vm.listAttachment">
															<td><p ng-bind="item.name"></p></td>
															<td><p ng-bind="item.typeName"></p></td>
															<td><p ng-bind="item.createTime | date:'yyyy-MM-dd'"></p></td>
															<td>
																<a target="_black" href="/ssc/admin/attachment/preview.do?id={{item.id}}" >预览</a>
																<a target="_black" href="/ssc/admin/attachment/download.do?id={{item.id}}" >下载</a>
															</td>
															
														</tr>
													</tbody> 
												</table>
												<div class="g-no-content" ng-if="vm.listAttachment && vm.listAttachment.length === 0">没有相关数据</div>
												<div class="page">
													<ul style="float:right;" uib-pagination direction-links="false" boundary-links="true" total-items="attachmentTotalItems" ng-model="attachmentCurrentPage" first-text="第一页" last-text="最后一页" items-per-page="attachmentItemsPerPage" ng-change="attachmentPageChanged()"></ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					<!-- 培训信息 start here -->
					<div class="outlet">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default toggle">
									<!-- Start .panel -->
									<div class="panel-heading">
										<h3 class="panel-title"><i class="ec-pencil"></i>培训信息</h3>
									</div>
									<div class="panel-body">
										<div class="form-horizontal group-border" role="form">
											<!-- 第1行 -->
											<div class="col-lg-12">
												<table class="table display" id="datatable">
													<thead>
														<tr>
															<th>日期</th>
															<th>培训项目</th>
															<th>培训地点</th>
															<th>培训形式</th>
															<th>培训结果</th>
														</tr>
													</thead>
													<tbody>
														<tr class="odd gradeX" ng-repeat="item in vm.listTrain">
													
															<td><p ng-bind="item.trainTime | date:'yyyy-MM-dd'"></p></td>
															<td><p ng-bind="item.project"></p></td>
															<td><p ng-bind="item.place"></p></td>
															<td><p ng-bind="item.form"></p></td>
															<td><p ng-bind="item.result"></p></td>
															
														</tr>
													</tbody> 
												</table>
												<div class="g-no-content" ng-if="vm.listTrain && vm.listTrain.length === 0">没有相关数据</div>
												<div class="page">
													<ul style="float:right;" uib-pagination direction-links="false" boundary-links="true" total-items="trainTotalItems" ng-model="trainCurrentPage" first-text="第一页" last-text="最后一页" items-per-page="trainItemsPerPage" ng-change="trainPageChanged()"></ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 调岗信息 start here -->
					<div class="outlet">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default toggle">
									<!-- Start .panel -->
									<div class="panel-heading">
										<h3 class="panel-title"><i class="ec-pencil"></i>调岗信息</h3>
									</div>
									<div class="panel-body">
										<div class="form-horizontal group-border" role="form">
											<!-- 第1行 -->
											<div class="col-lg-12">
												<table class="table display" id="datatable">
													<thead>
														<tr>
															<th>日期</th>
															<th>调整前岗位</th>
															<th>调整后岗位</th>
															<th>调整前薪酬</th>
															<th>调整后薪酬</th>
															<th>其他备注</th>
														</tr>
													</thead>
													<tbody>
														<tr class="odd gradeX" ng-repeat="item in vm.listTransferPosition">
															<td><p ng-bind="item.transferTime | date:'yyyy-MM-dd'"></p></td>
															<td><p ng-bind="item.postOld"></p></td>
															<td><p ng-bind="item.postNew"></p></td>
															<td><p ng-bind="item.salaryOld"></p></td>
															<td><p ng-bind="item.salaryNew"></p></td>
															<td><p ng-bind="item.remark"></p></td>
														</tr>
													</tbody> 
												</table>
												<div class="g-no-content" ng-if="vm.vm.listTransferPosition && vm.vm.listTransferPosition.length === 0">没有相关数据</div>
												<div class="page">
													<ul style="float:right;" uib-pagination direction-links="false" boundary-links="true" total-items="transferPositionTotalItems" ng-model="transferPositionCurrentPage" first-text="第一页" last-text="最后一页" items-per-page="transferPositionItemsPerPage" ng-change="transferPositionPageChanged()"></ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
				
				</c:if>
				
				
			</div>
			</form>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
	</div>
	

	<script src="${root}/public/js/pages/administrator/edit.js" type="text/javascript"></script>
<%-- 	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script> --%>
</body>
</html>