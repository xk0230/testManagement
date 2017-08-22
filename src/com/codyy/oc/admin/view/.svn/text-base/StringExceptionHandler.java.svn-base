package com.codyy.oc.admin.view;

import org.apache.commons.lang.StringUtils;

import com.codyy.commons.utils.ResultJson;

public class StringExceptionHandler {

	public static ResultJson handlerException(Exception e) {
		if(StringUtils.contains(e.getMessage(), "ORA-12899")){
	    	return new ResultJson(false,"长度过长，操作失败！");
	    }else if(StringUtils.contains(e.getMessage(),"ORA-01461")){
	    	return new ResultJson(false,"长度过长，操作失败！");
	    }else{
	    	return new ResultJson(false,"操作失败！");
	    }
	}
	
	
	
	

}
