package com.codyy.oc.admin.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.BookHistoryMapper;
import com.codyy.oc.admin.dao.BookMapper;
import com.codyy.oc.admin.dao.CostDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Book;
import com.codyy.oc.admin.entity.BookHistory;
import com.codyy.oc.admin.vo.BookVO;
import com.codyy.oc.admin.vo.CostChartsData;
import com.codyy.oc.admin.vo.CostChartsSeriesData;
import com.codyy.oc.admin.vo.CostInOutlayType;
import com.codyy.oc.admin.vo.CostMonthInOut;
import com.codyy.oc.admin.vo.CostTotalInOut;
import com.codyy.oc.admin.vo.CostVO;
import com.codyy.oc.admin.vo.CostYearVO;

/**
 * 图书控制server
 * @author Administrator
 *
 */
@Service("bookServer")
public class BookService {
    private static final String INSERT_SUCCESS = "保存成功";
    private static final String INSERT_ERROR = "保存失败";
    private static final String UPDATE_SUCCESS = "修改成功";
    private static final String UPDATE_ERROR = "修改失败";
	private static final String DEL_SUCCESS = "删除成功";
	private static final String DEL_ERROR = "删除失败";
	private static final String NO_EXIT_DATA = "数据不存在";
	private static final String BOOK_GET = "get";//借书
	private static final String BOOK_BACK = "back";//还书
	

	@Autowired
	private CostDaoMapper costDaoMapper; 
	
	@Autowired
	private BookMapper bookDaoMapper; 
	
	@Autowired
	private BookHistoryMapper bookHistoryMapper;
	
	public JsonDto insertOrUpdateBookEntity(AdminUser user,Book b){
		JsonDto jsonDto = new JsonDto();
		b.setUpdateTime(DateUtils.getCurrentTimestamp());
		
		if(StringUtils.isEmpty(b.getId())){
			b.setId(UUIDUtils.getUUID());
			b.setCreateTime(DateUtils.getCurrentTimestamp());
			Integer max = bookDaoMapper.getMaxBookNo();
			b.setBookNo(max==null?1:max+1);
			int insNum = bookDaoMapper.insertSelective(b);
            if(insNum == 1){
                jsonDto.setCode(0);
                jsonDto.setMsg(INSERT_SUCCESS);
            }else{
                jsonDto.setMsg(INSERT_ERROR);
            }
		}else {
			int updNum = bookDaoMapper.updateByPrimaryKeySelective(b);
			if(updNum == 1){
                jsonDto.setCode(0);
                jsonDto.setMsg(UPDATE_SUCCESS);
            }else{
                jsonDto.setMsg(UPDATE_ERROR);
            }
		}
		return jsonDto;
	}
	
	public JsonDto getBookEntityById(String id){
		
		JsonDto jsonDto = new JsonDto();
		Book b = bookDaoMapper.selectByPrimaryKey(id);
		if(b != null){
			jsonDto.setCode(0);
			jsonDto.setObjData(b);
		}else{
			jsonDto.setMsg(NO_EXIT_DATA);
		}
		
		return jsonDto;
		
	}

	public JsonDto delBookEntityById(String id){
		
		JsonDto jsonDto = new JsonDto();
		int delNum = bookDaoMapper.deleteByPrimaryKey(id);
		if(delNum == 1){
			jsonDto.setCode(0);
			jsonDto.setMsg(DEL_SUCCESS);
		}else{
			jsonDto.setMsg(DEL_ERROR);
		}
		
		return jsonDto;
	}
	
	public JsonDto putOrBack(String userId,String id){
		JsonDto jsonDto = new JsonDto();
		BookHistory bh = new BookHistory();
		bh.setId(UUIDUtils.getUUID());
		bh.setBookId(id);
		bh.setUserId(userId);
		bh.setBookTime(new Date());

		Book b = bookDaoMapper.selectByPrimaryKey(id);
		if(b == null) {
			jsonDto.setMsg("查无此书");
		}else if(b.getUserId() != null) {
			if(b.getUserId().equals(userId)) {
				//还书
				b.setUpdateTime(DateUtils.getCurrentTimestamp());
				b.setUserId(null);
				bookDaoMapper.updateByPrimaryKey(b);
				jsonDto.setCode(0);
				//添加还书记录
				bh.setType(BOOK_BACK);
				bookHistoryMapper.insert(bh);
				jsonDto.setMsg("还书成功");
			}else {
				jsonDto.setMsg("此书已被人借走，请稍后再试");
			}
		}else {
			//借书
			b.setUpdateTime(DateUtils.getCurrentTimestamp());
			b.setUserId(userId);
			bookDaoMapper.updateByPrimaryKey(b);
			//添加借书记录
			bh.setType(BOOK_GET);
			bookHistoryMapper.insert(bh);
			jsonDto.setCode(0);
			jsonDto.setMsg("借书成功");
		}
		
		return jsonDto;
	}
	
	/**
	 * 图书列表查询
	 * @param cost
	 * @return
	 */
	public Page getBookPageList(BookVO b){
	    Page page = new Page();
	    page.setStart(b.getStart());
	    page.setEnd(b.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    map.put("name", b.getName());
	    
	    page.setMap(map);
	    
	    List<Book> costPageList = bookDaoMapper.getBookPageList(page);
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
	    	alls.add(all);
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
	 * 获取图书支出类型图表数据
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
     * 获取图书收入支出
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
        
		return datas;
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
	        costChartsSeriesDataIn.setName("总收入");
	        costChartsSeriesDataIn.setData(dataInTotal);
	        
	        CostChartsSeriesData costChartsSeriesDataOut = new CostChartsSeriesData();
	        costChartsSeriesDataOut.setName("总支出");
	        costChartsSeriesDataOut.setData(dataOutTotal);
	        
//	        seriesDatas.add(costChartsSeriesDataIn);
//	        seriesDatas.add(costChartsSeriesDataOut);
	        costData.getXcategories().set(0, costData.getXcategories().get(0)+"  (总收入 : "+dataInTotal.get(0)+"   总支出 : "+dataOutTotal.get(0)+")");
	    }
	    
	    return datas;
	}
	
	/**
	 * 获取借书历史记录
	 * @param bh
	 * @return
	 */
	public List<BookHistory> getHistory(BookHistory bh){
		return bookHistoryMapper.selectAll(bh);
	}
}
