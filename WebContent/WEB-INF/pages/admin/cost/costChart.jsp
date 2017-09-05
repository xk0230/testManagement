<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body ng-app = "myApp" >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		
		<div id="content" ng-controller="CostController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
					
				<div class="outlet">
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title">测试<i class="ec-list"></i></h4>
								</div>
								<div class="panel-body">
									<div id="container"></div>
									
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
		
		$.post("${root}/admin/cost/depIncome.do",{},function(data){
			
			var xcategories = [];
			var seriesData = [];
			
				xcategories = data.xcategories;
				seriesData = data.seriesData;
			
			
		    $('#container').highcharts({
		        chart: {
		            type: 'column'
		        },
		        credits: {
		            enabled: false
		       	},
		        title: {
		            text: '支出类型'
		        },
		        xAxis: {
		            categories:xcategories,
		            crosshair: true
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: '支出值(元)'
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            			 '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
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
	
		});
	
	</script>
	
	<script src="${root}/public/js/pages/cost/script.js" type="text/javascript"></script>
	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
		
</body>
</html>