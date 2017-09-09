package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSubTypeBean;
import com.codyy.oc.admin.vo.CostMonthInOut;
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
	
	CostEntityBean getCostEntityById(String costId);
	
	List<CostVO> getCostPageList(Page page);
	
	List<CostMonthInOut> getCostOutlayType(CostVO cost);
	
	List<CostMonthInOut> getCostDepartIncomeType(CostVO cost);
	
	CostMonthInOut getCostInOutType(CostVO cost);
	
}
