package com.codyy.oc.admin.entity;

import java.util.Date;

public class PositionAudit {
    private String positionAuditId;

    private String positionId;

    private String auditUserId;

    private String createUserId;

    private Integer result;

    private Date auditTime;

    private Date createTime;
    
    private String postName;
    
    private String createUserName;
    
    private String auditUserName;
    
    private String depName;
    
    private String postResult;//整个岗位的最终审批结果
    
    private String resultName;
    
    private String name;
    
    private Integer organization;
    

    public Integer getOrganization() {
		return organization;
	}

	public void setOrganization(Integer organization) {
		this.organization = organization;
	}

	public String getName() {
		return postName;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getResultName() {
    	if (null==result||0==result) {
			return "未审批";
		}else if (1==result) {
			return "已通过";
		}else if (-1==result) {
			return "已拒绝";
		}
		return resultName;
	}

	public void setResultName(String resultName) {
		this.resultName = resultName;
	}

	public String getPostResult() {
		return postResult;
	}

	public void setPostResult(String postResult) {
		this.postResult = postResult;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public String getCreateUserName() {
		return createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

	public String getAuditUserName() {
		return auditUserName;
	}

	public void setAuditUserName(String auditUserName) {
		this.auditUserName = auditUserName;
	}

	public String getPositionAuditId() {
        return positionAuditId;
    }

    public void setPositionAuditId(String positionAuditId) {
        this.positionAuditId = positionAuditId;
    }

    public String getPositionId() {
        return positionId;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public String getAuditUserId() {
        return auditUserId;
    }

    public void setAuditUserId(String auditUserId) {
        this.auditUserId = auditUserId;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}