package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.codyy.oc.admin.entity.BaseArea;
import com.codyy.oc.admin.view.BaseAreaView;
import com.codyy.oc.admin.view.SelectModel;

public interface CommonsMapper {

	/**
	 * 
	 * getAreaByparentId:(根据parentId获取该parentId下的所有直属行政区，若parentId为空，则获取所有第一级行政区
	 * )
	 * 
	 * @author yangyongwu
	 * @param map(parentId)
	 * @return
	 */
//	List<SelectModel> getAreaByparentId(Map<String, String> map);
	
	
	/**
	 * 
	 * getFullAreaName:(获取区域全名)
	 * @author yangyongwu 
	 * @param baseAreaId
	 * @return
	 */
	String getFullAreaName(String baseAreaId);
	
	/**
	 * 
	 * getSelectModelByAreaCode:(根据区域code获取)
	 * @author ghost 
	 * @param areaCode
	 * @return
	 */
	SelectModel getSelectModelByAreaCode(String areaCode);


	public List<BaseAreaView> getAreasAndLevelByParentId(Map<String, String> map);
	
	public BaseAreaView getAreaById(Map<String, String> map);
	
	/**
	 * 查询学校<br/>
	 * 1、区域为空时，表示查询所有学校<br/>
	 * 2、有区域id号时，查询当前区域下的学校<br/>
	 * 
	 * @param areaId
	 * @return
	 */
	public List<SelectModel> getSchoolByAreaId(Map<String, String> map);
	
	public List<BaseArea> getRootArea();
	
	
	/**
	 * 
	 * getBaseAreaByParentId:(根据父级ID获取子区域)
	 * @param parentId
	 * @return
	 */
	public List<BaseArea> getBaseAreaByParentId(@Param(value="parentId") String parentId);
	
	/**
	 * 获取所有的学科信息
	 * 
	 * @return
	 */
	public List<SelectModel> getAllSubjects();
	
	/**
	 * getBaseAreaById:(根据ID获取区域对象)
	 * @param areaId
	 * @return
	 */
	public BaseArea getBaseAreaById(String areaId);
	
	/**
	 * 查询多学校<br/>
	 * 1、区域为空时，表示查询所有学校<br/>
	 * 2、有区域id号时，查询当前区域下的学校<br/>
	 * 
	 * @param areaId
	 * @return
	 */
	public List<SelectModel> getSchoolsByAreaId(Map<String, String> map);
	
	/**
	 * 用于判断当前的区域是否为最低层区域
	 * @param areaId
	 * @return
	 */
	public BaseArea getBaseAreaByMaxLevelAndId(String areaId);
	
	/**
	 * <p>获取用户全地址路径</p>
	 * <pre>
	 * 如果USER_TYPE = AREA_USR, 返回地区路径
	 * 如果USER_TYPE = SCHOOL_USR ， 返回地区路径 + 学校名
	 * 如果USER_TYPE = TEACHER ， 返回地区路径 + 学校名 + 教师姓名
	 * </pre>
	 * @param baseUserId
	 * @return String
	 */
	public String getFullPathByUserId(String baseUserId);
	
	/**
	 * 
	* @Title: getCount
	* @Description: 获取总数统计
	* @param @return
	* @return List<String>    
	* @throws
	 */
	public List<String> getCount();
	
	/**
	 * 
	* @Title: getZhouCount
	* @Description: 获取上周新增统计
	* @param @return
	* @return List<String>    
	* @throws
	 */
	public List<String> getZhouCount();
}
