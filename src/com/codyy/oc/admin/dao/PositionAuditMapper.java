package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.PositionAudit;

public interface PositionAuditMapper {
    int deleteByPrimaryKey(String positionAuditId);

    int insert(PositionAudit record);

    int insertSelective(PositionAudit record);

    PositionAudit selectByPrimaryKey(String positionAuditId);

    int updateByPrimaryKeySelective(PositionAudit record);

    int updateByPrimaryKey(PositionAudit record);
    
    int selectUnauditByid(String id);//查看该审批是否已审批过
    
    void setUnPassById(String id);//根据ID将审批岗位设为不通过
    
    int  getUnpassOrNullNum(String id);//根据id获取还未审批的和不通过的总数
    
    void passById(String id);//根据ID将岗位设为通过审批
    
    int getUntreatedNum(String userId);
    
    List<PositionAudit> getPositionAuditPageList(Page page);
}