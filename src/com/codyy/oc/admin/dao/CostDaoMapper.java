package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSubTypeBean;
import com.codyy.oc.admin.vo.CostVO;

/**
 * 成本dao
 * @author Administrator
 *
 */
public interface CostDaoMapper {
	
	List<CostSubTypeBean> getCostSubTypeList(int castType);

	int insertCostEntity(CostEntityBean costEntityBean);
	
	int updateCostEntity(CostEntityBean costEntityBean);
	
	int delCostEntityById(String costId);
	
	List<CostEntityBean> getCostDeatilList(CostVO cost);
	
}
