<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	<!-- Start #content -->
	<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
		<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>IPE</h3>
							</div>
							
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4">
										<span class="searchSpan">用户名:</span>
										<input type="text" class="form-control" name="userName" ng-model="userName" id="userName" />
									</div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">姓名 :</span>
										<input type="text" class="form-control" name="realName" ng-model="realName" id="realName" />
									</div>
									<div class="span1 pull-right">
									<input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getFinancingInfoList()" value="查询" />
									</div>
								</div>
								<div class="row">
									<div class="span4">
										<span class="searchSpan">部门:</span>
										<select class="form-control select2" ng-model="depId"  ng-change="vm.getPostionById()" ng-Disabled = "depIdChangeAble" >
											<option value="">请选择</option>
											<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
										</select>
									</div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">岗位 :</span>
										<select class="form-control select2" ng-model="postId" >
											<option value="">请选择</option>
											<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
										</select>
									</div>
								</div>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th>操作</th>
													<th>用户名</th>
													<th>姓名</th>
													<th>部门</th>
													<th>岗位</th>
													<th>状态</th>
													<th>个人pc等级</th>
													<th>岗位pc等级</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list">
													<td>
														<button type="button" class="btn btn-xs btn-success" ng-click="vm.searchIpe(item.userId)"><i class="br-pencil">评估</i></button>
													</td>
													<td><p ng-bind="item.userName"></p></td>
													<td><p ng-bind="item.realName"></p></td>
													<td><p ng-bind="item.depName"></p></td>
													<td><p ng-bind="item.postName"></p></td>
													<td><p ng-bind="item.workStatus"></p></td>
													<td><p ng-bind="item.salaryScale"></p></td>
													<td><p ng-bind="item.postPc"></p></td>
												</tr>
											</tbody>
										</table>
										<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
										<div style="width:1134px;">
											<%@ include file="../../common/page.jsp"%>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<script src="${root}/public/js/pages/ipe/script.js" type="text/javascript"></script>
</body>
</html>