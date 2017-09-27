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
import com.codyy.oc.admin.entity.Competency;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.Recruit;
import com.codyy.oc.admin.service.CompetencyService;
import com.codyy.oc.admin.service.RecruitService;

@Controller
@RequestMapping("/admin/recruit")
public class RecruitController  extends BaseController{
	@Autowired
	private CompetencyService competencyService;
	@Autowired
	private RecruitService service;
	
	
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
//		http://localhost:8080/ccydManagement/admin/recruit/saveOrUpdateRecruit.do?postid=1&competencys[0].name=n0&competencys[0].id=1&competencys[1].name=n1&competencys[0].id=2
		if(StringUtils.isEmpty(recruit.getId())){
			//如果没有ID则新增
			recruit.setCreateUser(userId);
			service.insert(recruit);
		}else {
			//如果有ID则是修改
			service.updateById(recruit);
		}
		return new ResultJson(true);
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
	
}
