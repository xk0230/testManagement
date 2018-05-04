<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div ng-repeat="pageItem in vm.printListPage">
	<div class="row hidden" id="printDiv{{$index}}" style="width:20cm;font: 宋体;">
		<div style="width:100%;height:146mm" ng-repeat="item in pageItem.pageList track by $index">
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
