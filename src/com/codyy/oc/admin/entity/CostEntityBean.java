package com.codyy.oc.admin.entity;

import java.util.Date;

/**
 * 成本实体类
 * @author Administrator
 *
 */
public class CostEntityBean {

	private String costId;
	
	//成本记录创建时间
	private Date createTime;
	
	//成本记录实际时间
	private Date costTime;
	
	//创建人ID
	private String createUserId;
	
	//成本类型,0:收入，1:支出
	private String costType ;
	
	//成本子类型ID
	private String costSubtypeId;
	
	//成本数目
	private double costNum = 0.00;
	
	//部门ID
	private String depId;

	public String getCostId() {
		return costId;
	}

	public void setCostId(String costId) {
		this.costId = costId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getCostTime() {
		return costTime;
	}

	public void setCostTime(Date costTime) {
		this.costTime = costTime;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public String getCostType() {
		return costType;
	}

	public void setCostType(String costType) {
		this.costType = costType;
	}

	public String getCostSubtypeId() {
		return costSubtypeId;
	}

	public void setCostSubtypeId(String costSubtypeId) {
		this.costSubtypeId = costSubtypeId;
	}

	public double getCostNum() {
		return costNum;
	}

	public void setCostNum(double costNum) {
		this.costNum = costNum;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}
	
}
