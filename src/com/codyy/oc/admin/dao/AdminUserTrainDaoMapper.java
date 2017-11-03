package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUserTrain;

public interface AdminUserTrainDaoMapper {

	void saveUserTrain(AdminUserTrain userTrain);
	
	int updateUserTrain(AdminUserTrain userTrain);
	
	void deleteUserTrain(String id);
	
	AdminUserTrain getAdminUserTrainById(String id);
	
	List<AdminUserTrain> getAdminUserTrainPageList(Page page);
	
	List<AdminUserTrain> getAllAdminUserTrain(AdminUserTrain userTrain);
	
}
