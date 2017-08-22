package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.AdminApp;

public interface AdminAppMapper {
	int deleteByPrimaryKey(String adminAppId);

	int insert(AdminApp record);

	int insertSelective(AdminApp record);

	AdminApp selectByPrimaryKey(String adminAppId);

	int updateByPrimaryKeySelective(AdminApp record);

	int updateByPrimaryKey(AdminApp record);
	
	int updateToHistoryByAppType(AdminApp record);
	
	int updateToCurrentVersionById(String adminAppId);
	
	public List<AdminApp> listByType(String appType);
	
	public List<AdminApp> exits(AdminApp record);
}