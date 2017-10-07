package com.codyy.oc.admin.entity;

public class CandidateRRecrcom {
    private String id;

    private String candidateId;

    private String recRComId;

    private String competencyId;
    
    private String recruitId;
    
    public String getCompetencyId() {
		return competencyId;
	}

	public void setCompetencyId(String competencyId) {
		this.competencyId = competencyId;
	}

	public String getRecruitId() {
		return recruitId;
	}

	public void setRecruitId(String recruitId) {
		this.recruitId = recruitId;
	}

	private String value;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(String candidateId) {
        this.candidateId = candidateId;
    }

    public String getRecRComId() {
        return recRComId;
    }

    public void setRecRComId(String recRComId) {
        this.recRComId = recRComId;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}