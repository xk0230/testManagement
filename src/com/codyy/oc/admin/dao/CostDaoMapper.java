package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSeqBean;
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
	
	int updateCostStatus(CostEntityBean costEntityBean);
	
	int delCostEntityById(String costId);
	
	CostEntityBean getCostEntityById(String costId);
	
	List<CostVO> getCostPageList(Page page);
	
	List<CostVO> getCostAuditPageList(Page page);
	
	List<CostMonthInOut> getCostOutlayType(CostVO cost);
	
	List<CostMonthInOut> getCostDepartIncomeType(CostVO cost);
	
	CostMonthInOut getCostInOutType(CostVO cost);

	List<CostMonthInOut> getCostDepartInOutcome(CostVO cost);

	List<CostVO> getCostVOList(CostVO cost);
	
	CostSeqBean getCostNoSeq(String costType);
	
	int updateCostNoSeq(CostSeqBean costSeqBean);
	
	int insertCostNoSeq(CostSeqBean costSeqBean);
}
