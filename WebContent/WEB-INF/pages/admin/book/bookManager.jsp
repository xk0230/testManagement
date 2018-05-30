<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="CostController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>图书管理</h3>
							</div>
							
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">图书名称 :</span>
										<span class="pull-left">
											<input type="text" class="form-control" name="name" ng-model="name" id="name" />
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getBookList()" value="查询" /></div>
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
												<th style="width:5%; font-size:14px;text-align: center;">序号</th>
												<th style="width:13%; font-size:14px;text-align: center;">操作</th>
												<!-- <th>序号</th> -->
												
												<th style="width:70%; font-size:14px;text-align: center;">图书名称</th>
												<th style="width:12%; font-size:14px;text-align: center;">当前借阅人</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode">
													<!-- view -->
													<td ng-switch-when="view"><p ng-bind="item.bookNo"></p></td>
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-small" ng-click="vm.edit(item)" ng-if="${adminUser.position == 'ADMIN'}"><i class="icon-edit"></i></a>
														<a href="javascript:;" class="btn btn-small btn-success"  ng-click="vm.pullOrBackBook(item)" >借还</a>
													</td>
													<!-- <td ng-switch-when="view"><p ng-bind="$index + 1"></p></td> -->
													
													<td ng-switch-when="view"><p ng-bind="item.name"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.userName"></p></td>
 													<!-- edit -->
 													<td ng-switch-when="edit">
														<p ng-bind="item.bookNo"></p>
													</td>
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)"><i class="icon-ok"></i></a>
													</td>
													<!-- <td ng-switch-when="edit"><p ng-bind="$index + 1"></p></td> -->
													
													<td ng-switch-when="edit">
														<input type="text" class="form-control" ng-model="item.name" />
													</td>
													<td ng-switch-when="edit">
														<p ng-bind="item.userName"></p>
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
    <script type="text/ng-template" id="myModalAddContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 图书信息</h1>
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
									<h3 class="panel-title"><i class="ec-pencil"></i>图书记录</h3>
								</div>
								<div class="panel-body">
									<div id="addDepNum" class="form-horizontal group-border" role="form">
										
										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">图书名称</label>
												<div class="col-lg-8">
														<input type="text" class="form-control" name="bookEntity.name" ng-model="bookEntity.name" />
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
		
	<!-- 这里可以定义一个js文件放到public下面 -->
    <script type="text/ng-template" id="myModalEditContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> 图书信息</h1>
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
									<h3 class="panel-title"><i class="ec-pencil"></i>图书信息</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<input type="hidden" ng-model="bookEntity.id">

										<div class="form-group">
											<div class="col-lg-6">
												<label class="col-lg-4 control-label">图书名称</label>
												<div class="col-lg-8">
													<input type="text" class="form-control" ng-model="bookEntity.name" />
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
							确定要借阅或归还该图书吗？
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
			
	<script src="${root}/public/js/pages/book/script.js" type="text/javascript"></script>
</body>
</html>