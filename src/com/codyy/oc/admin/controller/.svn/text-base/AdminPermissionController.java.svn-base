package com.codyy.oc.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.entity.AdminPermission;
import com.codyy.oc.admin.service.AdminPermissionService;

@Controller
@RequestMapping("/admin/adminuser/")
public class AdminPermissionController {
     
	@Autowired
	private AdminPermissionService adminPermissionService;
	
	/**
	 * @author lichen
	* @Title: permissionNameList
	* @Description: (查询复选框列表)
	* @param @return    设定文件
	* @return List<AdminPermission>    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("permissionNameList")
	public  List<AdminPermission> permissionNameList(){
		 return adminPermissionService.adminPermissionList();	
	}
	
	@RequestMapping("jump")
    public String jump(){
    	return "admin/administrator/addAdministrator";
    }
}
