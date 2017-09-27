package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.RecruitAudit;

public interface RecruitAuditMapper {
    int deleteByPrimaryKey(String id);

    int insert(RecruitAudit record);

    int insertSelective(RecruitAudit record);

    RecruitAudit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RecruitAudit record);

    int updateByPrimaryKey(RecruitAudit record);
    
    Integer getMaxRecruitNumByRecId(String recId);
}