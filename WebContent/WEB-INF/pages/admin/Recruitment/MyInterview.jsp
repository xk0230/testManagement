<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body  >
	<%@ include file="../../common/header.jsp"%>
	<!-- Start #content -->
	<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
		<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>我的面试</h3>
							</div>
							<div class="widget-content" style="padding-bottom: 100px;">
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th width="60px">操作</th>
													<th width="100px">候选人</th>
													<th width="100px">面试时间</th>
													<th width="300px">面试地点</th>
													<th>面试内容</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" >
													<td><button type="button" class="btn btn-success" ng-click="vm.edit(item,'.widget')"><i class="fa-thumbs-up"></i> 评估</button></td>
													<td><p ng-bind="item.candidateName"></p></td>
													<td><p ng-bind="item.interviewTime | date:'yyyy-MM-dd'"></p></td>
													<td><p ng-bind="item.place"></p></td>
													<td><p ng-bind="item.interviewDetail"></p></td>
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
		<script type="text/ng-template" id="myModalEditContent.html">
<style>
	.leftSpan{
		width:200px;
	}
</style>
		<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>候选人评估</h3>
							</div>
							<div class="widget-content">
								<div class="row">
									<h3 class="panel-title span359"><i class="ec-pencil"></i>评估信息</h3>
								</div>
								<div class="row lineMargin">
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">岗位名称:</span>
										<input type="text" class="form-control" ng-model="items.positionName"  value="" ng-disabled="true" />
									</div>
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">候选人:</span>
										<input type="text" class="form-control" ng-model="items.candidateName"  value="" ng-disabled="true" />
									</div>
								</div>
								<div class="row">
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">评估人:</span>
										<input type="text" class="form-control" ng-model="items.interviewerName"  value="" ng-disabled="true" />
									</div>
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">评估时间:</span>
										<input type="text" class="form-control" ng-model="items.interviewTime"  value="" ng-disabled="true" />
									</div>
								</div>

								<div class="row">
									<h3 class="panel-title span359"><i class="ec-pencil"></i>面试记录</h3>
								</div>
								<div class="row lineMargin">
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">I.相关工作经历/成就:</span>
										<textarea class="form-control" ng-model="items.workDetail" rows="5" Placeholder="点击输入相关工作经历/成就"  ng-required="true"></textarea>
									</div>
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">II.技术技能/岗位技能:</span>
										<textarea class="form-control" ng-model="items.skillDetail" rows="5" Placeholder="点击输入技术技能/岗位技能"  ng-required="true"></textarea>
									</div>
								</div>
								<div class="row">
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">相关工作经历/成就:</span>
										<select class="form-control select2" ng-model="items.wordScore" ng-required="true">
											<option value="">请选择工作经历/成就评价</option>
											<option value="1" >各方面都较欠缺</option>
											<option value="2" >低于平均水平</option>
											<option value="3" >平均水平</option>
											<option value="4" >高于平均水平</option>
											<option value="5" >非常杰出</option>
										</select>
									</div>
									<div class="span5 form-group">
										<span class="searchSpan leftSpan">技术技能/岗位技能:</span>
										<select class="form-control select2" ng-model="items.skillScore" ng-required="true">
											<option value="">请选择技术技能/岗位技能评价</option>
											<option value="1" >各方面都较欠缺</option>
											<option value="2" >低于平均水平</option>
											<option value="3" >平均水平</option>
											<option value="4" >高于平均水平</option>
											<option value="5" >非常杰出</option>
										</select>
									</div>
								</div>
								<div class="row">
									<h3 class="panel-title span359"><i class="ec-pencil"></i>胜任特质</h3>
								</div>
								<div class="row" style="margint-top:15px;">
									<div class="span359 form-group"  ng-repeat="competency in items.crrs track by $index" >
										<span class="searchSpan">{{competency.competencyName}}:</span>
										<input type="text" class="form-control" ng-model="competency.value" />
									</div>
								</div>
								<div class="modal-footer">
									<input type="button" class="btn btn-primary" ng-click="save()"  value="保存" />
									<input type="button" class="btn btn-warning" ng-click="$ctrl.cancel()"  value="取消" />
        						</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</script>
	</div>
	<script src="${root}/public/js/pages/Recruitment/MyInterview.js" type="text/javascript"></script>
</body>
</html>