<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body ng-app = "myApp" >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		
		<div id="content">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
					
				<div class="outlet">
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">月度支出构成<i class="ec-list"></i></h4>
								</div>
								<div class="panel-body">
									<div id="container1"></div>
								</div>
							</div>
							
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">月度收支构成<i class="ec-list"></i></h4>
								</div>
								<div class="panel-body">
									<div id="container2"></div>
								</div>
							</div>
							
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">收入结余构成<i class="ec-list"></i></h4>
								</div>
								<div class="panel-body">
									<div id="container3"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				

			<div class="clearfix"></div>
		</div>
	</div>
			
	<script type="text/javascript">
	$(function () {
		
		$.post("${root}/admin/cost/outlay.do",{},function(data){
			
			var xcategories = data.xcategories;
			var seriesData = data.seriesData;
			
		    $('#container1').highcharts({
		        chart: {
		            type: 'column'
		        },
		        credits: {
		            enabled: false
		       	},
		        title: {
		            text: '月度支出构成'
		        },
		        xAxis: {
		            categories:xcategories,
		            crosshair: true
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: ''
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            			 '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: seriesData
		    });
		});
	
		
		$.post("${root}/admin/cost/depIncome.do",{},function(data){
			
			var xcategories = data.xcategories;
			var seriesData = data.seriesData;
			
		    $('#container2').highcharts({
		        chart: {
		            type: 'column'
		        },
		        credits: {
		            enabled: false
		       	},
		        title: {
		            text: '月度收支构成'
		        },
		        xAxis: {
		            categories:xcategories,
		            crosshair: true
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: ''
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            			 '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: seriesData
		    });
		});
		
		$.post("${root}/admin/cost/inbalance.do",{},function(data){
			
			$('#container3').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '收入-结余'
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.y}</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format:'{point.name}: <b>{point.y}</b>'
		                },
		                showInLegend: true
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: '收入-结余',
		            data: [
		                	['收入',data.totalIncome],
			                {
			                    name: '结余',
			                    y: data.balance,
			                    sliced: true,
			                    selected: true
			                }
		            ]
		        }]
		    });
		});
	});
	
	</script>
	
	<script src="${root}/public/js/pages/cost/script.js" type="text/javascript"></script>
	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
		
</body>
</html>