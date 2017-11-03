package com.codyy.oc.admin.entity;

import java.util.Date;
import java.util.List;

public class CandidateRInterviewer {
    private String id;

    private String candidateId;

    private String interviewerId;

    private Date interviewTime;

    private String place;

    private String wordScore;

    private String skillScore;

    private String interviewDetail;

    private String workDetail;

    private String skillDetail;
    
    private String interviewerName;
    
    private String interviewerPostId;
    
    private String interviewerDepId;
    
    private String candidateName;//候选人名称
    
    private String positionName;//岗位名称
    
    private List<CandidateRRecrcom> crrs;//胜任特征
    
    public List<CandidateRRecrcom> getCrrs() {
		return crrs;
	}

	public void setCrrs(List<CandidateRRecrcom> crrs) {
		this.crrs = crrs;
	}

	public String getCandidateName() {
		return candidateName;
	}

	public void setCandidateName(String candidateName) {
		this.candidateName = candidateName;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public String getInterviewerName() {
		return interviewerName;
	}

	public void setInterviewerName(String interviewerName) {
		this.interviewerName = interviewerName;
	}

	public String getInterviewerPostId() {
		return interviewerPostId;
	}

	public void setInterviewerPostId(String interviewerPostId) {
		this.interviewerPostId = interviewerPostId;
	}

	public String getInterviewerDepId() {
		return interviewerDepId;
	}

	public void setInterviewerDepId(String interviewerDepId) {
		this.interviewerDepId = interviewerDepId;
	}

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

    public String getInterviewerId() {
        return interviewerId;
    }

    public void setInterviewerId(String interviewerId) {
        this.interviewerId = interviewerId;
    }

    public Date getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(Date interviewTime) {
        this.interviewTime = interviewTime;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
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

    public String getInterviewDetail() {
        return interviewDetail;
    }

    public void setInterviewDetail(String interviewDetail) {
        this.interviewDetail = interviewDetail;
    }

    public String getWorkDetail() {
        return workDetail;
    }

    public void setWorkDetail(String workDetail) {
        this.workDetail = workDetail;
    }

    public String getSkillDetail() {
        return skillDetail;
    }

    public void setSkillDetail(String skillDetail) {
        this.skillDetail = skillDetail;
    }
}