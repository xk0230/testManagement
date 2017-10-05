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
    
    int selectUnauditByid(String id);
    
    void setUnPassById(String id);//根据ID将招聘需求设为不通过
    
    void passById(String id);//根据ID将招聘需求设为通过审批
    
    int  getUnpassOrNullNum(String id);//根据id获取还未审批的和不通过的总数
}