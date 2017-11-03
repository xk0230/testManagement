package com.codyy.oc.admin.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.codyy.oc.admin.entity.AdminUser;

public class LoginFilter implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpSession session = request.getSession();
		AdminUser adminUser = (AdminUser) session.getAttribute(AdminUser.ADMIN_SESSION_USER);
		if(request.getServletPath().indexOf("/admin/system/area/readMapFile") != -1){
			chain.doFilter(req, resp);
			return;
		}
		if(adminUser == null){
			String contextPath = request.getContextPath();
			if (contextPath.equals("/")) {
				contextPath = "";
			}
			resp.getWriter().print("<script>top.location='"+contextPath+"/login.html';</script>");
		}else{
			chain.doFilter(req, resp);
		}
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
