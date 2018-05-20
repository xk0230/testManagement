<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<style>
	.fullPer{
		width:90%;
	}
</style>
</head>
<body>
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
								<h3>候选人评估汇总表</h3>
							</div>
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">岗位名称:</span>
										<span class="pull-left">
											<input type="text" class="form-control" ng-model="vm.Recruitment.postName"  value="" ng-disabled="true" />
										</span>
									</div>
								</div>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div class="row">
											<h3 class="panel-title span359"><i class="ec-pencil"></i>候选人面试概况</h3>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th width="55px">评估标准</th>
													<th width="140px">相关经验/成就</th>
													<th width="140px">技术/岗位能力</th>
													<th >PC</th>
													<th >教育</th>
													<th >其他资质</th>
													<th >总排序</th>
													<th width="90px">操作</th>
												</tr>
											</thead>
											<tbody ng-repeat="item in vm.list">
												<tr class="odd gradeX">
													<td rowspan="2"><h4>{{item.name}}</h4></td>
													<!-- 相关经验/成就 -->
													<td >
														<select class="form-control fullPer" ng-model="item.wordScore" ng-required="true">
															<option value="">请选择</option>
															<option value="1" >各方面都较欠缺</option>
															<option value="2" >低于平均水平</option>
															<option value="3" >平均水平</option>
															<option value="4" >高于平均水平</option>
															<option value="5" >非常杰出</option>
														</select>
													</td>
													<!-- 技术/岗位能力 -->
													<td>
														<select class="form-control fullPer" ng-model="item.skillScore" ng-required="true">
															<option value="">请选择</option>
															<option value="1" >各方面都较欠缺</option>
															<option value="2" >低于平均水平</option>
															<option value="3" >平均水平</option>
															<option value="4" >高于平均水平</option>
															<option value="5" >非常杰出</option>
														</select>
													</td>
													<!-- PC -->
													<td><input type="text" class="form-control fullPer" ng-model="item.pc" /></td>
													<!-- 教育 -->
													<td><input type="text" class="form-control fullPer" ng-model="item.edu" /></td>
													<!-- 其他资质 -->
													<td><input type="text" class="form-control fullPer" ng-model="item.other" /></td>
													<!-- 总排序 -->
													<td style="padding-right:8px;"><input type="text" class="form-control fullPer" ng-model="item.sort" /></td>
													<td rowspan="2">
														<input type="button" class="btn btn-success col-lg-12" ng-click="vm.save(item)"  value="保存" />
														<button type="button" class="btn btn-warning col-lg-12" ng-click="vm.show(item,'.widget')" style="margin-top:5px">面试详情</button>
													</td>
												</tr>
 												<tr class="odd gradeX">
													<td colspan="6" style="padding:0px;">
														<table class="table display" style="width:100%;height:100%;margin:0px;border:0px;" >
															<tr class="odd gradeX">
																<th style="vertical-align:middle;border:0px;" rowspan="3"><h5>PDP:</h5></th>
																<th style="width:12%" >情景</th>
																<th style="width:22%" class="container">谦和</th>
																<th style="width:22%" class="container">韧性</th>
																<th style="width:22%" class="container">理性</th>
																<th style="width:22%" class="container">自信</th>
															</tr>
															<tr class="odd gradeX">
																<th>顺境</th>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpSjA" /></td>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpSjB" /></td>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpSjC" /></td>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpSjD" /></td>
															</tr>
															<tr class="odd gradeX" >
																<th>逆境</th>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpNjA" /></td>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpNjB" /></td>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpNjC" /></td>
																<td class="container"><input type="text" class="form-control fullPer" ng-model="item.pdpNjD" /></td>
															</tr>
														</table>
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
		<script type="text/ng-template" id="myModalEditContent.html">
		<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>面试详情</h3>
							</div>
							
							<div class="widget-content">
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
									<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
										<thead>
											<tr>
												<th width="200px;">面试项目</th>
												<th width="200px;" ng-repeat="Interview in InterviewList">{{Interview.interviewerName}}</th>
											</tr>
										</thead>  
										<tr>
											<td>相关工作经历/成就</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.workDetail}}</td>
										</tr>
										<tr>
											<td>技术技能/岗位技能</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.skillDetail}}</td>
										</tr>
										<tr>
											<td>相关工作经历/成就评分</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.wordScore}}</td>
										</tr>
										<tr>
											<td>技术技能/岗位技能评分</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.skillScore}}</td>
										</tr>
										<tr ng-repeat="crr in InterviewList[0].crrs track by $index">
											<td ng-bind="tableMark=$index" style="display:none"></td>
											<td>{{crr.competencyName}}</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.crrs[tableMark].value}}</td>
										</tr>
									</table>
										<div class="g-no-content" ng-if="InterviewList && InterviewList.length === 0">没有相关数据</div>
									</div>
								</div>
								<div class="modal-footer">
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
	<script src="${root}/public/js/pages/Recruitment/AdminEvaluation.js" type="text/javascript"></script>
</body>
</html>