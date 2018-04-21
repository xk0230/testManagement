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
								<h3>付款信息</h3>
							</div>
							<div class="widget-content">
								<div class="row">
                                    <div class="span4">
                                        <span class="searchSpan">公司名称:</span>
                                        <input type="text" ng-model="name" class="span2"  ng-change="vm.getPaymentList()">
                                    </div>
									<!-- <div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getPaymentList()" value="查询" /></div> -->
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
													<th width="20%" style="min-width：100px;text-align:center;font-size:12px;">操作</th>
													<th width="20%" style="text-align:center;font-size:12px;">公司名称</th>
													<th width="20%" style="text-align:center;font-size:12px;">开户行</th>
													<th width="20%" style="text-align:center;font-size:12px;">银行账号</th>
													<th width="20%" style="text-align:center;font-size:12px;">税号</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in vm.list" ng-switch="item.editMode" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view">
													
														<a href="javascript:;" class="btn btn-xs  " ng-click="vm.editPayment(item)"><i class='icon-edit'></i></a>
														<a href="javascript:;" class="btn btn-xs btn-danger" ng-click="vm.scrap(item)"><i class='icon-remove-sign'></i></a>
													</td>
													<td ng-switch-when="view"><span class="line-limit-length span4" title="{{item.name}}">{{item.name}}</span></td>
													<td ng-switch-when="view"><span class="line-limit-length span4" title="{{item.bankName}}">{{item.bankName}}</span></td>
													<td ng-switch-when="view"><p ng-bind-html="item.bankNo"></p></td>
													
													<td ng-switch-when="view"><p ng-bind-html="item.taxNo"></p></td>
												
													<!-- edit -->
													<td ng-switch-when="edit" >
														<a href="javascript:;" class="btn btn-xs btn-success icon-ok "   ng-click="vm.save(item)"></a>
													</td>
													<td ng-switch-when="edit"><input type="text" ng-model="item.name" style="width:250px;" ></td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.bankName" style="width:200px;">
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.bankNo" style="width:200px;" >
													</td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.taxNo" style="width:200px;" >
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
							确定删除吗？
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