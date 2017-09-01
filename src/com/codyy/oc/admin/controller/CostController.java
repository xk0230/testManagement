package com.codyy.oc.admin.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSubTypeBean;
import com.codyy.oc.admin.service.CostService;

/**
 * 成本中心
 * @author Administrator
 *
 */

@Controller("/cost")
public class CostController {

	@Resource
	private CostService costService;
	
	@ResponseBody
	@RequestMapping("/subType/${castType}")
	public JsonDto getCostSubTypeList(@PathVariable int castType){
		
		return costService.getCostSubTypeList(castType);
	}
	
	@ResponseBody
	@RequestMapping(value = "/save",method = RequestMethod.POST)
	public JsonDto insertCost(@RequestBody CostEntityBean costEntityBean){
		
		return costService.insertCostEntity(costEntityBean);
	}
	
	@ResponseBody
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public JsonDto updateCost(@RequestBody CostEntityBean costEntityBean){
		
		return costService.updateCostEntity(costEntityBean);
	}
	
	@ResponseBody
	@RequestMapping("/del/${costId}")
	public JsonDto delCostById(@PathVariable String costId){
		
		return costService.delCostEntityById(costId);
		
	}
	
}
