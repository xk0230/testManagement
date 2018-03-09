/**
 * 
 */
package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.dao.ContractMapper;
import com.codyy.oc.admin.entity.Contract;
import com.codyy.oc.admin.vo.ContractVO;
import com.codyy.oc.admin.vo.CostVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ContractManageService.java, v 0.1	2018年3月6日	下午9:58:04	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("ContractManageService")
public class ContractManageService {
	
	@Autowired
	private ContractMapper contractMapper;
	
	public void insertContract(Contract record) {
		contractMapper.insert(record);
	}

	public List<Contract> getAll() {
		return contractMapper.getAll();
	}
	
	/**
	 * 成本列表查询
	 * @param contract
	 * @return
	 */
	public Page getContractPageList(ContractVO contract){
	    Page page = new Page();
	    page.setStart(contract.getStart());
	    page.setEnd(contract.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    map.put("contactType", contract.getType());
	    map.put("userId", contract.getUserId());
	    map.put("startTime", contract.getStartDate());
	    map.put("endTime", contract.getEndDate());
	    
	    
	    page.setMap(map);
	    
	    List<ContractVO> costPageList = contractMapper.getContractPageList(page);
	    page.setData(costPageList);
	    
	    return page;
	}
}
