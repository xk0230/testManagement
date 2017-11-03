package com.codyy.oc.commons.sso;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.UUID;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.context.SpringContext;
import com.codyy.commons.utils.URIUtils;

/**
 * Servlet Filter implementation class LoginCheckFilter
 * 检查用户是否登录，如果没有登录则重定向到UserCenter进行登录
 */
public class LoginCheckFilter implements Filter {

	private Logger logger = Logger.getLogger(LoginCheckFilter.class);
	@SuppressWarnings("rawtypes")
	private List excludeURILi = new ArrayList();

	/**
	 * Default constructor.
	 */
	public LoginCheckFilter() {
		logger.debug("construct LoginCheckFilter");
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		logger.debug("destroy LoginCheckFilter");
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
		if(excludeURILi != null && excludeURILi.size() > 0){
			String currURI = request.getServletPath();
			if(excludeURILi.contains(currURI)){
				chain.doFilter(request, response);
				logger.debug("LoginCheckFilter, pass exclude uri filter chain");
				return;
			}
		}
		SessionUser user = (SessionUser)request.getSession().getAttribute(CommonsConstant.SESSION_USER);
		if (user == null){
			//create data
			SsoConfig config = SpringContext.getBean(SsoConfig.class);
			StringBuffer bf = request.getRequestURL();
			if (StringUtils.isNotBlank(request.getQueryString())){
				bf.append('?').append(request.getQueryString());
			}
			String url = bf.toString();
			String redirectUrl = config.getRedirectUrl();
			String urlEncode = URLEncoder.encode(url, "utf-8");
			String redirectUrlEncode = URLEncoder.encode(redirectUrl, "utf-8");
			String app = config.getApp();
			String key = config.getKey();
			String state = UUID.randomUUID().toString();
			//String originalUri = URLEncoder.encode(URIUtils.getFullUri(request),"utf-8");
			request.getSession().setAttribute(CommonsConstant.SESSION_STATE, state);
			//build data sign, 参与计算sign的值应该为URLEncode之前的值
			TreeMap<String, String> map = new TreeMap<String, String>();
			map.put("app", app);
			map.put("url", url);
			map.put("redirectUrl", redirectUrl);
			map.put("state", state);
			String sign = SignUtil.buildSign(map, key);
			StringBuffer buffer = new StringBuffer();
			buffer.append(config.getAuthUrl());
			buffer.append("?app=" + app);
			buffer.append("&url=" + urlEncode);
			buffer.append("&redirectUrl=" + redirectUrlEncode);
			buffer.append("&state=" + state);
			buffer.append("&sign=" + sign);
			//buffer.append("&originalUri=" + originalUri);
			logger.debug("LoginCheckFilter, user not exist, redirect to login.");
			response.sendRedirect(buffer.toString());
		} else {
			SessionUserThreadLocal.getInstance().setSessionUser(user);
			chain.doFilter(request, response);
			logger.debug("LoginCheckFilter, user exist, do filter chain.");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	@SuppressWarnings("unchecked")
	public void init(FilterConfig fConfig) throws ServletException {
		logger.debug("init LoginCheckFilter");
		String excludeURIStr = fConfig.getInitParameter("excludeURI");
		if(StringUtils.isNotBlank(excludeURIStr)){
			StringTokenizer st = new StringTokenizer(excludeURIStr,";");
			this.excludeURILi.clear();
			while(st.hasMoreTokens()){
				this.excludeURILi.add(st.nextToken());
			}
		}
	}

}
