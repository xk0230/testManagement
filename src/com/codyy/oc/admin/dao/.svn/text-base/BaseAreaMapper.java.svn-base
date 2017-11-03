package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.oc.admin.entity.BaseArea;
import com.codyy.oc.admin.view.SelectModel;

public interface BaseAreaMapper {
	/*int deleteByPrimaryKey(String baseAreaId);

	int insert(BaseArea record);

	int insertSelective(BaseArea record);

	BaseArea selectByPrimaryKey(String baseAreaId);

	int updateByPrimaryKeySelective(BaseArea record);

	int updateByPrimaryKeyWithBLOBs(BaseArea record);

	int updateByPrimaryKey(BaseArea record);*/

	/**
	 * 
	 * getBaseAreaByparentId:(根据parentId获取该parentId下的所有直属行政区，若parentId为空，则获取所有第一级行政区
	 * )
	 * 
	 * @author zhangshuangquan
	 * @param map
	 *            (parentId)
	 * @return
	 */
	List<SelectModel> getBaseAreaByParentId(Map<String, String> map);

	
	/**
	 * 
	 * getAreaByServerId:根据服务器ID查询所有行政区域
	 * 
	 * @author chenjing
	 * @param map
	 * @return
	 */
	List<BaseArea> getAreaByServerId(Map<String, Object> map);
	
	/** 
	 * 根据名称或代码查询行政区 
	 * @author Gwang 
	 * @param map
	 * @return 
	 */
	BaseArea getAreaByProperty(Map<String, Object> map);
    
    /**
     * 
     * getParentAreaByid:根据Id查询服务器配置不同的最近父级行政区
     * @author chenjing
     * @param map
     * @return
     */
    BaseArea getParentAreaByid(Map<String, Object> map);
    
    /**
     * 
     * updateAreaById:根据Id更新行政区服务器信息
     * @author chenjing
     * @param map
     * @return
     */
    int updateAreaById(Map<String, Object> map);
    
    /** 
     * 获取同级最大排序
     * @author Gwang 
     * @param map
     * @return 
     */
    Integer getMaxSortByParentId(Map<String, Object> map);

    /**
     * 
     * getAreaByChildId:(根据区域ID查询其所有上级的区域)
     *
     * @param baseAreaId
     * @return
     * @author zhangtian
     */
	List<BaseArea> getAreaByChildId(String baseAreaId);
	
	/** 
	 * 根据区域ID查询其所有下级的区域
	 * @author Gwang 
	 * @param baseAreaId
	 * @return 
	 */
	List<BaseArea> getChildrenAreaByParentId(String baseAreaId);
	
	void updateSortBatch(List<BaseArea> areas);
	
	/**
	 * 根据地区全路径名查询baseAreaId
	 * @param areaPath
	 * @return
	 */
	String getBaseAreaIdByAreaPath(String areaPath);
	
	int getChildCount(String id);

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: getBaseArea
    	* @Description: (获取所有行政区)
    	* @return SelectModel    返回类型
    	* @throws
     */
	List<SelectModel> getBaseArea(String id);
}