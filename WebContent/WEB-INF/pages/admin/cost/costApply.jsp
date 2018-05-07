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
								<h3>费用申请</h3>
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
											<mb-datepicker input-class="mb-date" date="costEndDate"   date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getCostList()" value="查询" /></div>
								</div>
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">成本分类:</span>
	                                    <select id="costClass" ng-model="costSubtypeId"  class="form-control span2" 
	                                        ng-options="cType.costSubTypeId as cType.name group by cType.group for cType in costSubTypeList">
	                                        <option value="">--请选择--</option>
	                                    </select>
                                    </div>
                                    <div class="span4">
                                        <span class="searchSpan">单号:</span>
                                        <input type="text" ng-model="costNo" class="span2">
                                    </div>
								</div>
								<div class="row">
                                    <div class="span6">
                                    	<span class="searchSpan">内容:</span>
                                        <input type="text" ng-model="remark" class="span4">
                                    </div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.addCost()"><i class="icon-plus"></i>申请</button>
										</div>
										<div style="width:1134px;overflow-x:scroll;">
										<table class="table table-condensed table-bordered table-striped" style="width:1700px;margin-top:7px;" >
											<thead >
												<tr>
													<th width="110px">操作</th>
													<th width="110px">状态</th>
													<th width="100px">成本单号</th>
													<th width="80px">类型</th>
													<th width="100px" ng-show="${sessionScope.adminUser.userId == 'admin'}">分类</th>
													<th width="100px">成本产生时间</th>
													<th width="100px">金额</th>
													<th width="300px">成本详情</th>
													<th width="300px">合同</th>
													<th>项目</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-small" ng-click="vm.editCost(item,$index)" ng-if="item.status=='00' || item.status=='02'"><i class="icon-edit"></i></a>
														<a href="javascript:;" class="btn btn-small " ng-click="vm.submitCost(item)" ng-if="item.status=='00' || item.status=='02'"><i class="icon-share"></i></a>
														<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)" ng-if="item.status=='00' && item.status!='99'"><i class="icon-remove-sign"></i></a>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.statusName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costNo"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costTypeName"></p></td>
													<td ng-show="item.editMode == 'view' && ${sessionScope.adminUser.userId == 'admin'}"><p ng-bind="item.costSubName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costDate"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costNum"></p></td>
													<td ng-switch-when="view">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	<span class="line-limit-length span4" title="{{item.remark}}">详情：{{item.remark}}</span>
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="view">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																		<span class="line-limit-length span4">合同：
																		<a href="javascript:;" style="width:200px;" ng-if="item.contractId" ng-click="vm.editPayment(item,'.widget-content','view')">{{item.contractId}}</a>
																		<a href="javascript:;" style="width:200px;" ng-if="!item.contractId" >未选择</a>
																		</span>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	<span class="line-limit-length span4" title="{{item.contractContent}}">合同内容：{{item.contractContent}}</span>
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="view">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																		<span class="line-limit-length span4">项目：
																		<a href="javascript:;" style="width:200px;" ng-if="item.projectId" ng-click="vm.editProject(item,'.widget-content','view')">{{item.projectId}}</a>
																		<a href="javascript:;" style="width:200px;" ng-if="!item.projectId" >未选择</a>
																		</span>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	<span class="line-limit-length span4" title="{{item.projectName}}">项目名：{{item.projectName}}</span>
																</span>
															</li>
														</ul>
													</td>
													<!-- edit -->
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)"><i class="icon-ok"></i></a>
													</td>
													<td ng-switch-when="edit"></td>
													<td ng-switch-when="edit"></td>
													<td ng-switch-when="edit">
				                                        <select id="costType" style="width:60px;" ng-model="item.costType"  class="form-control select2" ng-change="costTypeChangeInList(item)"
				                                            ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList">
				                                        </select>
													</td>
													<td ng-show="item.editMode == 'edit' && ${sessionScope.adminUser.userId == 'admin'}" >
				                                        <select style="width:110px;" ng-model="item.costSubtypeId"  class="form-control select2" 
				                                            ng-options="cType.costSubTypeId as cType.name group by cType.group for cType in item.costSubTypeList">
				                                        </select>
													</td>
													<td ng-show="item.editMode == 'edit'">
															<mb-datepicker input-class="mb-date" date="item.costDate" date-format="YYYY-MM-DD"></mb-datepicker>
														<!-- <input type="text" id="datepicker{{$index}}" ng-model="item.costDate" style="width:80px;"> -->
													</td>
													<td ng-switch-when="edit">
														<input type="number" ng-model="item.costNum"  min="1" style="width:60px;" />
													</td>
													<td ng-switch-when="edit">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">详情：
																	<input type="text" ng-model="item.remark" style="width:240px;">
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="edit">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	合同：
																	<a href="javascript:;" style="width:200px;" ng-if="item.contractId" ng-click="vm.editPayment(item,'.widget-content','edit')">{{item.contractId}}</a>
																	<a href="javascript:;" style="width:200px;" ng-if="!item.contractId" ng-click="vm.editPayment(item,'.widget-content','edit')">未选择</a>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	<span class="line-limit-length span4" title="{{item.contractContent}}">合同内容：{{item.contractContent}}</span>
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="edit">
														<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	项目单号：
																	<a href="javascript:;" style="width:200px;" ng-if="item.projectId" ng-click="vm.editProject(item,'.widget-content','edit')">{{item.projectId}}</a>
																	<a href="javascript:;" style="width:200px;" ng-if="!item.projectId" ng-click="vm.editProject(item,'.widget-content','edit')">未选择</a>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:300px;">
																	<span class="line-limit-length span4" title="{{item.projectName}}">项目名：{{item.projectName}}</span>
																</span>
															</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
										</div>
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
									<div class="span12;">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="55px">操作</th>
													<th width="100px">编号</th>
													<th width="50px">类型</th>
													<th width="150px">内容</th>
													<th width="50px">部门</th>
													<th width="50px">金额</th>
													<th width="130px">收款方</th>
													<th width="100px">签订时间</th>
													<th width="140px">外部订单</th>
													<th >备注</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in list" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td>
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="Choose(item)" ng-if="item.status=='00' && mode=='edit'">选择</a>
													</td>
													<td><p ng-bind="item.contractId"></p></td>
													<td><p ng-bind="item.contractType"></p></td>
													<td><p  class="line-limit-length span2"  title="{{item.content}}" ng-bind="item.content"></p></td>
													<td><p ng-bind="item.dept"></p></td>
													<td><p ng-bind="item.cost"></p></td>
													<td><p class="line-limit-length span3" ng-bind="item.company"></p></td>
													<td><p ng-bind="item.url  | date:'yyyy-MM-dd'"></p></td>
													<td><p ng-bind="item.serialid"></p></td>
													<td><p  class="line-limit-length span2"  title="{{item.remakes}}" ng-bind="item.remakes"></p></td>
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
    
    <script type="text/ng-template" id="myModalProjectContent.html">
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
										<span class="searchSpan">单号:</span>
                                        <input type="text" ng-model="pjNo" class="span2">
                                    </div>
                                    <div class="span3">
										<span class="searchSpan">项目名:</span>
                                        <input type="text" ng-model="name" class="span2">
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
													<th width="50px">操作</th> 
												 	<th width="100px">单号</th>
													<th>项目名</th>
													<th width="200px">项目开始时间</th>
													<th width="200px">项目结束时间</th>
													<th width="100px">项目负责人</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in $project.list" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<td>
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="Choose(item)">选择</a>
													</td>
													<td><p ng-bind="item.pjNo"></p></td>
													<td><p ng-bind="item.name"></p></td>
													<td><p ng-bind="item.startTime | date:'yyyy-MM-dd'"></p></td>
													<td><p ng-bind="item.endTime | date:'yyyy-MM-dd'"></p></td>
													<td><p ng-bind="item.leader"></p></td>
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

	<script src="${root}/public/js/pages/cost/cost.js" type="text/javascript"></script>
</body>
</html>