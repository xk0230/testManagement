package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.AdminUserDetail;

public interface AdminUserDetailMapper {
    int deleteByPrimaryKey(String userDetailId);

    int insert(AdminUserDetail record);

    int insertSelective(AdminUserDetail record);

    AdminUserDetail selectByPrimaryKey(String userDetailId);

    int updateByPrimaryKeySelective(AdminUserDetail record);

    int updateByPrimaryKey(AdminUserDetail record);
}