package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.SecurityUtil;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminMenuMapper;
import com.codyy.oc.admin.dao.AdminUserDetailMapper;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.AdminUserPermissionMapper;
import com.codyy.oc.admin.entity.AdminMenu;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.AdminUserDetail;
import com.codyy.oc.admin.entity.AdminUserPermission;
import com.codyy.oc.admin.entity.AdminUserRole;
import com.codyy.oc.admin.view.UserSearchModel;

/**
 * 
 * ClassName:UserManagerService
 * Function: 用户管理业务控制
 *
 * @Date	 2015	2015年3月23日		上午9:55:50
 *
 */

@Service
public class AdminUserManagerService {
	
	@Autowired
	private AdminUserMapper adminUserMapper;
	@Autowired
	private AdminMenuMapper adminMenuMapper;
	@Autowired
	private AdminUserPermissionMapper adminUserPermissionMapper;
	@Autowired
	private AdminUserDetailMapper adminUserDetailMapper;
	
	/**
	* @Title: getselcAdminUserById
	* @Description: (通过id来对用户进行查询)
	* @param @param userId
	* @param @return    设定文件
	* @return AdminUser    返回类型
	* @throws
	 */
	public AdminUser getselcAdminUserById(String userId){
		
		return adminUserMapper.getselcAdminUserById(userId);
	}
	
	
	/**
	* @Title: insertAdminUsers
	* @Description: (这里用一句话描述这个方法的作用)
	* @param     设定文件
	* @return void    返回类型   给予提示操作是否成功
	* @throws
	 */
	public ResultJson insertAdminUsers(AdminUser adUser,AdminUserPermission adminUser){
		try{
			//如果用户名存在则直接返回并不执行下面的任何语句
			if(null!=adminUserMapper.selUserName(adUser.getUserName()) && adminUserMapper.selUserName(adUser.getUserName()).size()>0){
			       return new ResultJson(true, 1);
			}
			
			//测试数据
//			adUser.setPosition(CommonsConstant.USER_TYPE_STAFF);
//			adUser.setDepId("1");
//			adUser.setPostId("2");
//			adUser.setWorkStatus("3");
//			adUser.setSalaryScale("4");
//			adUser.setEntryDate(new Date());
//			adUser.setWorkingYears("5");
//			adUser.setSalaryBeginDate(new Date());
//			adUser.setProbationPeriod("6");
//			adUser.setExpectedDate(new Date());
//			adUser.setFwqAgreement("7");
//			adUser.setFwqNum("8");
//			adUser.setLabourBeginTime(new Date());
//			adUser.setLabourEndTime(new Date());
//			adUser.setSignTime("9");
//			adUser.setInsuranceBase("10");
//			adUser.setFilingDate(new Date());
//			adUser.setLeaveDate(new Date());
//			adUser.setRetiredDate(new Date());
			
			adminUserMapper.insertSelective(adUser);
			if(null!=adminUser.getFunctionList() && adminUser.getFunctionList().size()>0){
				adminUserPermissionMapper.insertUserPernission(adminUser);
			}
			
			AdminUserDetail ad = adUser.getAdminUserDetail()==null?new AdminUserDetail():adUser.getAdminUserDetail();
			ad.setUserDetailId(UUIDUtils.getUUID());
			ad.setUserId(adUser.getUserId());
//			ad.setAge(18);
			adminUserDetailMapper.insertSelective(ad);
			return new ResultJson(true,2);//用户名不重名则直接添加
		}catch(Exception e){
			e.printStackTrace();
			return new ResultJson(false);
		}
		 
	}
	
	
	
	/**
	* @Title: deleteAdminUsersById
	* @Description: (根据id来删除用户的所有信息)
	* @param @param userId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteAdminUsersById(String userId){
		
		return adminUserMapper.deleteAdminUsersById(userId);
	}
	
	
	/**
	* @Title: updateAdminsUser
	* @Description: (修改用户信息)
	* @param @param user
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public ResultJson updateAdminsUser(String userId, AdminUser user,AdminUserPermission adminUser,AdminUser sessionUser){
		
		try{
//			 adminUserPermissionMapper.deleteUserPermissionById(userId);//删除用户对应的权限表信息
			 
			 if(sessionUser.getPosition().equals(CommonsConstant.USER_TYPE_ADMIN)) {
				//只有管理员可以修改user信息
				 adminUserMapper.updateById(user);//修改用户详情列表的信息
			 }
			 //非管理员用户可以修改自己的userdetail信息
			 	adminUserDetailMapper.updateByPrimaryKeySelective(user.getAdminUserDetail());
			 
//			 if(null!=adminUser.getFunctionList() && adminUser.getFunctionList().size()>0){
//				 
//				 adminUserPermissionMapper.insertUserPernission(adminUser); 
//			 }
			 
			 return new ResultJson(true);
			 
		}catch(Exception e){
			
			e.printStackTrace();
			return new ResultJson(false);
		}
		 
	}
	
	/**
	 * 
	 * @param userName
	 * @param password
	 * @return
	 */
	public AdminUser getAdminUser(String userName,String password){
		if(StringUtils.isNotBlank(userName)){
			userName = userName.trim();
		}else{
			return null;
		}
		if(StringUtils.isNotBlank(password)){
			password = password.trim();
		}else{
			return null;
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("userName", userName);
		map.put("password", SecurityUtil.MD5String(password));
		return adminUserMapper.getAdminUser(map);
	}

	
	/**
	 * 
	 * findAdminUserById:(根据用户Id查询用户)
	 *
	 * @param adminUserId
	 * @return
	 */
	public AdminUser findAdminUserById(String adminUserId){
		
		AdminUser adminUser = adminUserMapper.findAdminUserById(adminUserId) ;
		// === 获取角色
		List<AdminUserRole> adminUserRole = adminUserMapper.findAdminUserRoleById(adminUserId) ;
		if(CollectionUtils.isNotEmpty(adminUserRole)) {
			adminUser.setAdminUserRoles(adminUserRole);
		}
		return adminUser ;
	}
	
	/**
	 * 
	 * findPageList:(条件分页查询用户信息)
	 *
	 * @param page
	 * @return
	 */
	public Page findPageList(Page page) {
		
		page.setData(adminUserMapper.findPageList(page));
		return page ;
	}
	
	
	/**
	 * 
	 * insertAdminUser:(插入用户)
	 *
	 * @param adminUser
	 * @return  true  插入成功  false  插入失败
	 */
	public boolean insertAdminUser(AdminUser adminUser) {
	
		// === 维护用户表
		Integer adminUserNum = adminUserMapper.insertAdminUser(adminUser) ;
		Integer adminUserRoleNum = 0 ;
		// ===  维护关联表
		List<AdminUserRole> adminUserRoles = adminUser.getAdminUserRoles() ;
		if(CollectionUtils.isNotEmpty(adminUserRoles)) {
			adminUserRoleNum = adminUserMapper.insertAdminUserRole(adminUserRoles) ;
			if(adminUserNum > 0 && adminUserRoleNum > 0) {
				return true ;
			} else {
				return false ;
			}
		} else {
			if(adminUserNum > 0) {
				return true ;
			} else {
				return false ;
			}
		}
	}
	
	/**
	 * 
	 * insertAdminUser:(更新用户)
	 *
	 * @param adminUser
	 * @return  true  更新成功  false  更新失败
	 */
	public boolean updateAdminUser(AdminUser adminUser) {
	
		// === 维护用户表
		Integer adminUserNum = adminUserMapper.updateAdminUser(adminUser) ;
		Integer adminUserRoleNumI = 0 ;
		// ===  维护关联表  更新关联表执行先删除后插入操作
		List<AdminUserRole> adminUserRoles = adminUser.getAdminUserRoles() ;
		if(CollectionUtils.isNotEmpty(adminUserRoles)) {
			adminUserMapper.deleteAdminUserRole(adminUser.getUserId()) ;
			adminUserRoleNumI = adminUserMapper.insertAdminUserRole(adminUserRoles) ;
			if(adminUserNum > 0 && adminUserRoleNumI > 0) {
				return true ;
			} else {
				return false ;
			}
		} else {
			if(adminUserNum > 0) {
				return true ;
			} else {
				return false ;
			}
		}
	}
	
	/**
	 * 
	 * deleteAdminUserById:(删除用户)
	 *
	 * @param adminUser
	 * @return  true  删除成功  false  删除失败
	 */
	public ResultJson deleteAdminUserById(String adminUserId) {
		// === 逻辑删除
		Integer adminUserP = adminUserMapper.deleteAdminUserById(adminUserId) ;
		if(adminUserP > 0 ) {
			return new ResultJson(true) ;
		} else {
			return new ResultJson(false) ;
		}
	}
	
	/**
	 * 
	 * modifyPassword:(修改密码)
	 *
	 * @param adminUserId
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
 	public ResultJson modifyPassword(String adminUserId,String oldPassword,String newPassword){
		if(StringUtils.isBlank(oldPassword)){
			return new ResultJson(false,"请输入原密码！");
		}
		if(StringUtils.isBlank(newPassword)){
			return new ResultJson(false, "请输入新密码！");
		}
		oldPassword = SecurityUtil.MD5String(oldPassword);
		newPassword = SecurityUtil.MD5String(newPassword);
		AdminUser adminUser = adminUserMapper.findAdminUserById(adminUserId);
		if(adminUser == null){
			return new ResultJson(false,"修改失败！");
		}
		if(oldPassword.equals(adminUser.getPassword())){
			Map<String,String> map = new HashMap<String,String>();
			map.put("adminUserId", adminUserId);
			map.put("password", newPassword);
			int result = adminUserMapper.modifyPassword(map);
			if(result > 0){
				return new ResultJson(true,"修改成功！");
			}else{
				return new ResultJson(false,"修改失败！");
			}
			
		}else{
			return new ResultJson(false,"原密码输入错误！");
		}
	}

 	/**
 	 * 校验用户名是否存在
 	 */
	public boolean checkUserName(String userName) {

		Integer num = adminUserMapper.checkUserName(userName) ;
		
		if(num > 0) {
			return false ;
		} else {
			return true ;
		}
	}
	
	
	/**
	 * 
	 * getUserAdminMenu:(获取用户所拥有menu的权限)
	 * @author ghost 
	 * @param adminUserId
	 * @return
	 */
	public Map<String,Object> getUserAdminMenu(String adminUserId){
		Map<String,Object> result = new HashMap<String,Object>();
		List<AdminMenu> list = adminMenuMapper.getUserAdminMenu(adminUserId);
		Map<String,AdminMenu> first =new HashMap<String, AdminMenu>();
		Map<String,AdminMenu> second =new HashMap<String, AdminMenu>();
		Map<String,AdminMenu> third =new HashMap<String, AdminMenu>();
		int menuLevel;
		boolean hasFirst = false;
		boolean hasSecond = false;
		boolean hasThird = false;
		String adminMenuId;
		for (AdminMenu adminMenu : list) {
			adminMenuId = adminMenu.getAdminMenuId();
			menuLevel = adminMenu.getMenuLevel();
			if(1 == menuLevel){
				if("content".equals(adminMenuId)){
					hasFirst = true;
				}else if("para".equals(adminMenuId)){
					hasSecond = true;
				}else if("admin".equals(adminMenuId)){
					hasThird = true;
				}
				first.put(adminMenuId, adminMenu);
			}else if(2 == menuLevel){
				second.put(adminMenuId, adminMenu);
			}else if(3 == menuLevel){
				third.put(adminMenuId, adminMenu);
			}
		}
		result.put("hasFirst", hasFirst);
		result.put("hasSecond", hasSecond);
		result.put("hasThird", hasThird);
		result.put("first", first);
		result.put("second", second);
		result.put("third", third);
		return result;
	}
	
	/**
	 * 
		* @Title: ModifyMsg
		* @Description: (修改个人资料)
		* @param:  adminUserId,realName,contact
		* @return ResultJson    返回类型
		* @throws
	 */
	public ResultJson modifyMsg(String adminUserId,String realName,String contact){
		
		if(StringUtils.isBlank(realName)){
			return new ResultJson(false,"请输入真实姓名！");
		}
		if (StringUtils.isBlank(contact)) {
			return new ResultJson(false,"请输入联系电话！");
		}
		AdminUser adminUser = adminUserMapper.findAdminUserById(adminUserId);
		if(adminUser==null){
			return new ResultJson(false,"修改失败");
		}else {
			Map<String,String> map = new HashMap<String,String>();
			map.put("adminUserId", adminUserId);
			map.put("realName",realName);
			map.put("contact",contact);
			int result=adminUserMapper.modifyMsg(map);
			if (result>0) {
				return new ResultJson(true,"修改成功！");
			}else {
				return new ResultJson(true,"修改失败！");
			}
		}
	}


	/**
	 * 
		* @Title: getAdmin
		* @Description: (根据adminUserId和userName获取对象)
		* @param: adminUserId,userName
		* @return ResultJson    返回类型
		* @throws
	 */
	public AdminUser getAdmin(String adminUserId, String userName) {
		if(StringUtils.isNotBlank(userName)){
			userName = userName.trim();
		}else{
			return null;
		}
		if(StringUtils.isNotBlank(adminUserId)){
			adminUserId=adminUserId.trim();
		}else{
			return null;
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("adminUserId",adminUserId);
		map.put("userName",userName);
		return adminUserMapper.getAdmin(map);
		
	}
	
	/**
	 * 
		* @Title: getAdminList
		* @Description: (获取用户列表)
		* @param strStart,strEnd,userSearch
		* @return Page    
	 */
	public Page getAdminList(Page page,UserSearchModel userSearch){
		boolean flag=true;
		Map<String,Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userSearch.getProjectId())){
			map.put("projectId",userSearch.getProjectId());
			flag=false;
		}
		map.put("userName", OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getUserName()));
		map.put("realName",OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getRealName()));
		map.put("contact", OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getContact()));
		map.put("position",OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getPosition()));
		if(flag){
			map.put("state",userSearch.getState());
		}
	    page.setMap(map);
		List<AdminUser> data = adminUserMapper.getAdminUserPageList(page);
		page.setData(data);
		return page;
	}
	
	/**
	* @Title: selUserName
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param userName
	* @param @return    设定文件
	* @return List<AdminUser>    返回类型
	* @throws
	 */
	public List<AdminUser> selUserName(String userName){
		
		return adminUserMapper.selUserName(userName);
	}
	
	/**
	 * @author lichen
	* @Title: checkSelUpteName
	* @Description: (修改操作用户名验证)
	* @param @param adminUser
	* @param @return    设定文件
	* @return List<AdminUser>    返回类型
	* @throws
	 */
	public List<AdminUser> checkSelUpteName(AdminUser adminUser){
		
		return adminUserMapper.checkSelUpteName(adminUser);
	}
	
	
	public void updatePasswd(AdminUser user) {
		adminUserMapper.updatePaswd(user);
	}
	
}
