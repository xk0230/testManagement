<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	<!-- Start #content -->
	<div id="content">
		  <div class="main-inner">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="widget">
							<!-- 标题 -->
							<div class="widget-header">
								<i class="icon-pushpin"></i>
								<h3>标准岗位等级分布表</h3>
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
										<c:set var="tmpIndex" value="70"></c:set>
										<c:forEach varStatus="pc" begin="40" end="70" >
											<tr class="odd gradeX">
												<td>${tmpIndex }</td>
												<c:if test="${deptPostLevels != null }">
													<c:forEach var="dep" items="${deptPostLevels }" >
														<td> 
															<c:forEach var="depPostLevel" items="${dep.postLevels }">
																<c:if test="${tmpIndex == depPostLevel.salaryScale }">
																	${depPostLevel.postName } </br>
																</c:if>
															</c:forEach>
														</td>
													</c:forEach>
												</c:if>
											</tr>
											<c:set var="tmpIndex" value="${tmpIndex-1 }"></c:set>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>