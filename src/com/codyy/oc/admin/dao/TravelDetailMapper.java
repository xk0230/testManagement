package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.TravelDetail;

public interface TravelDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(TravelDetail record);

    int insertSelective(TravelDetail record);

    TravelDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TravelDetail record);

    int updateByPrimaryKey(TravelDetail record);
}