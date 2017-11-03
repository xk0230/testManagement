package com.codyy.oc.admin.controller;

import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.codyy.oc.admin.service.ClassRoomService;
import com.codyy.oc.admin.view.ClsClassroomSearch;

@Controller
@RequestMapping("/admin/classroomenvir/")
public class ClassRoomEnvirController {

	@Autowired
	private ClassRoomService classroomservice;
	
	
	/**
	 * 
	* @Title: classroomlist
	* @Description: (教室列表页面)
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("classroomlist")
	public String classroomlist(){
		return "/admin/classroomenvirManager/classroomenvirlist";
	}
	
	
	/**
	 * 
	* @Title: exportProjectList
	* @Description: (导出教室列表)
	* @param @param clsClassroomSearch
	* @param @param response
	* @return void    
	* @throws
	 */
	@RequestMapping("exportclassroomlist")
	public void exportProjectList(ClsClassroomSearch clsClassroomSearch,HttpServletResponse response){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportEnvirSurveyList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=classroomservice.exportClassroomListEnvir(clsClassroomSearch);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
