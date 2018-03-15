<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" class="main" ng-app = "myApp" ng-controller="CostController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>我的成本审批</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
                                    <div class="span3">
                                        <select id="costType" ng-model="costType"  class="form-control select2" 
                                                ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList"
                                                ng-change="costTypeChange()">
                                            <option value="">--请选择收支类型--</option>
                                        </select>
                                    </div>
									<div class="span6" style="height:37px;">
										<span class="searchSpan">申请日期:</span>
										<input type="date" ng-model="costStartDate" class="span2">
										<span class="searchSpanMid">~</span>
										<input type="date" ng-model="costEndDate" class="span2">
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getCostList()" value="查询" /></div>
								</div>
								<hr>
									<div class="progress progress-striped active" style="height:18px;" >
										<div class="bar" style="width: {{inPercent}}%;height:18px;" ><span style="display:inlie-block;height:18px;">{{inStr}}</span></div>
									</div>
									<div class="progress progress-striped active">
										<div class="bar" style="width: {{outPercent}}%;">{{outStr}}</div>
									</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12" style="overflow:auto">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="60px">NO</th>
													<th width="120px">成本单号</th>
													<th width="60px">收支类型</th>
													<th width="140px">成本产生时间</th>
													<th width="120px">金额</th>
													<th width="140px">各部门金额</th>
													<th width="180px">成本详情</th>
													<th width="50px">提交人</th>
													<th width="50px">审核人</th>
													<th width="100px">状态</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view" ><p ng-bind="$index+1"></td>
													<td ng-switch-when="view"><p ng-bind="item.costNo"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costTypeName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costDate"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costNum"></p></td>
													
													<td ng-switch-when="view">
														<ul class="costnav" ng-repeat="depCost in item.costDepList">
															<li><span style="display: inline-block;width:40px">{{depCost.costDepName}}</span>:<span style="display: inline-block;width:58px">{{depCost.costNum}}</span></li>
														</ul>
													</td>
													
													<td ng-switch-when="view"><p ng-bind="item.remark"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.subUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.auditUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.statusName"></p></td>
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
    </div>
	<input type="hidden" id="rootUrl" value="${root}">

	<script src="${root}/public/js/pages/cost/costView.js" type="text/javascript"></script>
</body>
</html>