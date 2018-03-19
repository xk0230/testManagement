<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	
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
							
							<div class="widget-content">
								<div class="row">
									<div class="span6" style="height:37px;">
										<span class="searchSpan">日期:</span>
										<input type="date" ng-model="startDate" class="span2">
										<span class="searchSpanMid">~</span>
										<input type="date" ng-model="endDate" class="span2">
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getAttachmentEntityPageList()" value="查询" /></div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.addAttachment('', '.widget-content')" value="新增记录" /></div>
								</div>
											
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" id="datatable">
										<thead>
											<tr>
												<th>文件名称</th>
												<th>类型</th>
												<th>创建日期</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												
												<td><a href="${root}/admin/attachment/download.do?id={{item.id}}"><p ng-bind="item.name"></p></a></td>
												<td><p ng-bind="item.typeName"></p></td>
												<td><p ng-bind="item.createTime | date:'yyyy-MM-dd'"></p></td>
												<td>
													<button type="button" class="btn btn-xs  " ng-click="vm.addAttachment(item.id,'.widget-content')" value="修改"><i class="icon-edit"></i></button>
													<button type="button" class="btn btn-xs btn-danger " ng-click="vm.scrap(item.id)" value="删除"><i class="icon-remove-sign"></i></button>
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
			<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3> 附件信息</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
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
								</div>
											
								<hr>
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
			<div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<h3>确定删除附件记录吗？</h3>
							</div>
							
						
						</div>
					</div>
				</div>
			</div>

        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">确定</button>
            <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">取消</button>
        </div>

				
    </script>
    
	</div>

		<input type="hidden" id="contractId" value="${contractId}"> <input
			type="hidden" id="rootUrl" value="${root}">

		<script src="${root}/public/js/pages/attachment/contractScript.js"
			type="text/javascript"></script>
</body>
</html>