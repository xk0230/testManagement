package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Position;

public interface PositionMapper {
    int deleteByPrimaryKey(String postId);

    int insert(Position record);

    int insertSelective(Position record);

    Position selectByPrimaryKey(String postId);

    List<Position> selectByDepId(String depId);
    
    int updateByPrimaryKeySelective(Position record);

    int updateByPrimaryKey(Position record);
    
    List<Position> getPositionPageList(Page page);
    
}