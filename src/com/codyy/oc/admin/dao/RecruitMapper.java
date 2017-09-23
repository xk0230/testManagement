package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.Recruit;

public interface RecruitMapper {
    int deleteByPrimaryKey(String id);

    int insert(Recruit record);

    int insertSelective(Recruit record);

    Recruit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Recruit record);

    int updateByPrimaryKeyWithBLOBs(Recruit record);

    int updateByPrimaryKey(Recruit record);
}