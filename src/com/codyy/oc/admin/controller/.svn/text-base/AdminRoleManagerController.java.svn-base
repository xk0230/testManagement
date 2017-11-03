package com.codyy.oc.admin.controller;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONStringer;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MultiMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminRole;
import com.codyy.oc.admin.entity.AdminRolePermission;
import com.codyy.oc.admin.service.AdminRoleManagerService;
import com.codyy.oc.admin.service.AdminUserManagerService;

/**
 * 
 * ClassName:UserManagerController
 * Function: 用户管理
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月23日		上午9:56:58
 *
 */
@Controller
@RequestMapping("admin/system/role/")
public class AdminRoleManagerController extends BaseController {
	
	@Autowired
	private AdminRoleManagerService roleManagerService;
	@Autowired
	private AdminUserManagerService userManagerService;
	
	/**
	 * 
	 * listAdminUserPage:(角色显示页面)
	 *
	 * @param model
	 * @return
	 * @author zhangtian
	 */
	@RequestMapping("listAdminRolePage")
	public String listAdminUserPage(Model model) {
		
		return "admin/system/roleManager/role_list_page" ;
	}
	
	/**
	 * 
	 * listAdminRole:(分页显示角色列表)
	 *
	 * @param writer
	 * @param page
	 * @return
	 * @author zhangtian
	 */
	@RequestMapping("listAdminRole") 
	@ResponseBody
	public Page listAdminRole(Page page){
		
		page = roleManagerService.findPageList(page) ;
		return page ;
	}
	
	/**
	 * 
	 * addAdminRolePage:(插入角色页面)
	 *
	 * @param model
	 * @return
	 * @author zhangtian
	 */
	@RequestMapping("addAdminRolePage")
	public String addAdminRolePage(Model model) {
		
		MultiMap multiMap =  roleManagerService.findAllGroupPermission() ;
		model.addAttribute("multiMap", multiMap) ;
		return "admin/system/roleManager/role_add_page" ;
	}
	
	/**
	 * 
	 * addAdminRole:(插入角色)
	 *
	 * @param adminRoles
	 * @param writer
	 * @return
	 * @author zhangtian
	 * @throws IOException 
	 */
	@RequestMapping("addAdminRole")
	public String addAdminRole(@RequestParam String adminRoles ,Writer writer) throws IOException {
		
		JSONObject jsonObject = JSONObject.fromObject(adminRoles) ;
		// === List集合
		Object adminUserRoles = jsonObject.get("adminUserRoles") ;
		jsonObject.remove("adminUserRoles") ;
		
		// === Jsonbject转化为AdminRole
		String uuid = UUIDUtils.getUUID() ;
		AdminRole adminRole = (AdminRole)JSONObject.toBean(jsonObject, AdminRole.class) ;
		
		// 角色名称唯一性校验
		boolean isExist = roleManagerService.checkAdminRoleName(adminRole.getRoleName().trim()) ;
		if(!isExist) {
			writer.write(new JSONStringer().object().key("isExist").value(isExist).endObject().toString());
		} else {
			adminRole.setAdminRoleId(uuid);
			adminRole.setCreateTime(new Date());
			
			// === JsonArray转化为List<AdminRolePermission>
			List<AdminRolePermission> adminRolePermissions = new ArrayList<AdminRolePermission>() ;
			JSONArray array = JSONArray.fromObject(adminUserRoles) ;
			if(CollectionUtils.isNotEmpty(array)) {
				for(int i = 0; i<array.size(); i++) {
					AdminRolePermission adminRolePermission = (AdminRolePermission)JSONObject.toBean(JSONObject.fromObject(array.get(i)), AdminRolePermission.class) ;
					adminRolePermission.setAdminRoleId(uuid);
					adminRolePermissions.add(adminRolePermission) ;
				}
			}
			
			adminRole.setAdminRolePermissions(adminRolePermissions);
			boolean flag = roleManagerService.insertAdminRole(adminRole) ;
			writer.write(new JSONStringer().object().key("flag").value(flag).key("isExist").value(true).endObject().toString());
		}
		
		return null ;
	}
	
	/**
	 * 
	 * editAdminRolePage:(编辑角色页面)
	 *
	 * @return
	 * @author zhangtian
	 */
	@RequestMapping("editAdminRolePage")
	public String editAdminRolePage(@RequestParam String adminRoleId, Model model) {
		
		MultiMap multiMap =  roleManagerService.findAllGroupPermission() ;
		model.addAttribute("multiMap", multiMap) ;
		AdminRole adminRoles = roleManagerService.findAdminRoleById(adminRoleId) ;
		model.addAttribute("adminRoles", adminRoles) ;
		return "admin/system/roleManager/role_edit_page" ;
	}
	
	/**
	 * 
	 * editAdminRole:(编辑角色)
	 *
	 * @param adminRoles
	 * @param writer
	 * @return
	 * @throws IOException
	 * @author zhangtian
	 */
	@RequestMapping("editAdminRole")
	public String editAdminRole(@RequestParam String adminRoles ,Writer writer) throws IOException {
		
		JSONObject jsonObject = JSONObject.fromObject(adminRoles) ;
		// === List集合
		Object adminUserRoles = jsonObject.get("adminUserRoles") ;
		jsonObject.remove("adminUserRoles") ;
		
		// === Jsonbject转化为AdminRole
		AdminRole adminRole = (AdminRole)JSONObject.toBean(jsonObject, AdminRole.class) ;
		
		// === JsonArray转化为List<AdminRolePermission>
		List<AdminRolePermission> adminRolePermissions = new ArrayList<AdminRolePermission>() ;
		JSONArray array = JSONArray.fromObject(adminUserRoles) ;
		if(CollectionUtils.isNotEmpty(array)) {
			for(int i = 0; i<array.size(); i++) {
				AdminRolePermission adminRolePermission = (AdminRolePermission)JSONObject.toBean(JSONObject.fromObject(array.get(i)), AdminRolePermission.class) ;
				adminRolePermission.setAdminRoleId(adminRole.getAdminRoleId());
				adminRolePermissions.add(adminRolePermission) ;
			}
		}
		
		adminRole.setAdminRolePermissions(adminRolePermissions);
		boolean flag = roleManagerService.updateAdminRole(adminRole) ;
		writer.write(new JSONStringer().object().key("flag").value(flag).endObject().toString());
		return null ;
	}
	
	/**
	 * 
	 * deleteAdminRole:(删除角色)
	 *
	 * @param adminRoleId
	 * @param writer
	 * @return
	 * @author zhangtian
	 */
	@RequestMapping("deleteAdminRole")
	public String deleteAdminRole(@RequestParam String adminRoleId, Writer writer) throws IOException {
		
		String jsonStr = roleManagerService.deleteBaseRoleById(adminRoleId) ;
		writer.write(jsonStr);
		return null ;
	}
	
	/**
	 * 角色绑定用户显示页面
	 */
	@RequestMapping("showAdminUserRolePage")
	public String showAdminUserRolePage(@RequestParam String adminRoleId, Model model) {
	
		model.addAttribute("adminRoleId" ,adminRoleId) ;
		return "admin/system/roleManager/role_user_list_page" ;
	}
	
}
