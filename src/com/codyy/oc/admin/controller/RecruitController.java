package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.codyy.oc.admin.entity.Competency;
import com.codyy.oc.admin.entity.Recruit;
import com.codyy.oc.admin.entity.RecruitAudit;
import com.codyy.oc.admin.service.CompetencyService;
import com.codyy.oc.admin.service.RecruitService;

@Controller
@RequestMapping("/admin/recruit")
public class RecruitController  extends BaseController{
	@Autowired
	private CompetencyService competencyService;
	@Autowired
	private RecruitService service;
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@ResponseBody
	@RequestMapping("getAllCompetency")
	public List<Competency> getAllCompetency(){
		return competencyService.getAll();
	}
	
	/**
	 * 添加/修改招聘需求
	 * @param request
	 * @param position
	 * @return
	 */
	@ResponseBody
	@RequestMapping("saveOrUpdateRecruit")
	public ResultJson  saveOrUpdateRecruit(HttpServletRequest request, Recruit recruit ){
		String userId = getSessionUserId(request);
		AdminUser sessionUser = getSessionUser(request);
		if(StringUtils.isEmpty(recruit.getId())){
			//如果没有ID则新增
			recruit.setCreateUser(userId);
			recruit.setEditUserPosition(sessionUser.getPosition());
			service.insert(recruit);
		}else {
			//如果有ID则是修改
			service.updateById(recruit);
		}
		return new ResultJson(true);
	}
	
	/**
	 * 提交审批
	 * @param request
	 * @param recruit
	 * @return
	 */
	@ResponseBody
	@RequestMapping("putAuditRecruit")
	public ResultJson  putAuditRecruit(HttpServletRequest request, Recruit recruit,String auditIds ){
		String[] ids = null;
		if(StringUtils.isNotEmpty(auditIds)) {
			 ids = auditIds.split("@");
		}
		service.putAuditRecruit(recruit, ids);
		return new ResultJson(true);
	}
	
	/**
	 * 审批招聘需求 -1:驳回，1通过
	 * @param request
	 * @param audit
	 * @return
	 */
	@ResponseBody
	@RequestMapping("auditRecruit")
	public ResultJson  auditRecruit(HttpServletRequest request, RecruitAudit audit,String auditIds){
		AdminUser sessionUser = getSessionUser(request);
		audit.setAuditUserId(sessionUser.getUserId());
		audit.setAuditUserPosition(sessionUser.getPosition());
		String[] ids = null;
		if(StringUtils.isNotEmpty(auditIds)) {
			 ids = auditIds.split("@");
		}
		return service.auditRecruit(audit,ids);
	}
	
	/**
	 * 根据ID获取招聘需求
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("getById")
	@ResponseBody
	public Recruit  getPositionById(HttpServletRequest request,@RequestParam(required=true) String id ){
		return service.getByid(id);
	}
	
	/**
	 * 根据查询条件分页获取招聘需求列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getRecruitPageList")
	public Page getRecruitPageList(HttpServletRequest request,Page page,Recruit search,String type){
		return service.getRecruitPageList(page, search);
	}
	
	@ResponseBody
	@RequestMapping("getMyAuditRecruitPageList")
	public Page getMyAuditRecruitPageList(HttpServletRequest request,Page page,Recruit search,String type){
		if(search==null) {
			search = new Recruit();
		}
		search.setCreateUser(getSessionUserId(request));
		return service.getMyAuditRecruitPageList(page, search);
	}
	
	
	/**
	 * 审核招聘需求
	 * @return
	 */
//	@ResponseBody
//	@RequestMapping("auditRec")
//	public ResultJson  auditRec(HttpServletRequest request, RecruitAudit audit){
//		return service.auditRec(audit);
//	}
	
}
