package com.codyy.oc.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;

import com.codyy.oc.admin.entity.AdminUser;

/**
 * 基础controller，实现通用方法
 */
@Controller
public class BaseController {

	/**
	 * 获取session用户
	 * 
	 * @author Gwang
	 * @param request
	 * @return
	 */
	protected AdminUser getSessionUser(HttpServletRequest request) {
		Object adminUser = request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		return adminUser == null ? null : (AdminUser) adminUser;
	}

	/**
	 * 获取session用户ID
	 * 
	 * @author Gwang
	 * @param request
	 * @return
	 */
	protected String getSessionUserId(HttpServletRequest request) {
		Object adminUser = request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		return adminUser == null ? null : ((AdminUser) adminUser).getAdminUserId();
	}

}
