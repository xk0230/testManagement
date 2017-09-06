<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body>
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		
		<div id="content" ng-app = "myApp"  ng-controller="CostController as vm">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
		                <ul class="nav navbar-nav pull-left">
		                    <li id="toggle-sidebar-li">
		                        <a href="#" id="toggle-sidebar"><i class="im-users"></i></a>
		                    </li>
		                    <li id="toggle-sidebar-li">
		                        <h1 class="page-header">成本管理</h1>
		                    </li>
		                </ul>
					</div>
				</div>
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
                                    <h4 class="panel-title"><i class="ec-search"></i> 查询条件</h4>
								</div>
								<div class="panel-body">
								
							<ul class="searchWrap borderBox">
								<li>
									<label class="labelText">所属部门：</label>
									<select id="depId" ng-model="dep" 
											ng-options="dep.depId as dep.name group by dep.group for dep in depList">
											<option value="">--请选择--</option>
									</select>
									
									<label class="labelText">收支类型：</label>
									<select id="costType" ng-model="costType" 
											ng-options="costType.value as costType.name group by costType.group for costType in costTypeList"
											ng-change="costTypeChange()">
										<option value="">--请选择--</option>
									</select>
									
									<label class="labelText">分类名称：</label>
									<select id="costSubType" ng-model="costSubType" 
											ng-options="costSubType.costSubTypeId as costSubType.name group by costSubType.group for costSubType in costSubTypeList">
										<option value="">--请选择--</option>
									</select>
									
									<label class="labelText">开始日期：</label>
									<input type="text" id="costStartTime" onClick="WdatePicker({readOnly:true})" />
									
									<label class="labelText">结束日期：</label>
									<input type="text" id="costEndTime" onClick="WdatePicker({readOnly:true})" />
									
									<input type="button" class="submit btn" name="query" ng-click="vm.getCostList()" value="查询"  style="margin-left: 30px;"/>
									
									<input type="button" class="submit btn" name="query" ng-click="vm.editCost(0)" value="添加"  style="margin-left: 30px;"/>
								
									
								</li>
							</ul>
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
							<div class="panel panel-primary toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h4 class="panel-title"><i class="ec-list"></i>查询结果</h4>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>所属部门</th>
												<th>收支类型</th>
												<th>分类名称</th>
												<th>归属日期</th>
												<th>金额</th>
												<th>更新时间</th>
												<th>操作</th>
											</tr>
										</thead>  
										<tbody>
											<tr class="odd gradeX" ng-repeat="item in vm.list">
												<td><p ng-bind="item.depName"></p></td>
												<td><p ng-bind="item.costTypeName"></p></td>
												<td><p ng-bind="item.costSubName"></p></td>
												<td><p ng-bind="item.costDate"></p></td>
												<td><p ng-bind="item.costNum"></p></td>
												<td><p ng-bind="item.createDate"></p></td>
												<td>
													<input type="button" class="submit btn" name="edit" ng-click="vm.editCost(item.costId)" value="编辑"  />
													<input type="button" class="submit btn" name="del" ng-click="vm.delCost(item.costId)" value="删除"  />
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

			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
			
			<div id="dialog-save" title="成本记录" style="display:none">
			  <form>
				  <fieldset>
				    <label for="depName">部门</label>
				    <select id="depId" ng-model="dep" 
							ng-options="dep.depId as dep.name group by dep.group for dep in depList">
							<option value="">--请选择--</option>
					</select>
				    </br>
				    <label for="costType">收支</label>
				  	<select id="costType" ng-model="costType" 
							ng-options="costType.value as costType.name group by costType.group for costType in costTypeList"
							ng-change="costTypeChange()">
						<option value="">--请选择--</option>
					</select>
					</br>
				    <label for="costSubType">分类</label>
				   	<select id="costSubType" ng-model="costSubType" 
							ng-options="costSubType.costSubTypeId as costSubType.name group by costSubType.group for costSubType in costSubTypeList">
						<option value="">--请选择--</option>
					</select>
				   	</br>
				    <label for="costNum">金额</label>
				    <input type="text" name="costNum" id="costNum" value="" class="text ui-widget-content ui-corner-all" />
				    </br>
				    
				    <label for="costStartTime">日期</label>
				    <input type="text" id="costStartTime" onClick="WdatePicker({readOnly:true})" />
				     </br>
				     
				    <input type="button" class="submit btn" name="edit"  value="保存"  />
					<input type="button" class="submit btn" name="del"  value="取消"  />
				     
				  </fieldset>
			  </form>
			</div>
			
			<div id="dialog-confirm" title="删除" style="display:none">
			  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>删除后无法恢复,您确定吗？</p>
			</div>
			
		</div>
		<!-- End #content -->
	</div>
	
	<input type="hidden" id="rootUrl" value="${root}">
		
	<script src="${root}/public/js/pages/cost/script.js" type="text/javascript"></script>
	<script src="${root}/public/calendar/WdatePicker.js" type="text/javascript"></script>
	<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	
</body>
</html>