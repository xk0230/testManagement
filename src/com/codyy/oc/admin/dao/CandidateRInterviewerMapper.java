package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.CandidateRInterviewer;

public interface CandidateRInterviewerMapper {
    int deleteByPrimaryKey(String id);

    int insert(CandidateRInterviewer record);

    int insertSelective(CandidateRInterviewer record);

    CandidateRInterviewer selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CandidateRInterviewer record);

    int updateByPrimaryKeyWithBLOBs(CandidateRInterviewer record);

    int updateByPrimaryKey(CandidateRInterviewer record);
}