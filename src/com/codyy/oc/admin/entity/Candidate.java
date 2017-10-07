package com.codyy.oc.admin.entity;

import java.util.Date;
import java.util.List;

public class Candidate {
    private String id;

    private String name;

    private String recruitId;

    private String pdpSjA;

    private String pdpSjB;

    private String pdpSjC;

    private String pdpSjD;

    private String pdpNjA;

    private String pdpNjB;

    private String pdpNjC;

    private String pdpNjD;

    private String wordScore;

    private String skillScore;

    private String edu;

    private String other;

    private String evaluating;

    private String sort;

    private Date createTime;

    private String pc;
    
    private List<CandidateRRecrcom> crrs;//胜任特征总评

    public List<CandidateRRecrcom> getCrrs() {
		return crrs;
	}

	public void setCrrs(List<CandidateRRecrcom> crrs) {
		this.crrs = crrs;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRecruitId() {
        return recruitId;
    }

    public void setRecruitId(String recruitId) {
        this.recruitId = recruitId;
    }

    public String getPdpSjA() {
        return pdpSjA;
    }

    public void setPdpSjA(String pdpSjA) {
        this.pdpSjA = pdpSjA;
    }

    public String getPdpSjB() {
        return pdpSjB;
    }

    public void setPdpSjB(String pdpSjB) {
        this.pdpSjB = pdpSjB;
    }

    public String getPdpSjC() {
        return pdpSjC;
    }

    public void setPdpSjC(String pdpSjC) {
        this.pdpSjC = pdpSjC;
    }

    public String getPdpSjD() {
        return pdpSjD;
    }

    public void setPdpSjD(String pdpSjD) {
        this.pdpSjD = pdpSjD;
    }

    public String getPdpNjA() {
        return pdpNjA;
    }

    public void setPdpNjA(String pdpNjA) {
        this.pdpNjA = pdpNjA;
    }

    public String getPdpNjB() {
        return pdpNjB;
    }

    public void setPdpNjB(String pdpNjB) {
        this.pdpNjB = pdpNjB;
    }

    public String getPdpNjC() {
        return pdpNjC;
    }

    public void setPdpNjC(String pdpNjC) {
        this.pdpNjC = pdpNjC;
    }

    public String getPdpNjD() {
        return pdpNjD;
    }

    public void setPdpNjD(String pdpNjD) {
        this.pdpNjD = pdpNjD;
    }

    public String getWordScore() {
        return wordScore;
    }

    public void setWordScore(String wordScore) {
        this.wordScore = wordScore;
    }

    public String getSkillScore() {
        return skillScore;
    }

    public void setSkillScore(String skillScore) {
        this.skillScore = skillScore;
    }

    public String getEdu() {
        return edu;
    }

    public void setEdu(String edu) {
        this.edu = edu;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getEvaluating() {
        return evaluating;
    }

    public void setEvaluating(String evaluating) {
        this.evaluating = evaluating;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getPc() {
        return pc;
    }

    public void setPc(String pc) {
        this.pc = pc;
    }
}