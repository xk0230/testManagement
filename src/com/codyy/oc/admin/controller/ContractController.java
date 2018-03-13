/**
 * 
 */
package com.codyy.oc.admin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.Contract;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.service.ContractManageService;
import com.codyy.oc.admin.vo.ContractVO;
import com.codyy.oc.admin.vo.CostVO;

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
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateContract(HttpServletRequest request,Contract contract){
		return contractManageService.insertOrUpdateContract(this.getSessionUser(request),contract);
	}
	
	/**
	 * 合同申请
	 * @return
	 */
	@RequestMapping("/contractApply.do")
	public String contractApply(){
		return "admin/contract/contractApply";
	}
	

	@ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(HttpServletRequest request,ContractVO contract){
		String userId = getSessionUserId(request);
		contract.setUserId(userId);
        return contractManageService.getContractPageList(contract);
    }

	@ResponseBody
    @RequestMapping("/deleteContract.do")
    public JsonDto deleteContract(HttpServletRequest request,ContractVO contract){
		return contractManageService.deleteContract(contract);
    }
	
	

}
