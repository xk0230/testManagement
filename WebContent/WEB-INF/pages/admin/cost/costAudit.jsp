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
															<a href="javascript:;" class="btn btn-xs  icon-edit" ng-click="vm.editCost(item)" ng-if="${adminUser.userId == 'admin'} && (item.status=='05' || item.status=='03')"></a>
															<a href="javascript:;" class="btn btn-xs btn-success icon-ok" ng-click="vm.managerSubCost(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')"></a>
															<a href="javascript:;" class="btn btn-xs btn-danger icon-remove-sign" ng-click="vm.managerRejCost(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')"></a>
															<a href="javascript:;" class="btn btn-xs btn-success icon-ok" ng-click="vm.adminSubCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'"></a>
															<a href="javascript:;" class="btn btn-xs btn-danger icon-remove-sign" ng-click="vm.adminRejCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'"></a>
															<a href="javascript:;" class="btn btn-xs btn-danger icon-remove-sign" ng-click="vm.scrap(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='05'"></a>
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
													
													<td ng-switch-when="view">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<label>合同：</label>
																	<a href="javascript:;" style="width:200px;" ng-if="item.contractId" ng-click="vm.editBook(item,'.widget-content','view')">{{item.contractId}}</a>
																	<a href="javascript:;" style="width:200px;" ng-if="!item.contractId" >未选择</a>
																</span>
															</li>
															<li>
																<label>备注：</label>{{item.remark}}
															</li>
														</ul>
													</td>
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
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<label>合同：</label>
																	<a href="javascript:;" style="width:160px;" ng-if="item.contractId" ng-click="vm.editBook(item,'.widget-content','edit')">{{item.contractId}}</a>
																	<a href="javascript:;" style="width:160px;" ng-if="!item.contractId" ng-click="vm.editBook(item,'.widget-content','edit')">未选择</a>
																</span>
															</li>
															<li>
																<label>备注：</label>
																<input type="text" ng-model="item.remark" style="width:140px;">
															</li>
														</ul>
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
    <script type="text/ng-template" id="myModalEditContent.html">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>合同</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
                                    <div class="span3">
                                        <select id="contractType" ng-model="contractType"  class="form-control select2" 
                                                ng-options="cType.contractType as cType.name group by cType.group for cType in contractTypeList">
                                            <option value="">--请选择合同类型--</option>
                                        </select>
                                    </div>
                                    <div class="span3">
										<span class="searchSpan">合同内容:</span>
                                        <input type="text" ng-model="content"  style="width:120px;" />
                                    </div>
                                    <div class="span3">
										<span class="searchSpan">合同编号:</span>
                                        <input type="text" ng-model="contractId"  style="width:120px;" />
                                    </div>
									<div class="span6" style="height:37px;">
										<span class="searchSpan">申请日期:</span>
										<input type="date" ng-model="costStartDate" class="span2">
										<span class="searchSpanMid">~</span>
										<input type="date" ng-model="costEndDate" class="span2">
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getContractList()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="100px">编号</th>
													<th width="50px">类型</th>
													<th width="200px">内容</th>
													<th width="50px">部门</th>
													<th width="50px">金额</th>
													<th width="130px">对方公司</th>
													<th width="100px">签订时间</th>
													<th width="140px">外部订单</th>
													<th width="100px">备注</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in list" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td><p ng-bind="item.contractId"></p></td>
													<td><p ng-bind="item.contractType"></p></td>
													<td><p ng-bind="item.content"></p></td>
													<td><p ng-bind="item.dept"></p></td>
													<td><p ng-bind="item.cost"></p></td>
													<td><p ng-bind="item.company"></p></td>
													<td><p ng-bind="item.url"></p></td>
													<td><p ng-bind="item.serialid"></p></td>
													<td><p ng-bind="item.remakes"></p></td>
													<td>
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="Choose(item)" ng-if="item.status=='00' && mode=='edit'">选择</a>
													</td>
													<!-- edit -->
												</tr>
											</tbody>
										</table>
										<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
										<div style="width:1134px;">
											<%@ include file="../../common/page.jsp"%>
										</div>
									</div>
								</div>
        						<div class="modal-footer">
            						<button class="btn btn-warning" type="button" ng-click="cancel()">取消</button>
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

	<script src="${root}/public/js/pages/cost/costAudit.js" type="text/javascript"></script>
</body>
</html>