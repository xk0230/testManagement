<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<div id="content" class="main" ng-app = "myApp" ng-controller="TravelController as vm">
		  <div class="main-inner">
			<div class="container">
				<%@ include file="../print/CostTravel.jsp"%>
				<div class="row">
					<div class="span12">
						<div class="widget" style="padding-bottom:100px;">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3 ng-if="${mode == 'apply' }">出差登记</h3>
								<h3 ng-if="${mode == 'audit' }">出差审批</h3>
								<h3 ng-if="${mode == 'view' }">出差查看</h3>
								<!-- 模式 -->
								<input type="hidden" id="mode" value="${mode}">
							</div>
							
							<div class="widget-content">
								<div class="row">
                             <!--        <div class="span4">
										<span class="searchSpan">合同类型:</span>
                                        <select id="travelType" ng-model="travelType"  class="form-control span2" 
                                                ng-options="cType.travelType as cType.name group by cType.group for cType in travelTypeList">
                                            <option value="">--请选择合同类型--</option>
                                        </select>
                                    </div> -->
									<div class="span6" style="height:37px;">
										<span class="searchSpan pull-left">出差日期:</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="startDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
										<span class="searchSpanMid pull-left">~</span>
										<span class="pull-left">
											<mb-datepicker input-class="mb-date" date="endDate" date-format="YYYY-MM-DD" class="pull-left" ></mb-datepicker>
										</span>
									</div>
									<div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="vm.getTravelList()" value="查询" /></div>
									
								</div>
								<div class="row">
                                    <!-- <div class="span4">
                                        <span class="searchSpan">创建者名字:</span>
                                        <input type="text" ng-model="createUser" class="span2">
                                    </div> -->
                                    
                                    <div class="span6">
                                    	<span class="searchSpan">出差地:</span>
                                        <input type="text" ng-model="place" class="span4">
                                    </div>
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<div style="width:1134px;" ng-if="${mode == 'apply' }">
											<button class="btn btn-invert" ng-click="vm.addTravel()"><i class="icon-plus"></i> 新增</button>
										</div>
										<table class="table table-condensed table-bordered table-striped" style="width:1134px;margin-top:7px;" >
											<thead>
												<tr>
													<th width="18%"  style="text-align:center;font-size:12px;">操作</th>
													<%-- <th width="5%" ng-if="${adminUser.userId == 'admin' and mode=='view'}"><input type="checkbox" ng-model="vm.chkValue" ng-change="vm.chkAll()"  ></th> --%>
													<th width="10%" style="text-align:center;font-size:12px;">状态</th> 
												 	<th width="10%" style="text-align:center;font-size:12px;">姓名</th>
													<th width="10%" style="text-align:center;font-size:12px;">地点</th>
													<th width="10%" style="text-align:center;font-size:12px;">部门</th>
													<th width="8%" style="text-align:center;font-size:12px;">开始时间</th>
													<th width="8%" style="text-align:center;font-size:12px;">结束时间</th>
													<th style="text-align:center;font-size:12px;">备注</th>
												</tr>
											</thead>
											<tbody ng-repeat="item in vm.list" ng-switch="item.editMode">
												<tr class="odd gradeX"  ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td ng-switch-when="view">
														<div ng-if="${mode == 'apply' }">
															<a href="javascript:;" class="btn btn-xs  " ng-click="vm.toDetail(item,$index)"><i class='icon-list'></i></a>
															<a href="javascript:;" class="btn btn-xs  " ng-click="vm.editTravel(item,$index)" ng-if="item.status=='00' || item.status=='02'|| item.status=='03'|| item.status=='04'"><i class='icon-edit'></i></a>
															<a href="javascript:;" class="btn btn-small " ng-click="vm.submitTravel(item)" ng-if="item.status=='00' || item.status=='02'|| item.status=='04'"><i class="icon-share"></i></a>
															<a href="javascript:;" class="btn btn-xs btn-danger" ng-click="vm.scrap(item)" ng-if="item.status=='00' && item.status!='99'"><i class='icon-remove-sign'></i></a>
														</div>
														<div ng-if="${mode=='audit'}">
															<a href="javascript:;" class="btn btn-xs  " ng-click="vm.toDetail(item,$index)"><i class='icon-list'></i></a>
															<a href="javascript:;" class="btn btn-small" ng-click="vm.editTravel(item,$index)" ng-if="${adminUser.userId == 'admin'} && (item.status=='05' || item.status=='03')"><i class="icon-edit"></i></a>
															<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.managerSub(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')"><i class="icon-ok"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.managerRej(item)" ng-if="${adminUser.position == 'MANAGER'} && (item.status=='01' || item.status=='04')"><i class="icon-remove-sign"></i></a>
															<a href="javascript:;" class="btn btn-small btn-success" ng-click="vm.adminSub(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'"><i class="icon-ok"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.adminRej(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='03'"><i class="icon-remove-sign"></i></a>
															<a href="javascript:;" class="btn btn-small btn-danger" ng-click="vm.scrap(item)" ng-if="${adminUser.userId == 'admin'} && item.status=='05'"><i class="icon-remove-sign"></i></a>
														</div>
														
														<div ng-if="${mode=='view'}">
															<%-- <input type="checkbox" ng-if="${adminUser.userId == 'admin'}" ng-model="item.chk" ng-change="vm.chkChange()" > --%>
															<a href="javascript:;" class="btn btn-xs  " ng-click="vm.toDetail(item,$index)"><i class='icon-list'></i></a>
															<a href="javascript:;" class="btn btn-xs  " ng-click="vm.print(item.id)"><i class='icon-print'></i></a>
														</div>
													</td>
													<td ng-switch-when="view"><p ng-bind="item.statusName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.createUserName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.place"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.depName"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.startTime | date:'yyyy-MM-dd'"></p></td>
													<td ng-switch-when="view"><p ng-bind="item.endTime | date:'yyyy-MM-dd'"></p></td>
													<td ng-switch-when="view"><p class="line-limit-length span2"  title="{{item.remark}}" ng-bind="item.remark"></p></td>
													<!-- edit -->
													<td ng-switch-when="edit" >
														<a href="javascript:;" class="btn btn-xs btn-success " ng-click="vm.save(item)"><i class='icon-ok'></i></a>
													</td>
													<td ng-switch-when="edit">草稿</td>
													<td ng-switch-when="edit"><p ng-bind="item.createUserName"></p></td>
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.place" style="width:200px;" >
													</td>
													<td ng-switch-when="edit">
														<select id="dept" ng-model="item.depId"  ng-disabled="${sessionScope.adminUser.userId != 'admin'}" style="width:150px;" class="form-control select2" 
														ng-options="cType.depId as cType.name group by cType.group for cType in depList">
														<option value="">部门</option>
														</select>
													</td>
													
													
													<td ng-show="item.editMode == 'edit'">
														<mb-datepicker input-class="mb-date" date="item.startTime" class="pull-left"  date-format="YYYY-MM-DD"></mb-datepicker>
													</td>
													<td ng-show="item.editMode == 'edit'">
														<mb-datepicker input-class="mb-date" date="item.endTime" class="pull-left"  date-format="YYYY-MM-DD"></mb-datepicker>
													</td>
													
													<td ng-switch-when="edit">
														<input type="text" ng-model="item.remark"  style="width:150px;" />
													</td>
												
												</tr>
												<tr ng-switch-when="view" ng-if="item.costs">
													<td colspan="8">
														<span style="float:left;margin-left:10px;margin-right:8px；" ng-repeat="c in item.costs">
														{{c.remark}} : <strong >{{c.costNum}}</strong>
														</span>
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
    
    <script type="text/ng-template" id="myModalEditContent.html">
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
                                        <input type="text" ng-model="company" class="span2" ng-change="$ctrl.getPaymentList()">
                                    </div>
									<!-- <div class="span1 pull-right"><input type="button"  class="btn btn-large btn-success btn-support-ask" name="query" ng-click="$ctrl.getPaymentList()" value="查询" /></div> -->
								</div>
								<hr>
								<!-- 查询结果 -->
								<div class="row">
									<div class="span12">
										<table class="table table-condensed table-bordered table-striped" style="width:97%;margin-top:7px;" >
											<thead>
												<tr>
													<th width="20%">公司名称</th>
													<th width="20%">税号</th>
													<th width="20%">银行账号</th>
													<th width="20%">开户行</th>
													<th width="20%" style="min-width：100px">操作</th>
												</tr>
											</thead>
											<tbody>
												<tr class="odd gradeX" ng-repeat="item in list" ng-class="item.status=='99' ? 'ScrapBackground' : ''" >
													<!-- view -->
													<td><p ng-bind-html="item.name"></p></td>
													<td><p ng-bind-html="item.taxNo"></p></td>
													<td><p ng-bind-html="item.bankNo"></p></td>
													<td><p ng-bind-html="item.bankName"></p></td>
													<td>
														<a href="javascript:;" class="btn btn-small btn-success" ng-click="Choose(item)" ng-if="mode=='edit'">选择</a>
													</td>
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

	<script src="${root}/public/js/pages/travel/script.js" type="text/javascript"></script>
</body>
</html>