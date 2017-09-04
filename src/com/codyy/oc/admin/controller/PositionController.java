package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.StringUtils;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.service.PositionService;
import com.codyy.oc.commons.sso.SessionUser;

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
	
	@ResponseBody
	@RequestMapping("saveOrUpdatePosition")
	public ResultJson  insertAdminUser(HttpServletRequest request, Position position ){
		String userId = getSessionUserId(request);
		position.setCreateUser(userId);
		if(StringUtils.isEmpty(position.getPostId())){
			//如果没有ID则新增
			service.insert(position);
		}else {
			//如果有ID则是修改
			service.updateById(position);
		}
		return new ResultJson(true);
	}
}
