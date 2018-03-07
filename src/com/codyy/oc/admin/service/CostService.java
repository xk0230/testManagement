package com.codyy.oc.admin.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.CostDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSeqBean;
import com.codyy.oc.admin.entity.CostSubTypeBean;
import com.codyy.oc.admin.vo.CostChartsData;
import com.codyy.oc.admin.vo.CostChartsSeriesData;
import com.codyy.oc.admin.vo.CostInOutlayType;
import com.codyy.oc.admin.vo.CostMonthInOut;
import com.codyy.oc.admin.vo.CostTotalInOut;
import com.codyy.oc.admin.vo.CostVO;
import com.codyy.oc.admin.vo.CostYearVO;
import com.codyy.oc.admin.vo.DepMonthTotalVO;

/**
 * 成本控制server
 * @author Administrator
 *
 */
@Service("costServer")
public class CostService {
	
	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DEL_SUCCESS = "删除成功";
	private static final String DEL_ERROR = "删除失败";
	private static final String NO_EXIT_DATA = "数据不存在";
	private static final String SCRAP_SUCCESS = "报废成功";
	private static final String SCRAP_ERROR = "报废失败";

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
	
	/**
	 * 插入，更新成本数据
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto insertOrUpdateCostEntity(AdminUser user,CostEntityBean costEntityBean){
		
		JsonDto jsonDto = new JsonDto();
		//成本产生时间
		costEntityBean.setCostTime(DateUtils.stringToTimestamp((DateUtils.format(costEntityBean.getCostTime()))));
		//CostID为空时执行插入
		if(StringUtils.isBlank(costEntityBean.getCostId())){
			//部门ID=当前用户的部门
		    String depId = user.getDepId();
			//创建时间和创建者
			costEntityBean.setCreateTime(DateUtils.getCurrentTimestamp());
			costEntityBean.setCreateUserId(user.getUserId());
		    if(StringUtils.isNotBlank(depId)) {
		    	//对CostID设定UUID
		    	costEntityBean.setCostId(UUID.randomUUID().toString());
		    	//生成新的costNo
		    	costEntityBean.setCostNo(CreateCostNo(costEntityBean));
		    	//设置部门
		    	costEntityBean.setDepId(depId);
		    	//执行插入
		    	int insertCostEntityNum = costDaoMapper.insertCostEntity(costEntityBean);
		    	if(insertCostEntityNum == 1) {
					jsonDto.setCode(0);
					jsonDto.setMsg(INSERT_SUCCESS);
		    	}else {
					jsonDto.setMsg(INSERT_ERROR);
		    	}
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
	
	/**
	 * 生成成本单号
	 * @param costEntityBean
	 * @return
	 */
	private String CreateCostNo(CostEntityBean costEntityBean) {
		//当前日期
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); 
		String today = dateFormat.format(new Date());

		//取番
		CostSeqBean costSeqBean = costDaoMapper.getCostNoSeq(costEntityBean.getCostType());
		
		if(costSeqBean != null) {
			if(costSeqBean.getDate() == today) {
				costSeqBean.setSeq(costSeqBean.getSeq() + 1);
				costDaoMapper.updateCostNoSeq(costSeqBean);
			}else {
				costSeqBean.setDate(today);
				costSeqBean.setSeq(1);
				costDaoMapper.updateCostNoSeq(costSeqBean);
			}
		}else {
			costSeqBean = new CostSeqBean();
			costSeqBean.setType(costEntityBean.getCostType());
			costSeqBean.setDate(today);
			costSeqBean.setSeq(1);
			costDaoMapper.insertCostNoSeq(costSeqBean);
		}
		return costEntityBean.getCostType() + today + "_" + String.format("%04d", costSeqBean.getSeq());
	}

	/**
	 * 更新成本状态
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto updateCostStatus(AdminUser user,CostEntityBean costEntityBean){
		
		JsonDto jsonDto = new JsonDto();
		
		int updateCostEntityNum = costDaoMapper.updateCostStatus(costEntityBean);
		if(updateCostEntityNum == 1){
			jsonDto.setCode(0);
			jsonDto.setMsg(SCRAP_SUCCESS);
		}else{
			jsonDto.setMsg(SCRAP_ERROR);
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
	    
	    map.put("costType", cost.getCostType());
	    map.put("userId", cost.getUserId());
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
	    
	    CostChartsSeriesData cc = new CostChartsSeriesData();
	    cc.setName("All");
	    List<BigDecimal> alls = new ArrayList<BigDecimal>();
	    for (int i = 0; i < xcategories.size(); i++) {
	    	BigDecimal all = new BigDecimal(0);
	    	for (CostChartsSeriesData c : seriesDatas) {
				all  = all.add(c.getData().get(i));
			}
	    	alls.add(all.setScale(1, RoundingMode.HALF_UP));
		}
	    cc.setData(alls);
//	    seriesDatas.add(cc);
//	    for (String s : xcategories) {
//			s=s
//		}
	    for (int i = 0; i < xcategories.size(); i++) {
	    	xcategories.set(i,  xcategories.get(i)+"(总共: "+alls.get(i)+")");
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
                costTotalInOut.setTotalIncome(costMonthInOut.getTotal().setScale(1, RoundingMode.HALF_UP));
            }
            
            cost.setCostType("1");
            costMonthInOut = costDaoMapper.getCostInOutType(cost);
            if(null != costMonthInOut){
                costTotalInOut.setTotalOut(costMonthInOut.getTotal().setScale(1, RoundingMode.HALF_UP));
            }
            
            costTotalInOut.setBalance(costTotalInOut.getTotalIncome().subtract(costTotalInOut.getTotalOut()).setScale(1, RoundingMode.HALF_UP));
            
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

    /**
     * 获取部门月份收入支出图表数据
     * @param sessionUser
     * @param curYear
     * @return
     */
	public List<CostChartsData> getDepCostChartData(AdminUser user, int curYear) {
		
		List<CostChartsData> datas = new ArrayList<CostChartsData>();
		
		CostVO cost = new CostVO();
        boolean flag = false;
        String position = user.getPosition();
        if(CommonsConstant.USER_TYPE_MANAGER.equalsIgnoreCase(position)){
            cost.setDepId(user.getDepId());
            flag = true;
        }else if(CommonsConstant.USER_TYPE_ADMIN.equalsIgnoreCase(position)){
            flag = true;
        }
		
        if(flag){
        	cost.setStartTime(DateUtils.stringToTimestamp(curYear+"-01-01 00:00:00"));
            cost.setEndTime(DateUtils.stringToTimestamp(curYear+"-12-31 23:59:59"));
             
            List<CostMonthInOut> costList = costDaoMapper.getCostDepartInOutcome(cost);
        	if(CollectionUtils.isNotEmpty(costList)){
        		List<String> depMonths = new ArrayList<String>();
        		Map<String,BigDecimal> months = new HashMap<String,BigDecimal>();
        		for(CostMonthInOut costInOut : costList){
        			String name = costInOut.getName();
        			String month = costInOut.getMonth();
        			String type = costInOut.getType();
        			if(null == months.get(name+"-"+month+"-"+type)){
        				months.put(name+"-"+month+"-"+type, costInOut.getTotal());
        				depMonths.add(name+"-"+month+"-"+type);
        			}
        		}
        		//每个月份对应收入和支出
        		List<String> depInOutMonths = new ArrayList<String>();
        		Map<String,BigDecimal> inOutmonths = new HashMap<String,BigDecimal>();
        		for(String key : depMonths){
        			String keyMonth = "";
        			String[] splits = key.split("-");
        			boolean tag = false;
        			if("0".equals(splits[2])){
        				keyMonth = splits[0]+"-"+splits[1]+"-1";
        				depInOutMonths.add(key);
        			}else{
        				tag = true;
        				keyMonth = splits[0]+"-"+splits[1]+"-0";
        			}
        			
        			BigDecimal bigDecimal = months.get(keyMonth);
        			if(null == bigDecimal){
        				//补月份缺失的收入或支出 默认0
        				inOutmonths.put(keyMonth, new BigDecimal(0));
        				depInOutMonths.add(keyMonth);
        			}
        			inOutmonths.put(key, months.get(key));
        			if(tag){
        				depInOutMonths.add(key);
        			}
        			
        		}
        		
        		List<CostMonthInOut> costMonthInOutList = new ArrayList<CostMonthInOut>();
        		String month = null;
        		CostMonthInOut costMonthInOut = null;
        		for(String key : depInOutMonths){
        			String[] splits = key.split("-");
        			if("0".equals(splits[2])){
        				month = splits[1] + "-收入";
        			}else{
        				month = splits[1] + "-支出";
        			}
        			costMonthInOut = new CostMonthInOut();
        			costMonthInOut.setName(splits[0]);
        			costMonthInOut.setMonth(month);
        			costMonthInOut.setTotal(inOutmonths.get(key));
        			
        			costMonthInOutList.add(costMonthInOut);
        		}
        		
        		CostChartsData costChartsData = null;
        	    List<String> xcategories = null;
        	    List<CostChartsSeriesData> seriesDatas = null;
        		
        	    Map<String,Integer> depNameMap = new HashMap<String,Integer>();
        	    int size = costMonthInOutList.size();
        	    for(int i =0;i<size;i++){
        	    	CostMonthInOut costInOut = costMonthInOutList.get(i);
        	    	if(null == depNameMap.get(costInOut.getName())){
        	    		if(CollectionUtils.isNotEmpty(seriesDatas)){
        	    			costChartsData.setSeriesData(seriesDatas);
        	    			datas.add(costChartsData);
        	    		}
        	    		
        	    		depNameMap.put(costInOut.getName(), 1);
        	    		
        	    		xcategories = new ArrayList<String>();
        	    		xcategories.add(costInOut.getName());
        	    		seriesDatas = new ArrayList<CostChartsSeriesData>();
        	    		
        	    		costChartsData = new CostChartsData();
        	    		costChartsData.setXcategories(xcategories);
        	    	}
        	    	
    	    		CostChartsSeriesData costChartsSeriesData = new CostChartsSeriesData();
    	    		List<BigDecimal> data = new ArrayList<BigDecimal>();
    	    		data.add(costInOut.getTotal());
    	    		
    	    		costChartsSeriesData.setName(costInOut.getMonth());
    	    		costChartsSeriesData.setData(data);
        	    	
    	    		seriesDatas.add(costChartsSeriesData);
    	    		
    	    		if( i == (size -1)){
	    				costChartsData.setSeriesData(seriesDatas);
	    				datas.add(costChartsData);
    	    		}
        		}
        	}
        }
        
        //计算部门总收入总支出
        datas = getCostInOutTotal(datas);
        
        //部门排序
        datas = sortByDepartment(datas);
        
		return datas;
	}
    
	private List<CostChartsData> sortByDepartment(List<CostChartsData> datas) {
		String[] departments = new String[]{"GROUP","YSEC","GMO","FDD","CES","ATD","SSC"};
		List<CostChartsData> datasList = new ArrayList<CostChartsData>();
		for(String department : departments){
			for(CostChartsData costData : datas){
				List<String> xcategories = costData.getXcategories();
				if(xcategories.get(0).startsWith(department)){
					datasList.add(costData);
				}
			}
		}
		
		return datasList;
	}

	/**
	 * 计算部门总收入总支出
	 * @param datas
	 * @return
	 */
	private List<CostChartsData> getCostInOutTotal(List<CostChartsData> datas){
	    
	    for(CostChartsData costData : datas){
	        List<CostChartsSeriesData> seriesDatas = costData.getSeriesData();
	        int size = seriesDatas.size();
	        
	        List<BigDecimal> dataIn = new ArrayList<>();
	        List<BigDecimal> dataOut = new ArrayList<>();
	        for(int i = 0; i< size;i++){
	            CostChartsSeriesData costChartsSeriesData = seriesDatas.get(i);
	            List<BigDecimal> data = costChartsSeriesData.getData();
	            if(i % 2 == 0){
	                dataIn.addAll(data);
	            }else{
	                dataOut.addAll(data);
	            }
	        }
	        
	        
	        List<BigDecimal> dataInTotal = new ArrayList<>();
            List<BigDecimal> dataOutTotal = new ArrayList<>();
            BigDecimal intotal = new BigDecimal(0);
            BigDecimal outTotal = new BigDecimal(0);
            
	        for(BigDecimal data : dataIn){
	            intotal = intotal.add(data);
	        }
	        
	        for(BigDecimal data : dataOut){
	            outTotal = outTotal.add(data);
            }
	        
	        dataInTotal.add(intotal);
	        dataOutTotal.add(outTotal);
	        
	        CostChartsSeriesData costChartsSeriesDataIn = new CostChartsSeriesData();
	        costChartsSeriesDataIn.setName("收入");
	        costChartsSeriesDataIn.setData(dataInTotal);
	        
	        CostChartsSeriesData costChartsSeriesDataOut = new CostChartsSeriesData();
	        costChartsSeriesDataOut.setName("支出");
	        costChartsSeriesDataOut.setData(dataOutTotal);
	        
//	        seriesDatas.add(costChartsSeriesDataIn);
//	        seriesDatas.add(costChartsSeriesDataOut);
	        costData.getXcategories().set(0, costData.getXcategories().get(0)+"  (收入 : "+dataInTotal.get(0).setScale(1, RoundingMode.HALF_UP)+"   支出 : "+dataOutTotal.get(0).setScale(1, RoundingMode.HALF_UP)+")");
	    }
	    
	    return datas;
	}

	public List<DepMonthTotalVO> getDepMonthTotalOutcome(AdminUser user,int curYear) {
		
		List<DepMonthTotalVO> depMonthTotals = new ArrayList<>();
		
		CostVO cost = new CostVO();
		boolean flag = false;
        String position = user.getPosition();
        if(CommonsConstant.USER_TYPE_MANAGER.equalsIgnoreCase(position)){
            cost.setDepId(user.getDepId());
            flag = true;
        }else if(CommonsConstant.USER_TYPE_ADMIN.equalsIgnoreCase(position)){
            flag = true;
        }
        
        if(flag){
        	cost.setCostType("1");
        	cost.setStartTime(DateUtils.stringToTimestamp(curYear+"-01-01 00:00:00"));
            cost.setEndTime(DateUtils.stringToTimestamp(curYear+"-12-31 23:59:59"));
        	
            List<CostVO> costs = costDaoMapper.getCostVOList(cost);
            if(CollectionUtils.isNotEmpty(costs)){
            	DepMonthTotalVO depMonthTotal = null;
            	Map<String,DepMonthTotalVO> deps = new HashMap<>();
            	for(CostVO costVO : costs){
            		depMonthTotal = deps.get(costVO.getDepName());
            		if(null == depMonthTotal){
            			depMonthTotal = new DepMonthTotalVO();
            			depMonthTotal.setDepName(costVO.getDepName());
            		}
            		
            		deps.put(costVO.getDepName(), calculateDepMonthTotal(depMonthTotal, costVO));
            	}
            	
            	for(String key : deps.keySet()){
            		depMonthTotals.add(deps.get(key));
            	}
            }
        }
		
        
//		for (CostChartsSeriesData cc : ls) {
//		List<BigDecimal> Datas = cc.getData();
//		BigDecimal all = new BigDecimal(0.0);
//		for (BigDecimal d : Datas) {
//			all = all.add(d);
//		}
//		Datas.add(all);
//	}
//	c.getXcategories().add("总计");
        DepMonthTotalVO all = new DepMonthTotalVO();
        		all.setAprilTotal(new BigDecimal(0.0));
        		all.setAugustTotal(new BigDecimal(0.0));
        		all.setDecemberTotal(new BigDecimal(0.0));
        		all.setFebruaryTotal(new BigDecimal(0.0));
        		all.setJanuaryTotal(new BigDecimal(0.0));
        		all.setJulyTotal(new BigDecimal(0.0));
        		all.setJuneTotal(new BigDecimal(0.0));
        		all.setMarchTotal(new BigDecimal(0.0));
        		all.setMayTotal(new BigDecimal(0.0));
        		all.setNovemberTotal(new BigDecimal(0.0));
        		all.setOctoberTotal(new BigDecimal(0.0));
        		all.setSeptemberTotal(new BigDecimal(0.0));
        for (DepMonthTotalVO d : depMonthTotals) {
        	all.setAprilTotal(all.getAprilTotal().add(d.getAprilTotal()==null?new BigDecimal(0.0):d.getAprilTotal()));
        	all.setAugustTotal(all.getAugustTotal().add(d.getAugustTotal()==null?new BigDecimal(0.0):d.getAugustTotal()));
        	all.setDecemberTotal(all.getDecemberTotal().add(d.getDecemberTotal()==null?new BigDecimal(0.0):d.getDecemberTotal()));
        	all.setFebruaryTotal(all.getFebruaryTotal().add(d.getFebruaryTotal()==null?new BigDecimal(0.0):d.getFebruaryTotal()));
        	all.setJanuaryTotal(all.getJanuaryTotal().add(d.getJanuaryTotal()==null?new BigDecimal(0.0):d.getJanuaryTotal()));
        	all.setJulyTotal(all.getJulyTotal().add(d.getJulyTotal()==null?new BigDecimal(0.0):d.getJulyTotal()));
        	all.setJuneTotal(all.getJuneTotal().add(d.getJuneTotal()==null?new BigDecimal(0.0):d.getJuneTotal()));
        	all.setMarchTotal(all.getMarchTotal().add(d.getMarchTotal()==null?new BigDecimal(0.0):d.getMarchTotal()));
        	all.setMayTotal(all.getMayTotal().add(d.getMayTotal()==null?new BigDecimal(0.0):d.getMayTotal()));
        	all.setNovemberTotal(all.getNovemberTotal().add(d.getNovemberTotal()==null?new BigDecimal(0.0):d.getNovemberTotal()));
        	all.setOctoberTotal(all.getOctoberTotal().add(d.getOctoberTotal()==null?new BigDecimal(0.0):d.getOctoberTotal()));
        	all.setSeptemberTotal(all.getSeptemberTotal().add(d.getSeptemberTotal()==null?new BigDecimal(0.0):d.getSeptemberTotal()));
		}
        
        all.setAprilTotal(all.getAprilTotal().intValue()==0?null:all.getAprilTotal());
		all.setAugustTotal(all.getAugustTotal().intValue()==0?null:all.getAugustTotal());
		all.setDecemberTotal(all.getDecemberTotal().intValue()==0?null:all.getDecemberTotal());
		all.setFebruaryTotal(all.getFebruaryTotal().intValue()==0?null:all.getFebruaryTotal());
		all.setJanuaryTotal(all.getJanuaryTotal().intValue()==0?null:all.getJanuaryTotal());
		all.setJulyTotal(all.getJulyTotal().intValue()==0?null:all.getJulyTotal());
		all.setJuneTotal(all.getJuneTotal().intValue()==0?null:all.getJuneTotal());
		all.setMarchTotal(all.getMarchTotal().intValue()==0?null:all.getMarchTotal());
		all.setMayTotal(all.getMayTotal().intValue()==0?null:all.getMayTotal());
		all.setNovemberTotal(all.getNovemberTotal().intValue()==0?null:all.getNovemberTotal());
		all.setOctoberTotal(all.getOctoberTotal().intValue()==0?null:all.getOctoberTotal());
		all.setSeptemberTotal(all.getSeptemberTotal().intValue()==0?null:all.getSeptemberTotal());
        
        all.setDepName("总计");
        depMonthTotals.add(all);
		return depMonthTotals;
	}
	
	private DepMonthTotalVO calculateDepMonthTotal(DepMonthTotalVO depMonthTotal,CostVO costVO){
		
		Date costTime = costVO.getCostTime();
		DateTimeFormatter formatter = DateTimeFormat.forPattern(DateUtils.PATTERN_DATETIME);
		LocalDate localDate = formatter.parseLocalDate(DateUtils.format(costTime, DateUtils.PATTERN_DATETIME));
		
		int monthOfYear = localDate.getMonthOfYear();
		if(monthOfYear == 1){
			BigDecimal januaryTotal = depMonthTotal.getJanuaryTotal();
			if(null == januaryTotal){
				januaryTotal = new BigDecimal(0);
			}
			januaryTotal = januaryTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setJanuaryTotal(januaryTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 2){
			BigDecimal februaryTotal = depMonthTotal.getFebruaryTotal();
			if(null == februaryTotal){
				februaryTotal = new BigDecimal(0);
			}
			februaryTotal = februaryTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setFebruaryTotal(februaryTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 3){
			BigDecimal marchTotal = depMonthTotal.getMarchTotal();
			if(null == marchTotal){
				marchTotal = new BigDecimal(0);
			}
			marchTotal = marchTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setMarchTotal(marchTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 4){
			
			BigDecimal aprilTotal = depMonthTotal.getAprilTotal();
			if(null == aprilTotal){
				aprilTotal = new BigDecimal(0);
			}
			aprilTotal = aprilTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setAprilTotal(aprilTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 5){
			
			BigDecimal mayTotal = depMonthTotal.getMayTotal();
			if(null == mayTotal){
				mayTotal = new BigDecimal(0);
			}
			mayTotal = mayTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setMayTotal(mayTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 6){
			
			BigDecimal juneTotal = depMonthTotal.getJuneTotal();
			if(null == juneTotal){
				juneTotal = new BigDecimal(0);
			}
			juneTotal = juneTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setJuneTotal(juneTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 7){
			
			BigDecimal julyTotal = depMonthTotal.getJulyTotal();
			if(null == julyTotal){
				julyTotal = new BigDecimal(0);
			}
			julyTotal = julyTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setJulyTotal(julyTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 8){
			
			BigDecimal augustTotal = depMonthTotal.getAugustTotal();
			if(null == augustTotal){
				augustTotal = new BigDecimal(0);
			}
			augustTotal = augustTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setAugustTotal(augustTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 9){
			
			BigDecimal septemberTotal = depMonthTotal.getSeptemberTotal();
			if(null == septemberTotal){
				septemberTotal = new BigDecimal(0);
			}
			septemberTotal = septemberTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setSeptemberTotal(septemberTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 10){
			
			BigDecimal octoberTotal = depMonthTotal.getOctoberTotal();
			if(null == octoberTotal){
				octoberTotal = new BigDecimal(0);
			}
			octoberTotal = octoberTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setOctoberTotal(octoberTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 11){
			
			BigDecimal novemberTotal = depMonthTotal.getNovemberTotal();
			if(null == novemberTotal){
				novemberTotal = new BigDecimal(0);
			}
			novemberTotal = novemberTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setNovemberTotal(novemberTotal.setScale(1, RoundingMode.HALF_UP));
			
		}else if(monthOfYear == 12){
			BigDecimal decemberTotal = depMonthTotal.getDecemberTotal();
			if(null == decemberTotal){
				decemberTotal = new BigDecimal(0);
			}
			decemberTotal = decemberTotal.add(new BigDecimal(costVO.getCostNum()));
			depMonthTotal.setDecemberTotal(decemberTotal.setScale(1, RoundingMode.HALF_UP));
		}
		
		return depMonthTotal;
	}
	
}
