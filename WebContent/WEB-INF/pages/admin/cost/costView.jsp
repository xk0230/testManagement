<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" scope="page"/>
<style>
    #printtable{font-size:12px;}
</style>
</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" class="main" ng-app = "myApp" ng-controller="CostController as vm">
		  <div class="main-inner">
			<div class="container">
				<!-- 日常打印 -->
				<div ng-repeat="pageItem in vm.printListPage">
					<div class="row hidden" id="printDiv{{$index}}" style="width:20cm;font: 宋体;">
						<div style="width:100%;height:152mm" ng-repeat="item in pageItem.pageList track by $index">
							<div style="width:100%;">
								<div style="font-size: 20px;font-weight: bold;text-align: center;width: 100%">报 销 单</div>
								<div style="font-size: 12px;font-weight: bold;text-align: right;width: 100%;margin-top:0.2cm">打印日期：{{vm.date | date:'yyyy年MM月dd日'}}</div>
							</div>
							
							<table id="printtable"class="printTable" style="width:20cm;border-bottom:1px solid black;text-align: center;margin-top:0.2cm" cellspacing="0" cellpadding="0">
								<tr style="height:1cm;;">
									<th style="background-color:#F2F2F2; border-top:1px solid black;border-left:1px solid black;width:2cm">NO.</th>
									<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;width:3cm">单号</th>
									<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;width:9cm;">详情</th>
									<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;width:3cm">报销日期</th>
									<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;width:3cm">金额</th>
								</tr>
								<tr class="odd gradeX" ng-repeat="subitem in item.list" style="height:1cm;">
									<td style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;"><p ng-bind="$index+1"></td>
									<td style="border-top:1px solid black;border-left:1px solid black;"><p ng-bind="subitem.costNo"></p></td>
									<td style="border-top:1px solid black;border-left:1px solid black;text-align: left;padding-left: 0.1cm"><p ng-bind="subitem.remark"></p></td>
									<td style="border-top:1px solid black;border-left:1px solid black;"><p ng-bind="subitem.costDate"></p></td>
									<td style="border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;text-align: right;padding-left: 0.2cm"><p>{{subitem.costNum | currency:"¥"}}</p></td>
								</tr>
								<tr style="height:1cm;">
									<td rowspan="2" style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;">合计</td>
									<td style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;">小写</td>
									<td colspan="4" style="border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;text-align: right;padding-right: 0.2cm">{{item.sum | currency:"¥"}}</td>
								</tr>
								<tr style="height:1cm;">
									<td style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;">大写</td>
									<td colspan="4" style="border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;text-align: right;padding-right: 0.2cm">{{item.sum | Chinese}}</td>
								</tr>
							</table>
							<table border="0" cellspacing="0" cellpadding="0" style="width:100%;font-size:12px;margin-top:0.5cm">
								<tr>
									<td style="width:33%;">申请人: {{item.subUserName}}</td>
									<td style="width:33%;">部门主管: {{item.auditUserName}}</td>
									<td style="width:33%;">批准：李欢</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!-- 合同打印 -->
				<div class="row hidden" id="printContract{{$index}}" style="width:20cm;" ng-repeat="pageItem in vm.printContractList">
					<div style="width:100%;height:152mm;font: 宋体;" ng-repeat="contractItem in pageItem.pageList track by $index" >
						<div style="width:100%;">
							<div style="font-size: 20px;font-weight: bold;text-align: center;width: 100%">付款申请单</div>
							<div style="font-size: 12px;font-weight: bold;text-align: right;width: 100%;margin-top:0.2cm">{{vm.date | date:'yyyy年MM月dd日'}}</div>
						</div>
						<table id="printtable"class="printTable" style="width:20cm;border-bottom:1px solid black;text-align: center; margin-top:0.2cm" cellspacing="0" cellpadding="0">
							<tr style="height:1cm;">
								<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;width:10cm;">内容</th>
								<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;width:3cm">总金额</th>
								<th style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;width:3cm">本次金额</th>
							</tr>
							<tr class="odd gradeX" style="height:1cm;">
								<td style="border-top:1px solid black;border-left:1px solid black;text-align:left;padding-left: 0.2cm;"><p ng-bind="contractItem.contract.content"></p></td>
								<td style="border-top:1px solid black;border-left:1px solid black;text-align: right;padding-right: 0.2cm"><p>{{contractItem.contract.cost | currency:"¥"}}</p></td>
								<td style="border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;text-align: right;padding-right: 0.2cm"><p>{{contractItem.costNum | currency:"¥"}}</p></td>
							</tr>
							<tr class="odd gradeX" style="height:10px;">
								<td colspan="3" style="border-left:1px solid black;border-right:1px solid black;">
									<table style="width:100%;" cellspacing="0" cellpadding="0">
										<tr style="height:1cm;">
											<th colspan="2" style="background-color:#F2F2F2;text-align: center;border-top:1px solid black;">付款信息(请认真核对)</th>
										</tr>
										<tr style="height:1cm;">
											<td style="background-color:#F2F2F2;width:3cm;border-top:1px solid black;">收款名称</td>
											<td style="border-top:1px solid black;border-left:1px solid black;text-align: left;padding-left: 0.2cm;">{{contractItem.contract.payment.name}}</td>
										</tr>
										<tr style="height:1cm;">
											<td style="background-color:#F2F2F2;border-top:1px solid black;">收款账号</td>
											<td style="border-top:1px solid black;border-left:1px solid black;text-align: left;padding-left: 0.2cm;">{{contractItem.contract.payment.bankNo}}</td>
										</tr>
										<tr style="height:1cm;">
											<td style="background-color:#F2F2F2;border-top:1px solid black;">收款开户行</td>
											<td style="border-top:1px solid black;border-left:1px solid black;text-align: left;padding-left: 0.2cm;">{{contractItem.contract.payment.bankName}}</td>
										</tr>
										<tr style="height:1cm;">
											<td style="background-color:#F2F2F2;border-top:1px solid black;">备注</td>
											<td style="border-top:1px solid black;border-left:1px solid black;text-align: left;padding-left: 0.2cm;">{{contractItem.remark}}</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table style="width:100%;" cellspacing="0" cellpadding="0">
										<tr style="height:1cm;">
											<td rowspan="2" style="background-color:#F2F2F2;width:3cm;border-top:1px solid black;border-left:1px solid black;">合计</td>
											<td style="background-color:#F2F2F2;width:2cm;border-top:1px solid black;border-left:1px solid black;">小写</td>
											<td style="border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;text-align: right;padding-right: 0.2cm">{{contractItem.costNum | currency:"¥"}}</td>
										</tr>
										<tr style="height:1cm;">
											<td style="background-color:#FDF5E6;border-top:1px solid black;border-left:1px solid black;">大写</td>
											<td style="border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;text-align: right;padding-right: 0.2cm">{{contractItem.costNum | Chinese}}</td>
										</tr>
									</table>
								</td>
							</tr>

						</table>
						<table border="0" cellspacing="0" cellpadding="0" style="width:100%;font-size:12px;margin-top:0.5cm">
							<tr>
								<td style="width:33%;">申请人:{{contractItem.subUserName}}</td>
								<td style="width:33%;">部门主管:{{contractItem.auditUserName}}</td>
								<td style="width:33%;">批准：李欢</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="span12">
						<div class="widget">
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>成本查看</h3>
							</div>
							<div class="widget-content">
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">收支类型:</span>
                                        <select id="costType" ng-model="costType"  class="form-control span2" 
                                                ng-options="cType.costType as cType.name group by cType.group for cType in costTypeList"
                                                ng-change="costTypeChange()">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </div>
									<div class="span4" style="height:37px;">
										<span class="searchSpan pull-left">申请日期:</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="costStartDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
										<span class="searchSpanMid pull-left">~</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="costEndDate"   date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									<div class="span1 pull-right">
									<input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.search()" value="查询" />
									</div>
								</div>
								<div class="row">
                                    <div class="span4">
                                        <span class="searchSpan">单号:</span>
                                        <input type="text" ng-model="costNo" class="span2">
                                    </div>
                                    <div class="span6">
                                    	<span class="searchSpan">内容:</span>
                                        <input type="text" ng-model="remark" class="span4">
                                    </div>
                                    <div class="span1 pull-right">
									<input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.print()" value="打印" />
									</div>
								</div>
								<div class="row">
                                    <div class="span4">
										<span class="searchSpan">成本分类:</span>
                                        <select id="costClass" ng-model="costClass"  class="form-control span2" 
                                                ng-options="cType.costClass as cType.name group by cType.group for cType in costClassList"
                                                ng-change="costTypeChange()">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </div>
								</div>
								<hr>
									<div style="font-weight: bold;font-size: 16px">
									收入:<div class="progress progress-striped active" style="height:18px;" >
										<div class="bar"  ng-style="{'width' : inPercent}" >￥{{inStr}}</div>
									</div>
									支出:<div class="progress progress-striped active">
										<div class="bar" ng-style="{'width' : outPercent}">￥{{outStr}}</div>
									</div>
									<div ng-show="${adminUser.position == 'ADMIN'}">
									账户余额:<div class="progress progress-striped active" >
										<div class="bar" ng-style="{'width' : yePercent}">￥{{yeStr}}</div>
									</div>
									</div>
									</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12" style="overflow:auto">
										<table class="table table-condensed table-bordered table-striped tableBox" style="width:97%;margin-top:7px;" >
											<thead>
												<tr style="font-size:16px;">
													<th width="20px"><input type="checkbox" ng-model="vm.chkValue" ng-change="vm.chkAll()" ></th>
													<th style="text-align: center;width:20px;">NO</th>
													<th style="text-align: center;width:120px;">成本单号</th>
													<th style="text-align: center;width:60px;">类型</th>
													<th style="text-align: center;width:60px;">分类</th>
													<th style="text-align: center;width:140px;">成本产生时间</th>
													<th style="text-align: center;width:120px;">金额</th>
													<th style="text-align: center;width:120px;">成本详情</th>
													<th style="text-align: center;width:50px;">提交人</th>
													<th style="text-align: center;width:50px;">审核人</th>
													<th style="text-align: center;width:100px;">状态</th>
												</tr>
											</thead>
											<tbody ng-repeat="item in vm.list" ng-switch="item.editMode">
												<tr class="odd gradeX"  ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td rowspan="2"><input type="checkbox" ng-if="item.costType == 1" ng-model="item.chk" ng-change="vm.chkChange()" ></td>
													<td rowspan="2" ng-switch-when="view" ><p ng-bind="$index+1"></td>
													<td ng-switch-when="view"><p ng-bind="item.costNo"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costTypeName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costSubName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costDate"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.costNum"></p></td>
													
													<td ng-switch-when="view">
													<ul style="">
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<span class="line-limit-length span2" title="{{item.remark}}">详情：{{item.remark}}</span>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																		<span class="line-limit-length span2">合同：
																		<a href="javascript:;" style="width:200px;" ng-if="item.contractId" ng-click="vm.editBook(item,'.widget-content','view')">{{item.contractId}}</a>
																		<label style="width:200px;" ng-if="!item.contractId" >未选择</label>
																		</span>
																</span>
															</li>
															<li>
																<span style="display:inline-block;vertical-align: bottom;padding-bottom: 8px;width:200px;">
																	<span class="line-limit-length span3" title="{{item.contractContent}}">合同内容：{{item.contractContent}}</span>
																</span>
															</li>
														</ul>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.subUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.auditUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.statusName"></p></td>
												</tr>
												<tr>
													<td ng-switch-when="view" colspan="9" style="padding:8px;">
														<div style="float:left;margin-left:10px" ng-repeat="depCost in item.costDepList">
															{{depCost.costDepName}}:￥{{depCost.costNum}}
														</div>
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
		
    <script type="text/ng-template" id="myModalEditContent.html">
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
										<span class="searchSpan">合同类型:</span>
                                        <select id="contractType" ng-model="contractType"  class="form-control span2" 
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
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="$ctrl.getContractList()" value="查询" /></div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="100px">编号</th>
													<th width="50px">类型</th>
													<th width="200px">内容</th>
													<th width="50px">部门</th>
													<th width="50px">金额</th>
													<th width="130px">收款方</th>
													<th width="100px">签订时间</th>
													<th width="140px">外部订单</th>
													<th width="100px">备注</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in list" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td><p ng-bind="item.contractId"></p></td>
													<td><p ng-bind="item.contractType"></p></td>
													<td><p ng-bind="item.content"></p></td>
													<td><p ng-bind="item.dept"></p></td>
													<td><p ng-bind="item.cost"></p></td>
													<td><p ng-bind="item.company"></p></td>
													<td><p ng-bind="item.url"></p></td>
													<td><p ng-bind="item.serialid"></p></td>
													<td><p ng-bind="item.remakes"></p></td>
													<td>
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="Choose(item)" ng-if="item.status=='00' && mode=='edit'">选择</a>
													</td>
													<!-- edit -->
												</tr>
											</tbody>
										</table>
										<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
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

	<script src="${root}/public/js/pages/cost/costView.js" type="text/javascript"></script>
</body>
</html>