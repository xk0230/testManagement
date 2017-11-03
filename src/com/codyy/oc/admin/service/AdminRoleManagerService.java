package com.codyy.oc.admin.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MultiMap;
import org.apache.commons.collections.map.MultiValueMap;
import org.json.JSONStringer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.dao.AdminRoleMapper;
import com.codyy.oc.admin.entity.AdminRole;
import com.codyy.oc.admin.entity.AdminRolePermission;


/**
 * 
 * ClassName:UserManagerService
 * Function: 用户管理业务控制
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月23日		上午9:55:50
 *
 */
@Service
public class AdminRoleManagerService {

	@Autowired
	private AdminRoleMapper adminRoleMapper ;
	
	/**
	 * 
	 * insertAdminRole:(插入角色)
	 *
	 * @param adminRole
	 * @return
	 * @author zhangtian
	 */
	public boolean insertAdminRole(AdminRole adminRole) {
		
		// === 维护角色主表
		Integer roleN = adminRoleMapper.insertAdminRole(adminRole) ;
		
		List<AdminRolePermission> adminRolePermissions = adminRole.getAdminRolePermissions() ;
		
		if(CollectionUtils.isNotEmpty(adminRolePermissions)) {
			Integer rolePermissionN = adminRoleMapper.insertAdminRolePermission(adminRolePermissions) ;
			if(roleN >0 && rolePermissionN > 0) {
				return true ;
			} else {
				return false ;
			}
				
		} else {
			if(roleN > 0) {
				return true ;
			} else {
				return false ;
			}
		}
		
	}
	
	/**
	 * 
	 * updateAdminRole:(更新角色)
	 *
	 * @param adminRole
	 * @return
	 * @author zhangtian
	 */
	public boolean updateAdminRole(AdminRole adminRole) {
		
		// === 删除角色权中间表数据
		adminRoleMapper.deleteAdminRolePermission(adminRole.getAdminRoleId()) ;
		// === 更新角色主表
		Integer roleN = adminRoleMapper.updateAdminRole(adminRole) ;
		
		// === 插入角色权限中间表
		List<AdminRolePermission> adminRolePermissions = adminRole.getAdminRolePermissions() ;
		if(CollectionUtils.isNotEmpty(adminRolePermissions)) {
			Integer rolePermissionN = adminRoleMapper.insertAdminRolePermission(adminRolePermissions) ;
			if(roleN >0 && rolePermissionN > 0) {
				return true ;
			} else {
				return false ;
			}
				
		} else {
			if(roleN > 0) {
				return true ;
			} else {
				return false ;
			}
		}
	}
	
	/**
	 * 
	 * findAdminRoleById:(根据ID查询角色)
	 *
	 * @param adminRoleId
	 * @return
	 * @author zhangtian
	 */
	public AdminRole findAdminRoleById(String adminRoleId) {
		
		// === 查询角色主表
		AdminRole adminRole = adminRoleMapper.findAdminRoleById(adminRoleId) ;
		// === 查询所属权限
		List<AdminRolePermission> adminRolePermissions = adminRoleMapper.findAdminRolePermissionByRoldId(adminRoleId) ;
		if(CollectionUtils.isNotEmpty(adminRolePermissions)) {
			adminRole.setAdminRolePermissions(adminRolePermissions);
		}
		
		return adminRole ;
	}
	
	/**
	 * 
	 * findAllAdminRole:(查询后台所有角色)
	 *
	 * @return
	 * @author zhangtian
	 */
	public List<AdminRole> findAllAdminRole() {
		
		return adminRoleMapper.findAllAdminRole() ;
	}
	
	/**
	 * 
	 * deleteBaseRoleById:(根据ID删除角色)
	 *
	 * @param adminRoleId
	 * @return
	 * @author zhangtian
	 */
	public String deleteBaseRoleById(String adminRoleId) {
		
		String jsonStr = "" ;
		// === 查询角色下是否挂载了用户
		Integer isUserNum = adminRoleMapper.findAdminUserExist(adminRoleId) ;
		if(isUserNum > 0) {
			jsonStr = new JSONStringer().object().key("flag").value("删除失败，角色已绑定用户！").endObject().toString() ;
		} else {
			// === 删除角色权限中间表
			adminRoleMapper.deleteAdminRolePermission(adminRoleId) ;
			// === 删除角色主表
			Integer numD = adminRoleMapper.deleteAdminRoleById(adminRoleId) ;
			if(numD > 0) {
				jsonStr = new JSONStringer().object().key("flag").value("删除成功！").endObject().toString() ;
			} else {
				jsonStr = new JSONStringer().object().key("flag").value("删除失败！").endObject().toString() ;
			}
		}
		
		return jsonStr ;
	}
	
	/**
	 * 
	 * findPageList:(分页多条件查询)
	 *
	 * @param page
	 * @return
	 * @author zhangtian
	 */
	public Page findPageList(Page page) {
		
		page.setData(adminRoleMapper.findPageList(page));
		return page ;
	}
	
	/**
	 * 
	 * findAllGroupPermission:(查询所有分组权限)
	 *
	 * @author zhangtian
	 */
	public MultiMap findAllGroupPermission() {
		
		List<AdminRolePermission> adminRolePermissions = adminRoleMapper.findAllGroupPermission() ;
		MultiMap multiMap = new MultiValueMap() ;
		if(CollectionUtils.isNotEmpty(adminRolePermissions)) {
			for(AdminRolePermission adminRolePermission : adminRolePermissions) {
				multiMap.put(adminRolePermission.getAdminPermissionGroupName(), adminRolePermission) ;
			}
		}
		
		return multiMap ;
	}

	/**
	 * 角色名称唯一性校验
	 */
	public boolean checkAdminRoleName(String adminRoleName) {

		Integer num = adminRoleMapper.checkAdminRoleName(adminRoleName) ;
		return num > 0 ? false : true ;
	}
	
}
