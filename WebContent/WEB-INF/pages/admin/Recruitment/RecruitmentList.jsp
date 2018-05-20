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
								<h3>招聘需求列表</h3>
							</div>
							
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">部门:</span>
										<span class="pull-left">
											<select class="form-control select2" ng-model="depId"  ng-change="vm.getPostionById()" >
												<option value="">请选择</option>
												<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
											</select>
										</span>
									</div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">岗位:</span>
										<span class="pull-left">
											<select class="form-control select2" ng-model="postId" >
												<option value="">请选择</option>
												<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
											</select>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.search()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.addNewRecruitment()" ng-if="type!='myApproval'"><i class="icon-plus"></i>新增招聘需求</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th width="200px">操作</th>
													<th>岗位名称</th>
													<th width="100px">状态</th>
													<th width="100px">创建人</th>
													<th width="120px">创建时间</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode">
													<!-- view -->
													<td ng-switch-when="view">
														<button type="button" class="btn btn-xs btn-success" ng-click="vm.edit(item.id)"><i class="br-pencil"></i>详细信息</button>
														<button type="button" class="btn btn-xs btn-success" ng-click="vm.evaluation(item.id)" ng-if="${adminUser.userId == 'admin'}&&item.status=='audited'"><i class="fa-thumbs-up"></i> 管理员评估</button>
													</td>
													<td><p ng-bind="item.postName"></p></td>
													<td><p ng-bind="item.statusStr"></p></td>
													<td><p ng-bind="item.createUserName"></p></td>
													<td><p ng-bind="item.createTime | date:'yyyy-MM-dd hh:mm'"></p></td>
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
	<script src="${root}/public/js/pages/Recruitment/script.js" type="text/javascript"></script>
</body>
</html>