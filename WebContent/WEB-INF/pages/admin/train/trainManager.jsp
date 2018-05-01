<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="AdminUserTrianController as vm">
			<div class="main-inner">
				<div class="container">
					<div class="row">
						<div class="span12">
							<div class="widget">
								<!-- 标题 -->
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>培训信息</h3>
								</div>
								<div class="widget-content">
									<div class="row">
	                                    <div class="span4">
	                                        <span class="searchSpan">培训项目:</span>
	                                        <input type="text" id="project" ng-model="project" class="span2">
	                                    </div>
										<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getTrainList()" value="查询" /></div>
									</div>
									<hr>
									<!-- 查询结果 -->
									<div class="row">
										<div class="span12">
											<div style="width:1134px;">
												<button class="btn btn-invert" ng-click="vm.addTrain()"><i class="icon-plus"></i> 新增</button>
											</div>
											<table class="table table-condensed table-bordered table-striped" style="width:98%;margin-top:7px;" >
												<thead>
													<tr>
														<th width="100px">操作</th>
														<th width="100px">序号</th> 
													 	<th width="100px">开始时间</th>
														<th width="150px">结束时间</th>
														<th width="100px">培训项目</th>
														<th width="200px">培训地点</th>
														<th width="100px">培训形式</th>
														<th>培训结果</th>
													</tr>
												</thead>
												<tbody>
													<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" >
														<!-- view -->
														<td ng-switch-when="view">
															<a href="javascript:;" class="btn btn-small" ng-click="vm.edit(item)"><i class="icon-edit"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.delTrain(item)"><i class="icon-remove-sign"></i></a>
														</td>
														<td ng-switch-when="view"><p ng-bind="$index + 1"></p></td>
														<td ng-switch-when="view"><p ng-bind="item.trainTime | date:'yyyy-MM-dd'"></p></td>
														<td ng-switch-when="view"><p ng-bind="item.trainEndTime | date:'yyyy-MM-dd'"></p></td>
														<td ng-switch-when="view"><p ng-bind="item.project"></p></td>
														<td ng-switch-when="view"><p ng-bind="item.place"></p></td>
														<td ng-switch-when="view"><p ng-bind="item.form"></p></td>
														<td ng-switch-when="view"><p ng-bind="item.result"></p></td>
														<!-- edit -->
														<td ng-switch-when="edit" >
															<a href="javascript:;" class="btn btn-small btn-success " ng-click="vm.save(item)"><i class='icon-ok'></i></a>
														</td>
														<td ng-switch-when="edit"><p ng-bind="$index + 1"></p></td>
														<td ng-switch-when="edit">
															<mb-datepicker input-class="mb-date" date="item.trainTime | date:'yyyy-MM-dd'" date-format="YYYY-MM-DD"></mb-datepicker>
														</td>
														<td ng-switch-when="edit">
															<mb-datepicker input-class="mb-date" date="item.trainEndTime | date:'yyyy-MM-dd'" date-format="YYYY-MM-DD"></mb-datepicker>
														</td>
														<td ng-switch-when="edit">
															<input type="text" class="line-limit-length span4" ng-model="item.project" style="width:100px;" >
														</td>
														<td ng-switch-when="edit">
															<input type="text" class="line-limit-length span4" ng-model="item.place" style="width:100px;" >
														</td>
														<td ng-switch-when="edit">
															<input type="text" class="line-limit-length span4" ng-model="item.form" style="width:100px;" >
														</td>
														<td ng-switch-when="edit">
															<input type="text" class="line-limit-length span4" ng-model="item.result" style="width:100px;" >
														</td>
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
	<!-- 这里可以定义一个js文件放到public下面 -->
    <script type="text/ng-template" id="myModalEditContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 培训信息</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>

				<!-- 个人信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>培训记录</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<input type="hidden" ng-model="trainEntity.id">
										<div class="form-group">

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">培训项目</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="trainEntity.project" />
												</div>
											</div>

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">培训地点</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="trainEntity.place" />
												</div>
											</div>
											
										</div>

										<div class="form-group">
											
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">培训形式</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="trainEntity.form" />
												</div>
											</div>

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">培训结果</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="trainEntity.result" />
												</div>
											</div>

										</div>

										<div class="form-group">
											
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >培训开始时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="trainEntity.trainTime" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
										<div class="col-lg-6">
											<label class="col-lg-4 control-label" >培训结束时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="trainEntity.trainEndTime" is-open="popup.opened2" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(2)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">保存</button>
            <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        </div>
    </script>

	</div>

	
	<input type="hidden" id="userId" value="${userId}">
	<input type="hidden" id="rootUrl" value="${root}">
			
	<script src="${root}/public/js/pages/train/script.js" type="text/javascript"></script>
</body>
</html>