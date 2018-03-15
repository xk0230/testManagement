package com.codyy.oc.admin.entity;

/**
 * 成本实体类
 * @author Administrator
 *
 */
public class CostDepEntityBean {

	private String costId;
	//部门ID
	private String costDep;
	//部门ID
	private String costDepName;
	//成本年度
	private String costYear;
	//成本
	private String costMonth;
	//成本
	private String costDate;
	//成本金额
	private double costNum = 0.00;
	
	public String getCostId() {
		return costId;
	}
	public void setCostId(String costId) {
		this.costId = costId;
	}
	public String getCostDep() {
		return costDep;
	}
	public void setCostDep(String costDep) {
		this.costDep = costDep;
	}
	public String getCostYear() {
		return costYear;
	}
	public void setCostYear(String costYear) {
		this.costYear = costYear;
	}
	public String getCostMonth() {
		return costMonth;
	}
	public void setCostMonth(String costMonth) {
		this.costMonth = costMonth;
	}
	public String getCostDate() {
		return costDate;
	}
	public void setCostDate(String costDate) {
		this.costDate = costDate;
	}
	public double getCostNum() {
		return costNum;
	}
	public void setCostNum(double costNum) {
		this.costNum = costNum;
	}
	public String getCostDepName() {
		return costDepName;
	}
	public void setCostDepName(String costDepName) {
		this.costDepName = costDepName;
	}
	
}
