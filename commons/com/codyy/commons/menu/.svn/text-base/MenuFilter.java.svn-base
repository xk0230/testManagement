package com.codyy.commons.menu;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.context.SpringContext;
import com.codyy.oc.commons.sso.SessionUser;

public class MenuFilter implements Filter {
	@SuppressWarnings("rawtypes")
	private List excludeURILi = new ArrayList();

	public void destroy() {

	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		if(excludeURILi != null && excludeURILi.size() > 0){
			String currURI = request.getServletPath();
			if(excludeURILi.contains(currURI)){
				chain.doFilter(request, response);
				return;
			}
		}
		SessionUser user = (SessionUser) request.getSession().getAttribute(CommonsConstant.SESSION_USER);
		if (user != null){
			StringRedisTemplate template = SpringContext.getBean(StringRedisTemplate.class);
			MenuConfig config = SpringContext.getBean(MenuConfig.class);
			if (template.hasKey(config.getMenuTag())){
				BoundHashOperations<String, Object, Object> ops = template.boundHashOps(config.getMenuTag());
				Map<Object, Object> map = ops.entries();
				List<MenuEntity> list = buildMenu(request, map, user);
				request.setAttribute("menuPersonalInfo", map.get("menu.personalInfo").toString());
				request.setAttribute("menuLogout", map.get("menu.logout").toString());
				request.setAttribute("menuHome", map.get("menu.home").toString());
				request.setAttribute("menuWorkspace", map.get("menu.workspace").toString());
				request.setAttribute("menuLoginStatus", map.get("menu.loginStatus").toString());
				request.setAttribute("menuList", list);
			}
		}
		chain.doFilter(request, response);
	}

	@SuppressWarnings("unchecked")
	public void init(FilterConfig config) throws ServletException {
		String excludeURIStr = config.getInitParameter("excludeURI");
		if(StringUtils.isNotBlank(excludeURIStr)){
			StringTokenizer st = new StringTokenizer(excludeURIStr,";");
			this.excludeURILi.clear();
			while(st.hasMoreTokens()){
				this.excludeURILi.add(st.nextToken());
			}
		}
	}
	
	private List<MenuEntity> buildMenu(HttpServletRequest request, Map<Object, Object> map, SessionUser user){
		List<MenuEntity> list = new ArrayList<MenuEntity>();
		String[] main = StringUtils.split(map.get("menu.main").toString(), ',');
		for (String m:main){
			MenuEntity entity = new MenuEntity();
			entity.setClazz(map.get("menu." + m + ".class").toString());
			entity.setGroup(map.get("menu." + m + ".group").toString());
			entity.setTitle(map.get("menu." + m + ".title").toString());
			String subStr = map.get("menu." + m + ".submenus").toString();
			String[] subs = StringUtils.split(subStr, ',');
			for (String sub:subs){
				if (user.getUserType().equals(CommonsConstant.USER_TYPE_AREA_USER)){
					if (!user.getHasSubArea() && sub.equals("lowerUser"))
						continue;
					if (!user.getCreateSchool() && sub.equals("school"))
						continue;
				}
				String type = map.get("menu." + m + ".sub." + sub + ".type").toString();
				if (type.equals("ALL") || StringUtils.contains(type, user.getUserType())){
					SubMenuEntity subEntity = new SubMenuEntity();
					subEntity.setId(map.get("menu." + m + ".sub." + sub + ".id").toString());
					subEntity.setHref(map.get("menu." + m + ".sub." + sub + ".href").toString());
					subEntity.setTitle(map.get("menu." + m + ".sub." + sub + ".title").toString());
					entity.getSubMenu().add(subEntity);
				}
			}
			if (entity.getSubMenu().size() > 0)
				list.add(entity);
		}
		return list;
	}
}
