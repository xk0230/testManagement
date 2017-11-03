package com.codyy.oc.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.IpeBean;
import com.codyy.oc.admin.service.IpeService;
import com.codyy.oc.admin.vo.IpeVO;

/**
 * ipe
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/ipe")
public class IpeController extends BaseController{
	
	@Autowired
	private IpeService ipeService;
	
	@RequestMapping("/manager.do")
	public String toIpe(){
		
		return "/admin/ipe/ipeManager";
	}
	
	@RequestMapping("/trial.do")
	public String toIpeTrial(){
		
		return "/admin/ipe/ipeTrial";
	}
	
	@RequestMapping("/getIpe.do")
	public String getIpe(Model model,String userId){
		model.addAttribute("userId", userId);
		return "/admin/ipe/ipeList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getOrg.do",method = RequestMethod.GET)
	public JsonDto getOrganizationalSize(){
		
		return ipeService.getOrganizationalSize();
	}
	
	@ResponseBody
	@RequestMapping("/getIpeById.do")
	public JsonDto getCostEntityById(String id){
		
		return ipeService.getIpeById(id);
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateCost(HttpServletRequest request,IpeBean ipe){
		
		return ipeService.insertOrUpdateIpe(this.getSessionUser(request),ipe);
	} 
	
	@ResponseBody
    @RequestMapping("/page.do")
    public Page getIpePageList(IpeVO ipeVO){
        
        return ipeService.getIpePageList(ipeVO);
    }
	
	@ResponseBody
	@RequestMapping("/del/{id}.do")
	public JsonDto delIpeById(@PathVariable String id){
		
		return ipeService.delIpeById(id);
	}
	
	@ResponseBody
	@RequestMapping("/alYxAndOrg.do")
	public String calYxAndOrgValue(IpeVO ipeVO){
		
		return ipeService.calYxAndOrgValue(ipeVO);
	}
	
	@ResponseBody
	@RequestMapping("/calGtAndKj.do")
	public String calGtAndKjValue(IpeVO ipeVO){
		
		return ipeService.calGtAndKjValue(ipeVO);
	}
	
	@ResponseBody
	@RequestMapping("/calCxAndFzd.do")
	public String calCxAndFzdValue(IpeVO ipeVO){
		
		return ipeService.calCxAndFzdValue(ipeVO);
	}
	
	@ResponseBody
	@RequestMapping("/calZsAndTd.do")
	public String calZsAndTdValue(IpeVO ipeVO){
		
		return ipeService.calZsAndTdValue(ipeVO);
	}
	
	@ResponseBody
	@RequestMapping("/calIpe.do")
	public IpeVO calIpeByTotalScore(IpeVO ipeVO){
		
		return ipeService.calIpeByTotalScore(ipeVO);
	}
}
