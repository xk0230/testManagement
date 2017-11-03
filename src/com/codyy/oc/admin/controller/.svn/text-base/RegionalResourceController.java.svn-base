package com.codyy.oc.admin.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.RegRProject;
import com.codyy.oc.admin.entity.RegionalResource;
import com.codyy.oc.admin.service.RegRProjectService;
import com.codyy.oc.admin.service.RegionalResourceService;
import com.codyy.oc.admin.view.RegionalResourceSearch;
@Controller
@RequestMapping("/admin/arearesource/")
public class RegionalResourceController {

	@Autowired
	private RegionalResourceService regionalResourceService;
	
	@Autowired
	private RegRProjectService regRProjectService;
	
	/**
	 * @author lichen
	* @Title: insertAreaResource
	* @Description: (添加资源模块)
	* @param @param request
	* @param @param areaResource    设定文件
	* @return void    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("insertareasource")
	public ResultJson insertAreaResource(HttpServletRequest request,RegionalResource areaResource,String projectIdStr,String[] newFileName, String[] oraginalFileName){
		
		List<String> projIdList= new ArrayList<String>();
		if(projectIdStr!=null){
			String[] arrProjectId =projectIdStr.split(",");
			for(int i=0; i<arrProjectId.length; i++){
				//System.out.println(i+1+"=="+arrProjectId[i]);
				projIdList.add(arrProjectId[i]);
			}
		}
		
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		//将封装好的项目id集合赋给用户项目表对象
		areaResource.setRegionalResourceId(UUIDUtils.getUUID());//给新创建区域资源添加uuid
		areaResource.setCreate_User(adminUser.getAdminUserId());
		areaResource.setCreate_Time(new Date());
		//添加资源表与项目表之间的关系
		RegRProject regRProject = new RegRProject();
		regRProject.setProjectIdList(projIdList);
		regRProject.setRegionalResourceId(areaResource.getRegionalResourceId());
		
		List<Attachment> attachMentList = new ArrayList<Attachment>();
		if(newFileName!=null && newFileName.length>0 && oraginalFileName!=null && oraginalFileName.length>0 ){
			for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				Attachment attachment = new Attachment();
				attachment.setRelationShipId(areaResource.getRegionalResourceId());
				attachment.setAttachment_Url(newFileName[i]);
				attachment.setName(oraginalFileName[i]);
				attachment.setCreate_time(new Date());
				attachMentList.add(attachment);	
			}
		}
		
		//添加用户基本信息
	   return  regionalResourceService.insertAreaResource(areaResource,regRProject,attachMentList);	
		
	}
	
	/**
	 * @author lichen
	* @Title: selectAreaResourcePageList
	* @Description: (实现按条件搜索的分页)
	* @param @param page
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("arearesourcepageList")
	public Page selectAreaResourcePageList(String baseAreaId,String name,String type,String contactPersonName,String contactPersonPhone,String projectName,Page page){
		
		List<RegionalResource> areaResourceList=regionalResourceService.selectAreaResourcePageList(baseAreaId,name,type,contactPersonName,contactPersonPhone,projectName,page);
		page.setData(areaResourceList);
		return page;
	}
	
	/**
	 * @author lichen
	* @Title: deleteByPrimaryKey
	* @Description: (根据id来删除用户资源)
	* @param @param regionalResourceId    设定文件
	* @return void    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("deletearearesource")
	 public void deleteByPrimaryKey(String regionalResourceId){
		
		//删除id对应的资源表的记录
		 regionalResourceService.deleteByPrimaryKey(regionalResourceId);
	 }
	/**
	 * @author lichen
	* @Title: getProResouce
	* @Description: (实现项目的分页操作)
	* @param @param resourceUser_Id
	* @param @param page
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getproresource")
	public Page getProResouce(String supplier_Id,Page page){
		
		List<Project> proList =regionalResourceService.selcProjPageList(supplier_Id, page);
		
		page.setData(proList);
		return page;
	}
	
	/**
	 * @author lichen
	* @Title: jumpToProject
	* @Description: (跳转到项目列表显示页面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoproject")
	public String jumpToProject(HttpServletRequest request,String supplier_Id){
	
		request.setAttribute("uId", supplier_Id);
		return "admin/projectManager/showProjectList";
	}
	
	/**
	 * @author lichen
	* @Title: updateRegResource
	* @Description: (编辑区域资源信息)
	* @param @param regionalResource
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	@ResponseBody //可以得到返回的行数
	@RequestMapping("updateregresource")
	public ResultJson updateRegResource(RegionalResource regionalResource, String projList,String[] newFileName, String[] oraginalFileName){
	
		List<Attachment> qualifiList = new ArrayList<Attachment>();
		  
	    if(newFileName!=null && oraginalFileName!=null){
	    	
	    	for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				Attachment qualifi = new Attachment();
				qualifi.setRelationShipId(regionalResource.getRegionalResourceId());
				qualifi.setAttachment_Url(newFileName[i]);
				qualifi.setName(oraginalFileName[i]);
				qualifi.setCreate_time(new Date());
				qualifiList.add(qualifi);
			}
	    }
		
		List<String> projectList = new ArrayList<String>();
		if(projList!=null){
			String[] projectIdList=projList.split(",");
			
			for(int i=0; i<projectIdList.length; i++){
				
				projectList.add(projectIdList[i]);
			}
		}

				RegRProject regRProject = new RegRProject();
				regRProject.setProjectIdList(projectList);
				regRProject.setRegionalResourceId(regionalResource.getRegionalResourceId());
				//根据资源的id来修改资源的信息
			return regionalResourceService.updateRegResource(regionalResource,regRProject,qualifiList);
				
	}
	
	/**
	 * @author lichen
	* @Title: selcProById
	* @Description: (根据资源的id来获取本资源选中的所有项目的集合)
	* @param @param RegionalResourceId
	* @param @return    设定文件
	* @return List<Project>    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selcprobyId")
	public List<Project> selcProById(String RegionalResourceId){
		return regionalResourceService.selcProById(RegionalResourceId);
	}
	
	/**
	 * @author lichen
	* @Title: exportRegionalResource
	* @Description: (导出区域资源列表数据)
	* @param     设定文件
	* @return void    返回类型
	* @throws
	 */
	@RequestMapping("exportRegionalResource")
	public void exportRegionalResource(RegionalResourceSearch resourceSearch, HttpServletResponse response){
		
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportResourceList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=regionalResourceService.exportResourceList(resourceSearch);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
