package com.codyy.oc.admin.servlet;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.codyy.commons.CommonsConstant;

public class AndroidFileUploadUtil {
	
	public static void addUploadFileToSession(HttpServletRequest request, String filename){
		@SuppressWarnings("unchecked")
		List<String> list = (List<String>)request.getSession().getAttribute(CommonsConstant.SESSION_ANDROID_FILE);
		if (list == null){
			list = new LinkedList<String>();
			request.getSession().setAttribute(CommonsConstant.SESSION_ANDROID_FILE, list);
		}
		list.add(filename);
	}
	
	public static void removeUploadFileFromSession(HttpServletRequest request, String filename){
		@SuppressWarnings("unchecked")
		List<String> list = (List<String>)request.getSession().getAttribute(CommonsConstant.SESSION_ANDROID_FILE);
		if (list != null){
			list.remove(filename);
		}
	}
}
