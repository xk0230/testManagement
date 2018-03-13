/**
 * 
 */
package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.ContractMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Contract;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.vo.ContractVO;
import com.codyy.oc.admin.vo.CostVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ContractManageService.java, v 0.1	2018年3月6日	下午9:58:04	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("ContractManageService")
public class ContractManageService {

	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DELETE_SUCCESS = "删除成功";
	private static final String DELETE_ERROR = "删除失败";
	
	@Autowired
	private ContractMapper contractMapper;
	
	public void insertContract(Contract record) {
		contractMapper.insert(record);
	}

	public List<Contract> getAll() {
		return contractMapper.getAll();
	}
	
	/**
	 * 插入，更新合同数据
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto insertOrUpdateContract(AdminUser user,Contract contract){
		
		JsonDto jsonDto = new JsonDto();
		//CostID为空时执行插入
		if(StringUtils.isBlank(contract.getId())){
			//部门ID=当前用户的部门
		    String depId = user.getDepId();
			//创建时间和创建者
		    contract.setCreateTime(DateUtils.getCurrentTimestamp());
		    contract.setCreateUserId(user.getUserId());
			
		    if(StringUtils.isNotBlank(depId)) {
		    	contract.setId(UUID.randomUUID().toString());
		    	
		    	//执行插入
		    	int insertCostEntityNum = contractMapper.insert(contract);
		    	if(insertCostEntityNum == 1) {
					jsonDto.setCode(0);
					jsonDto.setMsg(INSERT_SUCCESS);
		    	}else {
					jsonDto.setMsg(INSERT_ERROR);
		    	}
		    }
		}else{
		    contract.setCreateTime(DateUtils.getCurrentTimestamp());
		    contract.setCreateUserId(user.getUserId());
		    
			int updateCostEntityNum = contractMapper.updateByPrimaryKey(contract);
			if(updateCostEntityNum == 1){
				jsonDto.setCode(0);
				jsonDto.setMsg(UPDATE_SUCCESS);
			}else{
				jsonDto.setMsg(UPDATE_ERROR);
			}
		}
		return jsonDto;
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
	
	public JsonDto deleteContract(ContractVO contract){
		JsonDto jsonDto = new JsonDto();
		int code = contractMapper.deleteByPrimaryKey(contract.getId());
		if(code == 1) {
			jsonDto.setCode(0);
			jsonDto.setMsg(DELETE_SUCCESS);
    	}else {
			jsonDto.setMsg(DELETE_ERROR);
    	}
		return jsonDto;
	}
}
