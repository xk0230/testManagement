var myAppModule = angular.module("myApp",['ui.bootstrap'])

myAppModule.controller('ChartController',
	function costListController($scope,$http,$uibModal,$document,$filter){
		var self = this;
		
		this.$onInit = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/costYear.do',
				params:{
					recentYear:5
				}
			
			}).then(function(res){
				
				$scope.curYear = res.data.curYear;
				$scope.years = res.data.years;
				$scope.year = res.data.curYear;
				
				self.getOutlay();
				self.getDepIncome();
//				self.getDepOutcome();
				self.getInbalance();
				
			});
			
		};
		
		$scope.costYearChange = function(){
			
			self.getOutlay();
			self.getDepIncome();
			//self.getDepOutcome();
			self.getInbalance();
		};

		this.getOutlay = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/outlay.do',
				params:{
					curYear:$scope.year
				}
			
			}).then(function(res){
				if(res){
					
					var xcategories = res.data.xcategories;
					var seriesData = res.data.seriesData;
					
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
				            			 '<td style="padding:0"><b>{point.y:.5f}</b></td></tr>',
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
				}
			});
			
		};
		
		
		this.getDepIncome = function(){
			
			$('#depIncome').html('');
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/depIncome.do',
				params:{
					curYear:$scope.year
				}
			
			}).then(function(res){
				
				if(res){
					var xcategories = res.data.xcategories;
					var seriesData = res.data.seriesData;
					
					if(null != xcategories && xcategories.length > 0){
						var length = xcategories.length;
						var html = '';
						for(var i = 0;i<length;i++){
							html += '<div class="panel panel-default toggle" id = "dep_'+xcategories[i]+'"><div class="panel-heading">';
							html += '<h4 class="panel-title">';
							html += xcategories[i]+'部门月度收入构成';
							html += '<i class="ec-list"></i></h4></div>';
							html += '<div class="panel-body">';
							html += '<div id="container2';
							html += i+'">';
							html += '</div></div></div>';
						}
						
						$('#depIncome').append(html);
						
						for(var i = 0;i<length;i++){
							var xx = new Array(1);
							xx[0] = xcategories[i];
							
							var yy = new Array(seriesData.length);
							for(var j = 0;j<seriesData.length;j++){
								var yName = seriesData[j].name;
								var yVal = seriesData[j].data[i];
								yy[j] = $.parseJSON('{"name":'+'"'+yName+'"'+',"data":['+yVal+']}');
							}
							 
							var containerId = "container2"+i;
							$('#'+containerId).highcharts({
						        chart: {
						            type: 'column'
						        },
						        credits: {
						            enabled: false
						       	},
						        title: {
						            text: ''
						        },
						        xAxis: {
						            categories:xx,
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
						            			 '<td style="padding:0"><b>{point.y:.5f}</b></td></tr>',
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
						        series: yy
						    });
						}
					}
				}
			});
			self.getDepOutcome();
		};
		
		this.getDepOutcome = function(){
			
			$('#depOutcome').html('');
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/depOutcome.do',
				params:{
					curYear:$scope.year
				}
			
			}).then(function(res){
				if(res){
					var xcategories = res.data.xcategories;
					var seriesData = res.data.seriesData;
					
					if(null != xcategories && xcategories.length > 0){
						var length = xcategories.length;
						for(var i = 0;i<length;i++){
							var html = '';
							html += '<div class="panel panel-default toggle"><div class="panel-heading">';
							html += '<h4 class="panel-title">';
							html += xcategories[i]+'部门月度支出构成';
							html += '<i class="ec-list"></i></h4></div>';
							html += '<div class="panel-body">';
							html += '<div id="container3';
							html += i+'">';
							html += '</div></div></div>';
							
							$('#dep_'+xcategories[i]).after(html);
						}
						
						//$('#depOutcome').append(html);
						
						
						for(var i = 0;i<length;i++){
							var xx = new Array(1);
							xx[0] = xcategories[i];
							
							var yy = new Array(seriesData.length);
							for(var j = 0;j<seriesData.length;j++){
								var yName = seriesData[j].name;
								var yVal = seriesData[j].data[i];
								yy[j] = $.parseJSON('{"name":'+'"'+yName+'"'+',"data":['+yVal+']}');
							}
							 
							var containerId = "container3"+i;
							$('#'+containerId).highcharts({
						        chart: {
						            type: 'column'
						        },
						        credits: {
						            enabled: false
						       	},
						        title: {
						            text: ''
						        },
						        xAxis: {
						            categories:xx,
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
						            			 '<td style="padding:0"><b>{point.y:.5f}</b></td></tr>',
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
						        series: yy
						    });
						}
					}
				}
			});
		};
		
		
		this.getInbalance = function(){
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/inbalance.do',
				params:{
					curYear:$scope.year
				}
			
			}).then(function(res){
				if(res){
					$('#container4').highcharts({
				        chart: {
				            plotBackgroundColor: null,
				            plotBorderWidth: null,
				            plotShadow: false
				        },
				        title: {
				            text: ''
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
				                	['收入',res.data.totalIncome],
					                {
					                    name: '结余',
					                    y: res.data.balance,
					                    sliced: true,
					                    selected: true
					                }
				            ]
				        }]
				    });
				}
			});
			
		};
		
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);