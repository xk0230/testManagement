package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.PositionAuditMapper;
import com.codyy.oc.admin.dao.PositionMapper;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.PositionAudit;
import com.codyy.oc.admin.view.PositionSearchView;

@Service
public class PositionService {
	@Autowired
	private PositionMapper mapper;
	@Autowired
	private PositionAuditMapper auditMapper;
	@Autowired
	private AdminUserMapper adminUserMapper;
	
	public List<Position> getPositionByDepId(String depId){
		return mapper.selectByDepId(depId);
	}
	
	public Position getPositionById(String depId){
		return mapper.selectByPrimaryKey(depId);
	}
	
	
	public void insert(Position position) {
		position.setPostId(UUIDUtils.getUUID());
		position.setCreateTime(new Date());
		position.setStatus(CommonsConstant.AUDIT_STATUS_AUDITING);
		mapper.insert(position);
		
		List<String> adminUserIds = adminUserMapper.getAllAdminUserIDs();
		adminUserIds.remove(position.getCreateUser());
		
		Date createTime = new Date();
		for (String id : adminUserIds) {
			PositionAudit pa = new PositionAudit();
			pa.setCreateTime(createTime);
			pa.setAuditUserId(id);
			pa.setCreateUserId(position.getCreateUser());
			pa.setPositionAuditId(UUIDUtils.getUUID());
			pa.setPositionId(position.getPostId());
			auditMapper.insert(pa);
		}
	};
	
	public void updateById(Position position) {
		mapper.updateByPrimaryKeySelective(position);
	}
	
	public ResultJson auditPosition(PositionAudit audit) {
		int num = auditMapper.selectUnauditByid(audit.getPositionAuditId());
		if(num != 1) {
			return new ResultJson(false,"该审批已完成，请勿重复审批");
		}
		else {
			audit.setAuditTime(new Date());
			auditMapper.updateByPrimaryKeySelective(audit);
			//如果全部审批通过，则将该岗位状态修改为通过，如果有人不通过，则修改为不通过
			if(audit.getResult() == CommonsConstant.AUDIT_UNPASS) {
				//如果是不通过
				auditMapper.setUnPassById(audit.getPositionAuditId());
			}else {
				//如果是通过
				int unpassnum = auditMapper.getUnpassOrNullNum(audit.getPositionAuditId());
				if(unpassnum == 0 ) {
					//如果已经全部通过，则将该岗位修改为审批通过
					auditMapper.passById(audit.getPositionAuditId());
				}
			}
		}
		return new ResultJson(true);
	}
	
	/**
	 * 根据用户ID获取未审批的数量
	 * @param userId
	 * @return
	 */
	public Integer getUntreatedNum(String userId) {
		return auditMapper.getUntreatedNum(userId);
	} 
	
	
	public Page getPositionPageList(Page page,PositionSearchView search){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", search.getName());
		map.put("depId",search.getDepId());
		map.put("status", search.getStatus());
		map.put("createUser",search.getCreateUser());
	    page.setMap(map);
		List<Position> data = mapper.getPositionPageList(page);
		page.setData(data);
		return page;
	}
	
	public Page getPositionAuditPageList(Page page,PositionSearchView search){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("createUserId", search.getCreateUser());
		map.put("postId", search.getPostId());
		if(search.getAudit()!=null) {
			map.put("auditUserId",search.getAudit().getAuditUserId());
			map.put("result", search.getAudit().getResult());
			map.put("postName", search.getAudit().getPostName());
			map.put("depId", search.getDepId());
		}
	    page.setMap(map);
		List<PositionAudit> data = auditMapper.getPositionAuditPageList(page);
		page.setData(data);
		return page;
	}
	
}
