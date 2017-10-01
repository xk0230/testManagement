package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.CompetencyMapper;
import com.codyy.oc.admin.dao.DepartmentMapper;
import com.codyy.oc.admin.dao.PositionAuditMapper;
import com.codyy.oc.admin.dao.RecruitAuditMapper;
import com.codyy.oc.admin.dao.RecruitMapper;
import com.codyy.oc.admin.dao.RecruitRCompetencyMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Competency;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.Recruit;
import com.codyy.oc.admin.entity.RecruitAudit;
import com.codyy.oc.admin.entity.RecruitRCompetency;
import com.codyy.oc.admin.view.PositionSearchView;

/**
 * 胜任特征server
 * @author Administrator
 *
 */
@Service("recruitService")
public class RecruitService {
	@Autowired
	private  RecruitMapper mapper;
	@Autowired
	private AdminUserMapper adminUserMapper;
	@Autowired
	private RecruitRCompetencyMapper recruitRCompetencyMapper;
	@Autowired
	private RecruitAuditMapper recruitAuditMapper;
	@Autowired
	private CompetencyMapper competencyMapper;
	@Autowired
	private DepartmentMapper departmentMapper;
	
	
	private void setAuditUser(Recruit recruit) {
		//获取当前审批人，如果是普通员工提交的，则审批人为部门经理，如果部门没有经理，则给超级管理员；如果是部门经理提交的，则审批人为超级管理员
		if(AdminUser.SUPER_ADMIN_ID.equals(recruit.getCreateUser())) {
			//如果是超级管理员创建
			recruit.setAuditUser(AdminUser.SUPER_ADMIN_ID);
		}else {
			String managerId = adminUserMapper.getManagerIdByUserId(recruit.getCreateUser());
			if(StringUtils.isEmpty(managerId)||managerId.equals(recruit.getCreateUser())) {
				//如果没有部门经理或者本身就是部门经理
				RecruitAudit ra = new RecruitAudit();
				ra.setAuditUser(AdminUser.SUPER_ADMIN_ID);
				ra.setCreateTime(new Date());
				ra.setId(UUIDUtils.getUUID());
				ra.setRecruitId(recruit.getId());
				
				Integer maxnum = recruitAuditMapper.getMaxRecruitNumByRecId(recruit.getId());
				ra.setRecruitNum(maxnum==null?1:(maxnum+1));
				recruitAuditMapper.insert(ra);
				recruit.setAuditUser(AdminUser.SUPER_ADMIN_ID);
			}else {
				//添加审批记录
				RecruitAudit ra = new RecruitAudit();
				ra.setAuditUser(managerId);
				ra.setCreateTime(new Date());
				ra.setId(UUIDUtils.getUUID());
				ra.setRecruitId(recruit.getId());
				
				Integer maxnum = recruitAuditMapper.getMaxRecruitNumByRecId(recruit.getId());
				ra.setRecruitNum(maxnum==null?1:(maxnum+1));
				recruitAuditMapper.insert(ra);
				recruit.setAuditUser(managerId);
			}
		}
	}
	
	public void insert(Recruit recruit) {
		recruit.setId(UUIDUtils.getUUID());
		recruit.setCreateTime(new Date());
		recruit.setStatus(CommonsConstant.AUDIT_STATUS_AUDITING);
		
		setAuditUser(recruit);
		mapper.insert(recruit);
		addCompetencys(recruit);

//		List<String> adminUserIds = adminUserMapper.getAllAdminUserIDs();
//		adminUserIds.remove(recruit.getCreateUser());
//		
//		Date createTime = new Date();
//		for (String id : adminUserIds) {
//			RecruitAudit pa = new RecruitAudit();
//			pa.setCreateTime(createTime);
//			pa.setAuditUserId(id);
//			pa.setCreateUserId(recruit.getCreateUser());
//			pa.setrecruitAuditId(UUIDUtils.getUUID());
//			pa.setrecruitId(recruit.getPostId());
//			auditMapper.insert(pa);
//		}
	};
	
	
	private void addCompetencys(Recruit recruit) {
		String[] competencys = recruit.getCompetencysStr().split("@");
		for (String c : competencys) {
			if(c != null && StringUtils.isNotBlank(c)) {
				RecruitRCompetency rc = new RecruitRCompetency();
				rc.setId(UUIDUtils.getUUID());
				rc.setCompetencyId(c);
				rc.setRecruitId(recruit.getId());
				recruitRCompetencyMapper.insert(rc);
			}
		}
	}
	
	
	public void updateById(Recruit recruit) {
		//先删除原有的关系
		recruitRCompetencyMapper.deleteByRecId(recruit.getId());
		addCompetencys(recruit);
		setAuditUser(recruit);
		mapper.updateByPrimaryKeySelective(recruit);
	}
	
	
	public Recruit getByid(String id) {
		Recruit rec =  mapper.selectByPrimaryKey(id);
		rec.setDepId(departmentMapper.getDepIdByPostId(rec.getPostid()));
		rec.setCompetencys(competencyMapper.getByRecId(rec.getId()));
		return rec;
	}
	
	public Page getRecruitPageList(Page page,Recruit search){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("postId",search.getPostid());
		map.put("status", search.getStatus());
		map.put("createUser",search.getCreateUser());
	    page.setMap(map);
		List<Recruit> data = mapper.getRecruitPageList(page);
		page.setData(data);
		return page;
	}
}
