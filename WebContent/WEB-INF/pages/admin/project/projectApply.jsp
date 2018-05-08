<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" class="main" ng-app = "myApp" ng-controller="ProjectController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>项目</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
                                    
									<div class="span6" style="height:37px;">
										<span class="searchSpan  pull-left">申请日期:</span>
										<mb-datepicker input-class="mb-date" date="costStartDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										<span class="searchSpanMid pull-left">~</span>
										<mb-datepicker input-class="mb-date" date="costEndDate"   date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
									</div>

									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getProjectList()" value="查询" /></div>
									
								</div>
								<div class="row">
                                    <div class="span4">
                                        <span class="searchSpan">单号:</span>
                                        <input type="text" ng-model="pjNo" class="span2">
                                    </div>
                                    <div class="span6">
                                    	<span class="searchSpan">项目名:</span>
                                        <input type="text" ng-model="name" class="span2">
                                    </div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.addProject()"><i class="icon-plus"></i> 新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:98%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="100px">操作</th> 
												 	<th width="100px">单号</th>
													<th width="50px">项目名</th>
													<th width="100px">备注</th>
													<th width="50px">项目开始时间</th>
													<th width="50px">项目结束时间</th>
													<th width="50px">项目负责人</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-xs  " ng-click="vm.editProject(item,$index)" ng-if="depIdChangeAble == false"><i class='icon-edit'></i></a>
														<a href="javascript:;" class="btn btn-xs btn-danger" ng-click="vm.scrap(item)" ng-if="depIdChangeAble == false"><i class='icon-remove-sign'></i></a>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.pjNo"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.name"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.remark"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.startTime | date:'yyyy-MM-dd'"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.endTime | date:'yyyy-MM-dd'"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.leader"></p></td>
													<!-- edit -->
													<td ng-switch-when="edit" >
														<a href="javascript:;" class="btn btn-xs btn-success " ng-click="vm.save(item)"><i class='icon-ok'></i></a>
													</td>
													<td ng-switch-when="edit"><p ng-bind="item.pjNo"></p></td>
													<td ng-switch-when="edit">
														<input type="text" class="line-limit-length span4" ng-model="item.name" style="width:100px;" >
													</td>
													<td ng-switch-when="edit">
														<input type="text" class="line-limit-length span4" ng-model="item.remark" style="width:100px;" >
													</td>
													<td ng-show="item.editMode == 'edit'">
														<!--<input type="text" id="datepicker{{$index}}" ng-model="item.startTime" style="width:120px;"> -->
														<mb-datepicker input-class="mb-date" date="item.startTime | date:'yyyy-MM-dd'" date-format="YYYY-MM-DD"></mb-datepicker>
													</td>
													<td ng-show="item.editMode == 'edit'">
														<!-- <input type="text" id="datepickers{{$index}}" ng-model="item.endTime" style="width:120px;"> -->
														<mb-datepicker input-class="mb-date" date="item.endTime | date:'yyyy-MM-dd'" date-format="YYYY-MM-DD"></mb-datepicker>
													</td>
													<td ng-switch-when="edit">
														<input type="text" class="line-limit-length span4" ng-model="item.leader" style="width:100px;" >
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

	<!-- 弹框-删除 -->
    <script type="text/ng-template" id="myModalDelContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<ul id="crumb" class="breadcrumb">
							确定删除合同记录吗？
						</ul>
					</div>
				</div>
			</div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">确定</button>
            <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        </div>
    </script>
    
    <script type="text/ng-template" id="myModalEditContent.html">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>付款信息</h3>
							</div>
							<div class="widget-content">
								<div class="row">
                                    <div class="span4">
                                        <span class="searchSpan">公司名称:</span>
                                        <input type="text" ng-model="company" class="span2">
                                    </div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="$ctrl.getPaymentList()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="20%">公司名称</th>
													<th width="20%">税号</th>
													<th width="20%">银行账号</th>
													<th width="20%">开户行</th>
													<th width="20%" style="min-width：100px">操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in list" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td><p ng-bind-html="item.name"></p></td>
													<td><p ng-bind-html="item.taxNo"></p></td>
													<td><p ng-bind-html="item.bankNo"></p></td>
													<td><p ng-bind-html="item.bankName"></p></td>
													<td>
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="Choose(item)" ng-if="mode=='edit'">选择</a>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="g-no-content" ng-if="list && list.length === 0">没有相关数据</div>
										<div style="width:1134px;">
											<%@ include file="../../common/page.jsp"%>
										</div>
									</div>
								</div>
        						<div class="modal-footer">
            						<button class="btn btn-warning" type="button" ng-click="cancel()">取消</button>
        						</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </script>
    
    </div>
	<input type="hidden" id="rootUrl" value="${root}">

	<script src="${root}/public/js/pages/project/script.js" type="text/javascript"></script>
</body>
</html>