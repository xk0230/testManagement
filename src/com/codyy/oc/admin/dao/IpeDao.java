package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.IpeBean;

public interface IpeDao {
	
	String getOrganizationalSize();

	int insertIpe(IpeBean ipe);

	int updateIpe(IpeBean ipe);

	IpeBean getIpeById(String id);
	
	List<IpeBean> getIpeByUserId(String id);
	
}
