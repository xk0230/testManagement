package com.codyy.oc.admin.entity;

/**
 * 成本类型
 * @author Administrator
 *
 */
public class CostSubTypeBean {
	
	private String costSubTypeId;
	
	private int costType = -1;
	
	private String name;


	public String getCostSubTypeId() {
		return costSubTypeId;
	}

	public void setCostSubTypeId(String costSubTypeId) {
		this.costSubTypeId = costSubTypeId;
	}

	public int getCostType() {
		return costType;
	}

	public void setCostType(int costType) {
		this.costType = costType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
