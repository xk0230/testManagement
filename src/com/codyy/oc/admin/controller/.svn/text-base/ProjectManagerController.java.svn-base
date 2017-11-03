package com.codyy.oc.admin.controller;



import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.service.ProjectService;
import com.codyy.oc.admin.view.ProjectSearchModel;

@Controller
@RequestMapping("/admin/projectmanager/")
public class ProjectManagerController extends BaseController{
	
	@Autowired
	private ProjectService projectservice;
	
	/**
	 * 对前台传递的Date进行格式化规定
	 * @param binder
	 */
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toProjectList
		* @Description: (跳转到项目列表页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toprojectlist")
	public String toProjectList(){
		return "admin/projectManager/projectList";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toAddProject
		* @Description: (跳转到添加项目页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toaddproject")
	public String toAddProject(){
		return "admin/projectManager/addProject";
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowManagerList
		* @Description: (跳转到展示项目经理页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowmanagerlist")
	public String toShowManagerList(@RequestParam(required=false) String managerId,@RequestParam(required=false) String managerName,@RequestParam(required=false) String projectId,HttpServletRequest request){
		if(managerId != null && managerName != null && projectId != null){
			request.setAttribute("managerId",managerId);
            request.setAttribute("managerName",managerName);
            request.setAttribute("projectId",projectId);   
		}
		return "admin/projectManager/showManagerList";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowEngineerList
		* @Description: (跳转到展示工程师页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowengineerlist")
	public String toShowEngineerList(@RequestParam(required=false) String projectId,HttpServletRequest request){
		if(StringUtils.isNotBlank(projectId)){
			request.setAttribute("projectId",projectId);
		}
		return "admin/projectManager/showEngineerList";
	}
	
	/**
	 * 
	* @Title: getProjectByArea
	* @Description: (根据地区获取项目列表)
	* @param @param areaId
	* @param @return
	* @return List<Project>    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getprojectbyarea")
	public List<Project> getProjectByArea(String areaId){
		return projectservice.getProjectByArea(areaId);
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: addproject
		* @Description: (这里用一句话描述这个方法的作用)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("addproject")
	public ResultJson addProject(Project project,String engineer,HttpServletRequest request){
	    AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		String createUserId = adminUser.getAdminUserId();
		project.setCreateUserId(createUserId);
		project.setProjectId(UUIDUtils.getUUID());
	    return projectservice.addProject(project,engineer);
		
	}
	
	/**
	 * @author lichen
	* @Title: getProjectList
	* @Description: (选择项目的时候获得项目列表)
	* @param @param page
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getprojectlist")
	public Page getProjectList(String baseAreaId,String projName,Page page){
		List<Project> projList = projectservice.showProjList(baseAreaId,projName,page);
		page.setData(projList);
		return page;
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: editProject
		* @Description: (这里用一句话描述这个方法的作用)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("updateproject")
	public Map<String,Object> updateProject(Project project,String engineer){
	    return  projectservice.updateProject(project,engineer);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toUpdateProject
		* @Description: ()
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toeditproject")
	public String toUpdateProject(@RequestParam String projectId,HttpServletRequest request){
		request.setAttribute("data",projectservice.getProjectById(projectId));
		return "admin/projectManager/editProject";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getProjectList
		* @Description: (查询项目列表)
		* @return Page    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("getprojectlists")
	public Page getProjectLists(Page page,ProjectSearchModel projectSearchModel,String sortDesc){
		return projectservice.getProjectList(page,projectSearchModel,sortDesc);
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: exportProjectList
		* @Description: (导出项目列表中的全部内容)
		* @param ProjectSearchModel   HttpServletResponse
		* @throws
	 */
	@RequestMapping("exportprojectlist")
	public void exportProjectList(ProjectSearchModel projectSearchModel,HttpServletResponse response,String sortDesc){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportProjectList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook = projectservice.exportProjectList(projectSearchModel,sortDesc);
		    workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (展示工程师页面)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowengineer")
	public String toshowEngineer(String projectId,HttpServletRequest request){
		if(projectId!=null){
			request.setAttribute("projectId",projectId);
			
		}
		return "admin/projectManager/showEngineer";
	}
	
	
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (在项目列表中根据项目id查出该项目的工程师)
		* @param  projectId    
		* @return String    返回类型
		* @throws
	 */
	
	@ResponseBody
	@RequestMapping("showengineer")
	public Page showEngineer(String projectId,Page page){
		return projectservice.getEngineerByProjectId(projectId, page);
	
	}
	/**
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (这里用一句话描述这个方法的作用)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	
	@ResponseBody
	@RequestMapping("deleteproject")
	public ResultJson deleteProject(String projectId){
		return projectservice.deleteProject(projectId);
		
	}
}
