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
                                    <h3 class="panel-title"><i class="ec-search"></i>查询条件</h3>
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