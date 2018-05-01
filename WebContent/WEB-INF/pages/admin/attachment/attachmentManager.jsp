<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		
		
		
		<!-- Start #content -->
		<div id="content" ng-app = "myApp" ng-controller="AttachmentController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>附件信息</h3>
							</div>
							
							<div class="widget-content" style="padding-bottom: 100px;">
								<div class="row">
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">上传日期:</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="startDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
										<span class="searchSpanMid pull-left">~</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="endDate"   date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getAttachmentEntityPageList()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.add()"><i class="icon-plus"></i>新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead >
												<tr>
													<th width="110px">操作</th>
													<th width="50px">序号</th>
													<th width="610px">文件名称</th>
													<th width="110px">类型</th>
													<th>创建日期</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode">
													<!-- view -->
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-small" ng-click="vm.edit(item)"><i class="icon-edit"></i></a>
														<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.del(item)" ><i class="icon-remove-sign"></i></a>
													</td>
													<td ng-switch-when="view"><p ng-bind="$index + 1"></p></td>
													<td ng-switch-when="view"><a href="${root}/admin/attachment/download.do?id={{item.id}}"><p ng-bind="item.name"></p></a></td>
													<td ng-switch-when="view"><p ng-bind="item.typeName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.createTime | date:'yyyy-MM-dd'"></p></td>
 													<!-- edit -->
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item,$index)"><i class="icon-ok"></i></a>
													</td>
													<td ng-switch-when="edit"><p ng-bind="$index + 1"></p></td>
													<td ng-switch-when="edit">
														<a href="${root}/admin/attachment/download.do?id={{item.id}}"><p ng-bind="item.name"></p>
														<input type="file" id="fileUpload{{$index}}" class="form-control" file-model="myfile" />
													</td>
													<td ng-switch-when="edit">
														<select ng-model="item.type"  class="form-control select2" >
															<option value="">--请选择--</option>
															<option value="0" >图片</option>
															<option value="1" >PDF</option>
														</select>
													</td>
													<td ng-switch-when="edit">
														<mb-datepicker input-class="mb-date" date="item.createTime" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
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
						<h1 class="page-header"><i class="im-users2"></i> 附件信息</h1>
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
									<h3 class="panel-title"><i class="ec-pencil"></i>附件记录</h3>
								</div>
								<div class="panel-body">
									<div class="form-horizontal group-border" role="form">
										<input type="hidden" ng-model="attachmentEntity.id">
										<div class="form-group">

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">类型</label>
												<div class="col-lg-8">
													<select ng-model="attachmentEntity.type"  class="form-control select2" >
														<option value="">--请选择--</option>
														<option value="0" >图片</option>
														<option value="1" >PDF</option>
													</select>
												</div>
												
											</div>
										</div>

										<div class="form-group">

											<div class="col-lg-6">
												<label class="col-lg-4 control-label">选择文件</label>
												<div class="col-lg-8">
													<input type="file" class="form-control" file-model="myfile" />
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
							确定删除附件记录吗？
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
			
	<script src="${root}/public/js/pages/attachment/script.js" type="text/javascript"></script>
</body>
</html>