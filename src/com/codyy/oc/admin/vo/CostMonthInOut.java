package com.codyy.oc.admin.vo;

import java.math.BigDecimal;


/**
 * 成本月份收入支出
 */
public class CostMonthInOut {
    
    private String name;
    
    private String month;
    
    private String type;
    
    private BigDecimal total;
    
    private String costSubId;
    
    private String costSubName;
    
    public String getCostSubId() {
		return costSubId;
	}

	public void setCostSubId(String costSubId) {
		this.costSubId = costSubId;
	}

	public String getCostSubName() {
		return costSubName;
	}

	public void setCostSubName(String costSubName) {
		this.costSubName = costSubName;
	}

	public BigDecimal getCostNum() {
		return costNum;
	}

	public void setCostNum(BigDecimal costNum) {
		this.costNum = costNum;
	}

	private BigDecimal costNum;
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}

