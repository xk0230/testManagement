package com.codyy.commons.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;


/**
 * 
 * ClassName:AnnocationUtils
 * Function: 注解解析工具类
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月24日		下午1:54:33
 *
 */
public class ExcelAnnocationUtils {

	/**
	 * 
	 * getExcelModalInfo:(获取Excel的头部标题以及列头信息)
	 *
	 * @param clazz
	 * @return
	 * @author zhangtian
	 */
	public static HSSFWorkbook exportExcelData(Class<?> clazz, List<?> appDatas) {
		
		Map<String, Object> results = new HashMap<String, Object>() ;
		Field[] fields = clazz.getDeclaredFields() ;
		
		if(clazz.isAnnotationPresent(ExcelHeader.class)) {
			ExcelHeader excelHeader = clazz.getAnnotation(ExcelHeader.class) ;
			results.put("headerName", excelHeader.headerName()) ;
		}
		
		List<String> list = new ArrayList<String>() ;
		for(Field field : fields) {
			if(field.isAnnotationPresent(ExcelColumn.class)) {
				ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class) ;
				list.add(excelColumn.columnName()) ;
			}
		}
		
		results.put("columnNames", list) ;
		results.put("appDatas", appDatas) ;
		
		return (new ExcelUtils().exportContainDataExcelSheet(results, clazz));
	}
	
	/**
	 * 
	 * getExcelModalInfo:(获取Excel的头部标题以及列头信息)
	 *
	 * @param clazz
	 * @return
	 * @author zhangtian
	 */
	public static HSSFWorkbook exportExcelErrData(Class<?> clazz, List<?> appDatas) {
		
		Map<String, Object> results = new HashMap<String, Object>() ;
		Field[] fields = clazz.getDeclaredFields() ;
		
		if(clazz.isAnnotationPresent(ExcelHeader.class)) {
			ExcelHeader excelHeader = clazz.getAnnotation(ExcelHeader.class) ;
			results.put("headerName", excelHeader.headerName()) ;
		}
		
		List<String> list = new ArrayList<String>() ;
		for(Field field : fields) {
			if(field.isAnnotationPresent(ExcelColumn.class)) {
				ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class) ;
				list.add(excelColumn.columnName()) ;
			}
		}
		
		results.put("columnNames", list) ;
		results.put("appDatas", appDatas) ;
		
		return new ExcelUtils().exportContainErrorDataExcelSheet(results, clazz);
	}
}
