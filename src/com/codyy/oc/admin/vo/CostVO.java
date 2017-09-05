package com.codyy.oc.admin.vo;

import java.sql.Timestamp;

import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.entity.CostEntityBean;

public class CostVO extends CostEntityBean{

	private Timestamp startTime;
	
	private Timestamp endTime;
	
	private String name;
	
	private int start;
	
	private int end = 10;
	
	private String depName;
	
	private String costSubName;
	
	private String costTypeName;
	
	private String costDate = "";
	
	private String createDate = "";

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

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getCostSubName() {
		return costSubName;
	}

	public void setCostSubName(String costSubName) {
		this.costSubName = costSubName;
	}

	public String getCostTypeName() {
		if(this.getCostType() == 1){
			costTypeName = "支出";
		}else if(this.getCostType() == 0){
			costTypeName = "收入";
		}else{
			costTypeName = "";
		}
		return costTypeName;
	}

	public String getCostDate() {
		if(this.getCostTime() != null){
			costDate = DateUtils.format(this.getCostTime(),"yyyy-MM");
		}
		return costDate;
	}

	public String getCreateDate() {
		if(this.getCreateTime() != null){
			createDate = DateUtils.format(this.getCreateTime());
		}
		return createDate;
	}

}
