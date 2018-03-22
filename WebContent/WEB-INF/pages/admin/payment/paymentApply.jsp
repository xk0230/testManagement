<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" class="main" ng-app = "myApp" ng-controller="PaymentController as vm">
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
                                    
									<div class="span6" style="height:37px;">
										<span class="searchSpan">申请日期:</span>
										<input type="date" ng-model="costStartDate" class="span2">
										<span class="searchSpanMid">~</span>
										<input type="date" ng-model="costEndDate" class="span2">
									</div>
									
									
									
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getPaymentList()" value="查询" /></div>
									
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;">
											<button class="btn btn-invert" ng-click="vm.addPayment()"><i class="icon-plus"></i> 新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
												<!-- 	<th width="100px">单号</th>
													<th width="50px">类型</th>
													<th width="120px">内容</th>
													<th width="50px">部门</th>
													<th width="50px">金额</th>
													<th width="130px">对方公司</th>
													<th width="100px">签订时间</th>
													<th width="140px">外部订单</th>
													<th width="100px">备注</th>
													<th width="150px">操作</th> -->
													<th width="20%">公司名称</th>
													<th width="15%">税号</th>
													<th width="20%">银行号</th>
													<th width="15%">开户行</th>
													<th width="30%" style="min-width：100px">操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view"><p ng-bind-html="item.name"></p></td>
													<td ng-switch-when="view"><p ng-bind-html="item.taxNo"></p></td>
													<td ng-switch-when="view"><p ng-bind-html="item.bankNo"></p></td>
													<td ng-switch-when="view"><p ng-bind-html="item.bankName"></p></td>
													<td ng-switch-when="view">
													
														<a href="javascript:;" class="btn btn-xs  " ng-click="vm.editPayment(item)"><i class='icon-edit'></i></a>
														<a href="javascript:;" class="btn btn-xs btn-danger" ng-click="vm.scrap(item)"><i class='icon-remove-sign'></i></a>
													</td>
													<!-- edit -->
													<td ng-switch-when="edit"><input type="text" ng-model="item.name" style="width:100px;" ></td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.taxNo" style="width:100px;" >
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.bankNo" style="width:100px;" >
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.bankName" style="width:50px;">
													</td>
													<td ng-switch-when="edit" >
														<a href="javascript:;" class="btn btn-xs btn-success icon-ok "   ng-click="vm.save(item)"></a>
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
							确定删除公司记录吗？
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

	<script src="${root}/public/js/pages/payment/script.js" type="text/javascript"></script>
</body>
</html>