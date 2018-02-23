<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Start #header -->
<script type="text/javascript">
$(document).on("mouseenter", ".table tr.odd", function(){ 
	//此处的$(this)指$( "#testDiv")，而非$(document) 
	$(this).css("background-color","#E9E9E4");
}); 
$(document).on("mouseleave", ".table tr.odd", function(){ 
	$(this).css("background-color","white");
}); 

function getNewsNum()
{
	$.ajax({
	    url:'${root}/admin/position/getUntreatedNum.do',
	    type:'POST', //GET
	    async:true,    //或false,是否异步
	    timeout:5000,    //超时时间
	    dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
	    success:function(data,textStatus,jqXHR){
	    	if(data.result == true){
	    		$("#news").html(data.code);
	    	}
	    },
	    error:function(xhr,textStatus){
	        console.log('错误')
	    }
	})
}

function logout(){
	$.ajax({
	    url:'${root}/logOut.do',
	    type:'POST', //GET
	    async:true,    //或false,是否异步
	    timeout:5000,    //超时时间
	    dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
	    success:function(data,textStatus,jqXHR){
	    	if(data.result == true){
	    		window.location.href='${root}';
	    	}
	    },
	    error:function(xhr,textStatus){
	        console.log('错误')
	    }
	})
}
getNewsNum();
setInterval("getNewsNum()","60000");
</script>

<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
    	<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.html">YSEC-SSC</a>
      <div class="nav-collapse">
        <ul class="nav pull-right">
          <li class="dropdown">
            <ul class="dropdown-menu">
              <li><a href="javascript:;">修改密码</a></li>
            </ul>
          </li>
          <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-user"></i>&nbsp;&nbsp;&nbsp;超级管理员<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="javascript:;">Profile</a></li>
              <li><a href="javascript:;">Logout</a></li>
            </ul>
          </li>
        </ul>
        <form class="navbar-search pull-right">
          <input type="text" class="search-query" placeholder="Search">
        </form>
      </div>
      <!--/.nav-collapse --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /navbar-inner --> 
</div>
<!-- /navbar -->

<div class="subnavbar">
  <div class="subnavbar-inner">
    <div class="container">
      <ul class="mainnav">
        <li ><a href="index.html"><i class="icon-dashboard"></i><span>首页</span> </a> </li>
        <li><a href="reports.html"><i class="icon-list-alt"></i><span>Reports</span> </a> </li>
        <li><a href="guidely.html"><i class="icon-facetime-video"></i><span>App Tour</span> </a></li>
        <li><a href="charts.html"><i class="icon-bar-chart"></i><span>Charts</span> </a> </li>
        <li><a href="shortcodes.html"><i class="icon-code"></i><span>Shortcodes</span> </a> </li>
        <li class="active"><a href="costdetail.html"><i class="icon-money"></i><span>成本中心</span> </a> </li>
      </ul>
    </div>
    <!-- /container --> 
  </div>
  <!-- /subnavbar-inner --> 
</div>




<script src="${root}/public/js/pages/header.js" type="text/javascript"></script>
<!-- End #header -->