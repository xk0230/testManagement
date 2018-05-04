package com.codyy.oc.admin.vo;

import com.codyy.oc.admin.entity.CostEntityBean;

public class CostChartVO extends CostEntityBean{

	private String depName; 
	
	private String costMonth;

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getCostMonth() {
		return costMonth;
	}

	public void setCostMonth(String costMonth) {
		this.costMonth = costMonth;
	}


}
