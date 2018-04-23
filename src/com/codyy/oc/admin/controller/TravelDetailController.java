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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.TravelDetail;
import com.codyy.oc.admin.service.TravelDetailManageService;
import com.codyy.oc.admin.vo.TravelDetailVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ContractController.java, v 0.1	2018年3月5日	下午5:47:35	Jason(pjx48476) $
 * @Description: TODO  
 */

@Controller
@RequestMapping("/traveldetail")
public class TravelDetailController extends BaseController {
	
	@Resource
	TravelDetailManageService travelDetailManageService;
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
		dateFormat.setLenient(false);  
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateTravelDetail(HttpServletRequest request,TravelDetail traveldetail){
		return travelDetailManageService.insertOrUpdateTravelDetail(this.getSessionUser(request),traveldetail);
	}
	
	@RequestMapping("/traveldetailApply.do")
	public String contractApply(@RequestParam(required=true,value="travelId")String travelId){
		return "admin/travel/travelDetailApply";
	}
	

	@ResponseBody
    @RequestMapping("/page.do")
    public Page getTraveldetailPageList(HttpServletRequest request,TravelDetailVO travelDetail){
		AdminUser user = getSessionUser(request);
		travelDetail.setUserId(user.getUserId());
		travelDetail.setUserPosition(user.getPosition());
		travelDetail.setUserDepId(user.getDepId());
        return travelDetailManageService.getTravelDetailPageList(travelDetail);
    }

	@ResponseBody
    @RequestMapping("/deleteTravelDetail.do")
    public JsonDto deleteTravelDetail(HttpServletRequest request,TravelDetailVO traveldetail){
		return travelDetailManageService.deleteTravelDetail(traveldetail);
    }
	

	/**
	 * 获取出差详情类型列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getTravelDetailType.do")
	public JsonDto getTravelDetailType(){
		return travelDetailManageService.getTravelDetailType();
	}
	
	
	
}
