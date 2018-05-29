<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<style>
	.full{
		width:90%;
	}
</style>
</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="TransferPositionController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>调岗/调薪信息</h3>
							</div>
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">调岗日期:</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="startDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
										<span class="searchSpanMid pull-left">~</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="endDate"   date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getTransferPositionList()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.add()" ng-if="${adminUser.position == 'ADMIN'}"><i class="icon-plus"></i>新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th width="80px">操作</th>
													<th width="80px">序号</th>
													<th width="120px">日期</th>
													<th width="120px">调整前岗位</th>
													<th width="120px">调整后岗位</th>
													<th width="120px">调整前薪酬</th>
													<th width="120px">调整后薪酬</th>
													<th>其他备注</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode">
													<!-- view -->
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-small" ng-click="vm.edit(item)"><i class="icon-edit"></i></a>
														<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)"><i class="icon-remove-sign"></i></a>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.order"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.transferTime | date:'yyyy-MM-dd'"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.postOld"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.postNew"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.salaryOld"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.salaryNew"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.remark"></p></td>
													<!-- edit -->
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)"><i class="icon-ok"></i></a>
													</td>
													<td ng-switch-when="edit">
														
													</td>
													<td ng-switch-when="edit">
														<mb-datepicker input-class="mb-date" date="item.transferTime" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
													</td>
													<td ng-switch-when="edit">
														<input type="text" class="full" ng-model="item.postOld" />
													</td>
													<td ng-switch-when="edit">
														<input type="text" class="full" ng-model="item.postNew" />
													</td>
													<td ng-switch-when="edit">
														<input type="number" class="full" ng-model="item.salaryOld" />
													</td>
													<td ng-switch-when="edit">
														<input type="number" class="full" ng-model="item.salaryNew" />
													</td>
													<td ng-switch-when="edit">
														<input type="text" class="full" ng-model="item.remark" />
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
						<h1 class="page-header"><i class="im-users2"></i> 调岗/调薪信息</h1>
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
									<h3 class="panel-title"><i class="ec-pencil"></i>调岗记录</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<input type="hidden" ng-model="transferPositionEntity.id">
										<div class="form-group">

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">调整前岗位</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="transferPositionEntity.postOld" />
												</div>
											</div>

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">调整后岗位</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="transferPositionEntity.postNew" />
												</div>
											</div>
											
										</div>

										<div class="form-group">
											
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">调整前薪酬</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="transferPositionEntity.salaryOld" />
												</div>
											</div>

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">调整后薪酬</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="transferPositionEntity.salaryNew" />
												</div>
											</div>

										</div>

										<div class="form-group">
											
											<div class="col-lg-6">
												<label class="col-lg-4 control-label" >调整时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="transferPositionEntity.transferTime" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">备注</label>
												<div class="col-lg-8">
													<textarea class="form-control" ng-model="transferPositionEntity.remark" rows="3" Placeholder=""></textarea>
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
    
    <script type="text/ng-template" id="myModalDelContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<ul id="crumb" class="breadcrumb">
							确定删除调岗记录吗？
						</ul>
					</div>
				</div>
			</div>
				
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">确定</button>
            <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        </div>
    </script>
    
	</div>

	
	<input type="hidden" id="userId" value="${userId}">
	<input type="hidden" id="rootUrl" value="${root}">
			
	<script src="${root}/public/js/pages/transferPosition/script.js" type="text/javascript"></script>
</body>
</html>