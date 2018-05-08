package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.SecurityUtil;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.AdminUserDetail;
import com.codyy.oc.admin.entity.AdminUserPermission;
import com.codyy.oc.admin.entity.ChartPieData;
import com.codyy.oc.admin.service.AdminUserManagerService;
import com.codyy.oc.admin.service.AdminUserPermissionService;
import com.codyy.oc.admin.view.UserSearchModel;

@Controller
@RequestMapping("/admin/adminuser/")
public class AdminUserManagerController extends BaseController {
	
	@Autowired
	private AdminUserManagerService adminUserManagerService;
	
	@Autowired
	private AdminUserPermissionService adminUserPermissionService;
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	/**
	* @Title: insertAdminUser
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param request
	* @param @param adUser    设定文件
	* @return void    返回类型
	* @throws
	 */
	//@RequestMapping("insertAdminUser")
	@ResponseBody
	@RequestMapping("insertadminuser")
	public ResultJson  insertAdminUser(HttpServletRequest request, AdminUser adUser ){
		adUser.setCreateTime(new Date());//记录当前时间
		adUser.setPassword(SecurityUtil.MD5String(adUser.getPassword()));//密码进行MD5加密
		if(StringUtils.isEmpty(adUser.getUserId())){//添加用户操作自动生成id
			adUser.setUserId(UUIDUtils.getUUID());//自动生成id
			adUser.setPassword(SecurityUtil.MD5String("888888"));
		}
	
		//如果用户做修改操作的时候即用户名是存在的    即不用自动生成    若修改则不用创建id
			AdminUserPermission adminUser = new AdminUserPermission();
			if(!"".equals(adUser.getFunctionList())){
				adminUser.setFunctionList(adUser.getFunctionList());
			}else{
				adminUser.setFunctionList(null);
			}
			//adminUser.setAdminUserId(adUser.getUserId());
		return adminUserManagerService.insertAdminUsers(adUser,adminUser);
	
		
		
	}
	
	/**
	* @Title: updateUserAdmin
	* @Description: (更新用户)
	* @param @param request
	* @param @param adUser    设定文件
	* @return void    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("updateuseradmin")
	public ResultJson updateUserAdmin(HttpServletRequest request, AdminUser adUser){
		AdminUser sessionUser =  getSessionUser(request);
		String userId=adUser.getUserId();
		
		adUser.setCreateTime(new Date());//记录当前时间
           //用户不输入密码即密码不进行修改
//		if("".equals(adUser.getPassword())){
//			
//			
//			
//		}else{
//			//用户修改密码
//			adUser.setPassword(SecurityUtil.MD5String(adUser.getPassword()));//密码进行MD5加密
//		}
		
		AdminUserPermission adminUser = new AdminUserPermission();
		if(!"".equals(adUser.getFunctionList())){
			adminUser.setFunctionList(adUser.getFunctionList());
		}else{
			adminUser.setFunctionList(null);
		}
		
		adminUser.setAdminUserId(adUser.getUserId());
		if(adUser.getAdminUserDetail() == null) {
			AdminUserDetail ad = new AdminUserDetail();
			ad.setUserId(adUser.getUserId());
			adUser.setAdminUserDetail(ad);
		}else {
			adUser.getAdminUserDetail().setUserId(adUser.getUserId());
		}
		return adminUserManagerService.updateAdminsUser(userId,adUser,adminUser,sessionUser);//修改用户详情列表的信息

	}
	
	@ResponseBody
	@RequestMapping("updatePasswd")
	public ResultJson updatePasswd(HttpServletRequest request, AdminUser adUser,String oldpsd){
			if(StringUtils.isEmpty(adUser.getPassword())){
				return new ResultJson(false,"密码不能为空");
			}else {
				//校验旧密码正确性
				AdminUser sessionUser =  getSessionUser(request);
				System.out.println(sessionUser.getPassword());
				
				if(StringUtils.isNotBlank(oldpsd)&&sessionUser.getPassword().equals(SecurityUtil.MD5String(oldpsd))) {
					//如果原密码正确则修改密码
					adUser.setPassword(SecurityUtil.MD5String(adUser.getPassword()));//密码进行MD5加密
				}else {
					return new ResultJson(false,"原密码不正确");
				}
			}
			adminUserManagerService.updatePasswd(adUser);
			return new ResultJson(true);
	}
	
	/**
	 * 
		* @Title: toAddAdminUser
		* @Description: (去添加用户)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toaddadminuser")
	public String toAddAdminUser(){
		return "admin/administrator/addAdministrator";
	}
	
	/**
	* @Title: getselcAdminUserById
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param userId
	* @param @return    设定文件
	* @return AdminUser    返回类型
	* @throws
	 */
	@RequestMapping("getselbyid")
	public ModelAndView getselcAdminUserById(String userId){
	
		System.out.println("getselcAdminUserById……");
		AdminUser adUser=adminUserManagerService.getselcAdminUserById(userId);
		ModelAndView model = new ModelAndView("/admin/administrator/updateAdministrator");
		model.addObject("user", adUser);
	    return model;	
	}
	
	/**
	* @Title: getselcAdminUserById
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param userId
	* @param @return    设定文件
	* @return AdminUser    返回类型
	* @throws
	 */
	@RequestMapping("toAddOrEditUser")
	public ModelAndView showAddUser(String id,String isView){
		ModelAndView model = new ModelAndView("admin/administrator/addOrEdit");
		if(StringUtils.isNotBlank(id)) {
			//如果有ID则是Edit
			AdminUser adUser=adminUserManagerService.getselcAdminUserById(id);
			model.addObject("user", adUser);
		}else {
			
		}
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping("getUserById")
	public AdminUser getUserById(@RequestParam(required=true) String id){
		AdminUser adUser=adminUserManagerService.getselcAdminUserById(id);
		return adUser;
	}
	
	/**
	 * 
		* @Title: toAdminList
		* @Description: (跳转到orgUserList.jsp页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toadminlist")
	public String toAdminList(){
		return "admin/administrator/showAdministratorList";	
	}
	
	/**
	 * 
		* @Title: getAdminList
		* @Description: (查询用户列表)
		* @return Page   
	 */
	@ResponseBody
	@RequestMapping("getadminlist")
	public Page getAdminList(Page page,UserSearchModel userSearch){
		return adminUserManagerService.getAdminList(page, userSearch);
		
	}
	
	@ResponseBody
	@RequestMapping("getAlladminlist")
	public List<AdminUser> getAllAdminList(Page page,UserSearchModel userSearch){
		return adminUserManagerService.getAllAdminList();
	}
	
	/**
	 * 
		* @Title: deleteAdminUserById
		* @Description: (删除用户)
		* @return Page   
	 */
	@ResponseBody
	@RequestMapping("deleteadminuserbyid")
	public ResultJson deleteAdminUserById(@RequestParam String adminUserId){
		return adminUserManagerService.deleteAdminUserById(adminUserId);
		
		
	}
	
	/**
	* @Title: selUserName
	* @Description: (验证用户名唯一)
	* @param @param userName
	* @param @return    设定文件
	* @return List<AdminUser>    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selUserName")
	public List<AdminUser> selUserName(String userName){
		
		return adminUserManagerService.selUserName(userName);
	}
	
	@ResponseBody
	@RequestMapping("checkseluptename")
	public List<AdminUser> checkSelUpteName(AdminUser adminUser){
		return adminUserManagerService.checkSelUpteName(adminUser);
	}
	
	/**
	 * 获取统计数据
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getchartsdata")
	public List<ChartPieData> getchartsdata(HttpServletRequest request){
		AdminUser au = getSessionUser(request);
		return adminUserManagerService.getchartsdata(au);
	}
}
