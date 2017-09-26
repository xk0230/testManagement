package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.AdminUserRole;
import com.codyy.oc.admin.view.AdminUserView;

/**
 * 
 * ClassName:BaseUserMapper
 * Function: 用户管理数据操作
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月23日		上午10:08:54
 *
 */
public interface AdminUserMapper {
	
	/**
	 * 
	 * @author： lichen
	* @Title: insertAdminUser
	* @Description: (添加用户)
	* @param @param adminUser
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertAdminUser(AdminUser adminUser) ;
	
	
	/**
	 *@author lichen
	* @Title: getselcAdminUserById
	* @Description: (通过id来查询对应的用户信息)
	* @param @param userId
	* @param @return    设定文件
	* @return AdminUser    返回类型
	* @throws
	 */
	public AdminUser getselcAdminUserById(String userId);
	
	
	/**
	 * @author lichen
	* @Title: deleteAdminUsersById
	* @Description: (删除本id对应的所有用户的信息)
	* @param @param userId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteAdminUsersById(String userId);
	
	
	/**
	 * @author lichen
	* @Title: updateAdminsUser
	* @Description: (用户进行修改操作)
	* @param @param user
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer updateAdminsUser(AdminUser user);
	
	
	/**
	 * 
	 * insertAdminUserRole:(维护用户角色关联表)
	 *
	 * @param adminRoles
	 * @return
	 * @author zhangtian
	 */
	public Integer insertAdminUserRole(List<AdminUserRole> adminUserRoles) ;

	/**
	 * 
	 * deleteBaseUserById:(根据主键id删除用户)
	 *
	 * @param adminUserId
	 * @return
	 * @author zhangshuangquan
	 */
	public Integer deleteAdminUserById(String adminUserId);
	
	/**
	 * 
	 * updateBaseUser:(更新用户)
	 *
	 * @param baseUser
	 * @return
	 * @author zhangtian
	 */
	public Integer updateAdminUser(AdminUser adminUser) ;
	
	/**
	 * 
	 * updateAdminUserRole:(维护用户角色关联表  删除关系)
	 *
	 * @param adminUserRoles
	 * @return
	 * @author zhangtian
	 */
	public Integer deleteAdminUserRole(String adminUserId) ;
	
	/**
	 * 
	 * findBaseUserById:(根据id查询用户)
	 *
	 * @param id
	 * @return
	 * @author zhangtian
	 */
	public AdminUser findAdminUserById(String adminUserId) ;
	
	/**
	 * 
	 * findAdminUserRoleById:(根据用户ID查询用户所属的角色)
	 *
	 * @param adminUserId
	 * @return
	 * @author zhangtian
	 */
	public List<AdminUserRole> findAdminUserRoleById(String adminUserId) ;
	
	/**
	 * 
	 * selectPageList:(分页条件查询用户信息)
	 *
	 * @param page
	 * @return
	 * @author zhangtian
	 */
	public List<AdminUserView> findPageList(Page page);
	
	/**
	 * 
	 * findAllAdminUser:(批量导出使用，导处全部用户信息)
	 *
	 * @return
	 * @author zhangtian
	 */
	public List<AdminUser> findAllAdminUser() ;
	
	/**
	 * 根据username和password获取adminUser
	 * @param map(userName,password)
	 * @return
	 * @author yangyongwu
	 */
	public AdminUser getAdminUser(Map<String,String> map);
	
	/**
	 * 
	 * modifyPassword:(修改密码)
	 * 
	 * @author yangyongwu 
	 * @param map(adminUserId,password)
	 * @return
	 */
	public Integer modifyPassword(Map<String,String> map);
	
	/**
	 * 
	 * checkUserName:(校验用户名是否存在)
	 *
	 * @param userName
	 * @return
	 * @author zhangtian
	 */
	public Integer checkUserName(String userName) ;
	
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: modifyMsg
		* @Description: (修改个人资料)
		* @param   Map<String,String> map
		* @return Integer    返回类型
		* 
	 */
	public Integer modifyMsg(Map<String,String> map);

	/**
	 * 
		* @author zhangshuangquan
		* @Title: 获取Admin
		* @Description: (根据adminUserId和userName获取对象)
		* @param   Map<String,String> map
		* @return AdminUser    返回类型
		* 
	 */
	public AdminUser getAdmin(Map<String, String> map);
	
	/**
	 * 
	 * getAdminUserList:(获取用户列表)
	 * @author zhangshuangquan
	 * @param map
	 * @return
	 */
	public List<AdminUser> getAdminUserList(Map<String,Object> map);
	
	/**
	 * 
	 * getAdminUserCount:(获取用户总数)
	 * @author zhangshuangquan 
	 * @param map
	 * @return
	 */
	public int getAdminUserCount(Map<String,Object> map);
	
	/**
	 * @author lichen
	* @Title: selUserName
	* @Description: (验证用户不重名)
	* @param @param userName
	* @param @return    设定文件
	* @return List<AdminUser>    返回类型
	* @throws
	 */
	public List<AdminUser> selUserName(String userName);
	
	
	/**
	 * @author lichen
	* @Title: checkSelUpteName
	* @Description: (修改用户名验证)
	* @param @param adminUser
	* @param @return    设定文件
	* @return List<AdminUser>    返回类型
	* @throws
	 */
	public List<AdminUser> checkSelUpteName(AdminUser adminUser);


	public AdminUser checkUserState(String userId);


	public List<AdminUser> getAdminUserPageList(Page page);

	/**
	 * 修改密码
	 * @param adminUser
	 */
	public void updatePaswd(AdminUser adminUser);
	
	
	/**
	 * 根据ID修改用户
	 * @param record
	 * @return
	 */
	 public int updateById(@Param("record") AdminUser record);
	 
	 /**
	  * 
	  * 获取所有用户类型为admin的用户ID列表
	  * @return
	  */
	 public List<String> getAllAdminUserIDs();
	 
	 public int insertSelective(AdminUser record);

	 /**
	  * 根据用户Id获取部门经理Id
	  * @param id
	  * @return
	  */
	 public String getManagerIdByUserId(String userId);
}