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

				self.depMonthOut();
				self.getDepIncome();

			});
			
			$scope.costTypeList = [
				{costType : "0", name : "收入"},
				{costType : "1", name : "支出"}
			];
			$scope.costType = "0";
		};
		$scope.costYearChange = function(){
			self.depMonthOut();
			self.getDepIncome();
		};
		
		this.depMonthOut = function(){
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/depMonthOut.do',
				params:{
					curYear:$scope.year,
					costType:$scope.costType
				}
			
			}).then(function(res){
				if(res){
					self.list = res.data || [];
				}
			});
			
		};
		
		this.getDepIncome = function(){
			
			$('#depIncome').html('');
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/depIncome.do',
				params:{
					curYear:$scope.year,
					costType:$scope.costType
				}
			
			}).then(function(res){
				if(res){
					/*子分类*/
					var costSubList = res.data.objData.costSubList;
					var costSubStrList = res.data.objData.costSubStrList;
					/*查询结果*/
					var costMaps = res.data.objData.costMaps;
					
					var yy = new Array();
					for(var i=1;i<=12;i++){
						var item = costMaps["costChartList" + i];
						var dataTmp = new Array();
						if(item.length == 0){
							/*遍历所有的分类*/
							angular.forEach(costSubList, function(item1, key1) {
								/*设置为0*/
								dataTmp.push(0);
							});
						}else{
							/*遍历所有的分类*/
							angular.forEach(costSubList, function(item1, key1) {
								/*遍历结果*/
								var hasData = false;
								angular.forEach(item, function(item2, key2) {
									if(item1.costSubTypeId == item2.costSubId){
										hasData = true;
										dataTmp.push(item2.costNum);
									}
								});
								if(!hasData){
									dataTmp.push(0);
								}
								
							});
						}
						var json = {};
						json["name"] = i+"月";
						json["data"] = dataTmp;
						yy.push(json);
					}
					
				    $('#depIncome').highcharts({
				        chart: {
				            type: 'column'
				        },
				        title: {
				            text: '月度支出'
				        },
				        subtitle: {
				            text: ''
				        },
				        xAxis: {
				            categories: costSubStrList,
				            crosshair: true
				        },
				        yAxis: {
				            min: 0,
				            title: {
				                text: '金额 (元)'
				            }
				        },
				        tooltip: {
				            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
				            '<td style="padding:0"><b>{point.y:.1f} 元</b></td></tr>',
				            footerFormat: '</table>',
				            shared: true,
				            useHTML: true
				        },
				        plotOptions: {
				            column: {
				                borderWidth: 0
				            }
				        },
				        series: yy
				    });

				}
			});
		};
		
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);