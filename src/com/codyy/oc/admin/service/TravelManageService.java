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
import com.codyy.oc.admin.dao.TravelDetailTypeMapper;
import com.codyy.oc.admin.dao.TravelMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Travel;
import com.codyy.oc.admin.entity.TravelDetailType;
import com.codyy.oc.admin.vo.TravelVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:TravelManageService.java, v 0.1	2018年4月18日	下午9:12:34	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("TravelManageService")
public class TravelManageService {

	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DELETE_SUCCESS = "删除成功";
	private static final String DELETE_ERROR = "删除失败";
	
	@Autowired
	private TravelMapper travelMapper;
	
	@Autowired
	private TravelDetailTypeMapper travelDetailTypeMapper;
	
	public void insertTravel(Travel record) {
		travelMapper.insert(record);
	}

	public List<Travel> getAll() {
		return travelMapper.getAll();
	}
	
	/**
	 * 插入，更新合同数据
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto insertOrUpdateTravel(AdminUser user,Travel travel){
		
		JsonDto jsonDto = new JsonDto();
		//CostID为空时执行插入
		if(StringUtils.isBlank(travel.getId())){
			//部门ID=当前用户的部门
		    String depId = user.getDepId();
			//创建时间和创建者
		    travel.setCreateTime(DateUtils.getCurrentTimestamp());
//		    travel.setCreateUserId(user.getUserId());
			
		    if(StringUtils.isNotBlank(depId)) {
		    	travel.setId(UUID.randomUUID().toString());
		    	
		    	//执行插入
		    	int insertCostEntityNum = travelMapper.insert(travel);
		    	if(insertCostEntityNum == 1) {
					jsonDto.setCode(0);
					jsonDto.setMsg(INSERT_SUCCESS);
		    	}else {
					jsonDto.setMsg(INSERT_ERROR);
		    	}
		    }
		}else{
			travel.setCreateTime(DateUtils.getCurrentTimestamp());
//			travel.setCreateUserId(user.getUserId());
		    
			int updateCostEntityNum = travelMapper.updateByPrimaryKey(travel);
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
	 * 合同列表查询
	 * @param travel
	 * @return
	 */
	public Page getTravelPageList(TravelVO travel){
	    Page page = new Page();
	    page.setStart(travel.getStart());
	    page.setEnd(travel.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();

	    map.put("name", travel.getCreateUser());
	    map.put("place", travel.getPlace());
	    map.put("userId", travel.getUserId());
	    map.put("startTime", travel.getStartDate());
	    map.put("endTime", travel.getEndDate());
	    map.put("userDepId", travel.getUserDepId());
	    map.put("userPosition", travel.getUserPosition());
	    
	    page.setMap(map);
	    
	    List<TravelVO> travelPageList = travelMapper.getTravelPageList(page);
	    page.setData(travelPageList);
	    
	    return page;
	}
	
	public JsonDto deleteTravel(TravelVO travel){
		JsonDto jsonDto = new JsonDto();
		int code = travelMapper.deleteByPrimaryKey(travel.getId());
		if(code == 1) {
			jsonDto.setCode(0);
			jsonDto.setMsg(DELETE_SUCCESS);
    	}else {
			jsonDto.setMsg(DELETE_ERROR);
    	}
		return jsonDto;
	}
	

}
