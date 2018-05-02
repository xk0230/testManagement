package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.TravelDetail;
import com.codyy.oc.admin.vo.TravelDetailVO;

public interface TravelDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(TravelDetail record);

    int insertSelective(TravelDetail record);

    TravelDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TravelDetail record);

    int updateByPrimaryKey(TravelDetail record);
    
    List<TravelDetailVO> getTravelDetailPageList(Page page);
    
    List<TravelDetailVO> getTravelDetailList(String travelId);
}