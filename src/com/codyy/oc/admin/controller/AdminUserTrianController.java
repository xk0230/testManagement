package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUserTrain;
import com.codyy.oc.admin.service.AdminUserTrainService;


@Controller
@RequestMapping("/admin/train")
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
	
	@ResponseBody
    @RequestMapping("/page.do")
    public Page getTrainPageList(AdminUserTrain train){
        
        return userTrainService.getTrainPageList(train);
        
    }
    
    @ResponseBody
    @RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
    public JsonDto insertOrUpdateTrainEntity(HttpServletRequest request,AdminUserTrain train){
        
        return userTrainService.insertOrUpdateTrainEntity(this.getSessionUser(request),train);
    }
    
    @ResponseBody
    @RequestMapping("/del/{id}.do")
    public JsonDto delTrainEntityById(@PathVariable String id){
        
        return userTrainService.delTrainEntityById(id);
        
    }
    
    @ResponseBody
    @RequestMapping("/get/{id}.do")
    public JsonDto getTrainEntityById(@PathVariable String id){
        
        return userTrainService.getTrainEntityById(id);
        
    }
	
	
}
