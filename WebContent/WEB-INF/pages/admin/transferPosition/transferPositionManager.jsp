<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="TransferPositionController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="st-chart"></i> 调岗信息</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><i class="ec-search"></i>查询条件</h3>
                                </div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >调岗开始时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="startDate" is-open="popup.opened1" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(1)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
												<label class="col-lg-4 control-label" >调岗结束时间</label>
												<div class="col-lg-8">
													<p class="input-group">
														<input type="text" class="form-control" uib-datepicker-popup ng-model="endDate" is-open="popup.opened2" 
														datepicker-options="dateOptions" current-text = "今日" close-text="关闭" clear-text="清空"
														ng-required="true"  />
														<span class="input-group-btn">
														<button type="button" class="btn btn-default" ng-click="open(2)"><i class="glyphicon glyphicon-calendar"></i></button>
														</span>
													</p>
												</div>
											</div>
											<div class="col-lg-3">
											</div>
											<div class="col-lg-3">
												<div class="col-lg-6">
													<input type="button"  class="btn btn-lg btn-primary col-lg-12" name="query" ng-click="vm.getTransferPositionList()" value="查询" />
												</div>
												<div class="col-lg-6">
													<input type="button"  class="btn btn-lg btn-success col-lg-12" name="query" ng-click="vm.addTransferPosition('', '.outlet')" value="新增记录" />
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End .row -->
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>查询结果</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>序号</th>
												<th>日期</th>
												<th>调整前岗位</th>
												<th>调整后岗位</th>
												<th>调整前薪酬</th>
												<th>调整后薪酬</th>
												<th>其他备注</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												
												<td><p ng-bind="item.order"></p></td>
												<td><p ng-bind="item.transferTime"></p></td>
												<td><p ng-bind="item.postOld"></p></td>
												<td><p ng-bind="item.postNew"></p></td>
												<td><p ng-bind="item.salaryOld"></p></td>
												<td><p ng-bind="item.salaryNew"></p></td>
												<td><p ng-bind="item.remark"></p></td>
												<td>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.addTransferPosition(item.id,'.outlet')"><i class="fa-edit"></i></button>
													<button type="button" class="btn btn-xs btn-success" ng-click="vm.delTransferPosition(item.id,'.outlet')"><i class="ec-trashcan"></i></button>
												</td>
												
											</tr>
										</tbody>
									</table>
									<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
									<%@ include file="../../common/page.jsp"%>
								</div>

						</div>
						<!-- col-lg-12 end here -->
					</div>
					<!-- Page End here -->
				</div>
				<!-- End .outlet -->
			</div>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
		
	<!-- 这里可以定义一个js文件放到public下面 -->
    <script type="text/ng-template" id="myModalEditContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 调岗信息</h1>
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
												<label class="col-lg-4 control-label" >成本产生时间</label>
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

	
	
	<input type="hidden" id="rootUrl" value="${root}">
			
	<script src="${root}/public/js/pages/transferPosition/script.js" type="text/javascript"></script>
</body>
</html>