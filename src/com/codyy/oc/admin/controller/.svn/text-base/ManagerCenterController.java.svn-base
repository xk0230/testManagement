package com.codyy.oc.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.service.AdminUserManagerService;

@Controller
@RequestMapping("admin/managercenter")
public class ManagerCenterController {
	
	@Autowired
	private AdminUserManagerService adminUserManagerService;
	
	@RequestMapping("welcome")
	public String toLogin(){
		return "admin/managerCenter/welcome";
	}
	
	@RequestMapping("tomodifypassword")
	public String toModifyPassword(){
		return "admin/managerCenter/modifyPassword";
	}
	
	@RequestMapping("modifypassword")
	@ResponseBody
	public ResultJson modifyPassword(String oldPassword,String newPassword,HttpServletRequest request){
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		return adminUserManagerService.modifyPassword(adminUser.getAdminUserId(), oldPassword.trim(), newPassword.trim());
	}
	
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toModifyMsg
		* @Description: (修改个人资料之前的方法)
		* @return String    返回类型
		* @throws
	 */
    @RequestMapping("tomodifymsg")
	public String toModifyMsg(HttpServletRequest request){
		return "admin/managerCenter/modifyMsg";
		
		
	}
	
    /**
     * 
    	* @author zhangshuangquan
    	* @Title: modifyMsg
    	* @Description: (修改个人资料)
    	* @return ResultJson    返回类型
    	* @throws
     */
    @RequestMapping("modifymsg")
    @ResponseBody
    public ResultJson modifyMsg(String realName,String contact,HttpServletRequest request){
    	AdminUser admin = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
    	String real = StringUtils.trim(realName);
    	String con = StringUtils.trim(contact);
		ResultJson result = adminUserManagerService.modifyMsg(admin.getAdminUserId(), real, con);
		if(result!=null){
			AdminUser adminUser = adminUserManagerService.getAdmin(admin.getAdminUserId(),admin.getUserName());
			request.getSession().setAttribute(AdminUser.ADMIN_SESSION_USER,adminUser);
			return result;
		}
		return null;
    	
    }
}
