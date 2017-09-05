package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.StringUtils;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.PositionAudit;
import com.codyy.oc.admin.service.PositionService;
import com.codyy.oc.admin.view.PositionSearchView;

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
	
	/**
	 * 添加/修改岗位
	 * @param request
	 * @param position
	 * @return
	 */
	@ResponseBody
	@RequestMapping("saveOrUpdatePosition")
	public ResultJson  saveOrUpdatePosition(HttpServletRequest request, Position position ){
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

	/**
	 * 审批岗位 -1:驳回，1通过
	 * @param request
	 * @param audit
	 * @return
	 */
	@ResponseBody
	@RequestMapping("auditPosition")
	public ResultJson  auditPosition(HttpServletRequest request, PositionAudit audit){
		return service.auditPosition(audit);
	}
	
	/**
	 * 获取当前登录用户未处理的审批的数量
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getUntreatedNum")
	public ResultJson  getUntreatedNum(HttpServletRequest request){
		AdminUser su = getSessionUser(request);
		if(su == null) {
			return new ResultJson(false,"请登录");
		}
		return new ResultJson(true,service.getUntreatedNum(su.getUserId()));
	}
	
	/**
	 * 根据查询条件分页获取岗位列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getPositionPageList")
	public Page getPositionPageList(Page page,PositionSearchView search){
		return service.getPositionPageList(page, search);
	}
	
}
