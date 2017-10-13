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
                        <h1 class="page-header"><i class="im-users2"></i> 候选人评估汇总表</h1>
                        <!-- Start .bredcrumb -->
                        <ul id="crumb" class="breadcrumb">
                        </ul>
					</div>
				</div>
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
													<input type="text" class="form-control" ng-model="vm.Recruitment.postName"  value="" ng-disabled="true" />
												</div>
											</div>
											<div class="col-lg-6">

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
									<h3 class="panel-title"><i class="ec-list"></i>候选人面试概况</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th style="width:8%">评估标准</th>
												<th style="width:10%">相关经验/成就</th>
												<th style="width:10%">技术/岗位能力</th>
												<th style="width:10%">PC</th>
												<th style="width:10%">教育</th>
												<th style="width:10%">其他资质</th>
												<th style="width:10%">测评</th>
												<th style="width:10%">总排序</th>
												<th style="width:10%">操作</th>
											</tr>
										</thead>  
										<tbody ng-repeat="item in vm.list">
											<tr class="odd gradeX">
												<td rowspan="3"><h4>{{item.name}}</h4></td>
												<!-- 相关经验/成就 -->
												<td >
													<select class="form-control select2" ng-model="item.wordScore" ng-required="true">
														<option value="">请选择工作经历/成就评价</option>
														<option value="1" >各方面都较欠缺</option>
														<option value="2" >低于平均水平</option>
														<option value="3" >平均水平</option>
														<option value="4" >高于平均水平</option>
														<option value="5" >非常杰出</option>
													</select>
												</td>
												<!-- 技术/岗位能力 -->
												<td>
													<select class="form-control select2" ng-model="item.skillScore" ng-required="true">
														<option value="">请选择技术技能/岗位技能评价</option>
														<option value="1" >各方面都较欠缺</option>
														<option value="2" >低于平均水平</option>
														<option value="3" >平均水平</option>
														<option value="4" >高于平均水平</option>
														<option value="5" >非常杰出</option>
													</select>
												</td>
												<!-- PC -->
												<td><input type="text" class="form-control" ng-model="item.pc" /></td>
												<!-- 教育 -->
												<td><input type="text" class="form-control" ng-model="item.edu" /></td>
												<!-- 其他资质 -->
												<td><input type="text" class="form-control" ng-model="item.other" /></p></td>
												<!-- 测评 -->
												<td><input type="text" class="form-control" ng-model="item.evaluating" /></td>
												<!-- 总排序 -->
												<td><input type="text" class="form-control" ng-model="item.sort" /></p></td>
												<td rowspan="3">
													<input type="button" class="btn btn-success col-lg-12" ng-click="vm.save(item)"  value="保存" />
													<button type="button" class="btn btn-warning col-lg-12" ng-click="vm.show(item)" style="margin-top:5px">查看面试详情</button>
												</td>
											</tr>
											<tr class="odd gradeX">
												<td style="vertical-align:middle;"><h5>PDP:</h5></td>
												<td colspan="6">
													<table class="col-lg-10">
														<tr>
															<th style="width:12%" >情景</th>
															<th style="width:22%" class="container">谦和</th>
															<th style="width:22%" class="container">韧性</th>
															<th style="width:22%" class="container">理性</th>
															<th style="width:22%" class="container">自信</th>
														</tr>
														<tr>
															<th>顺境</th>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjA" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjB" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjC" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpSjD" /></td>
														</tr>
														<tr>
															<th>逆境</th>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjA" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjB" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjC" /></td>
															<td class="container"><input type="text" class="form-control" ng-model="item.pdpNjD" /></td>
														</tr>
													</table>
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
						<h1 class="page-header"><i class="im-users2"></i> 面试详情</h1>
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
									<h3 class="panel-title"><i class="ec-list"></i>查询结果</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable" >
										<thead>
											<tr>
												<th width="200px;">面试项目</th>
												<th width="200px;" ng-repeat="Interview in InterviewList">{{Interview.interviewerName}}</th>
											</tr>
										</thead>  
										<tr>
											<td>相关工作经历/成就</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.workDetail}}</td>
										</tr>
										<tr>
											<td>技术技能/岗位技能</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.skillDetail}}</td>
										</tr>
										<tr>
											<td>相关工作经历/成就评分</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.wordScore}}</td>
										</tr>
										<tr>
											<td>技术技能/岗位技能评分</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.skillScore}}</td>
										</tr>
										<tr ng-repeat="crr in InterviewList[0].crrs track by $index">
											<td ng-bind="tableMark=$index" style="display:none"></td>
											<td>{{crr.competencyName}}</td>
											<td ng-repeat="Interview in InterviewList">{{Interview.crrs[tableMark].value}}</td>
										</tr>
									</table>
									<div class="g-no-content" ng-if="InterviewList && InterviewList.length === 0">没有相关数据</div>
								</div>
							</div>
						</div>
						<!-- col-lg-12 end here -->
					</div>
					<!-- Page End here -->
				</div>
       			 <div class="modal-footer">
            		<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        		</div>
			</form>
    </script>
			
			
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
		</div>
		<!-- End #content -->
	</div>
	<script src="${root}/public/js/pages/Recruitment/AdminEvaluation.js" type="text/javascript"></script>
</body>
</html>