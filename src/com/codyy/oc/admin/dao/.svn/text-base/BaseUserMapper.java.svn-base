package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.BaseUser;

public interface BaseUserMapper {
	
	/**
	 * 
	 * insertSelective:(插入用户)
	 * @author ghost 
	 * @param baseUser
	 * @return
	 */
	public int insertSelective(BaseUser baseUser);
	

	/**
	 * 
	 * getOrgUserList:(这里用一句话描述这个方法的作用)
	 * @author yangyongwu 
	 * @param map
	 * @return
	 */
	public List<AdminUser> getOrgUserList(Map<String,Object> map);
	
	/**
	 * 
	 * getOrgUserCount:(获取机构用户总数)
	 * @author yangyongwu 
	 * @param map
	 * @return
	 */
	public int getOrgUserCount(Map<String,Object> map);
	
	/**
	 * 
	 * getBaseUserCountByUserName:(通过userName统计用户总数)
	 * 
	 * @author yangyongwu 
	 * @param userName
	 * @return
	 */
	public int getBaseUserCountByUserName(String userName);
	
	/**
	 * 
	 * deleteBaseUserById:(根据用户id删除用户)
	 * @author ghost 
	 * @param map(baseUserId,adminFlag)
	 * @return
	 */
	public int deleteBaseUserById(Map<String,String> map);
	
	/** 
	 * 根据行政区ID删除超级管理员
	 * @author Gwang 
	 * @param baseAreaId 
	 */
	void deleteBaseUserByAreaId(String baseAreaId);
	
	/** 
	 * 根据行政区ID获取超级管理员
	 * @author Gwang 
	 * @param baseAreaId
	 * @return 
	 */
	BaseUser getBaseUserByAreaId(String baseAreaId);
	

	/**
	 * 
	 * getBaseUserById:(通过userName统计用户总数)
	 * @author Mellon
	 * @param baseUserId
	 * @return BaseUser
	 */
	public BaseUser getBaseUserById(String baseUserId);
	
	/**
	 * 
	 * updateOrgUser:(跟新机构用户信息（密码、备注、姓名、电话、状态、功能）)
	 * 
	 * @author yangyongwu 
	 * @param baseUser
	 * @return
	 */
	int updateOrgUser(BaseUser baseUser);
	
	/**
	 * 
	 * getTeaUserList:获取教师用户列表
	 * @author chenjing
	 * @param map
	 * @return
	 */
	public List<BaseUser> getTeaUserPageList(Page page);
	
	
	public int importUsers(List<Object> list);
	
	/**
	 * 更新学校管理员根据学校id
	 * @param baseUser
	 * @return int
	 */
	public int updateSchoolAdminUserBySchoolId(BaseUser baseUser);
	
	/**
	 * 根据学校id删除用户
	 * @param clsSchoolId
	 * @return
	 */
	public int deleteBaseUserBySchoolId(String clsSchoolId);
	
	/**
	 * 根据学校id 获得用户数
	 * @param clsSchoolId
	 * @return
	 */
	public int getBaseUserCountBySchoolId(String clsSchoolId);

	/**
	 * findSchoolBasemesters:(查询学校所有的学段)
	 * @param string
	 * @return
	 * @author zhangtian
	 */
	public String findSchoolBasemesters(String schoolId);
}