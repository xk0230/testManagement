/**
 * 
 */
package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.Travel;
import com.codyy.oc.admin.service.TravelManageService;
import com.codyy.oc.admin.vo.CostVO;
import com.codyy.oc.admin.vo.TravelVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ContractController.java, v 0.1	2018年3月5日	下午5:47:35	Jason(pjx48476) $
 * @Description: TODO  
 */

@Controller
@RequestMapping("/travel")
public class TravelController extends BaseController {
	
	@Resource
	TravelManageService travelManageService;
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
		dateFormat.setLenient(false);  
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateContract(HttpServletRequest request,Travel travel){
		return travelManageService.insertOrUpdateTravel(this.getSessionUser(request),travel);
	}
	
	/**
	 * 出差申请
	 * @return
	 */
	@RequestMapping("/travelApply.do")
	public String travelApply(Model model,String search){
		model.addAttribute("search", search);
		model.addAttribute("mode","apply");
		return "admin/travel/travelApply";
	}
	
	/**
	 * 出差审批
	 * @return
	 */
	@RequestMapping("/travelAudit.do")
	public String travelAudit(Model model,String search){
		model.addAttribute("search", search);
		model.addAttribute("mode","audit");
		return "admin/travel/travelApply";
	}
	
	/**
	 * 出差查看
	 * @return
	 */
	@RequestMapping("/travelView.do")
	public String travelView(Model model,String search){
		model.addAttribute("search", search);
		model.addAttribute("mode","view");
		return "admin/travel/travelApply";
	}
	

	@ResponseBody
    @RequestMapping("/page.do")
    public Page getTravelPageList(HttpServletRequest request,TravelVO travel){
		AdminUser user = getSessionUser(request);
		travel.setUserId(user.getUserId());
		travel.setUserPosition(user.getPosition());
		travel.setUserDepId(user.getDepId());
        return travelManageService.getTravelPageList(travel);
    }
	
	@ResponseBody
    @RequestMapping("/auditPage.do")
    public Page getAuditList(HttpServletRequest request,TravelVO travel){
		AdminUser adminUser = (AdminUser)request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		travel.setUserDepId(adminUser.getDepId());
		travel.setUserId(adminUser.getUserId());
		travel.setUserPosition(adminUser.getPosition());
		
		
        return travelManageService.getTravelAuditList(travel);
    }
	
	/**
	 * 审批列表的分页查询
	 * @param request
	 * @param cost
	 * @return
	 */
	@ResponseBody
    @RequestMapping("/viewPage.do")
    public Page getViewList(HttpServletRequest request,TravelVO travel){
		AdminUser adminUser = (AdminUser)request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		travel.setUserDepId(adminUser.getDepId());
		travel.setUserId(adminUser.getUserId());
		travel.setUserPosition(adminUser.getPosition());
        return travelManageService.getTravelViewList(travel);
    }
	
	@ResponseBody
	@RequestMapping(value = "/updateStatus.do",method = RequestMethod.POST)
	public JsonDto UpdateStatus(HttpServletRequest request,TravelVO travel){
		return travelManageService.updateStatus(this.getSessionUser(request),travel);
	}

	@ResponseBody
    @RequestMapping("/deleteTravel.do")
    public JsonDto deleteContract(HttpServletRequest request,TravelVO travel){
		return travelManageService.deleteTravel(travel);
    }
	
	
	
}
