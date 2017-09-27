<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>

</head>
<body  >
		<%@ include file="../../common/header.jsp"%>
		<%@ include file="../../common/side.jsp"%>
		<!-- Start #content -->
		<div id="content">
			<!-- Start .content-wrapper -->
			<div class="content-wrapper">
				<!-- End .row -->
				<div class="outlet">
					<div class="row">
						<div class="col-lg-12">
							<!-- col-lg-12 start here -->
							<div class="panel panel-default toggle">
								<!-- Start .panel -->
								<div class="panel-heading">
									<h3 class="panel-title"><i class="ec-list"></i>标准岗位等级分布表</h3>
								</div>
								<div class="panel-body">
									<table class="table display" id="datatable">
										<thead>
											<tr>
												<th>PC等级</th>
												
												<c:if test="${deptPostLevels != null }">
													<c:forEach var="dep" items="${deptPostLevels }">
														<th>${dep.depName }</th>
													</c:forEach>
												</c:if>
												
											</tr>
										</thead>  
										<tbody>
											
											<c:forEach varStatus="pc" begin="1" end="100">
											
												<tr class="odd gradeX">
												
													<td>${pc.index}</td>
												
													<c:if test="${deptPostLevels != null }">
														<c:forEach var="dep" items="${deptPostLevels }" >
															<td> 
																<c:forEach var="depPostLevel" items="${dep.postLevels }">
																	
																	<c:if test="${pc.index == depPostLevel.salaryScale }">
																		${depPostLevel.postName } </br>
																	</c:if>
																	
																</c:forEach>
															</td>
														</c:forEach>
													</c:if>

												</tr>
												
											</c:forEach>
											
										</tbody>
									</table>
									
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
		</div>
		<!-- End #content -->
		
	</div>

</body>
</html>