package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.CandidateRRecrcom;

public interface CandidateRRecrcomMapper {
    int deleteByPrimaryKey(String id);

    int insert(CandidateRRecrcom record);

    int insertSelective(CandidateRRecrcom record);

    CandidateRRecrcom selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CandidateRRecrcom record);

    int updateByPrimaryKey(CandidateRRecrcom record);
    
    int deleteByCandidate(String canId);
    
    List<CandidateRRecrcom> getAllByCandidateId(String canId);
}