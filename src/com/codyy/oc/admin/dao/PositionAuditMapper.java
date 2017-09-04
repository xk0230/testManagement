package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.PositionAudit;

public interface PositionAuditMapper {
    int deleteByPrimaryKey(String positionAuditId);

    int insert(PositionAudit record);

    int insertSelective(PositionAudit record);

    PositionAudit selectByPrimaryKey(String positionAuditId);

    int updateByPrimaryKeySelective(PositionAudit record);

    int updateByPrimaryKey(PositionAudit record);
}