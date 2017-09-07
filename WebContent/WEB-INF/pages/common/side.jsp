<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="sidebar" ng-controller="SideListController as side">
	<div class="sidebar-inner">
		<ul id="sideNav" class="nav navbar-nav">
			<li><a href="${root}/admin/adminuser/toadminlist.do">员工管理<i class="ec-users"></i></a></li>
			<li><a href="${root}/admin/adminuser/toAddUser.do">员工增加<i class="ec-users"></i></a></li>
			<li><a href="#"> Tables <i class="im-table2"></i></a>
				<ul class="nav sub">
					<li><a href="tables.html"><i class="en-arrow-right7"></i> Static tables</a>
					</li>
					<li><a href="data-tables.html"><i class="en-arrow-right7"></i> Data tables</a>
					</li>
				</ul>
			</li>
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="abbc">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseComponents" data-parent="#exampleAccordion">
              <i class="im-table2"></i>
              <span class="nav-link-text">成本信息</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="collapseComponents">
				<li><a href="${root}/admin/cost/manager.do"><i class="en-arrow-right7"></i>成本管理</a>
				</li>
				<li><a href="${root}/admin/cost/chart.do"><i class="en-arrow-right7"></i>成本图表</a>
				</li>
            </ul>
          </li>
		</ul>
	</div>
</div>
<script src="${root}/public/js/pages/administrator/script.js" type="text/javascript"></script>