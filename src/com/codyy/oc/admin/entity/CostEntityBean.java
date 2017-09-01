package com.codyy.oc.admin.entity;

import java.sql.Timestamp;

/**
 * 成本实体类
 * @author Administrator
 *
 */
public class CostEntityBean {

	private String costId;
	
	//成本记录创建时间
	private Timestamp createTime;
	
	//成本记录实际时间
	private Timestamp costTime;
	
	//创建人ID
	private String createUserId;
	
	//成本类型,0:收入，1:支出
	private int costType;
	
	//成本子类型ID
	private int costSubtypeId;
	
	//成本数目
	private double costNum;
	
	//部门ID
	private int depId;

	public String getCostId() {
		return costId;
	}

	public void setCostId(String costId) {
		this.costId = costId;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getCostTime() {
		return costTime;
	}

	public void setCostTime(Timestamp costTime) {
		this.costTime = costTime;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public int getCostType() {
		return costType;
	}

	public void setCostType(int costType) {
		this.costType = costType;
	}

	public int getCostSubtypeId() {
		return costSubtypeId;
	}

	public void setCostSubtypeId(int costSubtypeId) {
		this.costSubtypeId = costSubtypeId;
	}

	public double getCostNum() {
		return costNum;
	}

	public void setCostNum(double costNum) {
		this.costNum = costNum;
	}

	public int getDepId() {
		return depId;
	}

	public void setDepId(int depId) {
		this.depId = depId;
	}
	
}
