package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Candidate;

public interface CandidateMapper {
    int deleteByPrimaryKey(String id);

    int insert(Candidate record);

    int insertSelective(Candidate record);

    Candidate selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Candidate record);

    int updateByPrimaryKeyWithBLOBs(Candidate record);

    int updateByPrimaryKey(Candidate record);
    
    List<Candidate> getCandidatePageList(Page page);
}