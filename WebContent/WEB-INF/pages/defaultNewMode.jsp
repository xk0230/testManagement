<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script type="text/javascript" src="${root }/public/newCss/full-calendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="${root }/public/newCss/chart.min.js"></script> 
</head>
<body  >
	<%@ include file="common/header.jsp"%>
	<!-- Start #content -->
	<div class="main" ng-app = "myApp" ng-controller="UserListController as vm">
	  <div class="main-inner">
	    <div class="container">
	      <div class="row">
	        <div class="span6">
	          <div class="widget widget-nopad">
	            <div class="widget-header"> <i class="icon-list-alt"></i>
	              <h3> 实时状态</h3>
	            </div>
	            <!-- /widget-header -->
	            <div class="widget-content">
	              <div class="widget big-stats-container">
	                <div class="widget-content">
	                  <div id="big_stats" class="cf">
	                    <div class="stat">今日报销<i class="icon-anchor"></i> <span class="value">851</span> </div>
	                    <!-- .stat -->
	                    
	                    <div class="stat">人力资源<i class="icon-thumbs-up-alt"></i> <span class="value">423</span> </div>
	                    <!-- .stat -->
	                    
	                    <div class="stat">待处理事项<i class="icon-twitter-sign"></i> <span class="value">922</span> </div>
	                    <!-- .stat -->
	                    
	                    <div class="stat">年假剩余<i class="icon-bullhorn"></i> <span class="value">25%</span> </div>
	                    <!-- .stat --> 
	                  </div>
	                </div>
	                <!-- /widget-content --> 
	                
	              </div>
	            </div>
	          </div>
	          <!-- /widget -->
	          <div class="widget widget-nopad">
	            <div class="widget-header"> <i class="icon-list-alt"></i>
	              <h3> 近期日历</h3>
	            </div>
	            <!-- /widget-header -->
	            <div class="widget-content">
	              <div id='calendar'>
	              </div>
	            </div>
	            <!-- /widget-content --> 
	          </div>
	          <!-- /widget -->
	          <div class="widget widget-table action-table">
	            <div class="widget-header"> <i class="icon-th-list"></i>
	              <h3>常用下载</h3>
	            </div>
	            <!-- /widget-header -->
	            <div class="widget-content">
	              <table class="table table-striped table-bordered">
	                <thead>
	                  <tr>
	                    <th> Free Resource </th>
	                    <th> Download</th>
	                    <th class="td-actions"> </th>
	                  </tr>
	                </thead>
	                <tbody>
	                  <tr>
	                    <td> Fresh Web Development Resources </td>
	                    <td> http://www.by EGrappler/ </td>
	                    <td class="td-actions">
	                    	<a href="javascript:;" class="btn btn-small btn-success"><i class="btn-icon-only icon-ok"> </i></a>
	                    	<a href="javascript:;" class="btn btn-danger btn-small"><i class="btn-icon-only icon-remove"> </i></a></td>
	                  </tr>
	                  <tr>
	                    <td> Fresh Web Development Resources </td>
	                    <td> http://www.by EGrappler/ </td>
	                    <td class="td-actions"><a href="javascript:;" class="btn btn-small btn-success"><i class="btn-icon-only icon-ok"> </i></a><a href="javascript:;" class="btn btn-danger btn-small"><i class="btn-icon-only icon-remove"> </i></a></td>
	                  </tr>
	                  <tr>
	                    <td> Fresh Web Development Resources </td>
	                    <td> http://www.by EGrappler/ </td>
	                    <td class="td-actions"><a href="javascript:;" class="btn btn-small btn-success"><i class="btn-icon-only icon-ok"> </i></a><a href="javascript:;" class="btn btn-danger btn-small"><i class="btn-icon-only icon-remove"> </i></a></td>
	                  </tr>
	                  <tr>
	                    <td> Fresh Web Development Resources </td>
	                    <td> http://www.by EGrappler/ </td>
	                    <td class="td-actions"><a href="javascript:;" class="btn btn-small btn-success"><i class="btn-icon-only icon-ok"> </i></a><a href="javascript:;" class="btn btn-danger btn-small"><i class="btn-icon-only icon-remove"> </i></a></td>
	                  </tr>
	                  <tr>
	                    <td> Fresh Web Development Resources </td>
	                    <td> http://www.by EGrappler/ </td>
	                    <td class="td-actions"><a href="javascript:;" class="btn btn-small btn-success"><i class="btn-icon-only icon-ok"> </i></a><a href="javascript:;" class="btn btn-danger btn-small"><i class="btn-icon-only icon-remove"> </i></a></td>
	                  </tr>
	                
	                </tbody>
	              </table>
	            </div>
	            <!-- /widget-content --> 
	          </div>
	          <!-- /widget --> 
	        </div>
	        <!-- /span6 -->
	        <div class="span6">
	          <div class="widget">
	            <div class="widget-header"> <i class="icon-bookmark"></i>
	              <h3>快捷入口</h3>
	            </div>
	            <!-- /widget-header -->
	            <div class="widget-content">
	              <div class="shortcuts"> <a href="javascript:;" class="shortcut"><i class="shortcut-icon icon-list-alt"></i>
		              <span class="shortcut-label">入职必读</span> </a><a href="javascript:;" class="shortcut"><i class="shortcut-icon icon-bookmark"></i>
		              <span class="shortcut-label">书籍借阅</span> </a><a href="javascript:;" class="shortcut"><i class="shortcut-icon icon-signal"></i>
		              <span class="shortcut-label">合同管理</span> </a><a href="javascript:;" class="shortcut"> <i class="shortcut-icon icon-comment"></i>
		              <span class="shortcut-label">报销申请</span> </a><a href="javascript:;" class="shortcut"><i class="shortcut-icon icon-user"></i>
		              <span class="shortcut-label">岗位申请</span> </a><a href="javascript:;" class="shortcut"><i class="shortcut-icon icon-file"></i>
		              <span class="shortcut-label">招聘申请</span> </a><a href="javascript:;" class="shortcut"><i class="shortcut-icon icon-picture"></i>
		              <span class="shortcut-label">团建照片</span> </a><a href="javascript:;" class="shortcut"> <i class="shortcut-icon icon-tag"></i>
		              <span class="shortcut-label">健康管理</span> </a>
	              </div>
	              <!-- /shortcuts --> 
	            </div>
	            <!-- /widget-content --> 
	          </div>
	          <!-- /widget -->
	          <div class="widget">
	            <div class="widget-header"> <i class="icon-signal"></i>
	              <h3> 成本概览</h3>
	            </div>
	            <!-- /widget-header -->
	            <div class="widget-content">
	              <canvas id="area-chart" class="chart-holder" height="250" width="538"> </canvas>
	              <!-- /area-chart --> 
	            </div>
	            <!-- /widget-content --> 
	          </div>
	          <!-- /widget -->
	          <div class="widget widget-nopad">
	            <div class="widget-header"> <i class="icon-list-alt"></i>
	              <h3> 公司大事件</h3>
	            </div>
	            <!-- /widget-header -->
	            <div class="widget-content">
	              <ul class="news-items">
	                <li>
	                  
	                  <div class="news-item-date"> <span class="news-item-day">29</span> <span class="news-item-month">Aug</span> </div>
	                  <div class="news-item-detail"> <a href="http://www.by EGrappler/thursday-roundup-40/" class="news-item-title" target="_blank">Thursday Roundup # 40</a>
	                    <p class="news-item-preview"> This is our web design and development news series where we share our favorite design/development related articles, resources, tutorials and awesome freebies. </p>
	                  </div>
	                  
	                </li>
	                <li>
	                  
	                  <div class="news-item-date"> <span class="news-item-day">15</span> <span class="news-item-month">Jun</span> </div>
	                  <div class="news-item-detail"> <a href="http://www.by EGrappler/retina-ready-responsive-app-landing-page-website-template-app-landing/" class="news-item-title" target="_blank">Retina Ready Responsive App Landing Page Website Template – App Landing</a>
	                    <p class="news-item-preview"> App Landing is a retina ready responsive app landing page website template perfect for software and application developers and small business owners looking to promote their iPhone, iPad, Android Apps and software products.</p>
	                  </div>
	                  
	                </li>
	                <li>
	                  
	                  <div class="news-item-date"> <span class="news-item-day">29</span> <span class="news-item-month">Oct</span> </div>
	                  <div class="news-item-detail"> <a href="http://www.by EGrappler/open-source-jquery-php-ajax-contact-form-templates-with-captcha-formify/" class="news-item-title" target="_blank">Open Source jQuery PHP Ajax Contact Form Templates With Captcha: Formify</a>
	                    <p class="news-item-preview"> Formify is a contribution to lessen the pain of creating contact forms. The collection contains six different forms that are commonly used. These open source contact forms can be customized as well to suit the need for your website/application.</p>
	                  </div>
	                  
	                </li>
	              </ul>
	            </div>
	            <!-- /widget-content --> 
	          </div>
	          <!-- /widget -->
	        </div>
	        <!-- /span6 --> 
	      </div>
	      <!-- /row --> 
	    </div>
	    <!-- /container --> 
	  </div>
	  <!-- /main-inner --> 
	</div>
	<!-- /main -->
<script>     

        var lineChartData = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
				{
				    fillColor: "rgba(220,220,220,0.5)",
				    strokeColor: "rgba(220,220,220,1)",
				    pointColor: "rgba(220,220,220,1)",
				    pointStrokeColor: "#fff",
				    data: [65, 59, 90, 81, 56, 55, 40]
				},
				{
				    fillColor: "rgba(151,187,205,0.5)",
				    strokeColor: "rgba(151,187,205,1)",
				    pointColor: "rgba(151,187,205,1)",
				    pointStrokeColor: "#fff",
				    data: [28, 48, 40, 19, 96, 27, 100]
				}
			]

        }

        var myLine = new Chart(document.getElementById("area-chart").getContext("2d")).Line(lineChartData);


        var barChartData = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
				{
				    fillColor: "rgba(220,220,220,0.5)",
				    strokeColor: "rgba(220,220,220,1)",
				    data: [65, 59, 90, 81, 56, 55, 40]
				},
				{
				    fillColor: "rgba(151,187,205,0.5)",
				    strokeColor: "rgba(151,187,205,1)",
				    data: [28, 48, 40, 19, 96, 27, 100]
				}
			]

        }    

        $(document).ready(function() {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var calendar = $('#calendar').fullCalendar({
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
          },
          selectable: true,
          selectHelper: true,
          select: function(start, end, allDay) {
            var title = prompt('Event Title:');
            if (title) {
              calendar.fullCalendar('renderEvent',
                {
                  title: title,
                  start: start,
                  end: end,
                  allDay: allDay
                },
                true // make the event "stick"
              );
            }
            calendar.fullCalendar('unselect');
          },
          editable: true,
          events: [
            {
              title: 'All Day Event',
              start: new Date(y, m, 1)
            },
            {
              title: 'Long Event',
              start: new Date(y, m, d+5),
              end: new Date(y, m, d+7)
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d-3, 16, 0),
              allDay: false
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d+4, 16, 0),
              allDay: false
            },
            {
              title: 'Meeting',
              start: new Date(y, m, d, 10, 30),
              allDay: false
            },
            {
              title: 'Lunch',
              start: new Date(y, m, d, 12, 0),
              end: new Date(y, m, d, 14, 0),
              allDay: false
            },
            {
              title: 'Birthday Party',
              start: new Date(y, m, d+1, 19, 0),
              end: new Date(y, m, d+1, 22, 30),
              allDay: false
            },
            {
              title: 'by EGrappler',
              start: new Date(y, m, 28),
              end: new Date(y, m, 29),
              url: 'http://by EGrappler/'
            }
          ]
        });
      });
    </script><!-- /Calendar -->
	<script src="${root}/public/js/pages/default.js" type="text/javascript"></script>
</body>
</html>