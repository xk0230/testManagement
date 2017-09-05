package com.codyy.oc.admin.vo;

import java.sql.Timestamp;

import com.codyy.oc.admin.entity.CostEntityBean;

public class CostVO extends CostEntityBean{

	private Timestamp startTime;
	
	private Timestamp endTime;
	
	//成本类型名称
	private String name;

	public Timestamp getStartTime() {
		return startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
