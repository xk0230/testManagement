package com.codyy.oc.admin.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.service.CostService;
import com.codyy.oc.admin.vo.CostChartsData;
import com.codyy.oc.admin.vo.CostChartsSeriesData;
import com.codyy.oc.admin.vo.CostChartsSeriesDataComparator;
import com.codyy.oc.admin.vo.CostTotalInOut;
import com.codyy.oc.admin.vo.CostVO;
import com.codyy.oc.admin.vo.CostYearVO;
import com.codyy.oc.admin.vo.DepMonthTotalVO;

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
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@RequestMapping("/costApply.do")
	public String costManager(){
		return "admin/cost/costApply";
	}
	
	@RequestMapping("/chart.do")
    public String costChar(){
        return "admin/cost/costChart";
    }
	
	@ResponseBody
    @RequestMapping("/costYear.do")
    public CostYearVO getRecentYear(int recentYear){
        
        return costService.getRecentYear(recentYear);
    }
	
	@ResponseBody
	@RequestMapping("/subType/{castType}.do")
	public JsonDto getCostSubTypeList(@PathVariable int castType){
		
		return costService.getCostSubTypeList(castType);
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateCost(HttpServletRequest request,CostEntityBean costEntityBean){

		return costService.insertOrUpdateCostEntity(this.getSessionUser(request),costEntityBean);
	}
	
	@ResponseBody
	@RequestMapping("/del/{costId}.do")
	public JsonDto delCostById(@PathVariable String costId){
		
		return costService.delCostEntityById(costId);
		
	}
	
/*	@ResponseBody
	@RequestMapping("/get/{costId}.do")
	public JsonDto getCostEntityById(@PathVariable String costId){
		
		return costService.getCostEntityById(costId);
		
	}*/
	
	@ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(HttpServletRequest request,CostVO cost){
		String userId = getSessionUserId(request);
		cost.setUserId(userId);
        return costService.getCostPageList(cost);
        
    }
	
	@ResponseBody
    @RequestMapping("/outlay.do")
    public CostChartsData getChartDataByOutlayType(HttpServletRequest request,int curYear){
		CostChartsData c= costService.getCostChartData(this.getSessionUser(request),0,curYear);
		List<CostChartsSeriesData>  ls = c.getSeriesData();
		Collections.sort(ls, new CostChartsSeriesDataComparator());
//		for (CostChartsSeriesData cc : ls) {
//			List<BigDecimal> Datas = cc.getData();
//			BigDecimal all = new BigDecimal(0.0);
//			for (BigDecimal d : Datas) {
//				all = all.add(d);
//			}
//			Datas.add(all);
//		}
//		c.getXcategories().add("总计");
        return c;
        
    }
	
	@ResponseBody
    @RequestMapping("/depIncome.do")
    public CostChartsData getChartDataByDepIncome(HttpServletRequest request,int curYear){
        
        return costService.getCostChartData(this.getSessionUser(request),1,curYear);
        
    }
	
	@ResponseBody
    @RequestMapping("/depOutcome.do")
    public CostChartsData getChartDataByDepOutcome(HttpServletRequest request,int curYear){
        
        return costService.getCostChartData(this.getSessionUser(request),2,curYear);
        
    }
	
	@ResponseBody
    @RequestMapping("/inbalance.do")
    public CostTotalInOut getCostTotalInOut(HttpServletRequest request,int curYear){
        
        return costService.getCostTotalInOut(this.getSessionUser(request),curYear);
        
    }
	
	@ResponseBody
    @RequestMapping("/depInOutcome.do")
    public List<CostChartsData> getChartDataByDepInOutcome(HttpServletRequest request,int curYear){
        
        return costService.getDepCostChartData(this.getSessionUser(request),curYear);
        
    }
	
	@ResponseBody
    @RequestMapping("/depMonthOut.do")
    public List<DepMonthTotalVO> getDepMonthTotalOutcome(HttpServletRequest request,int curYear){
        
        return costService.getDepMonthTotalOutcome(this.getSessionUser(request),curYear);
        
    }
	
}
