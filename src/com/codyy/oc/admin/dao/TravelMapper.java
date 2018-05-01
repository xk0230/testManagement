package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Travel;
import com.codyy.oc.admin.vo.TravelVO;

public interface TravelMapper {
    int deleteByPrimaryKey(String id);

    int insert(Travel record);

    int insertSelective(Travel record);

    Travel selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Travel record);

    int updateByPrimaryKey(Travel record);
    
    List<Travel> getAll();
    
    List<TravelVO> getTravelPageList(Page page);
    
	List<TravelVO> getTravelAuditPageList(Page page);
	
	List<TravelVO> getTravelViewPageList(Page page);
    
	int updateTravelStatus(Travel record);
	
	TravelVO getById(String id);
}