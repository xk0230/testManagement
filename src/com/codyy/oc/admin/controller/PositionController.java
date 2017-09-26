package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.codyy.oc.commons.sso.SessionUser;

@Controller
@RequestMapping("/admin/position/")
public class PositionController extends BaseController {
	
	
	@Autowired
	private PositionService service;
	
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	/**
	 * 
		* @Title: toPostionList
		* @Description: (岗位列表)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toPostionList")
	public String toPostionList(HttpServletRequest request,String type){
		request.setAttribute("type", type);
		return "admin/postion/postionManager";
	}
	
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
	
	@RequestMapping("getPositionById")
	@ResponseBody
	public Position  getPositionById(HttpServletRequest request,@RequestParam(required=true) String id ){
		return service.getPositionById(id);
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
		if(StringUtils.isEmpty(position.getPostId())){
			//如果没有ID则新增
			position.setCreateUser(userId);
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
//		return new ResultJson(true,1);
	}
	
	/**
	 * 根据查询条件分页获取岗位列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getPositionPageList")
	public Page getPositionPageList(HttpServletRequest request,Page page,PositionSearchView search,String type){
		
		return service.getPositionPageList(page, search);
	}
//	
	
	@ResponseBody
	@RequestMapping("getPositionAuditPageList")
	public Page getPositionAuditPageList(HttpServletRequest request,Page page,PositionSearchView search){
		AdminUser su = getSessionUser(request);
		//只查询分配给自己的审批
		if(search.getAudit() == null) {
			PositionAudit audit = new PositionAudit();
			audit.setAuditUserId(su.getUserId());
			search.setAudit(audit);
		}else {
			search.getAudit().setAuditUserId(su.getUserId());
		}
		return service.getPositionAuditPageList(page, search);
	}
	
	
	@ResponseBody
	@RequestMapping("getPositionAuditDetailPageList")
	public Page getPositionAuditDetailPageList(HttpServletRequest request,Page page,PositionSearchView search){
		AdminUser su = getSessionUser(request);
		//只查询分配给自己的审批
		search.setCreateUser(su.getUserId());
		if(search.getAudit() == null) {
			PositionAudit audit = new PositionAudit();
			audit.setCreateUserId(su.getUserId());
//			audit.setAuditUserId(su.getUserId());
			audit.setResult(-1);
			search.setAudit(audit);
		}else {
			search.getAudit().setAuditUserId(su.getUserId());
			search.getAudit().setResult(-1);
		}
		return service.getPositionAuditPageList(page, search);
	}
	
	
	
	
}
