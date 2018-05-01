package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUserTrain;

public interface AdminUserTrainDaoMapper {

	int saveUserTrain(AdminUserTrain userTrain);
	
	int updateUserTrain(AdminUserTrain userTrain);
	
	int deleteUserTrain(String id);
	
	AdminUserTrain getAdminUserTrainById(String id);
	
	List<AdminUserTrain> getAdminUserTrainPageList(Page page);
	
	List<AdminUserTrain> getAllAdminUserTrain(AdminUserTrain userTrain);
	
}
