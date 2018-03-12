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
								<h3>我的成本申请</h3>
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
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.addCost()"><i class="icon-plus"></i> 新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="120px">收支类型</th>
													<th width="170px">成本产生时间</th>
													<th width="120px">金额</th>
													<th width="300px">成本详情</th>
													<th width="100px">状态</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view"><p ng-bind="item.costTypeName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costDate"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costNum"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.remark"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.statusName"></p></td>
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-small btn-invert" ng-click="vm.editCost(item)" ng-if="item.status=='00' || item.status=='02'">编辑</a>
														<a href="javascript:;" class="btn btn-small btn-info" ng-click="vm.submitCost(item)" ng-if="item.status=='00' || item.status=='02'">提交</a>
														<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)" ng-if="item.status=='00' && item.status!='99'">报废</a>
													</td>
													<!-- edit -->
													<td ng-switch-when="edit">
				                                        <select id="costType" style="width:110px;" ng-model="item.costType"  class="form-control select2" 
				                                            ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList">
				                                            <option value="">--收支类型--</option>
				                                        </select>
													</td>
													<td ng-switch-when="edit">
														<input type="date" ng-model="item.costDate" style="width:160px;" >
													</td>
													<td ng-switch-when="edit">
														<input type="number" ng-model="item.costNum"  min="1" style="width:110px;" />
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.remark" style="width:290px;">
													</td>
													<td ng-switch-when="edit">
														
													</td>
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)">保存</a>
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
    </div>
	<input type="hidden" id="rootUrl" value="${root}">

	<script src="${root}/public/js/pages/cost/cost.js" type="text/javascript"></script>
</body>
</html>