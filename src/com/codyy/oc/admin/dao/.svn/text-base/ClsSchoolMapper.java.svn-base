package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.ClsClassroom;
import com.codyy.oc.admin.entity.ClsSchool;
import com.codyy.oc.admin.entity.ClsSchoolRUser;

public interface ClsSchoolMapper {
	int deleteByPrimaryKey(String clsSchoolId);

	int insert(ClsSchool record);

	int insertSelective(ClsSchool record);

	ClsSchool selectByPrimaryKey(String clsSchoolId);

	int updateByPrimaryKeySelective(ClsSchool record);

	int updateByPrimaryKey(ClsSchool record);
	
	List<ClsSchool> getSchoolList(@Param("projectId") String projectId,@Param("areaId") String areaId);

	Map<String, Object> getEngineerList(String projectId);

	Integer getSchoolCountByProjectId(Map<String, Object> map);

	List<ClsSchool> getSchoolByProjectId(Map<String, Object> map);

	List<AdminUser> getEngineerRelationSchool(String projectId);

	Integer addSchool(ClsSchool school);

	Integer addSchoolRUser(List<ClsSchoolRUser> clsSchoolRUsers);

	Integer getSchoolCount(Map<String, Object> map);

	List<ClsSchool> getSchoolLists(Map<String, Object> map);

	List<ClsSchool> exportSchoolList(Map<String, Object> map);

	ClsSchool getSchoolById(String schoolId);

	List<AdminUser> getEngineerBySchoolId(String schoolId);

	Integer updateSchool(ClsSchool school);

	Integer deleteSchoolRUser(String clsSchoolId);

	Integer checkSchoolRUser(Map<String, Object> check);
	
	List<ClsClassroom> getClassRoomBySchoolIdPageList(Page page);

	List<AdminUser> getEngineerBySchoolIdPageList(Page page);

	Integer deleteSchoolById(String clsSchoolId);

	Integer checkSchoolEngineer(String clsSchoolId);

	Integer checkClassroom(String clsSchoolId);

	List<ClsSchool> getSchoolPageList(Page page);

	List<ClsSchool> getSchoolByProjectIdPageList(Page page);
	
	void updateExplorationPress(String id);//更新学校，项目勘察进度

	void updateInstallPress(String id);//更新学校，项目安装进度
	
	void updateInspectPress(String id);//更新学校，项目调试进度
}