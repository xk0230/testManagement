/**
 * 
 */
package com.codyy.oc.admin.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.service.ContractManageService;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ContractController.java, v 0.1	2018年3月5日	下午5:47:35	Jason(pjx48476) $
 * @Description: TODO  
 */

@Controller
@RequestMapping("/contract")
public class ContractController extends BaseController {
	
	@Resource
	ContractManageService contractManageService;
	
	@ResponseBody
	@RequestMapping("addContract")
	public void add() {
		
	}

}
