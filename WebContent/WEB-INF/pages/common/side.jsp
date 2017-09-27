<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="sidebar" ng-app = "sideApp" ng-controller="sideController as vm">
	<div class=" ">
		<ul id="sideNav" class="nav navbar-nav">
		  <li class="nav-item" data-toggle="tooltip" data-placement="right" title="员工信息">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#userComponents" data-parent="#exampleAccordion">
              <i class="ec-users"></i>
              <span class="nav-link-text">员工管理</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="userComponents">
				<li><a href="${root}/admin/adminuser/toadminlist.do" ng-click="getPostionById()">员工列表<i class="en-arrow-right7"></i></a></li>
				<li><a href="${root}/admin/adminuser/toAddOrEditUser.do">新增员工<i class="en-arrow-right7"></i></a></li>
            </ul>
          </li>
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="成本信息">
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
           <li class="nav-item" data-toggle="tooltip" data-placement="right" title="岗位信息">
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
           <li class="nav-item" data-toggle="tooltip" data-placement="right" title="招聘">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#postRecruitment" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">招聘管理</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="postRecruitment">
				<li><a href="${root}/admin/test/Recruitment.do"><i class="en-arrow-right7"></i>招聘需求列表</a>
				</li>
				<li><a href="${root}/admin/position/toPostionList.do?type=mypost"><i class="en-arrow-right7"></i>我的岗位管理</a>
				</li>
				<li><a href="${root}/admin/position/toPostionList.do?type=audit"><i class="en-arrow-right7"></i>岗位审批</a>
				</li>
            </ul>
          </li>
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="ipe">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#postIPE" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">IPE管理</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="postIPE">
				<li><a href="#"><i class="en-arrow-right7"></i>IPE试算</a>
				</li>
				<li><a href="#"><i class="en-arrow-right7"></i>IPE</a>
				</li>
            </ul>
          </li>
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="postLevel">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#postLevel" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">岗位等级分布</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="postLevel">
				<li><a href="${root}/admin/depPostLevel/distribute.do"><i class="en-arrow-right7"></i>岗位等级分布表</a>
				</li>
            </ul>
          </li>
		</ul>
	</div>
</div>
<script src="${root}/public/js/pages/side.js" type="text/javascript"></script>