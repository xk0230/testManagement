package com.codyy.oc.admin.dao;

import java.util.List;
import com.codyy.oc.admin.entity.AdminPermission;
public interface AdminPermissionMapper {

	/**
	 * @author lichen
	* @Title: adminPermissionList
	* @Description: (查询复选框的所有数据)
	* @param @return    设定文件
	* @return List<AdminPermission>    返回类型
	* @throws
	 */
	public List<AdminPermission> adminPermissionList();
	
	
}
