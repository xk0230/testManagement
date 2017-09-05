<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body ng-app = "myApp" >
	<div ng-controller="UserListController as vm">
		<!-- Start .content-wrapper -->
		<div class="content-wrapper">
			<div class="row">
				<div class="col-lg-12 heading">
					<ul class="nav navbar-nav pull-left">
						<li id="toggle-sidebar-li">
							<a href="#" id="toggle-sidebar"><i class="im-users"></i></a>
						</li>
						<li id="toggle-sidebar-li">
							<h1 class="page-header">用户管理</h1>
						</li>
					</ul>
				</div>
			</div>
		<!-- End .content-wrapper -->
	</div>
	<!-- End #content -->
<script src="${root}/public/js/pages/administrator/script.js" type="text/javascript"></script>
</body>
</html>