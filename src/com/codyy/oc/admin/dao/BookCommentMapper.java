package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.BookComment;

public interface BookCommentMapper {
    int deleteByPrimaryKey(String id);

    int insert(BookComment record);

    int insertSelective(BookComment record);

    BookComment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(BookComment record);

    int updateByPrimaryKey(BookComment record);
}