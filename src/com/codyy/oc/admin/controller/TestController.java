package com.codyy.oc.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.service.AdminUserManagerService;
import com.codyy.oc.admin.service.AdminUserPermissionService;

@Controller
@RequestMapping("/admin/test/")
public class TestController extends BaseController {
	
	@Autowired
	private AdminUserManagerService adminUserManagerService;
	
	@Autowired
	private AdminUserPermissionService adminUserPermissionService;
	
	
	/**
	 * @author lichen
	* @Title: insertAdminUser
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param request
	* @param @param adUser    设定文件
	* @return void    返回类型
	* @throws
	 */
	//@RequestMapping("insertAdminUser")
	@RequestMapping("testimg")
	public String  testimg(HttpServletRequest request, AdminUser adUser ){
		System.out.println("测试一下");
		return "/admin/test/testimg";
	}
	
}
