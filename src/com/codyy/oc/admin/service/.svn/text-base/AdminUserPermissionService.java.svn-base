package com.codyy.oc.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.AdminUserPermissionMapper;
import com.codyy.oc.admin.entity.AdminUserPermission;

@Service
public class AdminUserPermissionService {

	@Autowired
	private AdminUserPermissionMapper adminUserPermissionMapper;
	
	/**
	 * @author lichen
	* @Title: insertUserPernission
	* @Description: (添加用户权限)
	* @param @param adminUserPermission
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertUserPernission(AdminUserPermission adminUserPermission){
		
		return adminUserPermissionMapper.insertUserPernission(adminUserPermission);
	}
	
	/**
	 * @author lichen
	* @Title: deleteUserPermissionById
	* @Description: (根据id来删除用户的所有权限)
	* @param @param userId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteUserPermissionById(String userId){
		
		return adminUserPermissionMapper.deleteUserPermissionById(userId);
	}
}
