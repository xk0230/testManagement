package com.codyy.oc.admin.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.CostDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSubTypeBean;
import com.codyy.oc.admin.vo.CostChartsData;
import com.codyy.oc.admin.vo.CostChartsSeriesData;
import com.codyy.oc.admin.vo.CostInOutlayType;
import com.codyy.oc.admin.vo.CostMonthInOut;
import com.codyy.oc.admin.vo.CostTotalInOut;
import com.codyy.oc.admin.vo.CostVO;
import com.codyy.oc.admin.vo.CostYearVO;

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
	private static final String NO_EXIT_DATA = "数据不存在";
	

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
		
		costEntityBean.setCostTime(DateUtils.stringToTimestamp((DateUtils.format(costEntityBean.getCostTime()))));
		
		if(StringUtils.isBlank(costEntityBean.getCostId())){
		    
		    String depId = costEntityBean.getDepId();
		    String depAmount = costEntityBean.getDepAmount();
		    if(StringUtils.isNotBlank(depId) && StringUtils.isNotBlank(depAmount)) {
		        String[] depIds = depId.split(",");
		        String[] amouts = depAmount.split(",");
		        if(depIds.length == amouts.length){
		            CostEntityBean cost = null;
		            for(int i = 0;i<depIds.length;i++){
		                cost = new CostEntityBean();
		                cost.setCostId(UUID.randomUUID().toString());
		                cost.setCostSubtypeId(costEntityBean.getCostSubtypeId());
		                cost.setCostTime(costEntityBean.getCostTime());
		                cost.setCostType(costEntityBean.getCostType());
		                cost.setCreateTime(DateUtils.getCurrentTimestamp());
		                cost.setCreateUserId(costEntityBean.getCreateUserId());
		                cost.setDepId(depIds[i]);
		                cost.setCostNum(Double.parseDouble(amouts[i]));
		                
		                costDaoMapper.insertCostEntity(cost);
		            }
		        }
		    }
		    
		    jsonDto.setCode(0);
			
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
	
	public JsonDto getCostEntityById(String costId){
		
		JsonDto jsonDto = new JsonDto();
		CostEntityBean cost = costDaoMapper.getCostEntityById(costId);
		if(cost != null){
			jsonDto.setCode(0);
			jsonDto.setObjData(cost);
		}else{
			jsonDto.setMsg(NO_EXIT_DATA);
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
	
	/**
	 * 成本列表查询
	 * @param cost
	 * @return
	 */
	public Page getCostPageList(CostVO cost){
	    Page page = new Page();
	    page.setStart(cost.getStart());
	    page.setEnd(cost.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    map.put("depId", cost.getDepId());
	    map.put("costType", cost.getCostType());
	    map.put("costSubtypeId", cost.getCostSubtypeId());
	    map.put("startTime", cost.getStartDate());
	    map.put("endTime", cost.getEndDate());
	    
	    page.setMap(map);
	    
	    List<CostVO> costPageList = costDaoMapper.getCostPageList(page);
	    page.setData(costPageList);
	    
	    return page;
	}
	
	public CostChartsData getCostChartData(AdminUser user,int type,int curYear){
	    
	    CostChartsData costChartsData = new CostChartsData();
	    
	    List<String> xcategories = new ArrayList<String>();
	    List<CostChartsSeriesData> seriesDatas = new ArrayList<CostChartsSeriesData>();
	    
	    List<CostInOutlayType> departIncomeList = null;
	    if(type == 1){
	    	departIncomeList = this.getChartDataByDepIncome(user,curYear);
	    }else if(type == 2){
	        departIncomeList = this.getChartDataByDepOutcome(user,curYear);
	    }else{
	    	departIncomeList = this.getChartDataByOutlayType(user,curYear);
	    }
	    
	    if(CollectionUtils.isNotEmpty(departIncomeList)){
	        
	        Map<String,Integer> monthMap = new HashMap<String,Integer>();
	        for(CostInOutlayType costInOutlay : departIncomeList){
                
	            xcategories.add(costInOutlay.getName());
	            
	            List<CostMonthInOut> monthInOuts = costInOutlay.getMonthInOut();
                for(CostMonthInOut costMonthInOut : monthInOuts){
                    monthMap.put(costMonthInOut.getMonth(), 1);
                }
            }
	        
	        Map<String,List<BigDecimal>> map = new HashMap<String,List<BigDecimal>>();
	        for(CostInOutlayType costInOutlay : departIncomeList){
	            Map<String,Integer> costInOutMap = new HashMap<String,Integer>();
	            List<CostMonthInOut> monthInOuts = costInOutlay.getMonthInOut();
	            for(CostMonthInOut costMonthInOut : monthInOuts){
	                List<BigDecimal> list = map.get(costMonthInOut.getMonth());
                    if(list == null){
                        list = new ArrayList<BigDecimal>();
                    }
	                
                    list.add(costMonthInOut.getTotal());
                    map.put(costMonthInOut.getMonth(), list);
                    costInOutMap.put(costMonthInOut.getMonth(), 1);	                
	            }
	            
	            //补齐数据
	            for(String month : monthMap.keySet()){
	                boolean flag = true;
	                for(String key : costInOutMap.keySet()){
	                    if(month.equals(key)){
	                        flag = false;
	                        break;
	                    }
	                }
	                
	                if(flag){
	                    List<BigDecimal> list = map.get(month);
	                    if(list == null){
	                        list = new ArrayList<BigDecimal>();
	                    }
	                    list.add(new BigDecimal(0));
	                    map.put(month, list);
	                }
	            }
	            
	        }
	        
	        if(map.size() > 0){
	            
	            for(String key : map.keySet()){
	                CostChartsSeriesData seriesData = new CostChartsSeriesData();
	                seriesData.setName(key);
	                seriesData.setData(map.get(key));
	                
	                seriesDatas.add(seriesData);
	            }
	        }
	    }
	    
	    costChartsData.setXcategories(xcategories);
	    costChartsData.setSeriesData(seriesDatas);
	    
	    return costChartsData;
	}
	
	/**
	 * 获取成本支出类型图表数据
	 * @param user
	 * @return
	 */
	private List<CostInOutlayType> getChartDataByOutlayType(AdminUser user,int curYear){
        
	    CostVO cost = new CostVO();
	    cost.setCostType("1");
	    
        boolean flag = false;
        String position = user.getPosition();
        if(CommonsConstant.USER_TYPE_MANAGER.equalsIgnoreCase(position)){
            cost.setDepId(user.getDepId());
            flag = true;
        }else if(CommonsConstant.USER_TYPE_ADMIN.equalsIgnoreCase(position)){
            flag = true;
        }
        
        List<CostInOutlayType> outlayTypeList = new ArrayList<CostInOutlayType>();
        if(flag){
            cost.setStartTime(DateUtils.stringToTimestamp(curYear+"-01-01 00:00:00"));
            cost.setEndTime(DateUtils.stringToTimestamp(curYear+"-12-31 23:59:59"));
            
            List<CostMonthInOut> costList = costDaoMapper.getCostOutlayType(cost);
            if(CollectionUtils.isNotEmpty(costList)){
                Map<String,List<CostMonthInOut>> map = new HashMap<String,List<CostMonthInOut>>();
                for(CostMonthInOut monthOutlay : costList){
                    List<CostMonthInOut> list = map.get(monthOutlay.getName());
                    if(list == null){
                        list = new ArrayList<CostMonthInOut>();
                    }
                    list.add(monthOutlay);
                    
                    map.put(monthOutlay.getName(), list);
                }
                
                if(map.size() > 0){
                    for(String name : map.keySet()){
                        CostInOutlayType costOutlayType = new CostInOutlayType();
                        costOutlayType.setName(name);
                        costOutlayType.setMonthInOut(map.get(name));
                        
                        outlayTypeList.add(costOutlayType);
                    }
                }
            }
        }
	    
	    return outlayTypeList;
	}
	
	
	/**
     * 获取部门收入图表数据
     * @param user
     * @return
     */
    private List<CostInOutlayType> getChartDataByDepIncome(AdminUser user,int curYear){
        
        CostVO cost = new CostVO();
        cost.setCostType("0");
        
        boolean flag = false;
        String position = user.getPosition();
        if(CommonsConstant.USER_TYPE_MANAGER.equalsIgnoreCase(position)){
            cost.setDepId(user.getDepId());
            flag = true;
        }else if(CommonsConstant.USER_TYPE_ADMIN.equalsIgnoreCase(position)){
            flag = true;
        }
        
        List<CostInOutlayType> departIncomeList = new ArrayList<CostInOutlayType>();
        if(flag){
        	cost.setStartTime(DateUtils.stringToTimestamp(curYear+"-01-01 00:00:00"));
            cost.setEndTime(DateUtils.stringToTimestamp(curYear+"-12-31 23:59:59"));
            
            List<CostMonthInOut> costList = costDaoMapper.getCostDepartIncomeType(cost);
            if(CollectionUtils.isNotEmpty(costList)){
                Map<String,List<CostMonthInOut>> map = new HashMap<String,List<CostMonthInOut>>();
                for(CostMonthInOut monthOutlay : costList){
                    List<CostMonthInOut> list = map.get(monthOutlay.getName());
                    if(list == null){
                        list = new ArrayList<CostMonthInOut>();
                    }
                    list.add(monthOutlay);
                    
                    map.put(monthOutlay.getName(), list);
                }
                
                if(map.size() > 0){
                    for(String name : map.keySet()){
                        CostInOutlayType costOutlayType = new CostInOutlayType();
                        costOutlayType.setName(name);
                        costOutlayType.setMonthInOut(map.get(name));
                        
                        departIncomeList.add(costOutlayType);
                    }
                }
            }
            
        }
        Collections.sort(departIncomeList);
        return departIncomeList;
    }
    
    /**
     * 获取部门支出图表数据
     * @param user
     * @return
     */
    private List<CostInOutlayType> getChartDataByDepOutcome(AdminUser user,int curYear){
        
        CostVO cost = new CostVO();
        cost.setCostType("1");
        
        boolean flag = false;
        String position = user.getPosition();
        if(CommonsConstant.USER_TYPE_MANAGER.equalsIgnoreCase(position)){
            cost.setDepId(user.getDepId());
            flag = true;
        }else if(CommonsConstant.USER_TYPE_ADMIN.equalsIgnoreCase(position)){
            flag = true;
        }
        
        List<CostInOutlayType> departIncomeList = new ArrayList<CostInOutlayType>();
        if(flag){
            cost.setStartTime(DateUtils.stringToTimestamp(curYear+"-01-01 00:00:00"));
            cost.setEndTime(DateUtils.stringToTimestamp(curYear+"-12-31 23:59:59"));
            
            List<CostMonthInOut> costList = costDaoMapper.getCostDepartIncomeType(cost);
            if(CollectionUtils.isNotEmpty(costList)){
                Map<String,List<CostMonthInOut>> map = new HashMap<String,List<CostMonthInOut>>();
                for(CostMonthInOut monthOutlay : costList){
                    List<CostMonthInOut> list = map.get(monthOutlay.getName());
                    if(list == null){
                        list = new ArrayList<CostMonthInOut>();
                    }
                    list.add(monthOutlay);
                    
                    map.put(monthOutlay.getName(), list);
                }
                
                if(map.size() > 0){
                    for(String name : map.keySet()){
                        CostInOutlayType costOutlayType = new CostInOutlayType();
                        costOutlayType.setName(name);
                        costOutlayType.setMonthInOut(map.get(name));
                        
                        departIncomeList.add(costOutlayType);
                    }
                }
            }
            
        }
        Collections.sort(departIncomeList);
        return departIncomeList;
    }
    
	
    /**
     * 获取成本收入支出
     * @param user
     * @return
     */
    public CostTotalInOut getCostTotalInOut(AdminUser user,int curYear){
        
        CostVO cost = new CostVO();
        
        boolean flag = false;
        String position = user.getPosition();
        if(CommonsConstant.USER_TYPE_MANAGER.equalsIgnoreCase(position)){
            cost.setDepId(user.getDepId());
            flag = true;
        }else if(CommonsConstant.USER_TYPE_ADMIN.equalsIgnoreCase(position)){
            flag = true;
        }
        
        CostTotalInOut costTotalInOut = new CostTotalInOut();
        
        if(flag){
            cost.setStartTime(DateUtils.stringToTimestamp(curYear+"-01-01 00:00:00"));
            cost.setEndTime(DateUtils.stringToTimestamp(curYear+"-12-31 23:59:59"));
            cost.setCostType("0");
            
            CostMonthInOut costMonthInOut = costDaoMapper.getCostInOutType(cost);
            if(null != costMonthInOut){
                costTotalInOut.setTotalIncome(costMonthInOut.getTotal());
            }
            
            cost.setCostType("1");
            costMonthInOut = costDaoMapper.getCostInOutType(cost);
            if(null != costMonthInOut){
                costTotalInOut.setTotalOut(costMonthInOut.getTotal());
            }
            
            costTotalInOut.setBalance(costTotalInOut.getTotalIncome().subtract(costTotalInOut.getTotalOut()));
            
        }
        
        return costTotalInOut;
    }
    
    public CostYearVO getRecentYear(int recentYear){
        if(recentYear < 0 || recentYear == 0){
            recentYear = 5;
        }
        
        CostYearVO costYear = new CostYearVO();
        List<Integer> years = new ArrayList<Integer>();
        int currentYear = DateUtils.getCurrentYear();
        
        for(int i= -recentYear;i<0;i++){
            years.add(currentYear + i);
        }
        
        for(int i= 0;i<recentYear;i++){
            years.add(currentYear + i);
        }
        
        costYear.setCurYear(currentYear);
        costYear.setYears(years);
        
        return costYear;
    }
    
   
}
