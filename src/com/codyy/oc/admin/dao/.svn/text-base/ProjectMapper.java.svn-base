package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.ProjectRelationUser;
import com.codyy.oc.admin.view.ProjectView;

public interface ProjectMapper {

    
    List<Project> getProjectByArea(String areaId);

	Integer addProject(Project project);
	
	Integer addProjectRelationUser(List<ProjectRelationUser> projectRelationUsers);

	Project getProjectById(String projectId);

	List<AdminUser> getProjectRelationUser(String projectId);

	Integer updateProject(Project project);

	Integer deleteProjectRelationUser(List<ProjectRelationUser> projectRelationUsers);
	
	/**
	 * @author lichen
	* @Title: projList
	* @Description: (获得所有的项目列表)
	* @param @return    设定文件
	* @return List<Project>    返回类型
	* @throws
	 */
	public List<Project> projPageList(Page page);
    
	Integer getProjectCount(Map<String, Object> map);

	List<ProjectView> getProjectList(Map<String, Object> map);

	List<ProjectView> exportProjectList(Map<String, Object> map);

	List<AdminUser> getEngineerList(String projectId);
	
	Integer getEngineerCountByProjectId(Map<String, Object> map);

	List<AdminUser> getEngineerByProjectId(Map<String, Object> map);

	Integer checkProjectIsExist(String projectCode, String projectName);

	Integer checkProjectIsExist(Project project);

	Integer checkSchoolEngsExist(Map<String, Object> check);

	Integer checkEngsExit(String string);

	Integer getProjectRelationSchool(String projectId);

	Integer deleteProject(String projectId);

	void deletePRUserById(String projectId);

	Integer getSchoolCountByProjectId(String projectId);

	List<ProjectView> getProjectPageList(Page page);

	List<AdminUser> getEngineerByProjectIdPageList(Page page);

	void updateExplorationPress(String id);//更新项目勘察进度

	void updateInstallPress(String id);//更新项目安装进度
	
	void updateInspectPress(String id);//更新项目调试进度

	
}