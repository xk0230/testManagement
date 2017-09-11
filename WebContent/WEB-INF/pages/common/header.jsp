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
setInterval("getNewsNum()","10000");
</script>
<div id="header" ng-controller="HeaderController as header" >
    <div class="container-fluid">
        <div class="navbar">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">
                    <i class="im-windows8 text-logo-element animated bounceIn"></i><span class="text-slogan">YSEC</span> 
                </a>
            </div>
            <input id="sessionUserType"  type="hidden" value="${adminUser.position}">
            <input id="sessionUserId"  type="hidden" value="${sessionScope.adminUser.userId }" ng-model="sessionUserId" >
            <div>
            <nav class="top-nav" role="navigation">
                <ul class="nav navbar-nav pull-right">
                    <li class="dropdown">
                        <a href="${root}/admin/position/toPostionList.do?type=audit" ><i class="br-alarm"></i> <span class="notification" id="news">0</span></a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img class="user-avatar" src="${root }/public/assets/img/avatars/48.png" alt=${sessionScope.adminUser.realName }>${sessionScope.adminUser.realName }
                        </a>
                        <ul class="dropdown-menu right" role="menu">
                            <li>
                            	<a href="${root}/admin/adminuser/toAddOrEditUser.do?id=${sessionScope.adminUser.userId }"><i class="st-user"></i>个人信息</a>
                            </li>
                            <li ng-click="header.ChangePassWord()">
                            	<a href="javascript:void(0);" ng-click="header.ChangePassWord('.container-fluid')"><i class="st-settings"></i>修改密码</a>
                            </li>
                            <li>
                            	<a href="javascript:logout();"><i class="im-exit"></i> 退出</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
            </div>
        </div>
        <!-- Start #header-area -->
        <div id="header-area" class="fadeInDown">
            <div class="header-area-inner">
                <ul class="list-unstyled list-inline">
                    <li>
                        <div class="shortcut-button">
                            <a href="#">
                                <i class="im-pie"></i>
                                <span>Earning Stats</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="shortcut-button">
                            <a href="#">
                                <i class="ec-images color-dark"></i>
                                <span>Gallery</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="shortcut-button">
                            <a href="#">
                                <i class="en-light-bulb color-orange"></i>
                                <span>Fresh ideas</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="shortcut-button">
                            <a href="#">
                                <i class="ec-link color-blue"></i>
                                <span>Links</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="shortcut-button">
                            <a href="#">
                                <i class="ec-support color-red"></i>
                                <span>Support</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="shortcut-button">
                            <a href="#">
                                <i class="st-lock color-teal"></i>
                                <span>Lock area</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
	<!-- 修改密码 -->
	<script type="text/ng-template" id="ChangePassword.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 修改密码</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>

				<!-- 个人信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>修改密码</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-xs-12">
												<label class="col-xs-2 control-label">旧密码</label>
												<div class="col-xs-10">
													<input type="password" class="form-control" ng-model="oldPwd" />
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-xs-12">
												<label class="col-xs-2 control-label">新密码</label>
												<div class="col-xs-10">
													<input type="password" class="form-control" ng-model="newPwd" />
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-xs-12">
												<label class="col-xs-2 control-label">新密码</label>
												<div class="col-xs-10">
													<input type="password" class="form-control" ng-model="newPwdRe" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
		<div class="modal-footer">
			<button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">保存</button>
			<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
		</div>
	</script>
</div>