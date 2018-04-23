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
															<button type="button" class="btn btn-small btn-invert" ng-click="vm.bookHis(item.userId,'.outlet')" style="color:green;font-weight: 500;">Library</button>
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
								</div></div>
				
</div>
<script type="text/ng-template" id="myAuditDetailContent.html">
			<div class="modal-header">
				<div class="row ">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i>图书借阅记录</h1>
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
									<h3 class="panel-title"><i class="ec-pencil"></i>借阅详情</h3>
								</div>
								<div class="panel-body">
									<div class="panel-body">
									<table class="table display" id="datatable">
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
									<div class="g-no-content" ng-if="vm.list && vm.list.length === 0">没有相关数据</div>
									 <%@ include file="../../common/page.jsp"%> 
								</div>
									</div>
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


	<script type="text/javascript">
/* 	 $(document).ready(function(){
		$("#addOrgUser").click(function(){
			Win.open({id:"addOrgUserWin",url:"${root}/admin/adminuser/toaddadminuser.html",title:"新增账号",width:600,height:450,mask:true});
		});
		var splitPage;
	});
	
	function getUserType(adminFlag){
		if('Y' == adminFlag){
			return '超级管理员';
		}else{
			return '用户';
		}
	}
	function getState(locked){
		if('Y' == locked){
			return '关闭';
		}else{
			return '开启';
		}
	}
	
	function deleteOrgUser(id){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/adminuser/",{'adminUserId':id},function(data){
				if(data){
					if(data.result){
						Win.alert('删除成功');
						splitPage.reload();
					}else{
						Win.alert('删除失败！');
					}
				}else{
					Win.alert('删除失败！');
				}
			});
		},function(){});
	}
	
	function editOrgUser(baseUserId){
		Win.open({id:"addOrgUserWin",url:"${root}/admin/adminuser/getselbyid.do?userId="+baseUserId,title:"编辑账号",width:600,height:450,mask:true});
	}
	
	function orgUserImport(){
		Win.open({id:"uploadExcel",width:500,height:260,title:"批量导入机构用户",url:"${root}/admin/commons/importUserPage.do?userType=area",mask:true});
	} */
	</script>

	
	<script src="${root}/public/js/pages/administrator/script.js" type="text/javascript"></script>
	<script type="text/javascript" src="${root}/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root}/public/highcharts/modules/exporting.js"></script>
</div></body>
</html>
