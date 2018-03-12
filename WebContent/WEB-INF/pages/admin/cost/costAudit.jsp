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
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12" style="overflow:auto">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="60px">操作</th>
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
													<td ng-switch-when="view" >
														<div class="comandDiv" >
															<a href="javascript:;" class="btn btn-small btn-info" ng-click="vm.managerSubCost(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')">提交</a>
															<a href="javascript:;" class="btn btn-small btn-info" ng-click="vm.managerRejCost(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')">驳回</a>
															<a href="javascript:;" class="btn btn-small btn-info" ng-click="vm.adminSubCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'">提交</a>
															<a href="javascript:;" class="btn btn-small btn-info" ng-click="vm.adminRejCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'">驳回</a>
															<a href="javascript:;" class="btn btn-small btn-invert" ng-click="vm.editCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='05'">编辑</a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='05'">报废</a>
														</div>
													</td>
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
													<!-- edit -->
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)">保存</a>
													</td>
													<td ng-switch-when="edit"><p ng-bind="item.costNo"></p></td>
													<td ng-switch-when="edit">
				                                        <select id="costType" style="width:60px;" ng-model="item.costType"  class="form-control select2" 
				                                            ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList">
				                                            <option value="">--收支类型--</option>
				                                        </select>
													</td>
													<td ng-switch-when="edit">
														<input type="date" ng-model="item.costDate" style="width:125px;" >
													</td>
													<td ng-switch-when="edit">
														<input type="number" ng-model="item.costNum"  min="1" style="width:110px;" />
													</td>
													<td ng-switch-when="edit">
														<ul class="costnav" ng-repeat="depCost in item.costDepList" style="width:132px">
															<li>
																<span style="display: inline-block;width:40px">{{depCost.costDepName}}</span>:
																<span style="display: inline-block;width:80px">
																	<input type="number" ng-model="depCost.costNum"  min="1" style="width:78px;" />
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="edit">
														<textarea rows="5" cols="10" ng-model="item.remark"></textarea>
													</td>
													<td ng-switch-when="edit"><p ng-bind="item.subUserName"></p></td>
													<td ng-switch-when="edit"><p ng-bind="item.auditUserName"></p></td>
													<td ng-switch-when="edit"><p ng-bind="item.statusName"></p></td>
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
	<!-- 弹框-删除 -->
    <script type="text/ng-template" id="myModalDelContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<ul id="crumb" class="breadcrumb">
							确定删除成本记录吗？
						</ul>
					</div>
				</div>
			</div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">确定</button>
            <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        </div>
    </script>
    </div>
	<input type="hidden" id="rootUrl" value="${root}">

	<script src="${root}/public/js/pages/cost/costAudit.js" type="text/javascript"></script>
</body>
</html>