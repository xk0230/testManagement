package com.codyy.oc.admin.entity;

import java.util.Date;
import java.util.List;

public class Recruit {
    private String id;

    private String depId;
    
    private String postid;

    private Date createTime;

    private String education;

    private String createUser;

    private String status;

    private String auditUser;

    private String recruitA;

    private String recruitB;

    private String recruitC;

    private String recruitD;

    private String recruitE;

    private String recruitF;

    private String educationRemark;

    private String professional;
    
    private List<Competency> competencys;//胜任特征
    
    private String competencysStr;//胜任特征字符串，用于前台解析
    
    private String postName;//岗位名称
    
    private String createUserName;//创建人姓名
    
    private String editUserPosition;//提交审批角色
    
	public String getEditUserPosition() {
		return editUserPosition;
	}

	public void setEditUserPosition(String editUserPosition) {
		this.editUserPosition = editUserPosition;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
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

	public String getCompetencysStr() {
		return competencysStr;
	}

	public void setCompetencysStr(String competencysStr) {
		this.competencysStr = competencysStr;
	}

	public List<Competency> getCompetencys() {
		return competencys;
	}

	public void setCompetencys(List<Competency> competencys) {
		this.competencys = competencys;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPostid() {
        return postid;
    }

    public void setPostid(String postid) {
        this.postid = postid;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAuditUser() {
        return auditUser;
    }

    public void setAuditUser(String auditUser) {
        this.auditUser = auditUser;
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
}