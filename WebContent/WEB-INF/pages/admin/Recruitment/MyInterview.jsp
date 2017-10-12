<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="UserListController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
                        <h1 class="page-header"><i class="im-users2"></i> 我的面试</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
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
									<h3 class="panel-title"><i class="ec-list"></i>我的面试</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>候选人人</th>
												<th>面试时间</th>
												<th>面试地点</th>
												<th>面试内容</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td><p ng-bind="item.candidateName"></p></td>
												<td><p ng-bind="item.interviewTime | date:'yyyy-MM-dd'"></p></td>
												<td><p ng-bind="item.place"></p></td>
												<td><p ng-bind="item.interviewDetail"></p></td>
												<td>
													<button type="button" class="btn btn-success" ng-click="vm.edit(item,'.outlet')"><i class="fa-thumbs-up"></i> 评估</button>
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
			
	<!-- 候选人，面试官编辑 -->
    <script type="text/ng-template" id="myModalEditContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 候选人评估</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>
				<!-- 个人信息 start here -->
				<div class="outlet" >
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>评估信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">岗位名称</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="items.positionName"  value="" ng-disabled="true" />
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">候选人</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="items.candidateName"  value="" ng-disabled="true" />
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">评估人</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="items.interviewerName"  value="" ng-disabled="true" />
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">评估时间</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="items.interviewTime"  value="" ng-disabled="true" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-info toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-pencil"></i>面试记录</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<label class="col-lg-12 control-label text-left" >I.相关工作经历/成就：</label>
											<div class="col-lg-12 media">
												<textarea class="form-control" ng-model="items.workDetail" rows="5" Placeholder="点击输入相关工作经历/成就"  ng-required="true"></textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-lg-12 control-label text-left" >II.技术技能/岗位技能：</label>
											<div class="col-lg-12 media">
												<textarea class="form-control" ng-model="items.skillDetail" rows="5" Placeholder="点击输入技术技能/岗位技能"  ng-required="true"></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-12 control-label text-left" style="margin-left:-15px" >相关工作经历/成就</label>
												<div class="col-lg-12 media">
												<div class="form-group">
													<select class="form-control select2" ng-model="items.wordScore" ng-required="true">
														<option value="">请选择工作经历/成就评价</option>
														<option value="1" >各方面都较欠缺</option>
														<option value="2" >低于平均水平</option>
														<option value="3" >平均水平</option>
														<option value="4" >高于平均水平</option>
														<option value="5" >非常杰出</option>
													</select>
												</div>
												</div>
											</div>
											<div class="col-lg-6">
												<label class="col-lg-12 control-label text-left" style="margin-left:-15px" >技术技能/岗位技能</label>
												<div class="col-lg-12 media">
												<div class="form-group">
													<select class="form-control select2" ng-model="items.skillScore" ng-required="true">
														<option value="">请选择技术技能/岗位技能评价</option>
														<option value="1" >各方面都较欠缺</option>
														<option value="2" >低于平均水平</option>
														<option value="3" >平均水平</option>
														<option value="4" >高于平均水平</option>
														<option value="5" >非常杰出</option>
													</select>
												</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-12">
												<label class="col-lg-12 control-label text-left" style="margin-left:-15px" >胜任特质</label>
												<div class="col-lg-12 media">
													<span ng-repeat="competency in items.crrs track by $index" >{{competency.competencyName}}<input type="text" class="form-control" ng-model="competency.value" /></span>
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
       			 <div class="modal-footer">
					<input type="button" class="btn btn-primary" ng-click="save()"  value="保存" />
            		<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        		</div>
    </script>
			
			
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
	</div>
	<script src="${root}/public/js/pages/Recruitment/MyInterview.js" type="text/javascript"></script>
</body>
</html>