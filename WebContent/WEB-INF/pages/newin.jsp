<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script type="text/javascript" src="${root }/public/newCss/full-calendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="${root }/public/newCss/chart.min.js"></script> 
<html lang="en">
  
 <head>
    <title>入职必读</title>
  </head>

<body>
<%@ include file="common/header.jsp"%>
<div class="main">
	
	<div class="main-inner">
        <div class="container">
        <div class="row">
            <div class="span12">
            <div class="info-box" style="background-color:azure">
						<h3 style="text-align: center"><i class="icon-heart"></i>&nbsp;&nbsp;&nbsp;Welcome On Board!&nbsp;&nbsp;&nbsp;<i class="icon-heart"></i></h3>
                <p style="text-align: center">请仔细阅读以下内容，并按照提示操作，完成入职必须要熟悉的各项模块!</p>
                <nav style="text-align: center">
  <a href= "${root}/public/file/handbook.pdf" style="margin: 0 20px"><i class="icon-chevron-right "></i>&nbsp;&nbsp;阅读员工手册</a>
  <a href="javascript:void(0)" onclick="document.getElementById('outlook').scrollIntoView();" style="margin: 0 20px"><i class="icon-chevron-right "></i>&nbsp;&nbsp;Outlook设置</a>
  
  <a href="javascript:void(0)" onclick="document.getElementById('card').scrollIntoView();" style="margin: 0 20px"><i class="icon-chevron-right "></i>&nbsp;&nbsp;办理各类卡片</a>
  <a href="javascript:void(0)" onclick="document.getElementById('layout').scrollIntoView();" style="margin: 0 20px"><i class="icon-chevron-right "></i>&nbsp;&nbsp;熟悉办公环境</a>
   <a href="javascript:void(0)" onclick="document.getElementById('profile').scrollIntoView();" style="margin: 0 20px"><i class="icon-chevron-right "></i>&nbsp;&nbsp;完善入职资料</a> 
   <a href="javascript:void(0)" onclick="document.getElementById('contact').scrollIntoView();" style="margin: 0 20px"><i class="icon-chevron-right "></i>&nbsp;&nbsp;通讯录</a>                 
</nav>
                
                					</div> <!-- /widget-header -->
            </div></div>
        </div>

	    <div class="container"> 
	      	
	
	      <div class="row">
	      	
	      	<div class="span12">
	      		
	      		<div class="widget">
						
					<div class="widget-header">
						<i class="icon-group"></i>
						<h3 id="outlook">Outlook设置</h3>
					</div> <!-- /widget-header -->
					
					<div class="widget-content">
						<p><i class="icon-play"></i> SSC已引导您修改了exchange密码，该密码与用户名也是您的<strong> 域用户名与密码。请务必牢记。 </strong><i class="icon-play"></i> 如忘记密码请及时与SSC联系重置密码。</p>
                        <p><i class="icon-play"></i> 请按照如下要求配置Outlook。<a href="${root}/public/file/Outlook.pdf">Outlook使用必读</a> </p>
                        <p><i class="icon-play"></i> 网页版本邮件系统地址：<a href="https://mail.ccydsz.com/owa">https://mail.ccydsz.com/owa</a></p>
                        <p><i class="icon-play"></i> 重置密码 （两种方式）</p>
                        <p style="margin-left: 8%">&nbsp;&nbsp;<i class="icon-star-empty"></i> 方法一 登陆&nbsp;&nbsp;<a href="https://mail.ccydsz.com/owa">https://mail.ccydsz.com/owa （IE浏览器打开）</a> </p>
                        <img src="${root}/public/img/web1.png" style="width:20%;">&nbsp;&nbsp;&nbsp;<img src="${root}/public/img/web2.png" style="width:15%">&nbsp;&nbsp;&nbsp;<img src="${root}/public/img/web3.png" style="width:30%">&nbsp;&nbsp;&nbsp;<img src="${root}/public/img/web4.png" style="width:30%"> 
                        <hr>
                        <p style="margin-left: 8%">&nbsp;&nbsp;&nbsp;<i class="icon-star-empty"></i> 方法二 域用户登陆情况下，打开&nbsp;&nbsp;&nbsp;<strong>控制面板=>用户与账户</strong></p>
                        <img src="${root}/public/img/local2.png" style="width:50%">
                         <img src="${root}/public/img/local.png" style="width:23%;margin-left: 50px">         
                     
					</div> 
                    <!-- /outlook设置 -->
						
				</div> <!-- /widget -->
				
	      		
	      		
	      		
		    </div> <!-- /span12 -->
   </div><!-- /outlook -->
	      <div class="row">
	      <div class="span12">
                
	      		
	      		<div class="widget">
							
					<div class="widget-header">
						<i class="icon-list-alt"></i>
						<h3 id="card">办理各类卡片</h3>
					</div> <!-- /widget-header -->
					
					<div class="widget-content">
						<p><i class="icon-play"></i> 门禁卡：请至SSC领取门禁卡。</p>
                        <p><i class="icon-play"></i> 餐卡：请至产业园G1一楼办理市民卡。（需带身份证与适量充值金额，支持支付宝）</p>
                        <p><i class="icon-play"></i> 地下车位：如需停车，请在办公用品区域自行领取《在职证明》至SSC盖章，并携带<Strong style="margin: 0 30px">1）车辆行驶证复印件。 2）蓝牙押金200元</Strong> 至产业园G1一楼办理</p>
                        <p><i class="icon-play"></i> 工资卡：工商银行卡号。（不限制开户地）</p>
                        
					</div> <!-- /widget-content -->
				
				</div> <!-- /widget -->
									
		      </div> <!-- /span12 -->
			
            </div><!-- /card -->
	      <div class="row">
	      <div class="span12">
                
	      		
	      		<div class="widget">
							
					<div class="widget-header">
						<i class="icon-list-alt"></i>
						<h3 id="profile">完善入职资料</h3>
					</div> <!-- /widget-header -->
					
					<div class="widget-content">
						<p><i class="icon-play"></i> 个人信息：请在本系统中个人信息模块完成个人信息资料，包括市民卡卡号，工资卡卡号。</p>
                        <p><i class="icon-play"></i> 劳动合同：请阅读SSC发放的《劳动合同》并在指定位置签署。</p>
                        <p><i class="icon-play"></i> 个人纸质资料：请按照OFFER中提示的个人资料准备原件与复印件，连同签署完成的《劳动合同》一并提交给SSC。</p>
                        <p><i class="icon-play"></i> 未在苏州缴纳过社会保险的员工，请提交一寸<strong>白底</strong>电子照片。发送至 <a href="mailto:lilian.liu@ccydsz.com"><strong>lilian.liu@ccydsz.com</strong></a></p>
                        
					</div> <!-- /widget-content -->
				
				</div> <!-- /widget -->
									
		      </div> <!-- /span12 -->
			
            </div><!-- /profile -->
        <div class="row">
	      <div class="span12">
                
	      		
	      		<div class="widget">
							
					<div class="widget-header">
						<i class="icon-list-alt"></i>
						<h3 id="layout">熟悉办公环境</h3>
					</div> <!-- /widget-header -->
					
					<div class="widget-content">
						<p><i class="icon-play"></i> 共享文件： 文件夹权限请向直属主管申请。</p><br>
                        <img src="${root}/public/img/fs1.png" style="width: 35%">
                        <img src="${root}/public/img/fs2.png" style="width: 25%">
                        <img src="${root}/public/img/fs3.jpg" style="width: 39%"><br><br>
                        <p><i class="icon-play"></i> 前台打印扫描一体机驱动地址：<strong>\\192.168.6.244\software\打印机</strong></p>
                        <p><i class="icon-play"></i> 办公室功能平面图</p>
                        <img src="${root}/public/img/layout.png" style="width: 90%">
                    </div> <!-- /widget-content -->
				
				</div> <!-- /widget -->
									
		      </div> 
			
            </div><!-- /layout -->
            <div class="row">
	      <div class="span12">
                
	      		
	      		<div class="widget">
							
					<div class="widget-header">
						<i class="icon-list-alt"></i>
						<h3 id="contact">熟悉通讯工具</h3>
					</div> <!-- /widget-header -->
					
					<div class="widget-content">
						<p><i class="icon-play"></i> 企业微信下载地址：PC端与手机端都需下载 <strong>https://work.weixin.qq.com/</strong> SSC将推送后台邀请信息，请点击短信，按照提示加入YSEC</p>
                        <p><i class="icon-play"></i> 电话会议 : 3方电话会议使用方法：1）拨通第一方电话。2）按会议键（小人头）+“426”，然后拨通第二方电话。 3）拨通第二方电话后，按会议键（小人头）2次。 即可进行包括自己在内的3方通话。</p>
                        <p><i class="icon-play"></i> 通讯录<br><strong style="margin-left: 15px"> 1) 总机:0512-65078819&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;2) 拨打外线请先拨 " 9 "。&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;3) 代接其他电话请拨 " * # "。</strong></p>
                        <div class="row" style="width: 100%">
        
            <div class="span12">
<table class="table  table-bordered  table-hover table-condensed " style="text-align: center;background-color: white">
         <tbody><tr style="background-color:rgb(102,102,102);color: rgb(255,255,255)">
     
       <th style="text-align: center;font-size: 15px">部 门</th>
       <th style="text-align: center;font-size: 15px">姓 名</th>
      <th style="text-align: center;font-size: 15px">岗 位</th>
      <th style="text-align: center;font-size: 15px">手 机 号</th>
       <th style="text-align: center;font-size: 15px">分 机</th>
       <th style="text-align: center;font-size: 15px">邮 箱</th>
     </tr>
     <tr>
       
       <td>GMO</td>
      <td>孟庆洪</td>
       <td>总经理</td>
      <td>13009139941</td>
      <td>818</td>
      <td><a href="mailto:qinghong.meng@ccydsz.com">qinghong.meng@ccydsz.com</a></td>
     </tr>
     <tr>
       
       <td>GMO</td>
      <td>李欢</td>
       <td>主任</td>
      <td>13801740033</td>
       <td>819</td>
       <td><a href="mailto:franklin.li@ccydsz.com">franklin.li@ccydsz.com</a></td>
     </tr>
   
     <tr>
       
       <td>SSC</td>
     <td>刘玲玲</td>
       <td>共享中心</td>
       <td>18662618214</td>
       <td>809</td>
      <td><a href="mailto:lilian.liu@ccydsz.com">lilian.liu@ccydsz.com</a></td>
     </tr>
     <tr>
       </tr><tr>
       
       <td>CES</td>
      <td>谷叶水</td>
       <td>系统控制总监</td>
      <td>13656217210</td>
       <td>101</td>
       <td><a href="mailto:eric.gu@ccydsz.com">eric.gu@ccydsz.com</a></td>
     </tr>
    <tr>
       <td>CES</td>
      <td>严雪梅</td>
      <td>机械设计</td>
       <td>13405127556</td>
       <td>102</td>
      <td><a href="mailto:tomi.yan@ccydsz.com">tomi.yan@ccydsz.com</a></td>
     </tr>
       <tr>
       <td>CES</td>
      <td>冯飞</td>
      <td>系统分析</td>
       <td>15006200757</td>
       <td>103</td>
      <td><a href="mailto:kevin.feng@ccydsz.com">kevin.feng@ccydsz.com</a></td>
     </tr>
     <tr>
      </tr><tr>
      
      <td>CES</td>
     <td>王段段</td>
      <td>系统分析</td>
      <td>15180138226</td>
      <td>106</td>
      <td><a href="mailto:nathan.pang@ccydsz.com">doris.wang@ccydsz.com</a></td>
     </tr>
     <tr>
      
      <td>ATD</td>
     <td>逄淑一</td>
      <td>项目经理</td>
      <td>15250030224</td>
      <td>808</td>
      <td><a href="mailto:nathan.pang@ccydsz.com">nathan.pang@ccydsz.com</a></td>
     </tr>
     <tr>
       
       <td>ATD</td>
      <td>张向国</td>
       <td>数据分析</td>
      <td>15950070836</td>
     <td>601</td>
     <td><a href="mailto:richard.zhang@ccydsz.com">richard.zhang@ccydsz.com</a></td>
     </tr>
     <tr>
   
      <td>ATD</td>
     <td>肖侃</td>
     <td>数据分析</td>
      <td>15062382023</td>
    <td>602</td>
      <td><a href="mailto:allen.xiao@ccydsz.com">allen.xiao@ccydsz.com</a></td>
     </tr>
     <tr>
       
       <td>ATD</td>
      <td>季旭</td>
     <td>Java开发</td>
     <td>13951839695</td>
      <td>603</td>
     <td><a href="mailto:jirry.ji@ccydsz.com">jirry.ji@ccydsz.com</a></td>
     </tr>
      
       <tr><td>ATD</td>
      <td>汤传军</td>
     <td>dSpace系统分析</td>
     <td>15151443737</td>
      <td>604</td>
     <td><a href="mailto:jeffrey.tang@ccydsz.com">jeffrey.tang@ccydsz.com</a></td>
     </tr>
     
       <tr>
       
       <td>ATD</td>
      <td>张领</td>
     <td>客户端开发</td>
     <td>15850164351</td>
      <td>605</td>
     <td><a href="mailto:steven.zhang@ccydsz.com">steven.zhang@ccydsz.com</a></td>
     </tr>  
     <tr>
       
       <td>ATD</td>
      <td>邹李刚</td>
     <td>硬件开发</td>
     <td>15062653603</td>
      <td>606</td>
     <td><a href="mailto:steven.zhang@ccydsz.com">zero.zou@ccydsz.com</a></td>
     </tr>  
   </tbody></table>
        
    </div>
            

                     
        </div>
                        
                    </div> <!-- /widget-content -->
				
				</div> <!-- /widget -->
									
		      </div> 
			
            </div><!-- /contact -->
	    </div> <!-- /container -->
	    
	</div> <!-- /main-inner -->
    
</div> <!-- /main -->
    

    


<div class="footer">
	
	<div class="footer-inner">
		
		<div class="container">
			
			<div class="row">
				
    			<div class="span12">
    				&copy; 2018 <a href="#">YSEC</a>
    			</div> <!-- /span12 -->
    			
    		</div> <!-- /row -->
    		
		</div> <!-- /container -->
		
	</div> <!-- /footer-inner -->
	
</div> <!-- /footer -->
    

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/excanvas.min.js"></script>
<script src="js/chart.min.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>
<script src="js/base.js"></script>
<script>

    var pieData = [
				{
				    value: 30,
				    color: "#F38630"
				},
				{
				    value: 50,
				    color: "#E0E4CC"
				},
				{
				    value: 100,
				    color: "#69D2E7"
				}

			];

    var myPie = new Chart(document.getElementById("pie-chart").getContext("2d")).Pie(pieData);

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

    var myLine = new Chart(document.getElementById("bar-chart").getContext("2d")).Bar(barChartData);
	var myLine = new Chart(document.getElementById("bar-chart1").getContext("2d")).Bar(barChartData);
	var myLine = new Chart(document.getElementById("bar-chart2").getContext("2d")).Bar(barChartData);
	var myLine = new Chart(document.getElementById("bar-chart3").getContext("2d")).Bar(barChartData);
	
	</script>


  </body>

</html>