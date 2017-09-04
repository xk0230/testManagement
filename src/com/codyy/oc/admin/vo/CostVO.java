package com.codyy.oc.admin.vo;

import java.sql.Timestamp;

import com.codyy.oc.admin.entity.CostEntityBean;

public class CostVO extends CostEntityBean{

	private Timestamp startTime;
	
	private Timestamp endTime;
	

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
	
}
