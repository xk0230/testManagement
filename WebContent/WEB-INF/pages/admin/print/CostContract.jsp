<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
							<th colspan="2" style="background-color:#F2F2F2;text-align: center;border-top:1px solid black;border-right:1px solid black;">付款信息(请认真核对)</th>
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
							<td style="background-color:#F2F2F2;border-top:1px solid black;border-left:1px solid black;">大写</td>
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
