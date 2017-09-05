package com.codyy.oc.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.service.CostService;
import com.codyy.oc.admin.vo.CostChartsData;
import com.codyy.oc.admin.vo.CostInOutlayType;
import com.codyy.oc.admin.vo.CostTotalInOut;
import com.codyy.oc.admin.vo.CostVO;

/**
 * 成本中心
 * @author Administrator
 *
 */

@Controller
@RequestMapping("/admin/cost")
public class CostController extends BaseController{

	@Resource
	private CostService costService;
	
	@RequestMapping("/manager.do")
	public String costManager(){
		
		return "admin/cost/costManager";
	}
	
	@RequestMapping("/chart.do")
    public String costChar(){
        
        return "admin/cost/costChart";
    }
	
	@ResponseBody
	@RequestMapping("/subType/{castType}.do")
	public JsonDto getCostSubTypeList(@PathVariable int castType){
		
		return costService.getCostSubTypeList(castType);
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateCost(HttpServletRequest request,@RequestBody CostEntityBean costEntityBean){
		
		return costService.insertOrUpdateCostEntity(this.getSessionUser(request),costEntityBean);
	}
	
	@ResponseBody
	@RequestMapping("/del/{costId}.do")
	public JsonDto delCostById(@PathVariable String costId){
		
		return costService.delCostEntityById(costId);
		
	}
	
	@ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(@RequestBody CostVO cost){
        
        return costService.getCostPageList(cost);
        
    }
	
	@ResponseBody
    @RequestMapping("/outlay.do")
    public List<CostInOutlayType> getChartDataByOutlayType(HttpServletRequest request){
	    
        return costService.getChartDataByOutlayType(this.getSessionUser(request));
        
    }
	
	@ResponseBody
    @RequestMapping("/depIncome.do")
    public CostChartsData getChartDataByDepIncome(HttpServletRequest request){
        
        return costService.getCostChartDataByDepIncome(this.getSessionUser(request));
        
    }
	
	@ResponseBody
    @RequestMapping("/inbalance.do")
    public CostTotalInOut getCostTotalInOut(HttpServletRequest request){
        
        return costService.getCostTotalInOut(this.getSessionUser(request));
        
    }
	
}
