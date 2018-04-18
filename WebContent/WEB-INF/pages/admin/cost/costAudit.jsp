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
								<h3>成本审批</h3>
							</div>
							
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">收支类型:</span>
                                        <select id="costType" ng-model="costType"  class="form-control span2" 
                                                ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList"
                                                ng-change="costTypeChange()">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">申请日期:</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="costStartDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
										<span class="searchSpanMid pull-left">~</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="costEndDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getCostAuditList()" value="查询" /></div>
								</div>
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">成本分类:</span>
	                                    <select id="costClass" ng-model="costSubtypeId"  class="form-control span2" 
	                                        ng-options="cType.costSubTypeId as cType.name group by cType.group for cType in costSubTypeList">
	                                        <option value="">--请选择--</option>
	                                    </select>
                                    </div>
                                    <div class="span6">
                                    	<span class="searchSpan">内容:</span>
                                        <input type="text" ng-model="remark" class="span4">
                                    </div>
								</div>
								<div class="row">
                                    <div class="span4">
                                        <span class="searchSpan">单号:</span>
                                        <input type="text" ng-model="costNo" class="span2">
                                    </div>
                                    <div class="span4">
										<span class="searchSpan">审核状态:</span>
                                        <select id="costType" ng-model="auditStatus"  class="form-control span2" 
                                                ng-options="cType.costType as cType.name group by cType.group for cType in auditStatusList"
                                                ng-change="costTypeChange()">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12" style="overflow:auto">
										<table class="table table-condensed table-bordered table-striped" style="width:98%;margin-top:7px;" >
											<thead >
												<tr align="center">
													<th width="120px">成本单号</th>
													<th width="40px">类型</th>
													<th width="40px">分类</th>
													<th width="120px">成本产生时间</th>
													<th width="60px">金额</th>
													<th width="120px">成本详情</th>
													<th width="50px">提交人</th>
													<th width="50px">审核人</th>
													<th width="80px">状态</th>
													<th width="150px">操作</th>
												</tr>
											</thead>
											<tbody ng-repeat="item in vm.list" ng-switch="item.editMode">
												<tr class="odd gradeX"  ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view"><p ng-bind="item.costNo"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costTypeName"></p></td>
													<td ng-switch-when="view">
														<p ng-bind="item.costSubName" ng-if="${sessionScope.adminUser.userId == 'admin'}"></p>
														<p ng-if="${sessionScope.adminUser.userId != 'admin'}">-</p>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.costDate"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costNum"></p></td>
													<td ng-switch-when="view">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<span class="line-limit-length span3" title="{{item.remark}}">详情：{{item.remark}}</span>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																		<span class="line-limit-length span4">合同：
																		<a href="javascript:;" style="width:200px;" ng-if="item.contractId" ng-click="vm.editBook(item,'.widget-content','view')">{{item.contractId}}</a>
																		<a href="javascript:;" style="width:200px;" ng-if="!item.contractId" >未选择</a>
																		</span>
																</span>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<span class="line-limit-length span3" title="{{item.contractContent}}">合同内容：{{item.contractContent}}</span>
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.subUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.auditUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.statusName"></p></td>
													<td ng-switch-when="view" >
														<div >
															<a href="javascript:;" class="btn btn-small" ng-click="vm.editCost(item,$index)" ng-if="${adminUser.userId == 'admin'} && (item.status=='05' || item.status=='03')"><i class="icon-edit"></i></a>
															<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.managerSubCost(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')"><i class="icon-ok"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.managerRejCost(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')"><i class="icon-remove-sign"></i></a>
															<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.adminSubCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'"><i class="icon-ok"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.adminRejCost(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'"><i class="icon-remove-sign"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='05'"><i class="icon-remove-sign"></i></a>
														</div>
													</td>
													<!-- edit -->
													<td ng-switch-when="edit"><p ng-bind="item.costNo"></p></td>
													<td ng-switch-when="edit">
				                                        <select id="costType" style="width:80px;" ng-model="item.costType"  class="form-control select2" ng-change="costTypeChangeInList(item)"
				                                            ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList">
				                                        </select>
													</td>
													<td ng-show="item.editMode == 'edit'">
				                                        <select style="width:80px;" ng-model="item.costSubtypeId"  class="form-control select2" 
				                                            ng-options="cType.costSubTypeId as cType.name group by cType.group for cType in item.costSubTypeList">
				                                        </select>
													</td>
													<td ng-show="item.editMode == 'edit'">
														<mb-datepicker input-class="mb-date" date="item.costDate" date-format="YYYY-MM-DD" ></mb-datepicker>
														
														<!-- <input type="text" id="datepicker{{$index}}" ng-model="item.costDate" style="width:80px;"> -->
													</td>
													<td ng-switch-when="edit">
														<input type="number" ng-model="item.costNum"  min="1" style="width:50px;" />
													</td>
													<td ng-switch-when="edit">
														<ul style="width:100%">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">详情：
																	<input type="text" ng-model="item.remark" style="width:150px;">
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	合同：
																	<a href="javascript:;" style="width:200px;" ng-if="item.contractId" ng-click="vm.editBook(item,'.widget-content','edit')">{{item.contractId}}</a>
																	<a href="javascript:;" style="width:200px;" ng-if="!item.contractId" ng-click="vm.editBook(item,'.widget-content','edit')">未选择</a>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<span class="line-limit-length span3" title="{{item.contractContent}}">合同内容：{{item.contractContent}}</span>
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="edit"><p ng-bind="item.subUserName"></p></td>
													<td ng-switch-when="edit"><p ng-bind="item.auditUserName"></p></td>
													<td ng-switch-when="edit"><p ng-bind="item.statusName"></p></td>
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)"><i class="icon-ok"></i></a>
													</td>
												</tr>
												<tr>
													<td ng-switch-when="view" colspan="10" style="padding:8px;" ng-if="${adminUser.userId == 'admin'}">
														<div style="float:left;margin-left:10px" ng-repeat="depCost in item.costDepList">
															{{depCost.costDepName}}:￥{{depCost.costNum}}
														</div>
													</td>
													<td ng-switch-when="edit" colspan="10" style="padding:8px;" ng-if="${adminUser.userId == 'admin'}">
														<div style="float:left;margin-left:10px" ng-repeat="depCost in item.costDepList">
															{{depCost.costDepName}}:￥<input type="number" name="costNum" ng-model="depCost.costNum"  min="1" style="width:78px;" />
														</div>
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
								<h3>合同</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">合同类型:</span>
                                        <select id="contractType" ng-model="contractType"  class="form-control span2" 
                                                ng-options="cType.contractType as cType.name group by cType.group for cType in contractTypeList">
                                            <option value="">--请选择--</option>
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
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">申请日期:</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="costStartDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
										<span class="searchSpanMid pull-left">~</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="costEndDate"   date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="$ctrl.getContractList()" value="查询" /></div>
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
													<th width="130px">收款方</th>
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
													<td><p ng-bind="item.company" class="line-limit-length span2"></p></td>
													<td><p ng-bind="item.url | date:'yyyy-MM-dd'"></p></td>
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
									<button class="btn btn-warning" type="button" ng-click="ChooseNull()" ng-if="mode=='edit'">取消选择</button>
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