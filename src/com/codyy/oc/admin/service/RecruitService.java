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
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.CompetencyMapper;
import com.codyy.oc.admin.dao.DepartmentMapper;
import com.codyy.oc.admin.dao.PositionAuditMapper;
import com.codyy.oc.admin.dao.PositionMapper;
import com.codyy.oc.admin.dao.RecruitAuditMapper;
import com.codyy.oc.admin.dao.RecruitMapper;
import com.codyy.oc.admin.dao.RecruitRCompetencyMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Competency;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.PositionAudit;
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
	@Autowired
	private PositionMapper positionMapper;
	
	private void setAuditUser(Recruit recruit,String[] audits) {
		if(StringUtils.isEmpty(recruit.getId())) {
			//如果是新增
			recruit.setAuditUser(recruit.getCreateUser());//初始创建时Audituser为创建人
		}
		//获取当前审批人，如果是普通员工提交的，则审批人为部门经理，如果部门没有经理，则给超级管理员；如果是部门经理提交的，则审批人为超级管理员
		if(AdminUser.SUPER_ADMIN_ID.equals(recruit.getAuditUser())) {
			//如果是超级管理员
//			recruit.setAuditUser(AdminUser.SUPER_ADMIN_ID);
			Integer maxnum = recruitAuditMapper.getMaxRecruitNumByRecId(recruit.getId());
			maxnum= (maxnum==null?1:(maxnum+1));
			for (String audit : audits) {
				RecruitAudit ra = new RecruitAudit();
				ra.setAuditUser(audit);
				ra.setCreateTime(new Date());
				ra.setId(UUIDUtils.getUUID());
				ra.setRecruitId(recruit.getId());
				ra.setRecruitNum(maxnum);
				recruitAuditMapper.insert(ra);
			}
		}else {
			String managerId = adminUserMapper.getManagerIdByUserId(recruit.getCreateUser());
			if(StringUtils.isEmpty(managerId)||managerId.equals(recruit.getAuditUser())) {
				//如果没有部门经理或者本身就是部门经理
				RecruitAudit ra = new RecruitAudit();
				ra.setAuditUser(AdminUser.SUPER_ADMIN_ID);
				ra.setCreateTime(new Date());
				ra.setId(UUIDUtils.getUUID());
				ra.setRecruitId(recruit.getId());
				
				Integer maxnum = recruitAuditMapper.getMaxRecruitNumByRecId(recruit.getId());
				ra.setRecruitNum(maxnum==null?1:(maxnum+1));
				recruitAuditMapper.insert(ra);
//				recruit.setAuditUser(AdminUser.SUPER_ADMIN_ID);
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
//				recruit.setAuditUser(managerId);
			}
		}
	}
	
	
	public void insert(Recruit recruit) {
		recruit.setId(UUIDUtils.getUUID());
		recruit.setCreateTime(new Date());
		recruit.setStatus(CommonsConstant.AUDIT_STATUS_UNAUDIT);//默认未提交审核
		
		//添加审核记录
		//setAuditUser(recruit);
		
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
//		setAuditUser(recruit);
		//修改后将审核状态修改为未提交审核
		recruit.setStatus(CommonsConstant.AUDIT_STATUS_UNAUDIT);
		mapper.updateByPrimaryKeySelective(recruit);
	}
	
	
	public Recruit getByid(String id) {
		Recruit rec =  mapper.selectByPrimaryKey(id);
		rec.setDepId(departmentMapper.getDepIdByPostId(rec.getPostid()));
		rec.setCompetencys(competencyMapper.getByRecId(rec.getId()));
		rec.setPostName(positionMapper.selectByPrimaryKey(rec.getPostid()).getName());
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
	
	//提交审核
	public void  putAuditRecruit(Recruit recruit,String[]  auditIds) {
		setAuditUser(recruit,auditIds);
		recruit.setStatus(CommonsConstant.AUDIT_STATUS_AUDITING);
		mapper.updateByPrimaryKeySelective(recruit);
	}
	
//	public ResultJson auditRec(RecruitAudit audit) {
//		int num = auditMapper.selectUnauditByid(audit.getPositionAuditId());
//		if(num != 1) {
//			return new ResultJson(false,"该审批已完成，请勿重复审批");
//		}
//		else {
//			audit.setAuditTime(new Date());
//			auditMapper.updateByPrimaryKeySelective(audit);
//			//如果全部审批通过，则将该岗位状态修改为通过，如果有人不通过，则修改为不通过
//			if(audit.getResult() == CommonsConstant.AUDIT_UNPASS) {
//				//如果是不通过
//				auditMapper.setUnPassById(audit.getPositionAuditId());
//			}else {
//				//如果是通过
//				int unpassnum = auditMapper.getUnpassOrNullNum(audit.getPositionAuditId());
//				if(unpassnum == 0 ) {
//					//如果已经全部通过，则将该岗位修改为审批通过
//					auditMapper.passById(audit.getPositionAuditId());
//				}
//			}
//		}
//		return new ResultJson(true);
//	}
	
	public ResultJson auditRecruit(RecruitAudit audit,String[] auditIds) {
		int num = recruitAuditMapper.selectUnauditByid(audit.getId());
		if(num != 1) {
			return new ResultJson(false,"该审批已完成，请勿重复审批");
		}
		else {
			audit.setAuditTime(new Date());
			recruitAuditMapper.updateByPrimaryKeySelective(audit);
			//如果全部审批通过，则将该岗位状态修改为通过，如果有人不通过，则修改为不通过
			if(audit.getResult() == CommonsConstant.AUDIT_UNPASS) {
				//如果是不通过
				recruitAuditMapper.setUnPassById(audit.getId());
			}else {
				if(CommonsConstant.USER_TYPE_MANAGER.equals(audit.getAuditUserPosition())) {
					//如果审批人是部门经理，则提交超级管理员审批,审批状态依旧为审批中
					Recruit recruit = mapper.selectByPrimaryKey(audit.getRecruitId());
					recruit.setAuditUser(audit.getAuditUserId());//将提交审核的人设为AuditUser
					recruit.setStatus(CommonsConstant.AUDIT_STATUS_AUDITING);
					mapper.updateByPrimaryKeySelective(recruit);
					setAuditUser(recruit, null);
				}else if(AdminUser.SUPER_ADMIN_ID.equals(audit.getAuditUserId())) {
					//如果是超级管理员审批部门经理或者普通员工的请求
					Recruit recruit = mapper.selectByPrimaryKey(audit.getRecruitId());
					recruit.setAuditUser(AdminUser.SUPER_ADMIN_ID);//将超级管理员设为AuditUser
					recruit.setStatus(CommonsConstant.AUDIT_STATUS_AUDITING);
					mapper.updateByPrimaryKeySelective(recruit);
					setAuditUser(recruit, auditIds);
				}else if(CommonsConstant.USER_TYPE_ADMIN.equals(audit.getAuditUserPosition())){
					//如果是admin审批超级管理员的请求则表示最终通过
					int unpassnum = recruitAuditMapper.getUnpassOrNullNum(audit.getId());
					if(unpassnum == 0 ) {
						//如果已经全部通过，则将该岗位修改为审批通过
						recruitAuditMapper.passById(audit.getId());
					}
				}
			}
		}
		return new ResultJson(true);
	}
}
