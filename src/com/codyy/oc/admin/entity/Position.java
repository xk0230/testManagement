package com.codyy.oc.admin.entity;

import java.util.Date;

import com.codyy.commons.CommonsConstant;

public class Position {
    private String postId;

    private String name;

    private String depId;

    private String onDuty;//在岗

    private String organization;//编制

    private String vacancy;//空缺

    private String remark;

    private String status;

    private String createUser;
    
    private Date createTime;
    
    private String depName;
    
    private String createUserName;

    private String statusName;
    
    private String recruitA;

    private String recruitB;

    private String recruitC;

    private String recruitD;

    private String recruitE;

    private String recruitF;
    
    private String salaryScale;
    
    private String onlykq;
    
    private String educationRemark;

    private String professional;
    
    private String education;
    
	public String getEducationRemark() {
		return educationRemark;
	}

	public void setEducationRemark(String educationRemark) {
		this.educationRemark = educationRemark;
	}

	public String getProfessional() {
		return professional;
	}

	public void setProfessional(String professional) {
		this.professional = professional;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getOnlykq() {
		return onlykq;
	}

	public void setOnlykq(String onlykq) {
		this.onlykq = onlykq;
	}

	public String getSalaryScale() {
		return salaryScale;
	}

	public void setSalaryScale(String salaryScale) {
		this.salaryScale = salaryScale;
	}

	public String getRecruitA() {
		return recruitA;
	}

	public void setRecruitA(String recruitA) {
		this.recruitA = recruitA;
	}

	public String getRecruitB() {
		return recruitB;
	}

	public void setRecruitB(String recruitB) {
		this.recruitB = recruitB;
	}

	public String getRecruitC() {
		return recruitC;
	}

	public void setRecruitC(String recruitC) {
		this.recruitC = recruitC;
	}

	public String getRecruitD() {
		return recruitD;
	}

	public void setRecruitD(String recruitD) {
		this.recruitD = recruitD;
	}

	public String getRecruitE() {
		return recruitE;
	}

	public void setRecruitE(String recruitE) {
		this.recruitE = recruitE;
	}

	public String getRecruitF() {
		return recruitF;
	}

	public void setRecruitF(String recruitF) {
		this.recruitF = recruitF;
	}

	public String getStatusName() {
		if(status == null) {
			return null;
		}else if (CommonsConstant.AUDIT_STATUS_AUDITED.equals(status)) {
			return "审批通过";
		}else if (CommonsConstant.AUDIT_STATUS_AUDITING.equals(status)) {
			return "审批中";
		}else if (CommonsConstant.AUDIT_STATUS_REJECT.equals(status)) {
			return "审批拒绝";
		}
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getCreateUserName() {
		return createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepId() {
        return depId;
    }

    public void setDepId(String depId) {
        this.depId = depId;
    }

    public String getOnDuty() {
        return onDuty;
    }

    public void setOnDuty(String onDuty) {
        this.onDuty = onDuty;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public String getVacancy() {
        return vacancy;
    }

    public void setVacancy(String vacancy) {
        this.vacancy = vacancy;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}