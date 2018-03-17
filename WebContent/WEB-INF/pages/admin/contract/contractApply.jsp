<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" class="main" ng-app = "myApp" ng-controller="ContractController as vm">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>合同</h3>
							</div>
							
							<div class="widget-content">
								<div class="row">
                                    <div class="span3">
                                        <select id="contractType" ng-model="contractType"  class="form-control select2" 
                                                ng-options="cType.contractType as cType.name group by cType.group for cType in contractTypeList">
                                            <option value="">--请选择合同类型--</option>
                                        </select>
                                    </div>
                                    <div class="span3">
										<span class="searchSpan">合同内容:</span>
                                        <input type="text" ng-model="content"  style="width:120px;" />
                                    </div>
                                    <div class="span3">
										<span class="searchSpan">合同编号:</span>
                                        <input type="text" ng-model="contractId"  style="width:120px;" />
                                    </div>
									<div class="span6" style="height:37px;">
										<span class="searchSpan">申请日期:</span>
										<input type="date" ng-model="costStartDate" class="span2">
										<span class="searchSpanMid">~</span>
										<input type="date" ng-model="costEndDate" class="span2">
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getContractList()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.addContract()"><i class="icon-plus"></i> 新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="100px">编号</th>
													<th width="50px">类型</th>
													<th width="200px">内容</th>
													<th width="50px">部门</th>
													<th width="50px">金额</th>
													<th width="130px">对方公司</th>
													<th width="100px">扫描件</th>
													<th width="140px">外部订单</th>
													<th width="100px">备注</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view"><p ng-bind="item.contractId"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.contractType"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.content"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.dept"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.cost"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.company"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.url"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.serialid"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.remakes"></p></td>
													<td ng-switch-when="view">
														<a href="javascript:;" class="btn btn-small btn-invert" ng-click="vm.editContract(item)" ng-if="item.status=='00'">编辑</a>
														<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)" ng-if="item.status=='00' && item.status!='99'">删除</a>
														<button type="button" class="btn btn-xs btn-success" ng-click="vm.contractAttachmentList(item.contractId)">附件</button>
													</td>
													<!-- edit -->
													<td ng-switch-when="edit"><p ng-bind="item.contractId"></p></td>
													<td ng-switch-when="edit">
				                                        <select id="type" style="width:70px;" ng-model="item.contractType"  class="form-control select2" 
				                                            ng-options="cType.contractType as cType.name group by cType.group for cType in contractTypeList">
				                                            <option value="">-类型-</option>
				                                        </select>
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.content" style="width:190px;" >
													</td>
													<td ng-switch-when="edit">
														<select id="dept" ng-model="item.dept"  style="width:70px;" class="form-control select2" 
														ng-options="cType.depId as cType.name group by cType.group for cType in depList">
														<option value="">-部门-</option>
														</select>
													</td>
													<td ng-switch-when="edit">
														<input type="number" ng-model="item.cost" min="-1" style="width:50px;">
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.company"  style="width:120px;" />
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.url"  style="width:90px;" />
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.serialid"  style="width:130px;" />
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.remakes"  style="width:90px;" />
													</td>
													<td ng-switch-when="edit">
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.save(item)">保存</a>
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
    </div>
	<input type="hidden" id="rootUrl" value="${root}">

	<script src="${root}/public/js/pages/contract/script.js" type="text/javascript"></script>
</body>
</html>