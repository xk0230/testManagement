package com.codyy.commons.utils;

/**
 * 
 * ClassName:StringUtils
 * Function: 字符串个性化处理
 *
 * @author   zhangtian
 * @Date	 2015	2015年5月5日		上午11:12:06
 *
 */
public class StringUtils extends org.apache.commons.lang.StringUtils {

	public static String[] oldValue = new String[]{"&lt;", "&gt;","&amp;"} ;
	public static String[] newValue = new String[]{"<", ">","&"} ;
	
	/**
	 * 替换特殊字符
	 * @param str
	 * @return
	 * @author zhangtian
	 */
	public static String replaceEscapeChar(String str) {
		return StringUtils.replaceEach(str, oldValue, newValue) ;
	}
	
}
