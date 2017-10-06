package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.codyy.oc.admin.entity.Candidate;
import com.codyy.oc.admin.entity.CandidateRInterviewer;
import com.codyy.oc.admin.service.CandidateService;

@Controller
@RequestMapping("/admin/candidate")
public class CandidateController  extends BaseController{
	@Autowired
	private CandidateService service;
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
/**
	 * 添加/修改候选人
	 * @param request
	 * @param position
	 * @return
	 */
	@ResponseBody
	@RequestMapping("saveOrUpdateCandidate")
	public ResultJson  saveOrUpdateCandidate(HttpServletRequest request, Candidate candidate ){
		if(StringUtils.isEmpty(candidate.getId())){
			//如果没有ID则新增
			service.insert(candidate);
		}else {
			//如果有ID则是修改
			service.updateById(candidate);
		}
		return new ResultJson(true);
	}
	
	/**
	 * 新增修改面试记录
	 * @param request
	 * @param candidateRInterviewer
	 * @return
	 */
	@ResponseBody
	@RequestMapping("saveOrUpdateCandidateRInterviewer")
	public ResultJson  saveOrUpdateCandidateRInterviewer(HttpServletRequest request, CandidateRInterviewer candidateRInterviewer ){
		if(StringUtils.isEmpty(candidateRInterviewer.getId())){
			//如果没有ID则新增
			service.insertRInterviewer(candidateRInterviewer);
		}else {
			//如果有ID则是修改
			service.updateRInterviewerById(candidateRInterviewer);
		}
		return new ResultJson(true);
	}
//	
	/**
	 * 根据ID获取候选人
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("getById")
	@ResponseBody
	public Candidate  getById(HttpServletRequest request,@RequestParam(required=true) String id ){
		return service.getByid(id);
	}
	
	@RequestMapping("getCandidateRInterviewerById")
	@ResponseBody
	public CandidateRInterviewer  getCandidateRInterviewerById(HttpServletRequest request,@RequestParam(required=true) String id ){
		return service.getRInterviewerByid(id);
	}
	
	
//	
	/**
	 * 根据查询条件分页获取获选人列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getCandidatePageList")
	public Page getCandidatePageList(HttpServletRequest request,Page page,Candidate search,String type){
		return service.getCandidatePageList(page, search);
	}
	
	@ResponseBody
	@RequestMapping("getCandidateRInterviewerPageList")
	public Page getCandidateRInterviewerPageList(HttpServletRequest request,Page page,CandidateRInterviewer search,String type){
		return service.getCandidateRInterviewerPageList(page, search);
	}
	
//	审批
}