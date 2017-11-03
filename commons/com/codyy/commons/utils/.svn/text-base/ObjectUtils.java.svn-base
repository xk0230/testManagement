package com.codyy.commons.utils;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;

public class ObjectUtils {

	/**
	 * 
	 * getRandomPwd:随机生成N位数字字符串
	 * 
	 * @param num
	 * @return
	 */
	public static String getRandomPwd(int num) {
		Random random = new Random();
		String result = "";
		for (int i = 0; i < num; i++) {
			result += random.nextInt(10);
		}
		return result;
	}

	/**
	 * 
	 * getIpAddr:获取客户端IP地址
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	/**
	 * 将传入的JAVA对象转换成JSON字符串
	 * 
	 * @param Object
	 *            oo
	 * @return String
	 */
	public static String obj2Json(Object oo) {
		Gson gson = new Gson();
		String ss = gson.toJson(oo);
		return ss;
	}
}
