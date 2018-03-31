/**
 * 
 */
package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.service.ProjectService;
import com.codyy.oc.admin.vo.ProjectVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ProjectController.java, v 0.1	2018年3月29日	下午7:16:00	Jason(pjx48476) $
 * @Description: TODO  
 */

@Controller
@RequestMapping("/project")
public class ProjectController extends BaseController {

	@Resource
	ProjectService projectService;
	

	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
		dateFormat.setLenient(false);  
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateProject(HttpServletRequest request,Project project){
		return projectService.insertOrUpdateProject(this.getSessionUser(request), project);
	}
	
	/**
	 * 合同申请
	 * @return
	 */
	@RequestMapping("/projectApply.do")
	public String projectApply(){
		return "admin/project/projectApply";
	}
	

	@ResponseBody
    @RequestMapping("/page.do")
    public Page getProjectPageList(HttpServletRequest request,ProjectVO projectVO){
		AdminUser user = getSessionUser(request);
		projectVO.setUserId(user.getUserId());
		projectVO.setUserPosition(user.getPosition());
		projectVO.setUserDepId(user.getDepId());
        return projectService.getProjectPageList(projectVO);
    }
	

	@ResponseBody
    @RequestMapping("/deleteProject.do")
    public JsonDto deleteContract(HttpServletRequest request,ProjectVO project){
		return projectService.deleteProject(project);
    }

}
