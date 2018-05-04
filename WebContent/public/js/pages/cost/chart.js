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
			$scope.monthCheckList = [
				{month : "1", check : true},
				{month : "2", check : true},
				{month : "3", check : true},
				{month : "4", check : true},
				{month : "5", check : true},
				{month : "6", check : true},
				{month : "7", check : true},
				{month : "8", check : true},
				{month : "9", check : true},
				{month : "10", check : true},
				{month : "11", check : true},
				{month : "12", check : true}
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
					var costs = res.data.objData.costs;
					self.list = costs;
					console.log(costs);
					var sum1=parseFloat(0);
					var sum2=parseFloat(0);
					var sum3=parseFloat(0);
					var sum4=parseFloat(0);
					var sum5=parseFloat(0);
					var sum6=parseFloat(0);
					var sum7=parseFloat(0);
					var sum8=parseFloat(0);
					var sum9=parseFloat(0);
					var sum10=parseFloat(0);
					var sum11=parseFloat(0);
					var sum12=parseFloat(0);
					var depTotal = parseFloat(0);
					
					angular.forEach(self.list, function(item, key) {
						sum1 += item.chartList[0].costNum;
						sum2 += item.chartList[1].costNum;
						sum3 += item.chartList[2].costNum;
						sum4 += item.chartList[3].costNum;
						sum5 += item.chartList[4].costNum;
						sum6 += item.chartList[5].costNum;
						sum7 += item.chartList[6].costNum;
						sum8 += item.chartList[7].costNum;
						sum9 += item.chartList[8].costNum;
						sum10 += item.chartList[9].costNum;
						sum11 += item.chartList[10].costNum;
						sum12 += item.chartList[11].costNum;
						depTotal += item.depTotal;
					});
					var sumItem = {"depName":"总计"
						,"chartList":[{"costNum":sum1},
									{"costNum":sum2},
									{"costNum":sum3},
									{"costNum":sum4},
									{"costNum":sum5},
									{"costNum":sum6},
									{"costNum":sum7},
									{"costNum":sum8},
									{"costNum":sum9},
									{"costNum":sum10},
									{"costNum":sum11},
									{"costNum":sum12}]
						,"depTotal":depTotal};
					self.list["sum"] = sumItem;
				}
			});
			
		};
		
		this.checkDep = function(){
			self.getDepIncome();
		}
		
		this.getDepIncome = function(){
			
			$('#depIncome').html('');
			
			var checkedDep = "";
			angular.forEach(self.list, function(item, key) {
				if(item.checked){
					checkedDep = checkedDep + item.depId + ",";
				}
			});
			if(checkedDep.length > 0){
				checkedDep = checkedDep.substring(0,checkedDep.length-1);
			}else{
				checkedDep ="";
			}
			if(!$scope.year){
				return;
			}
			
			$http({
				method:'POST',
				url:$("#rootUrl").val()+'/admin/cost/depIncome.do',
				params:{
					curYear:$scope.year,
					costType:$scope.costType,
					depIds:checkedDep
				}
			
			}).then(function(res){
				if(res){
					/*子分类*/
					var costSubList = res.data.objData.costSubList;
					var costSubStrList = res.data.objData.costSubStrList;
					/*查询结果*/
					var costMaps = res.data.objData.costMaps;
					
					var monthList = new Array();
					
					var yy = new Array();
					
					angular.forEach($scope.monthCheckList, function(monthItem, key2) {
						if(monthItem.check){
							var i = monthItem.month;
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
							json["name"] = monthItem.month+"月";
							json["data"] = dataTmp;
							yy.push(json);
						}
					});
					
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