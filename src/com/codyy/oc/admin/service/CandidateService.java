package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.CandidateMapper;
import com.codyy.oc.admin.dao.CandidateRInterviewerMapper;
import com.codyy.oc.admin.entity.Candidate;
import com.codyy.oc.admin.entity.CandidateRInterviewer;

/**
 * 候选人server
 * @author Administrator
 *
 */
@Service("candidateService")
public class CandidateService {
//	@Autowired
//	private  RecruitMapper recruitMapper;
//	@Autowired
//	private AdminUserMapper adminUserMapper;
//	@Autowired
//	private RecruitRCompetencyMapper recruitRCompetencyMapper;
	@Autowired
	private CandidateRInterviewerMapper candidateRInterviewerMapper;
//	@Autowired
//	private RecruitAuditMapper recruitAuditMapper;
//	@Autowired
//	private CompetencyMapper competencyMapper;
//	@Autowired
//	private DepartmentMapper departmentMapper;
	@Autowired
	private CandidateMapper mapper;
	
	
	public void insert(Candidate candidate) {
		candidate.setId(UUIDUtils.getUUID());
		candidate.setCreateTime(new Date());
		mapper.insert(candidate);
	};
	
	public void insertRInterviewer(CandidateRInterviewer candidateRInterviewer) {
		candidateRInterviewer.setId(UUIDUtils.getUUID());
		candidateRInterviewerMapper.insert(candidateRInterviewer);
	};
	
	
//	private void addCompetencys(Recruit recruit) {
//		String[] competencys = recruit.getCompetencysStr().split("@");
//		for (String c : competencys) {
//			if(c != null && StringUtils.isNotBlank(c)) {
//				RecruitRCompetency rc = new RecruitRCompetency();
//				rc.setId(UUIDUtils.getUUID());
//				rc.setCompetencyId(c);
//				rc.setRecruitId(recruit.getId());
//				recruitRCompetencyMapper.insert(rc);
//			}
//		}
//	}
	
	
	public void updateById(Candidate candidate) {
		mapper.updateByPrimaryKeySelective(candidate);
	}
	
	public void updateRInterviewerById(CandidateRInterviewer candidateRInterviewer) {
		candidateRInterviewerMapper.updateByPrimaryKeySelective(candidateRInterviewer);
	}
	
	
	public Candidate getByid(String id) {
		Candidate candidate =  mapper.selectByPrimaryKey(id);
		return candidate;
	}
	
	public CandidateRInterviewer getRInterviewerByid(String id) {
		CandidateRInterviewer candidateRInterviewer =  candidateRInterviewerMapper.selectByPrimaryKey(id);
		return candidateRInterviewer;
	}
	
	public Page getCandidatePageList(Page page,Candidate search){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("recruitId",search.getRecruitId());//招聘需求ID
	    page.setMap(map);
		List<Candidate> data = mapper.getCandidatePageList(page);
		page.setData(data);
		return page;
	}
	
	public Page getCandidateRInterviewerPageList(Page page,CandidateRInterviewer search){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("candidateId",search.getCandidateId());//候选人ID
	    page.setMap(map);
		List<CandidateRInterviewer> data = candidateRInterviewerMapper.getCandidateRInterviewerPageList(page);
		page.setData(data);
		return page;
	}
}
