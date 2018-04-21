package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.TravelDetailType;

public interface TravelDetailTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TravelDetailType record);

    int insertSelective(TravelDetailType record);

    TravelDetailType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TravelDetailType record);

    int updateByPrimaryKey(TravelDetailType record);
}