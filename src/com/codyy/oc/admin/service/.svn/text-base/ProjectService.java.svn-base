package com.codyy.oc.admin.service;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.BaseAreaMapper;
import com.codyy.oc.admin.dao.ProjectMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.ProjectRelationUser;
import com.codyy.oc.admin.view.ProjectSearchModel;
import com.codyy.oc.admin.view.ProjectView;
import com.codyy.oc.admin.view.StringExceptionHandler;


@Service
public class ProjectService {

	 @Autowired
	 private ProjectMapper projectMapper;
	 
	 @Autowired
	 private AdminUserMapper adminUserMapper;
	 
	 @Autowired
	 private BaseAreaMapper baseAreaMapper;
	

	 /**
	  * 
	  * @author xiaokan
	 * @Title: getProjectByArea
	 * @Description: (根据区域id获取项目列表)
	 * @param @param areaId
	 * @param @return
	 * @return List<Project>    
	 * @throws
	  */
	 public List<Project> getProjectByArea(String areaId){
		 return projectMapper.getProjectByArea(areaId);
	 }


	 /**
	  * 
	 	* @author zhangshuangquan
	 	* @Title: addProject
	 	* @Description: (添加项目)
	 	* @param @return    设定文件
	 	* @return String    返回类型
	 	* @throws
	  */
	public ResultJson addProject(Project project, String engineer) {
	 try {
		if(project!=null){
			boolean flag=false;
			project.setCreateTime(new Date());
			project.setUpdateTime(new Date());
			List<ProjectRelationUser> projectRelationUsers=null;
			//校验项目编号和项目名称是否已经存在
			int check=projectMapper.checkProjectIsExist(project);
			if(check>0){
				return new ResultJson(false, "很抱歉，项目编号或名称已存在，请重新输入！");
			}
			if(StringUtils.isNotBlank(engineer)){
				String[] str=engineer.split(",");
				projectRelationUsers=new ArrayList<ProjectRelationUser>();
				for(int i=0;i<str.length;i++){
					ProjectRelationUser pRelationUser=new ProjectRelationUser();
					pRelationUser.setProjectRelationUserId(UUIDUtils.getUUID());
					pRelationUser.setProjectId(project.getProjectId());
					pRelationUser.setAdminUserId(str[i]);
					projectRelationUsers.add(pRelationUser);
				}
				flag=true;
			}
			projectMapper.addProject(project);
			if(flag){
			  projectMapper.addProjectRelationUser(projectRelationUsers);
		    }
		    return new ResultJson(true,"添加成功!");
		}else {
			return new ResultJson(false,"添加失败！");
		}
		
	  }catch (Exception e) {
		  return  StringExceptionHandler.handlerException(e);    
	  }
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: getProjectById
    	* @Description: (编辑项目根据项目id取值)
    	* @param @return    设定文件
    	* @return String    返回类型
    	* @throws
     */
	public Map<String,Object> getProjectById(String projectId) {
		if(projectId!=null){
			Map<String,Object> result = new HashMap<String, Object>();
			Project project = projectMapper.getProjectById(projectId);
			AdminUser adminUser = adminUserMapper.getselcAdminUserById(project.getManagerId());
			//List<BaseArea> baseAreas = baseAreaMapper.getAreaByChildId(project.getBaseAreaId());
			List<AdminUser>  adminUsers = projectMapper.getProjectRelationUser(projectId);
			result.put("project",project);
			result.put("manager",adminUser);
			result.put("engineer",adminUsers);
			
			return result;
			
		}
		return null;
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: updateProject
    	* @Description: (更新项目)
    	* @param @return    设定文件
    	* @return String    返回类型
    	* @throws
     */
	public Map<String,Object> updateProject(Project project, String engineer) {
		Map<String,Object>  map = new HashMap<String, Object>();
	  try {

		if(project!=null){
			boolean flag=false;
			List<ProjectRelationUser> projectRelationUsers=null;
			if(StringUtils.isNotBlank(engineer)){
				String[] str=engineer.split(",");
				projectRelationUsers=new ArrayList<ProjectRelationUser>();
				for(int i=0;i<str.length;i++){
					ProjectRelationUser pRelationUser=new ProjectRelationUser();
					pRelationUser.setProjectRelationUserId(UUIDUtils.getUUID());
					pRelationUser.setProjectId(project.getProjectId());
					pRelationUser.setAdminUserId(str[i]);
					projectRelationUsers.add(pRelationUser);
				}
				flag=true;
				//判断该项目下是否有工程师
				int i=projectMapper.checkEngsExit(project.getProjectId());
				if(i>0){
					Map<String,Object>  check = new HashMap<String, Object>();
					check.put("projectId",project.getProjectId());
					check.put("users",projectRelationUsers);
							
					//判断该项目下的学校是否已经有工程师
					int m=projectMapper.checkSchoolEngsExist(check);
					if(m>0){
						map.put("result",new ResultJson(false,"工程师已分配在学校无法删除!"));
						return  map;
					}else{
						
						   projectMapper.updateProject(project);
						   if(flag){
							  projectMapper.deleteProjectRelationUser(projectRelationUsers);
							  projectMapper.addProjectRelationUser(projectRelationUsers);
						   }
						   map.put("result",new ResultJson(true,"编辑成功!"));
						   return map;
						
				 }
				  
		      }else{
		    	  
		    		  //项目下没有工程师，添加工程师
			    	  projectMapper.updateProject(project);
					  projectMapper.addProjectRelationUser(projectRelationUsers);
					  map.put("result",new ResultJson(true,"编辑成功!"));
					  return map;
		     }
			}else{
				//项目下已经存在工程师，并修改项目下工程师数为0
				int j=projectMapper.getSchoolCountByProjectId(project.getProjectId());
				if(j>0){
					map.put("result",new ResultJson(false,"工程师已分配在学校无法删除!"));
					return  map;
				}else{
					int i=projectMapper.checkEngsExit(project.getProjectId());
					if(i>0){
						
							projectMapper.updateProject(project);
							projectMapper.deletePRUserById(project.getProjectId()); 
							map.put("result",new ResultJson(true,"编辑成功!"));
						    return map;
					
						
					}else{
						
							projectMapper.updateProject(project);
							map.put("result",new ResultJson(true,"编辑成功!"));
						    return map;
						
					}
				}
			}
		}else {
			 map.put("result",new ResultJson(false,"编辑失败!"));
			 return map;
		}
		} catch (Exception e) {
			  map.put("result",StringExceptionHandler.handlerException(e));
			  return map;
		}
	}
	
	
	/**
	 * @author lichen
	* @Title: showProjList
	* @Description: (获得所有项目的列表)
	* @param @param page
	* @param @return    设定文件
	* @return List<Project>    返回类型
	* @throws
	 */
	public List<Project> showProjList(String baseAreaId,String projName,Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("baseAreaId", baseAreaId);
		map.put("projName",OracleKeyWordUtils.oracleKeyWordReplace(projName));//项目名
		page.setMap(map);//封装参数
		List<Project> proList= projectMapper.projPageList(page);
		return proList;
	}
	
	/**
	 * @param strEnd 
	 * @param strStart 
	 * 
		* @author zhangshuangquan
		* @Title: getProjectList
		* @Description: (查看项目列表)
		* @param @return    ProjectSearchModel
		* @return page    返回类型
		* @throws
	 */
	public Page getProjectList(Page page, ProjectSearchModel projectSearchModel,String sortDesc) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("provinceId","".equals(projectSearchModel.getAreaId())?null:projectSearchModel.getAreaId());
		map.put("projectName",OracleKeyWordUtils.oracleKeyWordReplace(projectSearchModel.getProjectName()));
		map.put("managerName",OracleKeyWordUtils.oracleKeyWordReplace(projectSearchModel.getManagerName()));
		map.put("sortDesc", sortDesc);
		map.put("explorationDesc", projectSearchModel.getExplorationDesc());
		map.put("installDesc", projectSearchModel.getInstallDesc());
		map.put("updateDesc", projectSearchModel.getUpdateDesc());
		page.setMap(map);
		List<ProjectView> projects = projectMapper.getProjectPageList(page);
		page.setData(projects);
		return page;
	}

	/**
	 *  
		* @author zhangshuangquan
		* @Title: 
		* @Description: (导出项目列表)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */

	public HSSFWorkbook exportProjectList(ProjectSearchModel projectSearchModel,String sortDesc) {
		Map<String,Object>  map = new HashMap<String, Object>();
		map.put("projectName",OracleKeyWordUtils.oracleKeyWordReplace(projectSearchModel.getProjectName()));
		map.put("managerName",OracleKeyWordUtils.oracleKeyWordReplace(projectSearchModel.getManagerName()));
		map.put("provinceId","".equals(projectSearchModel.getAreaId())?null:projectSearchModel.getAreaId());
		map.put("sortDesc", sortDesc);
		map.put("explorationDesc", projectSearchModel.getExplorationDesc());
		map.put("installDesc", projectSearchModel.getInstallDesc());
		map.put("updateDesc", projectSearchModel.getUpdateDesc());
		List<ProjectView> projectView = projectMapper.exportProjectList(map);
		for (ProjectView p : projectView) {
			 p.getUpdateTimes();
			 p.getExplorationProcess();
			 p.getInspectProcess();
			 p.getInstallProcess();
		}
		return ExcelAnnocationUtils.exportExcelData(ProjectView.class,projectView);
	}

    
	/**
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (根据项目id获取工程师并分页)
		* @param projectId    strStart strEnd设定文件
		* @return Page    返回类型
		* @throws
	 */
	public Page getEngineerByProjectId(String projectId, Page page) {
		Map<String,Object> map = new HashMap<String, Object>();
        map.put("projectId", projectId);	
	    page.setMap(map);
		List<AdminUser> engs=projectMapper.getEngineerByProjectIdPageList(page);
		page.setData(engs);
		return page;
	}

   /**
    * 
   	* @author zhangshuangquan
   	* @Title:    deleteProject
   	* @Description: (根据项目id删除项目)
   	* @param @return    设定文件
   	* @return String    返回类型
   	* @throws
    */
	public ResultJson deleteProject(String projectId) {
		if(StringUtils.isNotBlank(projectId)){
			//检测学校中是否有项目
			int i=projectMapper.getProjectRelationSchool(projectId);
			if(i>0){
				return new ResultJson(false,"该项目下有学校无法删除");
			}else {
				int j=projectMapper.deleteProject(projectId);
				if(j>0){
					return new ResultJson(true,"删除成功");
				}
			}
		}
		return null;
		
	}
	
}
