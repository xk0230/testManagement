<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header">
	<div class="logo">
		<h1>运营服务平台</h1>
	</div>
	<div id="topDiv" class="headerNav">	
		<div class="uinfo">
			您好 , ${sessionScope.adminUser.realName } <a class="quit" href="javascript:void(0)" >&nbsp;</a>
		</div>
		<div id="tmenu" class="nav">
			<ul class="hmenu">
				<li class='menu_main currMenu' data-menu="main"><a href='javascript:;' >管理中心</a></li>
				<c:if test="${not empty sessionScope.menu.first['content'] }">
					<li class='menu_content icon_1' data-menu="content" ><a href='javascript:;'>${sessionScope.menu.first['content'].menuName }</a></li>
				</c:if>
				<c:if test="${(not empty sessionScope.menu.first['para']) and (not empty sessionScope.menu.third['para.para.subject']) }">
					<li class='menu_para icon_2' data-menu="para" ><a href='javascript:;' >${sessionScope.menu.first['para'].menuName }</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.menu.first['count'] }">
					<li class='menu_count icon_4' data-menu="count" ><a href='javascript:;'>${sessionScope.menu.first['count'].menuName }</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.menu.first['maintain'] }">
					<li class='menu_maintain icon_3' data-menu="maintain" ><a href='javascript:;'>${sessionScope.menu.first['maintain'].menuName }</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.menu.first['resource'] }">
					<li class='menu_resource icon_3' data-menu="resource" ><a href='javascript:;'>${sessionScope.menu.first['resource'].menuName }</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.menu.first['admin'] }">
					<li class='menu_admin icon_3' data-menu="admin" ><a href='javascript:;'>${sessionScope.menu.first['admin'].menuName }</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.menu.first['app'] }">
					<li class='menu_admin icon_3' data-menu="app" ><a href='javascript:;'>${sessionScope.menu.first['app'].menuName }</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>