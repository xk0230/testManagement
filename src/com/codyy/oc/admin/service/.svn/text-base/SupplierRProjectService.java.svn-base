package com.codyy.oc.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.SupplierRProjectMapper;

@Service
public class SupplierRProjectService {

	@Autowired
	private SupplierRProjectMapper supplierRProjectMapper;
	
	
	/**
	 * @author lichen
	* @Title: delSupplRProjBySuId
	* @Description: (根据集成商的id来删除集成商项目表的所有对应的项目)
	* @param @param supplyId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer delSupplRProjBySuId(String supplyId){
		
		System.out.println("supplyId===="+supplyId);
		return supplierRProjectMapper.delSupplRProjBySuId(supplyId);
	}
}
