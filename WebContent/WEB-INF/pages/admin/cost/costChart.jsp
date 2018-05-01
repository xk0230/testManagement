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
                                        <select id="costType" ng-model="costType"  class="form-control span2" 
                                                ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList"
                                                ng-change="costTypeChange()">
                                        </select>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getCostList()" value="查询" /></div>
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
															<td><p ng-bind="item.depName"></p></td>
															<td><p class ="a1" ng-bind="item.januaryTotal"></p></td>
															<td><p class ="a2" ng-bind="item.februaryTotal"></p></td>
															<td><p class ="a3" ng-bind="item.marchTotal"></p></td>
															<td><p class ="a4" ng-bind="item.aprilTotal"></p></td>
															<td><p class ="a5" ng-bind="item.mayTotal"></p></td>
															<td><p class ="a6" ng-bind="item.juneTotal"></p></td>
															<td><p class ="a7" ng-bind="item.julyTotal"></p></td>
															<td><p class ="a8" ng-bind="item.augustTotal"></p></td>
															<td><p class ="a9" ng-bind="item.septemberTotal"></p></td>
															<td><p class ="a10" ng-bind="item.octoberTotal"></p></td>
															<td><p class ="a11" ng-bind="item.novemberTotal"></p></td>
															<td><p class ="a12" ng-bind="item.decemberTotal"></p></td>
															<td><p class ="a13" ng-bind="item.decemberTotal+item.februaryTotal+item.marchTotal+item.aprilTotal+item.mayTotal+item.juneTotal+item.augustTotal+tem.septemberTotal+item.octoberTotal+item.novemberTotal+item.januaryTotal|number:1"></p></td>
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