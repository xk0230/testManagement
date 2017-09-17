<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="sidebar" ng-app = "sideApp" ng-controller="sideController as vm">
	<div class=" ">
		<ul id="sideNav" class="nav navbar-nav">
		  <li class="nav-item" data-toggle="tooltip" data-placement="right" title="abbc">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#userComponents" data-parent="#exampleAccordion">
              <i class="ec-users"></i>
              <span class="nav-link-text">员工管理</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="userComponents">
				<li><a href="${root}/admin/adminuser/toadminlist.do" ng-click="getPostionById()">员工列表<i class="en-arrow-right7"></i></a></li>
				<li><a href="${root}/admin/adminuser/toAddOrEditUser.do">新增员工<i class="en-arrow-right7"></i></a></li>
            </ul>
          </li>
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="abbc">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseComponents" data-parent="#exampleAccordion">
              <i class="st-chart"></i>
              <span class="nav-link-text">成本信息</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="collapseComponents">
				<li><a href="${root}/admin/cost/manager.do"><i class="en-arrow-right7"></i>成本管理</a>
				</li>
				<li><a href="${root}/admin/cost/chart.do"><i class="en-arrow-right7"></i>成本图表</a>
				</li>
            </ul>
          </li>
           <li class="nav-item" data-toggle="tooltip" data-placement="right" title="abbc">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#postComponents" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">岗位信息</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="postComponents">
				<li><a href="${root}/admin/position/toPostionList.do?type=list"><i class="en-arrow-right7"></i>岗位列表</a>
				</li>
				<li><a href="${root}/admin/position/toPostionList.do?type=mypost"><i class="en-arrow-right7"></i>我的岗位管理</a>
				</li>
				<li><a href="${root}/admin/position/toPostionList.do?type=audit"><i class="en-arrow-right7"></i>岗位审批</a>
				</li>
            </ul>
          </li>
		</ul>
	</div>
</div>
<script src="${root}/public/js/pages/side.js" type="text/javascript"></script>