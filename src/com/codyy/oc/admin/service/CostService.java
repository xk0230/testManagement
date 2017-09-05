package com.codyy.oc.admin.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
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
	
	private static final String ONE_MONTH_START = DateUtils.getCurrentYear()+"-01-01";
	private static final String ONE_MONTH_END = DateUtils.getCurrentYear()+"-01-31";
	private static final String SEC_MONTH_START = DateUtils.getCurrentYear()+"-02-01";
	private static final String SEC_MONTH_END = DateUtils.getCurrentYear()+"-02-29";
	

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
		
		JsonDto jsonDto = new JsonDto();
		
		CostVO cost = new CostVO();
		cost.setCostType(1);
		cost.setStartTime(DateUtils.getCurrentTimestamp());
		cost.setEndTime(DateUtils.getCurrentTimestamp());
		
		//判断当前角色，部门经理只能看到本部门成本数据，管理员汇总所有部门数据
		String position = user.getPosition();
		if(CommonsConstant.USER_TYPE_STAFF.equalsIgnoreCase(position)){
			jsonDto.setMsg("你暂时无权查看");
			return jsonDto;
		}else if(CommonsConstant.USER_TYPE_STAFF.equalsIgnoreCase(position)){
			cost.setDepId(user.getDepId());
		}
		
		//1.按支出类型汇总a
		cost.setCostType(1);
		List<CostVO> costDeatilList = costDaoMapper.getCostDeatilList(cost);
		if(CollectionUtils.isNotEmpty(costDeatilList)){
			jsonDto.setCode(0);
			
			for(CostVO costDeatil : costDeatilList){
				Timestamp costTime = costDeatil.getCostTime();
				
				
			}
			
		}
		
		//2.按部门收入汇总
		
		
		//3.按收入-结余汇总
		
		
		return jsonDto;
		
	}
	
	/**
	 * 获取从一月份到当前月每月成本详情
	 * @param month 当前月份（1-12）
	 * @param costDeatilList
	 * @return Map<String,List<CostVO>>
	 * @throws ParseException 
	 */
	private Map<String,List<CostVO>> getMonthCostList(int month,List<CostVO> costDeatilList) throws ParseException{
		
		Map<String,List<CostVO>> map = new HashMap<String, List<CostVO>>();
		
		List<CostVO> cost1 = new ArrayList<CostVO>();
		List<CostVO> cost2 = new ArrayList<CostVO>();
		
		
		
		for(CostVO costDeatil : costDeatilList){
			Timestamp costTime = costDeatil.getCostTime();
			if(costTime.after(DateUtils.parseTimestampString(ONE_MONTH_START)) 
					&& costTime.before(DateUtils.parseTimestampString(ONE_MONTH_END))){
				
				cost1.add(costDeatil);
				
			}else if(costTime.after(DateUtils.parseTimestampString(SEC_MONTH_START)) 
					&& costTime.before(DateUtils.parseTimestampString(SEC_MONTH_END))){
				
				cost2.add(costDeatil);
				
			}
			
		}
		
		return map;
	}
	
	
	
	
	
}
