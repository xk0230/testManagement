package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.service.PositionService;

@Controller
@RequestMapping("/admin/position/")
public class PositionController extends BaseController {
	
	
	@Autowired
	private PositionService service;
	
	
	/**
	 * 
	 * 根据部门ID获取所有岗位
	 * @param request
	 * @param adUser
	 * @return
	 */
	@RequestMapping("getPositionByDepId")
	@ResponseBody
	public List<Position>  testimg(HttpServletRequest request,@RequestParam(required=true) String depId ){
		return service.getPositionByDepId(depId);
	}
	
}
