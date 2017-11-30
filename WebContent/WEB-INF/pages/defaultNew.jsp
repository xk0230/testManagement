<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="common/header.jsp"%>
		<%@ include file="common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="im-users2"></i> 首页</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
				<table align="center">
					<tr><td width="30%"><div id="c1" ></div></td><td width="30%"><div id="c2" ></div></td><td width="30%"><div id="c3" ></div></td></tr>
					<tr><td><div id="c4" ></div></td><td><div id="c5" ></div></td></tr>
				</table>
				
				<div class="outlet">

					<div class="row">

						<div class="col-lg-12" >
							<!-- 个人信息 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position != 'ADMIN'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.userInfo()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile lime">
	                                            <div class="tile-icon">
	                                                <i class="im-user2 s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">个人信息</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>

							<!-- 新增员工 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position == 'ADMIN'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.addUser()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile lime">
	                                            <div class="tile-icon">
	                                                <i class="im-users2 s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">新增员工</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
							<!-- 员工列表 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position == 'ADMIN'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.userList()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile lime">
	                                            <div class="tile-icon">
	                                                <i class="im-users2 s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">员工列表</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
							<!-- 空缺岗位 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.emptyPostion()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile teal">
	                                            <div class="tile-icon">
	                                                <i class="im-profile s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">空缺岗位</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
							<!-- 新增岗位 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position != 'STAFF'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.addPostion()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile teal">
	                                            <div class="tile-icon">
	                                                <i class="im-profile s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">新增岗位</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
							<!-- 招聘 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position == 'ADMIN'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.Recruitment()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile brown">
	                                            <div class="tile-icon">
	                                                <i class="im-user4 s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">招聘</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
							<!-- 实时成本 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position != 'STAFF'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.cost()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile blue">
	                                            <div class="tile-icon">
	                                                <i class="st-chart s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">实时成本</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
							<!-- 新增成本 -->
	                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" ng-show="${adminUser.position == 'ADMIN'}">
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.addCost()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile blue">
	                                            <div class="tile-icon">
	                                                <i class="st-chart s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">新增成本</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
                        	 <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
	                            <div class="carousel-tile carousel vertical slide" ng-click="vm.myinterview()">
	                                <div class="carousel-inner">
	                                    <div class="item active">
	                                        <div class="tile brown">
	                                            <div class="tile-icon">
	                                                <i class="im-user4 s64"></i>
	                                            </div>
	                                            <div class="tile-content">
	                                                <div class="number">我的面试</div>
	                                                <h3>点击查看详细信息</h3>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
						</div>
					</div>
				</div>
			<div class="clearfix"></div>
		</div>
	</div>
			
	<script type="text/javascript">

	</script>
	<script src="${root}/public/js/pages/default.js" type="text/javascript"></script>
</body>
</html>
