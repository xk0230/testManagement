package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.PositionAuditMapper;
import com.codyy.oc.admin.dao.PositionMapper;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.PositionAudit;

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
	
	
	public void insert(Position position) {
		position.setPostId(UUIDUtils.getUUID());
		position.setCreateTime(new Date());
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
	
}
