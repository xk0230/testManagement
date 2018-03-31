/**
 * 
 */
package com.codyy.oc.admin.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.CostDaoMapper;
import com.codyy.oc.admin.dao.ProjectMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.CostEntityBean;
import com.codyy.oc.admin.entity.CostSeqBean;
import com.codyy.oc.admin.entity.Payment;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.vo.PaymentVO;
import com.codyy.oc.admin.vo.ProjectVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ProjectService.java, v 0.1	2018年3月29日	下午7:51:53	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("ProjectService")
public class ProjectService {

	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DELETE_SUCCESS = "删除成功";
	private static final String DELETE_ERROR = "删除失败";
	
	@Autowired
	private ProjectMapper projectMapper;
	
	@Autowired
	private CostDaoMapper costDaoMapper;
	
	public void insertProject(Project record) {
		projectMapper.insert(record);
	}
	
	/**
	 * 插入，更新合同数据
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto insertOrUpdateProject(AdminUser user,Project project){
		
		JsonDto jsonDto = new JsonDto();
		//CostID为空时执行插入
		if(StringUtils.isBlank(project.getId())){
			//部门ID=当前用户的部门
		    String depId = user.getDepId();
			//创建时间和创建者
		    project.setCreateTime(DateUtils.getCurrentTimestamp());
		    project.setPjNo(CreateProjectNo(project));
		    
		    if(StringUtils.isNotBlank(depId)) {
		    	project.setId(UUID.randomUUID().toString());
		    	
		    	//执行插入
		    	int insertPaymentEntityNum = projectMapper.insert(project);
		    	if(insertPaymentEntityNum == 1) {
					jsonDto.setCode(0);
					jsonDto.setMsg(INSERT_SUCCESS);
		    	}else {
					jsonDto.setMsg(INSERT_ERROR);
		    	}
		    }
		}else{
			project.setCreateTime(DateUtils.getCurrentTimestamp());
//		    payment.setCreateUser(user.getUserId());
		    
			int updateCostEntityNum = projectMapper.updateByPrimaryKey(project);
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
	 * @param contract
	 * @return
	 */
	public Page getProjectPageList(ProjectVO projectVO){
	    Page page = new Page();
	    page.setStart(projectVO.getStart());
	    page.setEnd(projectVO.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();

	    map.put("name", projectVO.getName());
	    map.put("pjNo", projectVO.getPjNo());
	    map.put("startTime", projectVO.getStartDate());
	    map.put("endTime", projectVO.getEndDate());
	    map.put("userDepId", projectVO.getUserDepId());
	    map.put("userPosition", projectVO.getUserPosition());
	    
	    page.setMap(map);
	    
	    List<ProjectVO> projectVOPageList = projectMapper.getProjectPageList(page);
	    page.setData(projectVOPageList);
	    
	    return page;
	}
	
	public JsonDto deleteProject(ProjectVO project){
		JsonDto jsonDto = new JsonDto();
		int code = projectMapper.deleteByPrimaryKey(project.getId());
		if(code == 1) {
			jsonDto.setCode(0);
			jsonDto.setMsg(DELETE_SUCCESS);
    	}else {
			jsonDto.setMsg(DELETE_ERROR);
    	}
		return jsonDto;
	}
	
	

	/**
	 * 生成成本单号
	 * @param project
	 * @return
	 */
	private String CreateProjectNo(Project project) {
		//当前日期
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); 
		String today = dateFormat.format(new Date());

		//取番
		CostSeqBean costSeqBean = costDaoMapper.getCostNoSeq("2");
		
		if(costSeqBean != null) {
			if(costSeqBean.getDate().equals(today)) {
				costSeqBean.setSeq(costSeqBean.getSeq() + 1);
				costDaoMapper.updateCostNoSeq(costSeqBean);
			}else {
				costSeqBean.setDate(today);
				costSeqBean.setSeq(1);
				costDaoMapper.updateCostNoSeq(costSeqBean);
			}
		}else {
			costSeqBean = new CostSeqBean();
			costSeqBean.setType("2");
			costSeqBean.setDate(today);
			costSeqBean.setSeq(1);
			costDaoMapper.insertCostNoSeq(costSeqBean);
		}
		return "2" + today + "_" + String.format("%04d", costSeqBean.getSeq());
	}
}
