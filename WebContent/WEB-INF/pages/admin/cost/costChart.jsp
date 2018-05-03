<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

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
                                    <div class="span3">
										<select ng-model="year"  class="form-control select2" ng-change="costYearChange()" ng-options="year for year in years">
												<option value="">--请选择年度--</option>
										</select>
                                    </div>
                                    <span class="searchSpan">收支类型:</span>
                                        <select id="costType" ng-model="costType"  class="form-control span2" ng-change="costYearChange()"
                                                ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList"
                                                ng-change="costTypeChange()">
                                        </select>
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
				                                <div id="depIncome"></div>
				                                <!-- /line-chart -->
				                            </div>
				                            <!-- /widget-content -->
				                        </div>
										<div class="widget">
				                            <!-- /widget-header -->
				                            <div class="widget-content">
												<table class="table display" id="datatable">
													<thead>
														<tr>
															<th>选择</th>
															<th>部门名称</th>
															<th>一月</th>
															<th>二月</th>
															<th>三月</th>
															<th>四月</th>
															<th>五月</th>
															<th>六月</th>
															<th>七月</th>
															<th>八月</th>
															<th>九月</th>
															<th>十月</th>
															<th>十一月</th>
															<th>十二月</th>
															<th>总计</th>
														</tr>
													</thead>  
													<tbody>
														<tr class="odd gradeX" ng-repeat="item in vm.list">
															<td>
																<input type="checkbox" ng-bind="item.checked" ng-click="vm.checkDep()" /> 
															</td>
															
															<td><p ng-bind="item.depName"></p></td>
															
															<td ng-repeat="mitem in item.chartList"><p ng-bind="mitem.costNum"></p></td>
															
															<td><p ng-bind="item.depTotal"></p></td>
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