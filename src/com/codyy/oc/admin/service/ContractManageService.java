/**
 * 
 */
package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codyy.oc.admin.dao.ContractMapper;
import com.codyy.oc.admin.entity.Contract;

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
}
