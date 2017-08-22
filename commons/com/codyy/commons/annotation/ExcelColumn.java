package com.codyy.commons.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * ClassName:Excel
 * Function: Excel导出列头标记通用注解
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月24日		下午1:45:24
 *
 */
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ExcelColumn {

	String columnName() ;		// === 导出文件列名称
}
