<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body	>
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<div id="content" ng-app = "myApp" ng-controller="IpeController as vm">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 heading">
						<h1 class="page-header"><i class="im-users2"></i> IPE试算信息</h1>
						<ul id="crumb" class="breadcrumb">
						</ul>
					</div>
				</div>
				
				
				<div class="outlet">
					<!-- Start .outlet -->
					<!-- Page start here ( usual with .row ) -->
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>IPE试算</h3>
								</div>
								<div class="panel-body">
									
									<div class="form-horizontal group-border" role="form">
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">组织规模</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.org" />
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">影响</label>
												<div class="col-lg-9">
													<select ng-model="ipe.yx"  class="form-control select2" ng-change="yxAndGxChange()">
															<option value="">--请选择--</option>
															<option value="交付">交付</option>
															<option value="操作">操作</option>
															<option value="战术">战术</option>
															<option value="战略">战略</option>
															<option value="远见">远见</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">贡献</label>
												<div class="col-lg-9">
													<select ng-model="ipe.gx"  class="form-control select2" ng-change="yxAndGxChange()">
														<option value="">--请选择--</option>
														<option value="yx,有限" >有限</option>
														<option value="bf,部分" >部分</option>
														<option value="zj,直接" >直接</option>
														<option value="xz,显著" >显著</option>
														<option value="sy,首要" >首要</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">得分</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.score1" ng-readonly="true"/>
												</div>
											</div>
											
										</div>

										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">沟通</label>
												<div class="col-lg-9">
													<select ng-model="ipe.gt"  class="form-control select2" ng-change="gtAndKjChange()">
															<option value="">--请选择--</option>
															<option value="传达" >传达</option>
															<option value="传达-交互" >传达-交互</option>
															<option value="交互" >交互</option>
															<option value="交互-影响" >交互-影响</option>
															<option value="影响" >影响</option>
															<option value="影响-谈判" >影响-谈判</option>
															<option value="谈判" >谈判</option>
															<option value="谈判-长期影响的谈判" >谈判-长期影响的谈判</option>
															<option value="长期影响的谈判" >长期影响的谈判</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">框架</label>
												<div class="col-lg-9">
													<select ng-model="ipe.kj"  class="form-control select2" ng-change="gtAndKjChange()">
														<option value="">--请选择--</option>
														<option value="a,内部共享" >内部共享</option>
														<option value="b,外部共享" >外部共享</option>
														<option value="c,内部分歧" >内部分歧</option>
														<option value="d,外部分歧" >外部分歧</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">得分</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.score2" ng-readonly="true"/>
												</div>
											</div>
											
										</div>

										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">创新</label>
												<div class="col-lg-9">
													<select ng-model="ipe.cx"  class="form-control select2" ng-change="cxAndFzdChange()">
															<option value="">--请选择--</option>
															<option value="跟从">跟从</option>
															<option value="跟从-核查">跟从-核查</option>
															<option value="核查">核查</option>
															<option value="核查-改进">核查-改进</option>
															<option value="改进">改进</option>
															<option value="改进-提高">改进-提高</option>
															<option value="提高">提高</option>
															<option value="提高-概念化">提高-概念化</option>
															<option value="创造/概念化">创造/概念化</option>
															<option value="概念化-技术突破">概念化-技术突破</option>
															<option value="科学的/技术的突破">科学的/技术的突破</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">复杂度</label>
												<div class="col-lg-9">
													<select ng-model="ipe.fzd"  class="form-control select2" ng-change="cxAndFzdChange()">
														<option value="">--请选择--</option>
														<option value="a,明确的" >明确的</option>
														<option value="b,明确-复杂" >明确-复杂</option>
														<option value="c,困难的" >困难的</option>
														<option value="d,困难-符合" >困难-符合</option>
														<option value="e,复合的" >复合的</option>
														<option value="f,复合-多维" >复合-多维</option>
														<option value="g,多维的" >多维的</option>
													</select>
												</div>
											</div>
												
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">得分</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.score3" ng-readonly="true"/>
												</div>
											</div>
											
										</div>

										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">知识</label>
												<div class="col-lg-9">
													<select ng-model="ipe.zs"  class="form-control select2" ng-change="zsAndTdChange()">
															<option value="">--请选择--</option>
															<option value="有限职位知识">有限职位知识</option>
															<option value="有限-基本">有限-基本</option>
															<option value="基本职位知识">基本职位知识</option>
															<option value="基本-宽泛">基本-宽泛</option>
															<option value="宽泛岗位知识">宽泛岗位知识</option>
															<option value="宽泛-专门">宽泛-专门</option>
															<option value="专门技术知识">专门技术知识</option>
															<option value="专门技术-专门标准">专门技术-专门标准</option>
															<option value="专门标准知识">专门标准知识</option>
															<option value="专门标准-职能专才/组织通才">专门标准-职能专才/组织通才</option>
															<option value="职能专才/组织通才">职能专才/组织通才</option>
															<option value="职能专才/组织通才-职能杰出/宽泛实践经验">职能专才/组织通才-职能杰出/宽泛实践经验</option>
															<option value="职能杰出/宽泛实践经验">职能杰出/宽泛实践经验</option>
															<option value="职能杰出/宽泛实践经验-广博">职能杰出/宽泛实践经验-广博</option>
															<option value="广博而深入的实践经验">广博而深入的实践经验</option>
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">团队宽度</label>
												<div class="col-lg-9">
													<select ng-model="ipe.td"  class="form-control select2" ng-change="zsAndTdChange()">
														<option value="">--请选择--</option>
														<option value="a,团队成员-本土" >团队成员-本土</option>
														<option value="b,团队成员-地区" >团队成员-地区</option>
														<option value="c,团队成员-全球" >团队成员-全球</option>													
														<option value="d,成员-领导-本土" >成员-领导-本土</option>
														<option value="e,成员-领导-地区" >成员-领导-地区</option>													
														<option value="f,成员-领导-全球" >成员-领导-全球</option>
														<option value="g,团队领导-本土" >团队领导-本土</option>
														<option value="h,团队领导-地区" >团队领导-地区</option>													
														<option value="i,团队领导-全球" >团队领导-全球</option>
														<option value="j,领导-多团队-本土" >领导-多团队-本土</option>
														<option value="k,领导-多团队-地区" >领导-多团队-地区</option>
														<option value="l,领导-多团队-全球" >领导-多团队-全球</option>
														<option value="m,多团队领导-本土" >多团队领导-本土</option>
														<option value="n,多团队领导-地区" >多团队领导-地区</option>
														<option value="o,多团队领导-全球" >多团队领导-全球</option>														
													</select>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">得分</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.score4" ng-readonly="true"/>
												</div>
											</div>
											
										</div>
										
										<div class="form-group">
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">总得分</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.totalScore" ng-readonly="true"/>
												</div>
											</div>
											
											<div class="col-lg-3">
												<label class="col-lg-3 control-label">PC等级</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.pc" ng-readonly="true"/>
												</div>
											</div>

											<div class="col-lg-3">
												<label class="col-lg-3 control-label">建议年薪</label>
												<div class="col-lg-9">
													<input type="text" class="form-control" ng-model="ipe.adviseSalary" ng-readonly="true"/>
												</div>
											</div>
											
										</div>

									</div>
								</div>		
													
								</div>

						</div>
						<!-- col-lg-12 end here -->
					</div>
					<!-- Page End here -->
				</div>
				<!-- End .outlet -->
			</div>

			</div>
			<!-- End .content-wrapper -->
			<div class="clearfix"></div>
	
		</div>
		
	<input type="hidden" id="rootUrl" value="${root}">
	
	<script src="${root}/public/js/pages/ipe/trail.js" type="text/javascript"></script>
</body>
</html>