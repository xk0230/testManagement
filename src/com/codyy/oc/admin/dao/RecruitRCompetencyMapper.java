package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.RecruitRCompetency;

public interface RecruitRCompetencyMapper {
    int deleteByPrimaryKey(String id);
    
    int deleteByRecId(String recruitId);

    int insert(RecruitRCompetency record);

    int insertSelective(RecruitRCompetency record);

    RecruitRCompetency selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RecruitRCompetency record);

    int updateByPrimaryKey(RecruitRCompetency record);
    
    String selectByRecCom(RecruitRCompetency record);
    
}