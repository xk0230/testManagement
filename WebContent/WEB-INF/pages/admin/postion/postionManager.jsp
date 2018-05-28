<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="PostionController as vm">
				  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3 ng-if="${type=='list'}">岗位列表</h3>
								<h3 ng-if="${type=='mypost'}">我的岗位管理</h3>
								<h3 ng-if="${type=='audit'}">岗位审批</h3>
							</div>
							
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">岗位名称:</span>
										<span class="pull-left">
											<input type="text" class="form-control" ng-model="name"/>
										</span>
									</div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">所属部门 :</span>
										<span class="pull-left">
											<select id="depId" ng-model="depId"  class="form-control select2" ng-Disabled = "depIdChangeAble"
												ng-options="dep.depId as dep.name group by dep.group for dep in depList">
												<option value="">--请选择--</option>
											</select>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getList()" value="查询" /></div>
								</div>
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">岗位状态 :</span>
										<span class="pull-left">
											<select  id="status" ng-model="status" class="form-control">
												<option value="">--请选择--</option>
												<option value="{{status.status}}" ng-repeat="status in vm.statusList">{{status.statusName}}</option>
											</select>
										</span>
									</div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">审批状态 :</span>
										<span class="pull-left">
											<select id="result" ng-model="result" class="form-control">
												<option value="">--请选择--</option>
												<option value="{{result.result}}" ng-repeat="result in vm.resultList">{{result.resultName}}</option>
											</select>
										</span>
									</div>
									<div class="span2">
										<input type="checkbox"   ng-model="onlykq"  value="true" ng-Disabled = "${adminUser.position == 'STAFF'}"><label class=" control-label">只显示空缺岗位 </label>
									</div>
								</div>
								
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.edit('', '.widget')" ng-if="${type=='mypost'}"><i class="icon-plus"></i>新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th style="text-align: center;font-size:14px;">所属部门</th>
													<th style="text-align: center;font-size:14px;">岗位名称</th>
													<th style="text-align: center;font-size:14px;">编制</th>
													<th ng-if="${type=='list' or type=='mypost'}" style="text-align: center;font-size:14px;">在岗人数</th>
													<th ng-if="${type=='list' or type=='mypost'}" style="text-align: center;font-size:14px;">空缺</th>
													<th ng-if="${type=='audit'}" style="text-align: center;font-size:14px;">创建人</th>
													<th ng-if="${type=='audit' or type=='list'}" style="text-align: center;font-size:14px;">创建时间</th>
													<th colspan="3" ng-if="${type=='list'}" style="text-align: center;font-size:14px;">操作</th>
													<th ng-if="${type=='mypost'}" style="text-align: center;font-size:14px;">岗位状态</th>
													<th ng-if="${type=='audit'}" style="text-align: center;font-size:14px;">审批状态</th>
													<th colspan="2" ng-if="${type=='audit'}" style="text-align: center;font-size:14px;">操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode">
													<!-- view -->
													<td ng-switch-when="view" class="col-lg-2"><p ng-bind="item.depName"></p></td>
													<td ng-switch-when="view" class="col-lg-2"><p ng-bind="item.name"></p></td>
													<td ng-switch-when="view" class="col-lg-1"><p ng-bind="item.organization"></p></td>
													<td ng-switch-when="view" ng-if="${type=='list' or type=='mypost'}" class="col-lg-1"><p ng-bind="item.onDuty"></p></td>
													<td ng-switch-when="view" ng-if="${type=='list' or type=='mypost'}" class="col-lg-1"><p ng-bind="item.vacancy" ng-class="{true: 'redNumber', false: ''}[item.vacancy > 0]"></p></td>
													<td ng-switch-when="view" ng-if="${type=='audit'}" class="col-lg-2"><p ng-bind="item.createUserName"></p></td>
													<td ng-switch-when="view" ng-if="${type=='audit' or type=='list'}" class="col-lg-2"><p ng-bind="item.createTime | date:'yyyy-MM-dd hh:mm:ss'"></p></td>
													<td ng-switch-when="view" ng-if="${type=='list'}" ng-show ="item.depName != '合计'">
														<button type="button" class="btn btn-sm btn-success" ng-click="vm.edit(item.postId,'.widget')" >标准JD</button>
														<button type="button" class="btn btn-sm btn-success" ng-click="vm.userList(item.postId)" ng-show = "${adminUser.position != 'STAFF'} ">查看员工</button>
													</td>
													<td ng-switch-when="view" ng-if="${type=='list'}" ng-show ="item.depName == '合计'">
														-
													</td>
													<td ng-switch-when="view" ng-if="${type=='mypost'}" class="col-lg-1">
														<p ng-if="item.statusName != '审批拒绝'" ng-bind="item.statusName"></p>
														<button  ng-if="item.statusName == '审批拒绝'" type="button" class="btn btn-sm btn-success" ng-click="vm.auditDetailReg(item.postId, '.widget')">审批拒绝</button>
													</td>
													<td ng-switch-when="view" ng-if="${type=='audit'}" class="col-lg-1"><p ng-bind="item.resultName"></p></td>
													<td ng-switch-when="view" ng-if="${type=='audit'}">
														<button  ng-if="item.resultName == '未审批'" type="button" class="btn btn-sm btn-success" ng-click="vm.audit(item.positionAuditId,1,'','.widget')">通过</i></button>
														<button  ng-if="item.resultName == '未审批'" type="button" class="btn btn-sm btn-success" ng-click="vm.auditReg(item.positionAuditId, '.widget')">驳回</button>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
										<div style="width:1134px;">
											<%@ include file="../../common/page.jsp"%>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 岗位信息 -->
		<script type="text/ng-template" id="myModalContent.html">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>岗位信息</h3>
							</div>
							<div class="widget-content">
								<div class="row">
                                    <div class="span359">
										<span class="searchSpan">所属部门:</span>
										<select ng-model="costEntity.depId"  class="form-control span2" 
											ng-options="dep.depId as dep.name group by dep.group for dep in depList"
											ng-change="$ctrl.getPostionById()">
											<option value="">--请选择--</option>
										</select>
                                    </div>
                                    <div class="span359">
										<span class="searchSpan">岗位:</span>
                                        <input type="text" class="form-control" ng-model="costEntity.name" ng-blur="$ctrl.cau()" />
                                    </div>
                                    <div class="span359">
										<span class="searchSpan">编制人数:</span>
                                        <input type="text" class="form-control" ng-model="costEntity.organization" ng-blur="$ctrl.cau()" />
                                    </div>
								</div>
								<div class="row">
									<div class="span359">
										<span class="searchSpan">在岗人数:</span>
                                        <input type="text" class="form-control" ng-model="costEntity.onDuty" ng-blur="$ctrl.cau()" ng-readonly="true" />
                                    </div>
									<div class="span359">
										<span class="searchSpan">空缺人数:</span>
                                        <input type="text" class="form-control" ng-model="costEntity.vacancy" ng-readonly="true" />
                                    </div>
									<div class="span359">
										<span class="searchSpan">薪级:</span>
                                        <input type="text" class="form-control" ng-model="costEntity.salaryScale" />
                                    </div>
								</div>
                                <br>
								<div class="row">
									<h3 class="span359">相关经历/成就要求</h3>
								</div>
<hr>
								<div class="row">
									<div class="span359">
										<span class="searchSpan">过往职业:</span>
                                        <textarea class="form-control" ng-model="costEntity.recruitA" rows="3" Placeholder="点击输入过往职业"  ng-required="true"></textarea>
                                    </div>
									<div class="span359">
										<span class="searchSpan">工作经验:</span>
                                        <textarea class="form-control" ng-model="costEntity.recruitB"  rows="3" Placeholder="点击输入工作经验" ng-required="true"></textarea>
                                    </div>
									<div class="span359">
										<span class="searchSpan">关键成就:</span>
                                        <textarea class="form-control" ng-model="costEntity.recruitC"  rows="3" Placeholder="点击输入关键成就"  ng-required="true"></textarea>
                                    </div>
								</div>
<br>
								<div class="row">
									<h3 class="span359">技术/岗位要求</h3>
								</div>
<hr>
								<div class="row">
									<div class="span359">
										<span class="searchSpan">基本要求1:</span>
                                        <textarea class="form-control" ng-model="costEntity.recruitD"  rows="10" Placeholder="点击输入基本要求1"></textarea>
                                    </div>
									<div class="span359">
										<span class="searchSpan">基本要求2:</span>
                                        <textarea class="form-control" ng-model="costEntity.recruitE"  rows="10" Placeholder="点击输入基本要求2"></textarea>
                                    </div>
									<div class="span359">
										<span class="searchSpan">IPE要求:</span>
                                        <textarea class="form-control" ng-model="costEntity.recruitF"  rows="10" Placeholder="点击输入IPE要求,选填"></textarea>
                                    </div>
								</div>
								<div class="row">
									<div class="span359">
										<span class="searchSpan">学历:</span>
										<select class="form-control select2" ng-model="costEntity.education" ng-change="" >
											<option value="">请选择学历</option>
											<option value="博士">博士</option>
											<option value="硕士">硕士</option>
											<option value="学士">学士</option>
											<option value="专科">专科</option>
										</select>
                                    </div>
									<div class="span359">
										<span class="searchSpan">学历备注:</span>
                                        <textarea class="form-control" ng-model="costEntity.educationRemark" rows="3" Placeholder="点击输入学历备注"></textarea>
                                    </div>
									<div class="span359">
										<span class="searchSpan">专业资格:</span>
                                        <textarea class="form-control" ng-model="costEntity.professional" rows="3" Placeholder="点击输入专业资格"></textarea>
                                    </div>
								</div>
        						<div class="modal-footer">
									<button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">保存</button>
									<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        						</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </script>
		<!-- 审批记录 -->
		<script type="text/ng-template" id="myAuditContent.html">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>驳回</h3>
							</div>
							<div class="widget-content">
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">驳回理由:</span>
                                        <input type="text" class="form-control" ng-model="auditEntity.remark" />
                                    </div>
								</div>
								<hr>
        						<div class="modal-footer">
            						<button class="btn btn-primary" type="button" ng-click="$ctrl.okaudit(id)">确定</button>
            						<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        						</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </script>
		<!-- 审批详情 -->
		<script type="text/ng-template" id="myAuditDetailContent.html">
		<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>驳回详情</h3>
							</div>
							
							<div class="widget-content">
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="100px">审批人</th> 
												 	<th>驳回理由</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in list" >
													<td><p ng-bind="item.auditUserName"></p></td>
													<td><p ng-bind="item.remark"></p></td>
												</tr>
											</tbody>
										</table>
										<div class="g-no-content" ng-if="$project.list && $project.list.length === 0">没有相关数据</div>
										<div style="width:1134px;">
											<%@ include file="../../common/page.jsp"%>
										</div>
									</div>
								</div>
        						<div class="modal-footer">
            						<button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">确定</button>
            						<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        						</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </script>
	</div>
	
	
	<input type="hidden" id="rootUrl" value="${root}">
			
	<script src="${root}/public/js/pages/postion/script.js" type="text/javascript"></script>
</body>
</html>