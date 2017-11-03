<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="sidebar" ng-app = "sideApp" ng-controller="sideController as vm">
	<div class=" ">
		<ul id="sideNav" class="nav navbar-nav">
           <li class="nav-item" data-toggle="tooltip" data-placement="right" title="招聘" >
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#post1" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">员工信息</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="post1">
				<li ng-show="${adminUser.position != 'STAFF'}"><a href="${root}/admin/adminuser/toadminlist.do"><i class="en-arrow-right7"></i>员工列表</a></li>
				<li><a href="${root}/admin/adminuser/toAddOrEditUser.do?id=${sessionScope.adminUser.userId }"><i class="en-arrow-right7"></i>个人信息</a></li>
            </ul>
          </li>
           <li class="nav-item" data-toggle="tooltip" data-placement="right" title="成本信息" ng-show="${adminUser.position != 'STAFF'}">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#post2" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">成本信息</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="post2">
				<li><a href="${root}/admin/cost/manager.do"><i class="en-arrow-right7"></i>成本管理</a></li>
				<li><a href="${root}/admin/cost/chart.do"><i class="en-arrow-right7"></i>成本图表</a></li>
            </ul>
          </li>
          
           <li class="nav-item" data-toggle="tooltip" data-placement="right" title="岗位信息" ng-show="${adminUser.position != 'STAFF'}">
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
				<li><a href="${root}/admin/recruit/Recruitment.do?type=''"><i class="en-arrow-right7"></i>招聘需求列表</a></li>
				<li ng-show="${adminUser.position != 'STAFF'}"><a href="${root}/admin/recruit/Recruitment.do?type=myApproval"><i class="en-arrow-right7" ></i>招聘需求审批列表</a></li>
				<li><a href="${root}/admin/recruit/MyInterview.do"><i class="en-arrow-right7"></i>我的面试</a></li>
            </ul>
          </li>
          
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="ipe" ng-show="${adminUser.position != 'STAFF'}">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#postIPE" data-parent="#exampleAccordion">
              <i class="fa-th-list"></i>
              <span class="nav-link-text">IPE管理</span>
            </a>
            <ul class="sidenav-second-level collapse nav" id="postIPE">
				<li><a href="${root}/admin/ipe/manager.do"><i class="en-arrow-right7"></i>IPE</a>
				</li>
				<li><a href="${root}/admin/ipe/trial.do"><i class="en-arrow-right7"></i>IPE试算</a>
				</li>
				<li><a href="${root}/admin/depPostLevel/distribute.do"><i class="en-arrow-right7"></i>标准岗位等级表</a>
				</li>
            </ul>
          </li>
          
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="ipe">
            <a class="nav-link nav-link-collapse collapsed" href="${root}/admin/test/UnderConstruction.do" >
              <i class="fa-th-list"></i>
              <span class="nav-link-text">绩效管理</span>
            </a>
          </li>
         
		</ul>
	</div>
</div>
<script src="${root}/public/js/pages/side.js" type="text/javascript"></script>
