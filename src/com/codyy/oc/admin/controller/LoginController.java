package com.codyy.oc.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.service.AdminUserManagerService;

@Controller
public class LoginController {
	
	@Autowired
	private AdminUserManagerService adminUserManagerService;
	
	@RequestMapping("login")
	public String toLogin(){
		return "loginNew";
	}
	
	@RequestMapping("loginValidate")
	@ResponseBody
	public ResultJson loginValidate(String userName,String password,HttpServletRequest request){
		AdminUser adminUser = adminUserManagerService.getAdminUser(userName, password);
		if(adminUser == null){
			return new ResultJson(false,"账号或密码错误，请重新输入!");
		}else{
				HttpSession session = request.getSession();
				session.setAttribute(AdminUser.ADMIN_SESSION_USER, adminUser);
				session.setAttribute("menu", adminUserManagerService.getUserAdminMenu(adminUser.getUserId()));
				return new ResultJson(true);
		}
	}
	
	@RequestMapping("logOut")
	@ResponseBody
	public ResultJson logOut(HttpServletRequest request){
		request.getSession().invalidate();
		return new ResultJson(true);
	}
	
	@RequestMapping("admin/index")
	public String index(){
		return "defaultNewMode";
	}
	
	@RequestMapping("admin/newin")
	public String newin(){
		return "newin";
	}
	
}
