package com.codyy.oc.admin.view;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.codyy.commons.utils.StringUtils;

public class AreaSubjectStaExcel extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook wb, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HSSFSheet sheet = wb.createSheet("学科统计");
		HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        sheet.setDefaultColumnStyle(0, style);
        sheet.setDefaultColumnStyle(1, style);
        sheet.setDefaultColumnStyle(2, style);
        sheet.setDefaultColumnStyle(3, style);
        sheet.setDefaultColumnStyle(4, style);
        sheet.setDefaultColumnStyle(5, style);
        
        sheet.setColumnWidth(0, 15*256);
        sheet.setColumnWidth(1, 15*256);
        sheet.setColumnWidth(2, 15*256);
        sheet.setColumnWidth(3, 15*256);
        sheet.setColumnWidth(4, 15*256);
        sheet.setColumnWidth(5, 15*256);

		//形成表格
        HSSFCellStyle headerStyle = wb.createCellStyle();   
        HSSFFont font = wb.createFont();  
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        headerStyle.setFont(font);
        
        String startDt = model.get("startDt").toString();
        String endDt = model.get("endDt").toString();
        HSSFCell startDtTitleCol = getCell(sheet, 0, 0);
        startDtTitleCol.setCellStyle(headerStyle);
        startDtTitleCol.setCellValue("起始日期：");
        HSSFCell startDtValCol = getCell(sheet, 0, 1);
        startDtValCol.setCellValue(startDt);
        HSSFCell endDtTitleCol = getCell(sheet, 0, 2);
        endDtTitleCol.setCellStyle(headerStyle);
        endDtTitleCol.setCellValue("结束日期：");       
        HSSFCell endDtValCol = getCell(sheet, 0, 3);
        endDtValCol.setCellValue(endDt);
        
        HSSFCell col1 = getCell(sheet, 1, 0);
        col1.setCellStyle(headerStyle);
        HSSFCell col2 = getCell(sheet, 1, 1);
        col2.setCellStyle(headerStyle);
        HSSFCell col3 = getCell(sheet, 1, 2);
        col3.setCellStyle(headerStyle);
        HSSFCell col4 = getCell(sheet, 1, 3);
        col4.setCellStyle(headerStyle);
        HSSFCell col5 = getCell(sheet, 1, 4);
        col5.setCellStyle(headerStyle);
        HSSFCell col6 = getCell(sheet, 1, 5);
        col6.setCellStyle(headerStyle);
        
       Boolean isLastArea = Boolean.valueOf(model.get("isLastArea").toString()); 
       if(isLastArea){
    	   col1.setCellValue("学校");
       } else {
    	   col1.setCellValue("地区");
       }
       
       col2.setCellValue("学科");
       col3.setCellValue("计划开课节数");
       col4.setCellValue("应开课节数");
       col5.setCellValue("实开课节数");
       col6.setCellValue("开课节数比例");
		
		@SuppressWarnings("unchecked")
		List<AreaSubjectStaView> data = (List<AreaSubjectStaView>)model.get("data");
		AreaSubjectStaView viewObj = null;
		int rowNum = 2;
		DecimalFormat df=new DecimalFormat("#.##");
		for(int i = 0;i<data.size();i++){
			viewObj = data.get(i);
			
		//	String rate = "0.0".equals(viewObj.getDownRate()) ? "0" : viewObj.getDownRate().replace(".0", "");
			
			getCell(sheet, i+rowNum, 0).setCellValue(StringUtils.replaceEscapeChar(viewObj.getAreaName()));
			getCell(sheet, i+rowNum, 1).setCellValue(StringUtils.replaceEscapeChar(viewObj.getSubjectName()));
			getCell(sheet, i+rowNum, 2).setCellValue(viewObj.getPlanCnt());
			getCell(sheet, i+rowNum, 3).setCellValue(viewObj.getRequiredCnt());
			getCell(sheet, i+rowNum, 4).setCellValue(viewObj.getDownCnt());
			getCell(sheet, i+rowNum, 5).setCellValue(df.format(viewObj.getDownRate())+"%");
		}
		
	}
	
	

}
