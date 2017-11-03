<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="menu submenu">
	<ul class="menu_main">
		<li class="menulist">
			<div class="menutree1">
				<a hidefocus="true" href="javascript:;" class="mius">管理中心</a>
			</div>
			<ul class='menusub'>
				<li><a href='${root}/admin/managercenter/welcome.html' target="mainFrame">欢迎页</a></li>
				<li><a href='${root}/admin/managercenter/tomodifymsg.html' target="mainFrame">修改个人资料</a></li>
				<li><a href='${root}/admin/managercenter/tomodifypassword.html' target="mainFrame">修改密码</a></li>
			</ul>
		</li>
	</ul>

	<ul class="hide menu_content">
		<c:if test="${not empty sessionScope.menu.second['content.eva'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['content.eva'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['content.eva.defstd'] }">
						<li><a href='${root}/admin/projectmanager/toprojectlist.html' target="mainFrame">${sessionScope.menu.third['content.eva.defstd'].menuName }</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.menu.third['content.eva.recyeva'] }">
						<li><a href='${root}/admin/schoolmanager/toschoollist.html' target="mainFrame">${sessionScope.menu.third['content.eva.recyeva'].menuName }</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.menu.third['content.eva.recystd'] }">
						<li><a href='${root}/admin/classroom/classroomlist.html' target="mainFrame">${sessionScope.menu.third['content.eva.recystd'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
	<ul class="hide menu_para">
		<c:if test="${not empty sessionScope.menu.second['para.para'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['para.para'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['para.para.subject'] }">
						<li><a href='${root}/admin/personsigncontroller/jumptosignlist.html' target="mainFrame" id="menuBaseSubject">${sessionScope.menu.third['para.para.subject'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
	
	<ul class="hide menu_maintain">
		<c:if test="${not empty sessionScope.menu.second['maintain.maintain'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['maintain.maintain'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['maintain.maintain.order'] }">
				    	<li><a href='${root}/admin/workorder/toshoworderlist.html' target="mainFrame">${sessionScope.menu.third['maintain.maintain.order'].menuName }</a></li>
				    </c:if>
					<c:if test="${not empty sessionScope.menu.third['maintain.maintain.repair'] }">
						<li><a href='${root}/admin/maintenanceorder/jumptoreparingmanagelist.html' target="mainFrame">${sessionScope.menu.third['maintain.maintain.repair'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
	
	
	<ul class="hide menu_resource">
		<c:if test="${not empty sessionScope.menu.second['resource.resource'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['resource.resource'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['resource.resource.supplier'] }">
				    	<li><a href='${root}/admin/supplier/jumptosupplierlist.html' target="mainFrame">${sessionScope.menu.third['resource.resource.supplier'].menuName }</a></li>
				    </c:if>
					<c:if test="${not empty sessionScope.menu.third['resource.resource.regional'] }">
						<li><a href='${root}/admin/area/jumptolistarea.html' target="mainFrame">${sessionScope.menu.third['resource.resource.regional'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
	
	
	<ul class="hide menu_count">
		<c:if test="${not empty sessionScope.menu.second['count.teach'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['count.teach'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['count.teach.classroom'] }">
				    	<li><a href='${root}/admin/classroomenvir/classroomlist.html' target="mainFrame">${sessionScope.menu.third['count.teach.classroom'].menuName }</a></li>
				    </c:if>
					<c:if test="${not empty sessionScope.menu.third['count.teach.course'] }">
						<li><a href='${root}/admin/classroominspect/classroomlist.html' target="mainFrame">${sessionScope.menu.third['count.teach.course'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
	<ul class="hide menu_admin">
		<c:if test="${not empty sessionScope.menu.second['admin.usr'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['admin.usr'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['admin.usr.org'] }">
						<li><a href='${root}/admin/adminuser/toadminlist.html' target="mainFrame">${sessionScope.menu.third['admin.usr.org'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
	
    <ul class="hide menu_app">
		<c:if test="${not empty sessionScope.menu.second['app.app'] }">
			<li class="menulist">
				<div class="menutree1">
					<a hidefocus="true" href="javascript:;" class="mius">${sessionScope.menu.second['app.app'].menuName }</a>
				</div>
				<ul class='menusub'>
					<c:if test="${not empty sessionScope.menu.third['app.app.org'] }">
						<li><a href='${root}/admin/apk/jumptouploadapk.html' target="mainFrame">${sessionScope.menu.third['app.app.org'].menuName }</a></li>
					</c:if>
				</ul>
			</li>
		</c:if>
	</ul>
</div>