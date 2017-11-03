package com.codyy.oc.commons.sso;

import java.io.IOException;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.context.SpringContext;

/**
 * Servlet implementation class TokenServlet
 */
public class TokenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(TokenServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TokenServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");	
		String state = request.getParameter("state");	
		String token = request.getParameter("token");	
		String sign = request.getParameter("sign");
		String error = null;
		if (StringUtils.isBlank(url)){
			error = "Parameter 'url' is null.";
			logger.debug("Parameter 'url' is null.");
		} else if (StringUtils.isBlank(state)) {
			error = "Parameter 'state' is null.";
			logger.debug("Parameter 'state' is null.");
		} else if (StringUtils.isBlank(token)) {
			error = "Parameter 'token' is null.";
			logger.debug("Parameter 'token' is null.");
		} else if (StringUtils.isBlank(sign)) {
			error = "Parameter 'sign' is null.";
			logger.debug("Parameter 'sign' is null.");
		} else {
			SsoConfig config = SpringContext.getBean(SsoConfig.class);
			TreeMap<String, String> map = new TreeMap<String, String>();
			map.put("url", url);
			map.put("state", state);
			map.put("token", token);
			String buildSign = SignUtil.buildSign(map, config.getKey());
			if (!buildSign.equals(sign)){
				error = "Sign '" + sign + "' error.";
				logger.debug("Sign '" + sign + "' error.");
			} else {
				String sessionState = (String)request.getSession().getAttribute(CommonsConstant.SESSION_STATE);
				if (sessionState == null){
					error = "Session state error.";
					logger.debug("Session state error.");
				} else if (!sessionState.equals(state)){
					logger.debug("Receive state=" + state + ", sessionState=" + sessionState);
					error = "Session state not equals.";
				} else {
					String app = config.getApp();
					TreeMap<String, String> checkMap = new TreeMap<String, String>();
					checkMap.put("app", app);
					checkMap.put("token", token);
					String checkSign = SignUtil.buildSign(checkMap, config.getKey());
					CloseableHttpClient client = HttpClients.createDefault();
					HttpGet get = new HttpGet(config.getCheckUrl() + "?app=" + app + "&token=" + token + "&sign=" + checkSign);
					CloseableHttpResponse httpResponse = client.execute(get);
					int code = httpResponse.getStatusLine().getStatusCode();
					if (code != 200){
						error = "User Center error.";
						logger.debug("User Center error.");
					} else {
						HttpEntity entity = httpResponse.getEntity();
				        String str = EntityUtils.toString(entity, "utf-8");
				        logger.debug("SSO Server response:" + str);
				        SessionUser user = SignUtil.pareseSessionUser(str);
				        request.getSession().setAttribute(CommonsConstant.SESSION_USER, user);
				        response.sendRedirect(url);
				        return;
					}
				}
			}
		}
		response.getWriter().write("<html><body>" + error + "</body></html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
