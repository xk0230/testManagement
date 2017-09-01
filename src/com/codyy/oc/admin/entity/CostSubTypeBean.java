package com.codyy.oc.admin.entity;

/**
 * 成本类型
 * @author Administrator
 *
 */
public class CostSubTypeBean {
	
	private int costSubTypeId;
	
	private int castType = -1;
	
	private String name;

	public int getCostSubTypeId() {
		return costSubTypeId;
	}

	public void setCostSubTypeId(int costSubTypeId) {
		this.costSubTypeId = costSubTypeId;
	}

	public int getCastType() {
		return castType;
	}

	public void setCastType(int castType) {
		this.castType = castType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
