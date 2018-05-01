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
import com.codyy.oc.admin.dao.TravelDetailMapper;
import com.codyy.oc.admin.dao.TravelDetailTypeMapper;
import com.codyy.oc.admin.dao.TravelMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Travel;
import com.codyy.oc.admin.entity.TravelDetail;
import com.codyy.oc.admin.entity.TravelDetailType;
import com.codyy.oc.admin.vo.TravelDetailVO;
import com.codyy.oc.admin.vo.TravelVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:TravelManageService.java, v 0.1	2018年4月18日	下午9:12:34	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("TravelDetailManageService")
public class TravelDetailManageService {

	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DELETE_SUCCESS = "删除成功";
	private static final String DELETE_ERROR = "删除失败";
	
	@Autowired
	private TravelDetailMapper travelDetailMapper;
	
	@Autowired
	private TravelDetailTypeMapper travelDetailTypeMapper;
	
	public void insertTravelDetail(TravelDetail record) {
		travelDetailMapper.insert(record);
	}

/*	public List<TravelDetail> getAll() {
		return travelDetailMapper.getAll();
	}*/
	
	/**
	 * 插入，更新合同数据
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto insertOrUpdateTravelDetail(AdminUser user,TravelDetail traveldetail){
		
		JsonDto jsonDto = new JsonDto();
		//CostID为空时执行插入
		if(StringUtils.isBlank(traveldetail.getId())){
			//部门ID=当前用户的部门
		    	traveldetail.setId(UUID.randomUUID().toString());
		    	traveldetail.setCreateTime(DateUtils.getCurrentTimestamp());
		    	
		    	//执行插入
		    	int insertCostEntityNum = travelDetailMapper.insert(traveldetail);
		    	if(insertCostEntityNum == 1) {
					jsonDto.setCode(0);
					jsonDto.setMsg(INSERT_SUCCESS);
		    	}else {
					jsonDto.setMsg(INSERT_ERROR);
		    	}
		}else{
			int updateCostEntityNum = travelDetailMapper.updateByPrimaryKey(traveldetail);
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
	public Page getTravelDetailPageList(TravelDetailVO travelDetail){
	    Page page = new Page();
	    page.setStart(travelDetail.getStart());
	    page.setEnd(travelDetail.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();

//	    map.put("name", travel.getCreateUser());
//	    map.put("place", travel.getPlace());
//	    map.put("userId", travel.getUserId());
	    map.put("startTime", travelDetail.getStartDate());
	    map.put("endTime", travelDetail.getEndDate());
//	    map.put("userDepId", travel.getUserDepId());
	    map.put("travelId", travelDetail.getTravelId());
	    map.put("type", travelDetail.getType());
	    
	    
	    page.setMap(map);
	    
	    List<TravelDetailVO> travelDetailPageList = travelDetailMapper.getTravelDetailPageList(page);
	    page.setData(travelDetailPageList);
	    
	    return page;
	}
	
	public JsonDto deleteTravelDetail(TravelDetailVO traveldetail){
		JsonDto jsonDto = new JsonDto();
		int code = travelDetailMapper.deleteByPrimaryKey(traveldetail.getId());
		if(code == 1) {
			jsonDto.setCode(0);
			jsonDto.setMsg(DELETE_SUCCESS);
    	}else {
			jsonDto.setMsg(DELETE_ERROR);
    	}
		return jsonDto;
	}
	
	public JsonDto getTravelDetailType(){
		JsonDto jsonDto = new JsonDto();
		List<TravelDetailType> ls =  travelDetailTypeMapper.getAll();
		jsonDto.setObjData(ls);
		jsonDto.setCode(0);
		jsonDto.setMsg(DELETE_SUCCESS);
		return jsonDto;
	}
}
