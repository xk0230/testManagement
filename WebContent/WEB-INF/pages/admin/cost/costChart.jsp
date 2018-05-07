<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<style>
	th p {font-weight: bold;font-size: 30}
</style>
</head>
<body >
		<%@ include file="../../common/header.jsp"%>
		<!-- Start #content -->
		<div id="content" class="main" ng-app = "myApp" ng-controller="ChartController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>成本图表</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
                                    <div class="span1">
										<select ng-model="year"  class ng-change="costYearChange()" style="width:100%" ng-options="year for year in years">
										</select>
                                    </div>
                                    <div class="span2">
	                                    <span class="pull-left">收支:</span>
	                                    <select id="costType" ng-model="costType" class="form-control pull-left" style="width:60px; margin-left:15px;" ng-change="costYearChange()"
	                                            ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList"
	                                            ng-change="costTypeChange()">
	                                    </select>
                                    </div>
                                    <div class="span8">
										<span>月度：</span>
										<span ng-repeat="item in monthCheckList">
											{{item.month}}月<input type="checkbox" ng-model="item.check" ng-click="vm.getDepIncome()" style="margin-right:10px;" >
										</span>
                                    </div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12" style="width:1134px;">
				                        <div class="widget">
				                            <div class="widget-header">
				                                <i class="icon-bar-chart"></i>
				                                <h3>月度支出构成</h3>
				                            </div>
				                            <!-- /widget-header -->
				                            <div class="widget-content">
				                                <div id="depIncome" style="overflow-x: scroll;"></div>
				                                <!-- /line-chart -->
				                            </div>
				                            <!-- /widget-content -->
				                        </div>
										<div class="widget">
				                            <!-- /widget-header -->
				                            <div class="widget-content" style="overflow-x: auto">
												<table class="table display" id="datatable">
													<thead>
														<tr align="right">
															<th><p>选择</p></th>
															<th><p>部门名称</p></th>
															<th><p style="text-align: right;">一月</p></th>
															<th><p style="text-align: right;">二月</p></th>
															<th><p style="text-align: right;">三月</p></th>
															<th><p style="text-align: right;">四月</p></th>
															<th><p style="text-align: right;">五月</p></th>
															<th><p style="text-align: right;">六月</p></th>
															<th><p style="text-align: right;">七月</p></th>
															<th><p style="text-align: right;">八月</p></th>
															<th><p style="text-align: right;">九月</p></th>
															<th><p style="text-align: right;">十月</p></th>
															<th><p style="text-align: right;">十一月</p></th>
															<th><p style="text-align: right;">十二月</p></th>
															<th><p style="text-align: right;">总计</p></th>
														</tr>
													</thead>  
													<tbody>
														<tr class="odd gradeX" ng-repeat="item in vm.list">
															<td>
																<input type="checkbox" ng-bind="item.checked" ng-click="vm.checkDep()" ng-if="item.depName !='总计'" /> 
															</td>
															
															<td><p ng-bind="item.depName"></p></td>
															
															<td ng-repeat="mitem in item.chartList"><p ng-bind="mitem.costNum | currency:'￥':2" style="text-align: right;"></p></td>
															
															<td><p ng-bind="item.depTotal | currency:'￥':2" style="text-align: right;"></p></td>
													</tbody>
												</table>
				                                <!-- /bar-chart -->
				                            </div>
				                            <!-- /widget-content -->
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
	
	<script src="${root}/public/js/pages/cost/chart.js" type="text/javascript"></script>
	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
	
</body>
</html>