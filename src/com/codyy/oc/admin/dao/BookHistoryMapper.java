package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.BookHistory;

public interface BookHistoryMapper {
    int deleteByPrimaryKey(String id);

    int insert(BookHistory record);

    int insertSelective(BookHistory record);

    BookHistory selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(BookHistory record);

    int updateByPrimaryKey(BookHistory record);
    
    List<BookHistory> selectAll(BookHistory record);
}