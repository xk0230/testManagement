package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.service.AdminUserTrainService;


@Controller
@RequestMapping("/admin/user/train")
public class AdminUserTrianController extends BaseController{

	@Autowired
	private AdminUserTrainService userTrainService;
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@RequestMapping("/manager.do")
	public String trainManager(Model model,String userId){
		
		model.addAttribute("userId", userId);
		
		return "admin/train/trainManager";
	}
	
	
	
	
}
