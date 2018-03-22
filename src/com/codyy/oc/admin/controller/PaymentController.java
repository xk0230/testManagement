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

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Payment;
import com.codyy.oc.admin.service.PaymentService;
import com.codyy.oc.admin.vo.PaymentVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:PaymentController.java, v 0.1	2018年3月22日	下午9:03:49	Jason(pjx48476) $
 * @Description: TODO  
 */

@Controller
@RequestMapping("/payment")
public class PaymentController extends BaseController {

	@Resource
	PaymentService paymentService;
	

	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
		dateFormat.setLenient(false);  
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateContract(HttpServletRequest request,Payment payment){
		return paymentService.insertOrUpdatePayment(this.getSessionUser(request),payment);
	}
	
	/**
	 * 合同申请
	 * @return
	 */
	@RequestMapping("/paymentApply.do")
	public String contractApply(){
		return "admin/payment/paymentApply";
	}
	

	@ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(HttpServletRequest request,PaymentVO payment){
		AdminUser user = getSessionUser(request);
		payment.setUserId(user.getUserId());
		payment.setUserPosition(user.getPosition());
		payment.setUserDepId(user.getDepId());
        return paymentService.getPaymentPageList(payment);
    }
	

	@ResponseBody
    @RequestMapping("/deletePayment.do")
    public JsonDto deleteContract(HttpServletRequest request,PaymentVO payment){
		return paymentService.deletePayment(payment);
    }

}
