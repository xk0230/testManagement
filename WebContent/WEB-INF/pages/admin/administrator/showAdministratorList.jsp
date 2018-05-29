<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		
		<div id="content" class="main" ng-app = "myApp" ng-controller="UserListController as vm">
			<div class="main-inner">
				<div class="container">
				<!-- 所有员工列表 -->
					<div class="row">
						<div class="span12">
							<div class="widget">
						
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>员工列表</h3>
								</div>
								<div class="widget-content" style="padding-bottom: 100px;">
									<div class="row">
	                                   
										<div class="span4" style="height:37px;">
											<span class="searchSpan pull-left">姓名 :</span>
											<input type="text" class="form-control" name="realName" ng-model="realName" id="realName" />
										</div>
                                        
                                         <div class="span4">
											<span class="searchSpan" >用户名 :</span>
	                                        <input type="text" class="form-control" name="userName" ng-model="userName" id="userName" />
	                                    </div>
                                        
										<div class="span1 pull-right"><input type="button"  class="btn-large btn-success btn-support-ask" name="query" ng-click="vm.getFinancingInfoList()" value="查询" /></div>
									</div>
									<div class="row">
	                                    <div class="span4">
											<span class="searchSpan">部门 :</span>
											<select class="form-control select2" ng-model="depId"  ng-change="vm.getPostionById()" ng-Disabled = "depIdChangeAble" >
												<option value="">请选择</option>
												<option value="{{dep.depId}}" ng-repeat="dep in vm.deplist">{{dep.name}}</option>
											</select>
	                                    </div>
	                                    <div class="span4">
											<span class="searchSpan">岗位 :</span>
											<select class="form-control select2" ng-model="postId" >
												<option value="">请选择</option>
												<option value="{{pos.postId}}" ng-repeat="pos in vm.postlist">{{pos.name}}</option>
											</select>
										</div>
									</div>
									<hr>
									<!-- 查询结果 -->
									<div class="row">
										<div class="span12">
											<div style="width:1134px;">
												<button class="btn btn-invert" ng-click="vm.addNewUser('')" ng-if="${adminUser.userId == 'admin'}"><i class="icon-plus"></i>新增用户</button>
											</div>
											<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
												<thead >
													<tr>
														<th style="text-align: center;font-size:14px;">姓名</th>
														<th style="text-align: center;font-size:14px;">用户名</th>
														<th style="text-align: center;font-size:14px;">部门</th>
														<th style="text-align: center;font-size:14px;">角色</th>
														<th style="text-align: center;font-size:14px;">岗位</th>
														<th style="text-align: center;font-size:14px;">状态</th>
														<th style="text-align: center;font-size:14px;">入职日期</th>
														<th style="text-align: center;font-size:14px;">操作</th>
													</tr>
												</thead>
												<tbody>
													<tr class="odd gradeX" ng-repeat="item in vm.list">
														<td><p ng-bind="item.realName"></p></td>
														<td><p ng-bind="item.userName"></p></td>
														<td><p ng-bind="item.depName"></p></td>
														<td><p ng-bind="item.positionStr"></p></td>
														<td><p ng-bind="item.postName"></p></td>
														<td><p ng-bind="item.workStatus"></p></td>
														<td><p ng-bind="item.entryDate | date:'yyyy-MM-dd'"></p></td>
														<td>
															<button type="button" class="btn btn-small btn-invert" ng-click="vm.edit(item.userId)" style="color:green;font-weight: 500;">Edit</button>
															<button type="button" class="btn btn-small btn-invert" ng-click="vm.userTrainList(item.userId)" style="color:green;font-weight: 500;">Training</button>
															<button type="button" class="btn btn-small btn-invert" ng-click="vm.userTransferPositionList(item.userId)" style="color:green;font-weight: 500;"> Adjustment </button>
															<button type="button" class="btn btn-small btn-invert" ng-click="vm.userAttachmentList(item.userId)" style="color:green;font-weight: 500;">ATT</button>
															<button type="button" class="btn btn-small btn-invert" ng-click="vm.bookHis(item.userId,'.widget')" style="color:green;font-weight: 500;">Library</button>
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
								<br>
							</div>
						</div>
					</div>
					<!-- 图表统计 -->
					<div class="row">
						<div class="span6">
							<div class="widget">
								<div class="widget-header">
									<i class="icon-bar-chart"></i>
									<h3>部门人员分布</h3>
								</div>
								<div class="widget-content" style="padding-bottom: 50px;">
									<div class="row">
										<div class="span5" style="padding:15px;">
				                        	<div id="c2" class="col-lg-12 panel panel-primary panelMove toggle panelRefresh panelClose"></div>
				                        </div>
				                    
									</div>
								</div>
							</div>
						</div>
						<div class="span6">
							<div class="widget">
								<div class="widget-header">
									<i class="icon-bar-chart"></i>
									<h3>学历分布</h3>
								</div>
								<div class="widget-content" style="padding-bottom: 50px;">
									<div class="row">
										<div class="span5" style="padding:15px;">
											<div id="c1" class="col-lg-12 panel panel-primary panelMove toggle panelRefresh panelClose"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="span6">
							<div class="widget">
								<div class="widget-header">
									<i class="icon-bar-chart"></i>
									<h3>年龄分布</h3>
								</div>
								<div class="widget-content" style="padding-bottom: 50px;">
									<div class="row">
										<div class="span5" style="padding:15px;">
										<div id="c3" class="col-lg-12 panel panel-primary panelMove toggle panelRefresh panelClose"></div></div>
									</div>
								</div>
							</div>
						</div>
						<div class="span6">
							<div class="widget">
								<div class="widget-header">
									<i class="icon-bar-chart"></i>
									<h3>工龄分布</h3>
								</div>
								<div class="widget-content" style="padding-bottom: 50px;">
									<div class="row">
										<div class="span5" style="padding:15px;">
				                        	<div id="c4" class="col-lg-3 panel panel-primary panelMove toggle panelRefresh panelClose"></div>
				                        </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<script type="text/ng-template" id="myAuditDetailContent.html">
			<div class="main-inner">
				<div class="container">
					<div class="row">
						<div class="span12">
							<div class="widget">
								<!-- 标题 -->
								
								<div class="widget-header">
									<i class="icon-pushpin"></i>
									<h3>图书借阅记录</h3>
								</div>
								<div class="widget-content">
									<!-- 查询结果 -->
									<div class="row">
										<div class="span12">
											<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
												<thead>
													<tr>
														<th>图书名</th>
														<th>借阅人</th>
														<th>借/还</th>
														<th>时间</th>
													</tr>
												</thead>
												<tbody>
													<tr class="odd gradeX" ng-repeat="item in list">
														<td class="col-lg-2"><p ng-bind="item.bookName"></p></td>
														<td class="col-lg-2"><p ng-bind="item.userName"></p></td>
														<td class="col-lg-2"><p ng-bind="item.type"></p></td>
														<td class="col-lg-2"><p ng-bind="item.bookTime | date:'yyyy-MM-dd hh:mm'"></p></td>
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
	            						<button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">确定</button>
	            						<button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
	        						</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</script>	

	<script src="${root}/public/js/pages/administrator/script.js" type="text/javascript"></script>
	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
</div></body>
</html>
