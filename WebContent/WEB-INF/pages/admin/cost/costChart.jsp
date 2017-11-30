<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		
		<div id="content"  ng-app = "myApp" ng-controller="ChartController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="st-chart"></i> 成本图表</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
				<div class="outlet">
					<div class="row">
					
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"></h3>
                                </div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										
										<div class="form-group">
											<div class="col-lg-3">
												<input type="hidden" ng-model="curYear" >
												<label class="col-lg-4 control-label" >查询年份</label>
												<div class="col-lg-8">
													<select ng-model="year"  class="form-control select2" ng-change="costYearChange()"
															ng-options="year for year in years">
													</select>
												</div>
											</div>
											
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">月度支出构成</h4>
								</div>
								<div class="panel-body">
									<div id="container1"></div>
									
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
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td><p ng-bind="item.depName"></p></td>
												<td><p ng-bind="item.januaryTotal"></p></td>
												<td><p ng-bind="item.februaryTotal"></p></td>
												<td><p ng-bind="item.marchTotal"></p></td>
												<td><p ng-bind="item.aprilTotal"></p></td>
												<td><p ng-bind="item.mayTotal"></p></td>
												<td><p ng-bind="item.juneTotal"></p></td>
												<td><p ng-bind="item.julyTotal"></p></td>
												<td><p ng-bind="item.augustTotal"></p></td>
												<td><p ng-bind="item.septemberTotal"></p></td>
												<td><p ng-bind="item.octoberTotal"></p></td>
												<td><p ng-bind="item.novemberTotal"></p></td>
												<td><p ng-bind="item.decemberTotal"></p></td>
											</tr>
										</tbody>
									</table>
									
								</div>
							</div>
							
							<div id="depIncome"></div>
							<div id="depOutcome"></div>
							
							<div class="panel panel-default toggle" ng-show="${adminUser.position == 'ADMIN'}">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">收入结余构成</h4>
								</div>
								<div class="panel-body">
									<div id="container4"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				

			<div class="clearfix"></div>
		</div>
	</div>
			
	<input type="hidden" id="rootUrl" value="${root}">
	
	<script src="${root}/public/js/pages/cost/chart.js" type="text/javascript"></script>
	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
	
</body>
</html>