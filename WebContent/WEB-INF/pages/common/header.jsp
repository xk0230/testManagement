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
<div ng-app = "headerApp" ng-controller="HeaderController as header">
    <div class="navbar navbar-fixed-top" >
      <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="index.html">YSEC-SSC</a>
          <div class="nav-collapse pull-right">
            <img class="AvatarImg" src="${root}/public/img/message_avatar2.png"/>
          </div>
          <div class="nav-collapse" >
	          <ul class="nav pull-right">
	            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 22px;">
	            <i class="icon-user"></i>
	            &nbsp;&nbsp;&nbsp;超级管理员<b class="caret"></b></a>
	              <ul class="dropdown-menu">
	                <li><a href="javascript:;">Profile</a></li>
	                <li><a href="javascript:;">Logout</a></li>
	              </ul>
	            </li>
	           </ul>
          </div>

          <!--/.nav-collapse --> 
        </div>
        <!-- /container --> 
      </div>
      <!-- /navbar-inner --> 
    </div>
    <!-- /网页头 -->
    
    <div class="subnavbar">
      <div class="subnavbar-inner">
        <div class="container">
          <ul class="mainnav">
            <li class="dropdown mainLi"><a href="${root}/admin/index.do"><i class="icon-dashboard"></i><span>首页</span> </a> </li>
            <!-- 员工信息 -->
            <li class="dropdown mainLi"><a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-user"></i><span>员工信息</span> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li ng-show="${adminUser.position != 'STAFF'}"><a href="${root}/admin/adminuser/toadminlist.do"><i class="en-arrow-right7"></i>员工列表</a></li>
                <li><a href="${root}/admin/adminuser/toAddOrEditUser.do?id=${sessionScope.adminUser.userId }"><i class="en-arrow-right7"></i>个人信息</a></li>
              </ul>
            </li>
            <!-- 成本信息 -->
            <li class="dropdown mainLi"><a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-shopping-cart"></i><span>成本信息</span> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                    <li><a href="${root}/admin/cost/costApply.do"><i class="en-arrow-right7"></i>我的费用</a></li>
                    <li ng-show="${adminUser.position != 'STAFF'}"><a href="${root}/admin/cost/costAudit.do"><i class="en-arrow-right7"></i>成本审核</a></li>
                    <li ng-show="${adminUser.position != 'STAFF'}"><a href="${root}/admin/cost/chart.do"><i class="en-arrow-right7"></i>成本图表</a></li>
              </ul>
            </li>
            <!-- 岗位信息 -->
            <li class="dropdown mainLi"><a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-tags"></i><span>岗位信息</span> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                    <li><a href="${root}/admin/position/toPostionList.do?type=list"><i class="en-arrow-right7"></i>正式岗位目录</a></li>
                    <li><a href="${root}/admin/position/toPostionList.do?type=mypost"><i class="en-arrow-right7"></i>申请新增岗位</a></li>
                    <li><a href="${root}/admin/position/toPostionList.do?type=audit"><i class="en-arrow-right7"></i>待我审批</a></li>
              </ul>
            </li>
            <!-- 招聘管理 -->
            <li class="dropdown mainLi"><a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-github"></i><span>Drops</span> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="${root}/admin/recruit/Recruitment.do?type=''"><i class="en-arrow-right7"></i>我要招人</a></li>
                <li ng-show="${adminUser.position != 'STAFF'}"><a href="${root}/admin/recruit/Recruitment.do?type=myApproval"><i class="en-arrow-right7" ></i>待我审批</a></li>
                <li><a href="${root}/admin/recruit/MyInterview.do"><i class="en-arrow-right7"></i>我的面试</a></li>
              </ul>
            </li>
            <!-- IPE管理 -->
            <li class="dropdown mainLi"><a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-rss"></i><span>IPE管理</span> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="${root}/admin/ipe/manager.do"><i class="en-arrow-right7"></i>IPE</a></li>
                <li><a href="${root}/admin/ipe/trial.do"><i class="en-arrow-right7"></i>IPE试算</a></li>
                <li><a href="${root}/admin/depPostLevel/distribute.do"><i class="en-arrow-right7"></i>标准岗位等级表</a></li>
              </ul>
            </li>
            <!-- 绩效管理 -->
            <li class="mainLi"><a href="${root}/admin/test/UnderConstruction.do"><i class=" icon-thumbs-up"></i><span>绩效管理</span> </a> </li>
            <!-- 图书管理 -->
            <li class="mainLi"><a href="${root}/admin/book/manager.do"><i class="icon-book"></i><span>图书管理</span> </a> </li>
           	<!-- 合同管理 -->
            <li class="mainLi"><a href="${root}/contract/contractApply.do"><i class="icon-signal"></i><span>合同管理</span> </a> </li>
          </ul>
        </div>
        <!-- /container --> 
      </div>
      <!-- /subnavbar-inner --> 
    </div>
    <!-- /导航栏 -->
</div>
<script src="${root}/public/js/pages/header.js" type="text/javascript"></script>