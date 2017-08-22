function bindEvent(){
	$("#semester").on("click"," a",function(){
		var $elem = $(this);
		$elem.addClass("selected");
		var $parent = $elem.parent();
		$parent.find("a").not(this).removeClass("selected");
	});
	
	$("#resourceCategory").on("click"," a",function(){
		var $elem = $(this);
		$elem.addClass("selected");
		var $parent = $elem.parent();
		$parent.find("a").not(this).removeClass("selected");
	});
} ;

// 资源总数
function totalTop(data) {
	$.post("topTotal.do",data,function(data){
		if(data.totalNum == "0"){
			$("#top").html("没有相关统计信息！");
		}else{
			$("#top").html("共有<b class='orange'>"+data.TOTALNUM+"</b>个资源，共计被查看<b class='orange'>"+data.VIEWNUM+"</b>次，下载<b class='orange'>"+data.DOWNLOADNUM+"</b>次。");
			
		}
	},"json") ;
}

// 上传资源统计
function uploadResources(data) {
	 $.post("uploadResourcesCount.do", data, function(data){
		 showUploadNum(data) ;
	 }, "json") ;
} ;

// 资源总量
function allResources(data) {
	$.post("allResourcesCount.do", data, function(data){
		showAllResourcesNum(data) ;
	 }, "json") ;
}

// 资源一级分类
function firstCatelogry(data) {
	$.post("firstCatelogry.do", data, function(data){
		showFirstCategory(data) ;
	 }, "json") ;
}

// === 资源二级分类
function secondCatelogry(data) {
	$.post("secondCatelogry.do", data, function(data){
		showSecondCategory(data) ;
	 },"json") ;
}

// === 年级统计资源
function classlevelCatelogry(data) {
	$.post("classlevelCatelogry.do", data, function(data){
		showClasslevelCatelogry(data) ;
	 }, "json") ;
}

// === 学科统计资源
function subjectCatelory(data) {
	$.post("subjectResources.do", data, function(data){
		showSubjectCatelogry(data) ;
	 }, "json") ;
}

// === 学校top10
function schoolTopTen(data) {
	$.post("schoolTenLevel.do", data, function(data){
		showSchoolTopTen(data) ;
	 }, "json") ;
}

// === 老师top10
function teacherTopTen(data) {
	$.post("teacherTenLevel.do", data, function(data){
		showTeacherTopTen(data) ;
	 }, "json") ;
}

//============================================ 图表展示区域  ==============================
// === 上传的资源
function showUploadNum(data){
	if(data.statisticsNum.length > 0){
		$('#statistics2').highcharts({
			credits: {
				enabled:false
			},
			title: {
				text: '上传资源统计'
			},
			xAxis: {
				categories: data.months
			},
			yAxis: {
				title:null,
				floor: 0,
				labels:{
					enabled:true
				} ,
	            allowDecimals:false ,
	            min:0
			},
			legend: {
				enabled: false
			},
			series: data.statisticsNum
		});
	 }else{
		$('#statistics2').html("");
	} 
} ;

// === 资源总量
function showAllResourcesNum(data){
	if(data.statisticsNum.length > 0){
		$('#statistics1').highcharts({
			credits: {
				enabled:false
			},
			title: {
				text: '资源总量统计'
			},
			xAxis: {
				categories: data.months
			},
			yAxis: {
				title:null,
				floor: 0,
				labels:{
					enabled:true
				},
	            allowDecimals:false ,
	            min:0
			},
			legend: {
				enabled: false
			},
			series: data.statisticsNum
		});
	 }else{
		$('#statistics1').html("");
	} 
} ;

// === 一级分类
function showFirstCategory(data){
	//if(data.length > 0){
		$('#statistics3').highcharts({
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: '一级分类'
			},
			credits: {
				enabled:false
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.y}</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						format: '<b>{point.name}</b>: {point.percentage:.0f}%'
					},
					showInLegend: true
				}
			},
			lang: {
	            noData: "抱歉，未查询到相关记录。"
	        },
	        noData: {
	            style: {
	                fontWeight: 'bold',
	                fontSize: '15px',
	                color: '#303030'
	            }
	        },
			series: [{
				type: 'pie',
				name: '资源数',
				data: data
			}]
		});
	/*}else{
		$('#statistics3').html("");
	}*/
} ;

// === 二级分类
function showSecondCategory(data){
	//if(data.length > 0){
		console.log(data) ;
		$('#statistics4').highcharts({
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: '二级分类'
			},
			credits: {
				enabled:false
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.y}</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						format: '<b>{point.name}</b>: {point.percentage:.0f}%'
					},
					showInLegend: true
				}
			},
			lang: {
	            noData: "抱歉，未查询到相关记录。"
	        },
	        noData: {
	            style: {
	                fontWeight: 'bold',
	                fontSize: '15px',
	                color: '#303030'
	            }
	        },
			series: [{
				type: 'pie',
				name: '资源数',
				data: data
			}]
		});
	/*}else{
		$('#statistics4').html("");
	}*/
} ;

// === 年级分类
function showClasslevelCatelogry(data){
	//if(data.length > 0){
		$('#statistics5').highcharts({
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: '年级资源分布'
			},
			credits: {
				enabled:false
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.y}</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						format: '<b>{point.name}</b>: {point.percentage:.0f}%'
					},
					showInLegend: true
				}
			},
			lang: {
	            noData: "抱歉，未查询到相关记录。"
	        },
	        noData: {
	            style: {
	                fontWeight: 'bold',
	                fontSize: '15px',
	                color: '#303030'
	            }
	        },
			series: [{
				type: 'pie',
				name: '资源数',
				data: data
			}]
		});
	/*}else{
		$('#statistics5').html("");
	}*/
} ;

// === 学科分类
function showSubjectCatelogry(data){
	//if(data.length > 0){
		$('#statistics6').highcharts({
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: '学科资源分布'
			},
			credits: {
				enabled:false
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.y}</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						format: '<b>{point.name}</b>: {point.percentage:.0f}%'
					},
					showInLegend: true
				}
			},
			lang: {
	            noData: "抱歉，未查询到相关记录。"
	        },
	        noData: {
	            style: {
	                fontWeight: 'bold',
	                fontSize: '15px',
	                color: '#303030'
	            }
	        },
			series: [{
				type: 'pie',
				name: '资源数',
				data: data
			}]
		});
	/*}else{
		$('#statistics6').html("");
	}*/
} ;

// 学校top10
function showSchoolTopTen(data){
	$("#schoolT").html("");
	var schoolTop = data;
	var html = '';
	for(var i=0;i<schoolTop.length;i++){
		html += '<tr>';
		html += '<td>'+(i+1)+'</td>';
		html += '<td>'+schoolTop[i].name+'</td>';
		html += '<td>'+schoolTop[i].sum+'</td>';
		html += '</tr>';
	}
	$("#schoolT").append(html);
} ;

// 学校top10
function showTeacherTopTen(data){
	$("#teacherT").html("");
	var schoolTop = data;
	var html = '';
	for(var i=0;i<schoolTop.length;i++){
		html += '<tr>';
		html += '<td>'+(i+1)+'</td>';
		html += '<td>'+schoolTop[i].TEACHERNAME+'</td>';
		html += '<td>'+schoolTop[i].SCHOOLNAME+'</td>';
		html += '<td>'+schoolTop[i].TOTALNUM+'</td>';
		html += '</tr>';
	}
	$("#teacherT").append(html);
} ;