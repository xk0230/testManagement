package com.codyy.oc.admin.view;

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

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.utils.StringUtils;

public class AreaOpenProfileDetailExcel extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook wb, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HSSFSheet sheet = wb.createSheet("开课详情");
		HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        sheet.setDefaultColumnStyle(0, style);
        sheet.setDefaultColumnStyle(1, style);
        sheet.setDefaultColumnStyle(2, style);
        sheet.setDefaultColumnStyle(3, style);
        sheet.setDefaultColumnStyle(4, style);
        sheet.setDefaultColumnStyle(5, style);
        sheet.setDefaultColumnStyle(6, style);
        sheet.setDefaultColumnStyle(7, style);
        
        sheet.setColumnWidth(0, 15*256);
        sheet.setColumnWidth(1, 15*256);
        sheet.setColumnWidth(2, 15*256);
        sheet.setColumnWidth(3, 15*256);
        sheet.setColumnWidth(4, 15*256);
        sheet.setColumnWidth(5, 15*256);
        sheet.setColumnWidth(6, 15*256);
        sheet.setColumnWidth(7, 15*256);

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
        HSSFCell col7 = getCell(sheet, 1, 6);
        col7.setCellStyle(headerStyle);
        HSSFCell col8 = getCell(sheet, 1, 7);
        col8.setCellStyle(headerStyle);
       
       String classroomType = model.get("classroomType").toString();
       col1.setCellValue("学校名称");
       if(classroomType.equals(CommonsConstant.CLASSROOM_TYPE_MASTER)){
    	   col2.setCellValue("主讲教室名称");
       } else {
    	   col2.setCellValue("接收教室名称");
       }
       col3.setCellValue("课表名称");
       col4.setCellValue("排课日期");
       col5.setCellValue("周次");
       col6.setCellValue("星期");
       col7.setCellValue("节次");
       col8.setCellValue("状态");
		
		@SuppressWarnings("unchecked")
		List<AreaOpenProfileDetailView> data = (List<AreaOpenProfileDetailView>)model.get("data");
		AreaOpenProfileDetailView viewObj = null;
		int rowNum = 2;
		for(int i = 0;i<data.size();i++){
			viewObj = data.get(i);
			
			getCell(sheet, i+rowNum, 0).setCellValue(StringUtils.replaceEscapeChar(viewObj.getSchoolName()));
			getCell(sheet, i+rowNum, 1).setCellValue(StringUtils.replaceEscapeChar(viewObj.getClassroomName()));
			getCell(sheet, i+rowNum, 2).setCellValue(StringUtils.replaceEscapeChar(viewObj.getScheduleName()));
			getCell(sheet, i+rowNum, 3).setCellValue(viewObj.getScheduleDate());
			getCell(sheet, i+rowNum, 4).setCellValue(viewObj.getWeekSeq());
			getCell(sheet, i+rowNum, 5).setCellValue(formSeq(viewObj.getDaySeq()));
			getCell(sheet, i+rowNum, 6).setCellValue(formSeq(viewObj.getClassSeq()));
			getCell(sheet, i+rowNum, 7).setCellValue(formStatus(viewObj.getStatus()));
		}
		
	}
	
	private String formStatus(String status){
		String statusName = "有效授课";
		if(status.equals(CommonsConstant.CLASS_STA_STATUS_VALID)){
			statusName = "有效授课";
		} else if(status.equals(CommonsConstant.CLASS_STA_STATUS_INVALID)){
			statusName = "无效授课";
		} else if(status.equals(CommonsConstant.CLASS_STA_STATUS_REASONABLE_MISSED)){
			statusName = "因故停课";
		} else if(status.equals(CommonsConstant.CLASS_STA_STATUS_UNREASONABLE_MISSED)){
			statusName = "无故停课";
		}
		return statusName;		
	}
	
	private String formSeq(String seq){
		int index = Integer.valueOf(seq);
		String x = "";
		switch (index){
			 case 1:
		   	   x="一";
		   	   break;
		   	 case 2:
		   	   x="二";
		   	   break;
		   	 case 3:
		   	   x="三";
		   	   break;
		   	 case 4:
		   	   x="四";
		   	   break;
		   	 case 5:
		   	   x="五";
		   	   break;
		   	 case 6:
		   	   x="六";
		   	   break;
		   	 case 7:
		   	   x="七";
		   	   break;
		   	 case 8:
		   	   x="八";
		   	   break;
		}
		return x;
	}
	
	

}
