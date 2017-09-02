package com.codyy.oc.admin.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.service.CostService;

/**
 * 成本中心
 * @author Administrator
 *
 */

@Controller
@RequestMapping("/cost")
public class CostController extends BaseController{

	@Resource
	private CostService costService;
	
	@RequestMapping("/manager.do")
	public String costManager(){
		
		return "cost/costManager";
	}
	
	@ResponseBody
	@RequestMapping("/subType/{castType}.do")
	public JsonDto getCostSubTypeList(@PathVariable int castType){
		
		return costService.getCostSubTypeList(castType);
	}
	
	@ResponseBody
	@RequestMapping(value = "/save.do",method = RequestMethod.POST)
	public JsonDto insertCost(@RequestBody CostEntityBean costEntityBean){
		
		return costService.insertCostEntity(costEntityBean);
	}
	
	@ResponseBody
	@RequestMapping(value = "/update.do",method = RequestMethod.POST)
	public JsonDto updateCost(@RequestBody CostEntityBean costEntityBean){
		
		return costService.updateCostEntity(costEntityBean);
	}
	
	@ResponseBody
	@RequestMapping("/del/{costId}.do")
	public JsonDto delCostById(@PathVariable String costId){
		
		return costService.delCostEntityById(costId);
		
	}
	
}
