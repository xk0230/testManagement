<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
<script type="text/javascript" src="${root}/public/highcharts/highcharts-more.js"></script>
<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<div class="main-inner">
				<div class="container">
					<div class="row">
						<div class="span12">
							<form ng-submit="vm.onSubmit()" novalidate="novalidate">
							
							<div class="widget">
								<!-- 岗位信息 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>岗位信息</h3>
								</div>
								<div class="widget-content" >
									<!-- 岗位信息 -->
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan">用户名:</span>
											<input type="hidden" class="form-control"  ng-model="vm.user.userId" ng-show="false"  />
											<input type="text" class="form-control"  ng-model="vm.user.userName"  ng-readonly="vm.readOnly" ng-required="true" />
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">姓名:</span>
											<input type="text" class="form-control" ng-model="vm.user.realName"  value="" ng-readonly="vm.readOnly" ng-required="true" />
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">部门:</span>
											<select class="form-control select2" ng-model="vm.user.depId"  ng-change="vm.getPostionById()" ng-disabled="vm.readOnly" ng-required="true" >
												<option value="">请选择</option>
												<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan">角色:</span>
											<select class="form-control select2" ng-model="vm.user.position" ng-disabled="vm.readOnly" ng-required="true">
												<option value="">请选择</option>
												<option value="ADMIN" >管理员</option>
												<option value="MANAGER" ng-if="hasManager=='N'">部门经理</option>
												<optgroup label="部门经理" ng-if="hasManager=='Y'" style="color:#D0D0D0"></optgroup>
												<option value="STAFF" >员工</option>
											</select>
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">岗位:</span>
											<select class="form-control select2" ng-model="vm.user.postId" ng-disabled="vm.readOnly" ng-required="true">
												<option value="">请选择</option>
												<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
											</select>                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">状态:</span>
											<select class="form-control select2" ng-model="vm.user.workStatus">
												<option value="">请选择</option>
												<option value="试用期" >试用期</option>
												<option value="正式" >正式</option>
												<option value="离职" >离职</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan pull-left">入职日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.entryDate" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly"></mb-datepicker>
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">工龄:</span>
											<input class="form-control" ng-model="vm.user.workingYears" id="position" ng-readonly="true" />
										</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">起薪日:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.salaryBeginDate" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan pull-left">试用期限:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.probationPeriod" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">转正日:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.expectedDate" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
										<div class="span359">
	                                        <span class="searchSpan">服务期协议:</span>
											<input type="text" class="form-control" ng-model="vm.user.fwqAgreement" id="position" ng-readonly="vm.readOnly" />
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan pull-left">服务期金额:</span>
											<input type="number" class="form-control"  ng-model="vm.user.fwqNum" id="userName" ng-readonly="vm.readOnly" style="margin-left:4px" />
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">劳动合同起:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.labourBeginTime" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">劳动合同止:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.labourEndTime" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan">已签订次数:</span>
											<input type="number" class="form-control" ng-model="vm.user.signTime" id="position" ng-readonly="vm.readOnly" />
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">缴费基数:</span>
											<input type="number" class="form-control"  ng-model="vm.user.insuranceBase" id="userName" ng-readonly="vm.readOnly" />
										</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">备案日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.filingDate" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan pull-left">离职日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.leaveDate" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
										<div class="span359">
											<span class="searchSpan pull-left">退工日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.retiredDate" date-format="YYYY-MM-DD" class="pull-left" ng-disabled="vm.readOnly" ></mb-datepicker>
										</div>
										<div class="span359">
											<span class="searchSpan">薪级:</span>
											<input type="number" class="form-control" ng-model="vm.user.salaryScale" ng-readonly="vm.readOnly" />
										</div>
									</div>
									
								</div>
<br>
								<!-- 个人信息 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>个人信息</h3>
								</div>
								<div class="widget-content">
									<!-- 岗位信息 -->
									<div class="row">
										<div class="span359">
											<span class="searchSpan">姓名:</span>
											<input type="text" class="form-control" ng-model="vm.user.realName" id="realname" value="${user.realName}"/>
										</div>
										<div class="span359">
											<span class="searchSpan">性别:</span>
											<select class="form-control select2" ng-model="vm.user.adminUserDetail.sex">
												<option value="">请选择</option>
												<option value="0" >男</option>
												<option value="1" >女</option>
											</select>
										</div>
										<div class="span359">
											<span class="searchSpan pull-left">出生日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.adminUserDetail.birthday" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan">年龄:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.age"  readonly="readonly" />
										</div>
										<div class="span359">
											<span class="searchSpan">出生月份:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.birthdayMonth" readonly="readonly"  />
										</div>
										<div class="span359">
	                                        <span class="searchSpan">身份证号:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.idNumber"  />
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan pull-left">籍贯:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.origin" style="margin-left:4px;" />
										</div>
										<div class="span359">
											<span class="searchSpan">户籍地:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.domicile"  />
										</div>
										<div class="span359">
											<span class="searchSpan pull-left">民族:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.nation" style="margin-left:4px;"/>
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan pull-left">婚姻:</span>
											<select class="form-control select2" ng-model="vm.user.adminUserDetail.marriage" style="margin-left:4px;">
												<option value="">请选择</option>
												<option value="已婚" >已婚</option>
												<option value="未婚" >未婚</option>
											</select>
                                    	</div>
										<div class="span359">
											<span class="searchSpan pull-left">政治面貌:</span>
											<select class="form-control select2" ng-model="vm.user.adminUserDetail.political" style="margin-left:4px;">
												<option value="">请选择</option>
												<option value="群众" >群众</option>
												<option value="团员" >团员</option>
												<option value="党员" >党员</option>
											</select>
										</div>
										<div class="span359">
											<span class="searchSpan">学历:</span>
											<select class="form-control select2" ng-model="vm.user.adminUserDetail.education">
												<option value="">请选择</option>
												<option value="本科以下" >本科以下</option>
												<option value="本科" >本科</option>
												<option value="硕士" >硕士</option>
												<option value="博士" >博士</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan pull-left">专业:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.major" style="margin-left:4px;" />
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">毕业院校:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.university" style="margin-left:4px;" />
										</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">手机号码:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.phone1" style="margin-left:4px;" />
										</div>
									</div>
									<div class="row">
										<div class="span359">
	                                        <span class="searchSpan">备用手机号码:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.phone2" />
                                    	</div>
										<div class="span359">
	                                        <span class="searchSpan">英语水平:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.english" />	
										</div>
										<div class="span359">
	                                        <span class="searchSpan pull-left">其他语言水平:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.otherLanguage" style="margin-left:4px;" />
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan pull-left">参加工作日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.adminUserDetail.firstWorkTime" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</div>
										<div class="span359">
											<span class="searchSpan pull-left">家庭住址:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.address" style="margin-left:4px;" />
										</div>
										<div class="span359">
											
										</div>
									</div>
									
								</div>
<br>
								<!-- 银行信息 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>银行信息</h3>
								</div>
								<div class="widget-content">
									<div class="row">
										<div class="span359">
											<span class="searchSpan">市民卡:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.citizenCard"  />
										</div>
										<div class="span359">
											<span class="searchSpan">工资卡:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.payrollCard"  />
										</div>
										<div class="span359">
										</div>
									</div>
								</div>
<br>
								<!-- 家庭情况 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>家庭情况</h3>
								</div>
								<div class="widget-content">
									<div class="row">
										<div class="span359">
											<span class="searchSpan">配偶姓名:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeName"  />
										</div>
										<div class="span359">
											<span class="searchSpan">学历:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeXl"  />
										</div>
										<div class="span359">
											<span class="searchSpan">专业:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeZy"  />
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan pull-left">出生日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.adminUserDetail.homeBirthday" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</div>
										<div class="span359">
											<span class="searchSpan">工作单位:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeWork"  />
										</div>
										<div class="span359">
											<span class="searchSpan">职务:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeZw"  />
										</div>
									</div>
									<div class="row">
										<div class="span359">
											<span class="searchSpan pull-left">联系电话:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homePhone" style="margin-left:4px;" />
										</div>
										<div class="span359">
											<span class="searchSpan">身份证号:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.homeIdcard"  />
										</div>
										<div class="span359"></div>
									</div>
									<div class="row">
										<div class="span3" style="width:200px;">
											<span class="searchSpan">子女姓名:</span>
											<input type="text" class="form-control" style="width:70px;" ng-model="vm.user.adminUserDetail.child1Name" />
										</div>
										<div class="span359" style="width:240px;">
											<span class="searchSpan pull-left">出生日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.adminUserDetail.child1Birthday" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</div>
										<div class="span359" style="width:200px;">
											<span class="searchSpan pull-left" style="width:80px;">性别:</span>
											<select class="form-control select2" style="width:70px;" ng-model="vm.user.adminUserDetail.child1Sex">
												<option value="">请选择</option>
												<option value="0" >男</option>
												<option value="1" >女</option>
											</select>
										</div>
										<div class="span359">
											<span class="searchSpan">单位:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child1Work"  />
										</div>
									</div>
									<div class="row">
										<div class="span3" style="width:200px;">
											<span class="searchSpan">子女姓名:</span>
											<input type="text" class="form-control" style="width:70px;" ng-model="vm.user.adminUserDetail.child2Name" />
										</div>
										<div class="span359" style="width:240px;">
											<span class="searchSpan pull-left">出生日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.adminUserDetail.child2Birthday" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
                                    	</div>
										<div class="span359" style="width:200px;">
											<span class="searchSpan pull-left" style="width:80px;">性别:</span>
											<select class="form-control select2" style="width:70px;" ng-model="vm.user.adminUserDetail.child2Sex">
												<option value="">请选择</option>
												<option value="0" >男</option>
												<option value="1" >女</option>
											</select>
										</div>
										<div class="span359">
											<span class="searchSpan">单位:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child2Work"  />
										</div>
									</div>
									<div class="row">
										<div class="span3" style="width:200px;">
											<span class="searchSpan">子女姓名:</span>
											<input type="text" class="form-control" style="width:70px;" ng-model="vm.user.adminUserDetail.child3Name" />
										</div>
										<div class="span359" style="width:240px;">
											<span class="searchSpan pull-left">出生日期:</span>
											<mb-datepicker input-class="mb-date" date="vm.user.adminUserDetail.child3Birthday" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</div>
										<div class="span359" style="width:200px;">
											<span class="searchSpan pull-left" style="width:80px;">性别:</span>
											<select class="form-control select2" style="width:70px;" ng-model="vm.user.adminUserDetail.child3Sex">
												<option value="">请选择</option>
												<option value="0" >男</option>
												<option value="1" >女</option>
											</select>
										</div>
										<div class="span359">
											<span class="searchSpan">单位:</span>
											<input type="text" class="form-control" ng-model="vm.user.adminUserDetail.child3Work"  />
										</div>
									</div>
								</div>
<br>
								<!-- 工作经历 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>工作经历</h3>
								</div>
								<div class="widget-content">
									<div class="row">
										<table class="table" style="margin-left:30px;width:1138px;">
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
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work1Time"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work1Place"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work1Reason"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work1Job"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work1Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work2Time"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work2Place"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work2Reason"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work2Job"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work2Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work3Time"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work3Place"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work3Reason"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work3Job"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work3Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work4Time"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work4Place"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work4Reason"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work4Job"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work4Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work5Time"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work5Place"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work5Reason"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work5Job"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work5Zyyj"  />
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work6Time"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work6Place"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work6Reason"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work6Job"  />
												</td>
												<td>
													<input type="text" class="form-control span2" ng-model="vm.user.adminUserDetail.work6Zyyj"  />
												</td>
											</tr>
										</table>
									</div>
								</div>
<br>
								<!-- PDP信息 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>PDP信息</h3>
								</div>
								<div class="widget-content">
									<div class="row">
										<div class="span262">
											<span class="searchSpan">顺境-谦和:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpSjA" />
										</div>
										<div class="span262">
											<span class="searchSpan">顺境-韧性:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpSjB" />
										</div>
										<div class="span262">
											<span class="searchSpan">顺境-理性:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpSjC" />
										</div>
										<div class="span262">
											<span class="searchSpan">顺境-自信:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpSjD" />
										</div>
									</div>
									<div class="row">
										<div class="span262">
											<span class="searchSpan">逆境-谦和:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpNjA" />
										</div>
										<div class="span262">
											<span class="searchSpan">逆境-韧性:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpNjB" />
										</div>
										<div class="span262">
											<span class="searchSpan">逆境-理性:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpNjC" />
										</div>
										<div class="span262">
											<span class="searchSpan">逆境-自信:</span>
											<input type="text" class="form-control" style="width:140px;" ng-model="vm.user.adminUserDetail.pdpNjD" />
										</div>
									</div>
									<!--<div class="row">
										<div class="span262 pull-left" style="width:554px">
											  <span class="searchSpan" style="width:140px;" >共享中心后续验证:</span>
											<input type="text" class="form-control" style="width:240px;" ng-model="vm.user.adminUserDetail.pdpNjA" />
										</div>
										<div class="span262 pull-left" style="width:554px">
											<span class="searchSpan" style="width:140px;">直接上级后续验证:</span>
											<input type="text" class="form-control" style="width:240px;" ng-model="vm.user.adminUserDetail.pdpNjB" />
										</div>
									</div>-->
									<div class="row">
										<div id="containerpdp"  ng-if="${adminUser.position != 'STAFF'}"></div>
									</div>
									<div class="row">
										<span class="pull-right"><input type="submit" class="btn btn-success " ladda = "submitting"  value="保存" /></span>
									</div>
								</div>
	<br>							
								<!-- 附件信息  -->
								<div class="widget-header" ng-if="${not empty user.userId }">
									<i class="icon-pushpin"></i>
									<h3>附件信息</h3>
								</div>
								<div class="widget-content" ng-if="${not empty user.userId }">
									<div class="row">
										<table class="table display" id="datatable" style="margin-left:30px;">
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
<br>
								<!-- 培训信息  -->
								<div class="widget-header" ng-if="${not empty user.userId }">
									<i class="icon-pushpin"></i>
									<h3>培训信息</h3>
								</div>
								<div class="widget-content" ng-if="${not empty user.userId }">
									<div class="row">
										<table class="table display" id="datatable" style="margin-left:30px;">
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
<br>
								<!-- 调岗/调薪信息  -->
								<div class="widget-header" ng-if="${not empty user.userId }">
									<i class="icon-pushpin"></i>
									<h3>调岗/调薪信息</h3>
								</div>
								<div class="widget-content" ng-if="${not empty user.userId }">
									<div class="row">
										<table class="table display" id="datatable" style="margin-left:30px;">
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
							
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	<script src="${root}/public/js/pages/administrator/edit.js" type="text/javascript"></script>
</body>
</html>