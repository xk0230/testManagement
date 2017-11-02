package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUserTrain;

public interface AdminUserTrainDaoMapper {

	void saveUserTrain(AdminUserTrain userTrain);
	
	void updateUserTrain(AdminUserTrain userTrain);
	
	void deleteUserTrain(String trainId);
	
	List<AdminUserTrain> getAdminUserTrainPageList(Page page);
	
	List<AdminUserTrain> getAllAdminUserTrain(AdminUserTrain userTrain);
	
}
