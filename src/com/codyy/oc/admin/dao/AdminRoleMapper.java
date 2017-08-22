package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminRole;
import com.codyy.oc.admin.entity.AdminRolePermission;

/**
 * 
 * ClassName:BaseUserMapper
 * Function: 用户管理数据操作
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月23日		上午10:08:54
 *
 */
public interface AdminRoleMapper {
	
	/**
	 * 
	 * insertBaseUser:(新增角色)
	 *
	 * @param baseUser
	 * @return
	 * @author zhangtian
	 */
	public Integer insertAdminRole(AdminRole adminRole) ;
	
	/**
	 * 
	 * insertAdminRolePermission:(维护角色关联表)
	 *
	 * @param adminRolePermissions
	 * @return
	 * @author zhangtian
	 */
	public Integer insertAdminRolePermission(List<AdminRolePermission> adminRolePermissions) ;
	
	/**
	 * 
	 * deleteBaseUserById:(根据主键id删除用户)
	 *
	 * @param baseUserId
	 * @return
	 * @author zhangtian
	 */
	public Integer deleteAdminRoleById(String adminRoleId);
	
	/**
	 * 
	 * updateBaseUser:(更新用户)
	 *
	 * @param baseUser
	 * @return
	 * @author zhangtian
	 */
	public Integer updateAdminRole(AdminRole adminRole) ;
	
	public Integer deleteAdminRolePermission(String adminRoleId) ;
	
	/**
	 * 
	 * findBaseUserById:(根据id查询用户)
	 *
	 * @param id
	 * @return
	 * @author zhangtian
	 */
	public AdminRole findAdminRoleById(String adminRoleId) ;
	
	/**
	 * 
	 * findAdminRolePermissionByRoldId:(查询角色所属的权限)
	 *
	 * @param adminRoleId
	 * @return
	 * @author zhangtian
	 */
	public List<AdminRolePermission> findAdminRolePermissionByRoldId(String adminRoleId) ;
	
	/**
	 * 
	 * selectPageList:(分页条件查询用户信息)
	 *
	 * @param page
	 * @return
	 * @author zhangtian
	 */
	public List<AdminRole> findPageList(Page page);

	/**
	 * 
	 * findAllAdminRole:(查询后台所有角色)
	 *
	 * @return
	 * @author zhangtian
	 */
	public List<AdminRole> findAllAdminRole();
	
	/**
	 * 
	 * findAllGroupPermission:(查询所有分组权限)
	 *
	 * @return
	 * @author zhangtian
	 */
	public List<AdminRolePermission> findAllGroupPermission() ;
	
	/**
	 * 
	 * findAdminUserExist:(查询角色下是否挂载了用户)
	 *
	 * @param adminRoleId
	 * @return
	 * @author zhangtian
	 */
	public Integer findAdminUserExist(String adminRoleId) ;

	/**
	 * 
	 * checkAdminRoleName:(角色名称唯一性校验)
	 *
	 * @param adminRoleName
	 * @return
	 * @author zhangtian
	 */
	public Integer checkAdminRoleName(String adminRoleName);

}