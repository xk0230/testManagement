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
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Contract;
import com.codyy.oc.admin.entity.Travel;
import com.codyy.oc.admin.service.ContractManageService;
import com.codyy.oc.admin.service.TravelManageService;
import com.codyy.oc.admin.vo.ContractVO;
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
	 * 合同申请
	 * @return
	 */
	@RequestMapping("/travelApply.do")
	public String contractApply(){
		return "admin/travel/travelApply";
	}
	

	@ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(HttpServletRequest request,TravelVO travel){
		AdminUser user = getSessionUser(request);
		travel.setUserId(user.getUserId());
		travel.setUserPosition(user.getPosition());
		travel.setUserDepId(user.getDepId());
        return travelManageService.getTravelPageList(travel);
    }

	@ResponseBody
    @RequestMapping("/deleteTravel.do")
    public JsonDto deleteContract(HttpServletRequest request,TravelVO travel){
		return travelManageService.deleteTravel(travel);
    }
	
}