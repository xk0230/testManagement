<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="CostController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="im-users2"></i> 成本管理</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><i class="ec-search"></i>查询条件</h3>
                                </div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">所属部门</label>
												<div class="col-lg-8">
													<select id="depId" ng-model="dep"  class="form-control select2" 
															ng-options="dep.depId as dep.name group by dep.group for dep in depList">
															<option value="">--请选择--</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">收支类型</label>
												<div class="col-lg-8">
													<select id="costType" ng-model="costType"  class="form-control select2" 
															ng-options="costType.value as costType.name group by costType.group for costType in costTypeList"
															ng-change="costTypeChange()">
														<option value="">--请选择--</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-4 control-label">分类名称</label>
												<div class="col-lg-8">
													<select id="costSubType" ng-model="costSubType" class="form-control select2"
															ng-options="costSubType.costSubTypeId as costSubType.name group by costSubType.group for costSubType in costSubTypeList">
														<option value="">--请选择--</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3 pull-left">
												<ul class="nav navbar-nav pull-left">
													<li id="toggle-sidebar-li" class="ui-buttonset">
														<input type="button"  class="btn btn-primary" name="query" ng-click="vm.getCostList()" value="查询" />
													</li>
													<li id="toggle-sidebar-li">
														<input type="button"  class="btn btn-success " name="query" ng-click="vm.editCost('')" value="新增成本" />
													</li>
												</ul>
											</div>
										</div>
										
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >成本开始时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="costStartDate" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >成本结束时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="costEndDate" is-open="popup.opened2" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(2)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											
										</div>
										
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End .row -->
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>查询结果</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>所属部门</th>
												<th>收支类型</th>
												<th>分类名称</th>
												<th>归属日期</th>
												<th>金额</th>
												<th>更新时间</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												
												<td><p ng-bind="item.depName"></p></td>
												<td><p ng-bind="item.costTypeName"></p></td>
												<td><p ng-bind="item.costSubName"></p></td>
												<td><p ng-bind="item.costDate"></p></td>
												<td><p ng-bind="item.costNum"></p></td>
												<td><p ng-bind="item.createDate"></p></td>
												<td>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.delCost(item.costId,'sm')"><i class="ec-search"></i></button>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.editCost(item.costId)"><i class="br-pencil"></i></button>
												</td>
												
											</tr>
										</tbody>
									</table>
									<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
									<%@ include file="../../common/page.jsp"%>
								</div>

						</div>
						<!-- col-lg-12 end here -->
					</div>
					<!-- Page End here -->
				</div>
				<!-- End .outlet -->
			</div>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
	</div>
			
	<input type="hidden" id="rootUrl" value="${root}">
			
	<script src="${root}/public/js/pages/cost/script.js" type="text/javascript"></script>
</body>
</html>