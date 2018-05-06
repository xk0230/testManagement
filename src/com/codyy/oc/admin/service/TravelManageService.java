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
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.Travel;
import com.codyy.oc.admin.vo.CostVO;
import com.codyy.oc.admin.vo.TravelVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:TravelManageService.java, v 0.1	2018年4月18日	下午9:12:34	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("TravelManageService")
public class TravelManageService {

	private static final String DELETE_SUCCESS = "删除成功";
	private static final String DELETE_ERROR = "删除失败";
	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String SCRAP_SUCCESS = "报废成功";
	private static final String SCRAP_ERROR = "报废失败";
	private static final String SUB_SUCCESS = "提交成功";
	private static final String SUB_ERROR = "提交失败";
	private static final String REJ_SUCCESS = "提交成功";
	private static final String REJ_ERROR = "提交失败";
	
	@Autowired
	private TravelMapper travelMapper;
	
	@Autowired
	private TravelDetailMapper travelDetailMapper;
	
	@Autowired
	private TravelDetailTypeMapper travelDetailTypeMapper;
	
	@Autowired
	private CostService costService;
	
	@Autowired
	AdminUserManagerService adminUserManagerService;
	
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
		    travel.setCreateUser(user.getUserId());
		    travel.setDepId(user.getDepId());
		    
		    if(user.getPosition().equals("MANAGER")) {
		    	travel.setStatus("03");
			}else if(user.getUserId().equals("admin")) {
				travel.setStatus("05");
			}else {
				travel.setStatus("00");
			}
			
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
	 * 出差列表查询
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
	    map.put("depId", travel.getUserDepId());
	    map.put("userPosition", travel.getUserPosition());
	    
	    page.setMap(map);
	    
	    List<TravelVO> travelPageList = travelMapper.getTravelPageList(page);
	    for(TravelVO travelVO : travelPageList) {
	    	travelVO.setCosts(travelMapper.getCostsById(travelVO.getId()));
	    }
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
	
	
public JsonDto updateTravelStatus(AdminUser user,TravelVO travel){
		
		JsonDto jsonDto = new JsonDto();
		
		String sucessResult = "";
		String errResult = "";
		
		if(travel.getStatus().equals("99")) {
			sucessResult = SCRAP_SUCCESS;
			errResult = SCRAP_ERROR;
		}else if(travel.getStatus().equals("03") || travel.getStatus().equals("05")|| travel.getStatus().equals("01")) {
			sucessResult = SUB_SUCCESS;
			errResult = SUB_ERROR;
			
		}else if(travel.getStatus().equals("02")|| travel.getStatus().equals("04")) {
			sucessResult = REJ_SUCCESS;
			errResult = REJ_ERROR;
		}
		if(user.getPosition().equals("MANAGER") && (travel.getStatus().equals("03") || travel.getStatus().equals("02"))) {
			travel.setAuditUser(user.getUserId());
		}
		
		int updateCostEntityNum = travelMapper.updateTravelStatus(travel);
		if(updateCostEntityNum == 1){
			jsonDto.setCode(0);
			jsonDto.setMsg(sucessResult);
		}else{
			jsonDto.setMsg(errResult);
		}
		return jsonDto;
	}


/**
 * 出差审核查询
 * @param cost
 * @return
 */
public Page getTravelAuditList(TravelVO travel){
    Page page = new Page();
    page.setStart(travel.getStart());
    page.setEnd(travel.getEnd());
    
    Map<String, Object> map = new HashMap<String, Object>();
    
//    map.put("costType", cost.getCostType());
//    map.put("costSubtypeId", cost.getCostSubtypeId());
    map.put("depId", travel.getUserDepId());
    map.put("status", travel.getStatus());
    map.put("startTime", travel.getStartDate());
    map.put("endTime", travel.getEndDate());
    map.put("userId", travel.getUserId());
//    map.put("costNo", cost.getCostNo());
//    map.put("remark", cost.getRemark());
//    map.put("auditStatus", cost.getAuditStatus());
    map.put("userPosition", travel.getUserPosition());
    
    page.setMap(map);
    
    List<TravelVO> pageList = travelMapper.getTravelAuditPageList(page);
    
//    for(TravelVO TravelVO : pageList) {
//    	TravelVO.setCostDepList(travelMapper.getTravelDepList(TravelVO.getId()));
//    }
    for(TravelVO travelVO : pageList) {
    	travelVO.setCosts(travelMapper.getCostsById(travelVO.getId()));
    }
    page.setData(pageList);
    return page;
}

/**
 * 出差查看查询
 * @param cost
 * @return
 */
public Page getTravelViewList(TravelVO travel){
    Page page = new Page();
    page.setStart(travel.getStart());
    page.setEnd(travel.getEnd());
    
    Map<String, Object> map = new HashMap<String, Object>();
    
//    map.put("costType", cost.getCostType());
//    map.put("costSubtypeId", cost.getCostSubtypeId());
    map.put("depId", travel.getUserDepId());
    map.put("status", travel.getStatus());
    map.put("startTime", travel.getStartDate());
    map.put("endTime", travel.getEndDate());
    map.put("userId", travel.getUserId());
//    map.put("costNo", cost.getCostNo());
//    map.put("remark", cost.getRemark());
    map.put("userPosition", travel.getUserPosition());
//    map.put("searchMonth", cost.getSearchMonth());
    
    page.setMap(map);
    
    List<TravelVO> pageList = travelMapper.getTravelViewPageList(page);
    
    for(TravelVO travelVO : pageList) {
    	travelVO.setTravelDetailVOList(travelDetailMapper.getTravelDetailList(travelVO.getId()));
    	
    	travelVO.setCosts(travelMapper.getCostsById(travelVO.getId()));
    }
    
//    for(TravelVO travelvo : pageList) {
//    	travelvo.setCostDepList(travelMapper.getTravelDepList(travelvo.getCostId()));
//    }
    page.setData(pageList);
    return page;
}


public JsonDto updateStatus(AdminUser user,TravelVO travel){
	
	JsonDto jsonDto = new JsonDto();
	
	String sucessResult = "";
	String errResult = "";
	
	if(travel.getStatus().equals("99")) {
		sucessResult = SCRAP_SUCCESS;
		errResult = SCRAP_ERROR;
	}else if(travel.getStatus().equals("03") || travel.getStatus().equals("05")|| travel.getStatus().equals("01")) {
		sucessResult = SUB_SUCCESS;
		errResult = SUB_ERROR;
	}else if(travel.getStatus().equals("02")|| travel.getStatus().equals("04")) {
		sucessResult = REJ_SUCCESS;
		errResult = REJ_ERROR;
	}
	if(user.getPosition().equals("MANAGER") && (travel.getStatus().equals("03") || travel.getStatus().equals("02"))) {
		travel.setAuditUser(user.getUserId());
	}
	
	int updateCostEntityNum = travelMapper.updateTravelStatus(travel);
	
	if(travel.getStatus().equals("05")) {
		//如果是最终管理员通过，那么把出差明细的费用落地到成本中心。
		AdminUser admin = new AdminUser();
		admin.setUserId("admin");
		admin.setPosition("ADMIN");
		
		List<CostEntityBean> costs = travelMapper.getCostsById(travel.getId());
		AdminUser au = null;
		for (CostEntityBean c : costs) {
			if(au == null) {
				au = adminUserManagerService.getselcAdminUserById(c.getCreateUserId());
			}
			c.setTravelId(travel.getId());//设置出差id
			c.setCostSubtypeId("9");//设置子分类为差旅费
			costService.insertOrUpdateCostEntity(au, c);
			c.setStatus("05");
			costService.updateCostStatus(admin,c);
		}
	}
	
	
	if(updateCostEntityNum == 1){
		jsonDto.setCode(0);
		jsonDto.setMsg(sucessResult);
	}else{
		jsonDto.setMsg(errResult);
	}
	return jsonDto;
}


	public  TravelVO getTravelById(String id){
		return travelMapper.getById(id);
	}
	
	public List<CostEntityBean> getCostsById(String id){
		List<CostEntityBean> ls = travelMapper.getCostsById(id);
		return ls;
	}
}
