package com.codyy.oc.admin.service;

import java.util.List;
import java.util.UUID;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.CostDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSubTypeBean;
import com.codyy.oc.admin.vo.CostVO;

/**
 * 成本控制server
 * @author Administrator
 *
 */
@Service("costServer")
public class CostService {
	
	private static final String INSERT_SUCCESS = "保存成功";
	private static final String INSERT_ERROR = "保存失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DEL_SUCCESS = "删除成功";
	private static final String DEL_ERROR = "删除失败";

	@Autowired
	private CostDaoMapper costDaoMapper; 
	
	public JsonDto getCostSubTypeList(int castType){
		
		JsonDto jsonDto = new JsonDto();
		List<CostSubTypeBean> costSubTypeList = costDaoMapper.getCostSubTypeList(castType);
		if(CollectionUtils.isNotEmpty(costSubTypeList)){
			jsonDto.setCode(0);
			jsonDto.setObjData(costSubTypeList);
		}
		
		return jsonDto;
	}
	
	public JsonDto insertOrUpdateCostEntity(AdminUser user,CostEntityBean costEntityBean){
		
		JsonDto jsonDto = new JsonDto();
		
		costEntityBean.setCreateTime(DateUtils.getCurrentTimestamp());
		costEntityBean.setCreateUserId(user.getUserId());
		
		if(StringUtils.isBlank(costEntityBean.getCostId())){
			costEntityBean.setCostId(UUID.randomUUID().toString());
			int insertCostEntityNum = costDaoMapper.insertCostEntity(costEntityBean);
			if(insertCostEntityNum == 1){
				jsonDto.setCode(0);
				jsonDto.setMsg(INSERT_SUCCESS);
			}else{
				jsonDto.setMsg(INSERT_ERROR);
			}
			
		}else{
			int updateCostEntityNum = costDaoMapper.updateCostEntity(costEntityBean);
			if(updateCostEntityNum == 1){
				jsonDto.setCode(0);
				jsonDto.setMsg(UPDATE_SUCCESS);
			}else{
				jsonDto.setMsg(UPDATE_ERROR);
			}
		}
		
		return jsonDto;
	}

	public JsonDto delCostEntityById(String costId){
		
		JsonDto jsonDto = new JsonDto();
		int delNum = costDaoMapper.delCostEntityById(costId);
		if(delNum == 1){
			jsonDto.setCode(0);
			jsonDto.setMsg(DEL_SUCCESS);
		}else{
			jsonDto.setMsg(DEL_ERROR);
		}
		
		return jsonDto;
	}
	
	
	public JsonDto getCostChartsData(AdminUser user){
		
		//判断当前角色，部门经理只能看到本部门成本数据，管理员汇总所有部门数据
		
		//1.按支出类型汇总
		CostVO cost = new CostVO();
		cost.setCostType(1);
		cost.setStartTime(DateUtils.getCurrentTimestamp());
		cost.setEndTime(DateUtils.getCurrentTimestamp());
		
		List<CostEntityBean> costDeatilList = costDaoMapper.getCostDeatilList(cost);
		if(CollectionUtils.isNotEmpty(costDeatilList)){
			
			
		}
		
		//2.按部门收入汇总
		
		
		//3.按收入-结余汇总
		
		
		return null;
	}
	
}
