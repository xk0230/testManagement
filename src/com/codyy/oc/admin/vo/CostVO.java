package com.codyy.oc.admin.vo;

import java.sql.Timestamp;
import java.util.List;

import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.entity.Contract;
import com.codyy.oc.admin.entity.CostDepEntityBean;
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
	
	private String startDate;
    
    private String endDate;
    
    private String UserId;
    
    private String editMode;
    
    private String costNo;
    
	private String status;
	
	private String statusName;
	
	private String depId;
	
	private String auditUser;
	
	private String auditUserName;
	
	private String subUser;
	
	private String subUserName;
	
	private String contractId;
	
	private String contractContent;
	
	private String remark;
	
	private String createUserPosition;
	
	private Contract contract;
	

	public String getCreateUserPosition() {
		return createUserPosition;
	}

	public void setCreateUserPosition(String createUserPosition) {
		this.createUserPosition = createUserPosition;
	}

	private List<CostDepEntityBean> costDepList;
	
    public String getCostNo() {
		return costNo;
	}

	public void setCostNo(String costNo) {
		this.costNo = costNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getEditMode() {
		return editMode;
	}

	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}

	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

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
		if(this.getCostType().equals("1")){
			costTypeName = "支出";
		}else if(this.getCostType().equals("0")){
			costTypeName = "收入";
		}else{
			costTypeName = "";
		}
		return costTypeName;
	}

	public String getCostDate() {
		if(this.getCostTime() != null){
			costDate = DateUtils.format(this.getCostTime(),DateUtils.PATTERN_DATE);
		}
		return costDate;
	}

	public String getCreateDate() {
		if(this.getCreateTime() != null){
			createDate = DateUtils.format(this.getCreateTime());
		}
		return createDate;
	}

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public String getAuditUser() {
		return auditUser;
	}

	public void setAuditUser(String auditUser) {
		this.auditUser = auditUser;
	}

	public String getAuditUserName() {
		return auditUserName;
	}

	public void setAuditUserName(String auditUserName) {
		this.auditUserName = auditUserName;
	}

	public String getSubUser() {
		return subUser;
	}

	public void setSubUser(String subUser) {
		this.subUser = subUser;
	}

	public String getSubUserName() {
		return subUserName;
	}

	public void setSubUserName(String subUserName) {
		this.subUserName = subUserName;
	}

	public List<CostDepEntityBean> getCostDepList() {
		return costDepList;
	}

	public void setCostDepList(List<CostDepEntityBean> costDepList) {
		this.costDepList = costDepList;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getContractContent() {
		return contractContent;
	}

	public void setContractContent(String contractContent) {
		this.contractContent = contractContent;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

}
