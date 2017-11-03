package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.Achievements;

public interface AchievementsMapper {
    int deleteByPrimaryKey(String id);

    int insert(Achievements record);

    int insertSelective(Achievements record);

    Achievements selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Achievements record);

    int updateByPrimaryKey(Achievements record);
}