<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.travelTable th{border:1px solid black;}
    .travelTable td{border:1px solid black;}
    .travelTable tr{height:1cm;}
</style>
<!-- 合同打印 -->
<div class="row " style="width:20cm;" >
	<div style="width:100%;height:152mm;font: 宋体;" ng-repeat="item in vm.list" >
		<div style="width:100%;">
			<div style="font-size: 20px;font-weight: bold;text-align: center;width: 100%">出差报销单</div>
		</div>
		<table id="printtable"class="printTable travelTable" style="width:20cm;border-collapse:collapse;" cellspacing="0" cellpadding="0">
			<tr>
				<th style="background-color:#F2F2F2;width:2cm;">姓名</th>
				<th style="width:8cm"><p></p></th>
				<th style="background-color:#F2F2F2;width:2cm">部门</th>
				<th style="width:8cm"><p></p></th>
			</tr>
			<tr>
				<th style="background-color:#F2F2F2;width:2cm;">出差地</th>
				<th style="width:8cm"><p></p></th>
				<th style="background-color:#F2F2F2;width:2cm">出差日期</th>
				<th style="width:8cm"><p></p></th>
			</tr>
			<tr>
				<th style="background-color:#F2F2F2;width:2cm;">共享</th>
				<th style="width:8cm"><p></p></th>
				<th style="background-color:#F2F2F2;width:2cm">部门</th>
				<th style="width:8cm"><p></p></th>
			</tr>
			<tr>
				<th style="background-color:#F2F2F2;width:2cm;">总经办</th>
				<th style="width:8cm"><p></p></th>
				<th style="background-color:#F2F2F2;width:2cm">备注</th>
				<th style="width:8cm"><p></p></th>
			</tr>
			<tr>
				<th colspan="4" style="background-color:#F2F2F2;border-bottom:none;">费用明细</th>
			</tr>
			<tr class="odd gradeX" >
				<td colspan="4" style="border:none;">
					<table class="travelTable" style="width:100%;border-collapse:collapse;" cellspacing="0" cellpadding="0">
						<tr>
							<th>序号</th>
							<th>项目</th>
							<th>起始地</th>
							<th>目的地</th>
							<th>时间起</th>
							<th>时间止</th>
							<th>金额</th>
							<th>备注</th>
						</tr>
						<tr style="height:1cm;" ng-repeat="detailitem in item.travelDetailVOList">
							<td><p ng-bind="$index + 1"></p></td>
							<td><p ng-bind="detailitem.travelDetailTypeName"></p></td>
							<td><p ng-bind="detailitem.startPlace"></p></td>
							<td><p ng-bind="detailitem.endPlace"></p></td>
							<td><p ng-bind="detailitem.startTime | date:'yyyy-MM-dd'"></p></td>
							<td><p></p></td>
							<td><p ng-bind="detailitem.costNum"></p></td>
							<td><p ng-bind="detailitem.remark"></p></td>
						</tr>
						
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>
