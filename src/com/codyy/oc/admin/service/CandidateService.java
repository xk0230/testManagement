package com.codyy.oc.admin.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminUserMapper;
import com.codyy.oc.admin.dao.CandidateMapper;
import com.codyy.oc.admin.dao.CandidateRInterviewerMapper;
import com.codyy.oc.admin.dao.CandidateRRecrcomMapper;
import com.codyy.oc.admin.dao.CompetencyMapper;
import com.codyy.oc.admin.dao.PositionMapper;
import com.codyy.oc.admin.dao.RecruitMapper;
import com.codyy.oc.admin.dao.RecruitRCompetencyMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Candidate;
import com.codyy.oc.admin.entity.CandidateRInterviewer;
import com.codyy.oc.admin.entity.CandidateRRecrcom;
import com.codyy.oc.admin.entity.Competency;
import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.Recruit;
import com.codyy.oc.admin.entity.RecruitRCompetency;

/**
 * 候选人server
 * @author Administrator
 *
 */
@Service("candidateService")
public class CandidateService {
	@Autowired
	private  RecruitMapper recruitMapper;
	@Autowired
	private AdminUserMapper adminUserMapper;
	@Autowired
	private CandidateRInterviewerMapper candidateRInterviewerMapper;
	@Autowired
	private CandidateMapper mapper;
	@Autowired
	private PositionMapper positionMapper;
	@Autowired
	private CandidateRRecrcomMapper candidateRRecrcomMapper;
	@Autowired
	private CompetencyMapper competencyMapper;
	@Autowired
	private RecruitRCompetencyMapper recruitRCompetencyMapper;
	
	
	public String insert(Candidate candidate) {
		String uuid = UUIDUtils.getUUID();
		candidate.setId(uuid);
		candidate.setCreateTime(new Date());
		mapper.insert(candidate);
		return uuid;
	};
	
	public void insertRInterviewer(CandidateRInterviewer candidateRInterviewer) {
		candidateRInterviewer.setId(UUIDUtils.getUUID());
		candidateRInterviewerMapper.insert(candidateRInterviewer);
	};
	
	public void updateById(Candidate candidate,List<CandidateRRecrcom> crs) {
		mapper.updateByPrimaryKeySelective(candidate);
		//添加胜任特征总评
		if(crs != null) {
			candidateRRecrcomMapper.deleteByCandidate(candidate.getId());
			for (CandidateRRecrcom candidateRRecrcom : crs) {
				candidateRRecrcomMapper.insert(candidateRRecrcom);
			}
		}
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
//	    Recruit rec =  recruitMapper.selectByPrimaryKey(search.getRecruitId());
	    List<CandidateRRecrcom> crrsModel = new ArrayList<CandidateRRecrcom>();
	    for (Competency c : competencyMapper.getByRecId(search.getRecruitId())) {
	    	CandidateRRecrcom cr = new CandidateRRecrcom();
	    	cr.setCompetencyId(c.getId());
	    	cr.setCompetencyName(c.getName());
	    	RecruitRCompetency rrr = new RecruitRCompetency();
	    	rrr.setRecruitId(search.getRecruitId());
	    	rrr.setCompetencyId(c.getId());
	    	cr.setRecRComId(recruitRCompetencyMapper.selectByRecCom(rrr));
	    	crrsModel.add(cr);
		}
		List<Candidate> data = mapper.getCandidatePageList(page);
		for (Candidate c : data) {
			List<CandidateRRecrcom> res = new ArrayList<CandidateRRecrcom>();
			res.addAll(crrsModel);
			List<CandidateRRecrcom> crrs = candidateRRecrcomMapper.getAllByCandidateId(c.getId());
			for (CandidateRRecrcom cr : crrs) {
				for (CandidateRRecrcom cm : res) {
					if(cm.getCompetencyId().equals(cr.getCompetencyId())){
						//如果是对应上的则赋值
						cm.setCandidateId(cr.getCandidateId());
						cm.setId(cr.getId());
						cm.setRecRComId(cr.getRecRComId());
						cm.setValue(cr.getValue());
					}
				}
			}
			c.setCrrs(res);
		}
		page.setData(data);
		return page;
	}
	
	public Page getCandidateRInterviewerPageList(Page page,CandidateRInterviewer search){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("candidateId",search.getCandidateId());//候选人ID
		map.put("interviewerId",search.getInterviewerId());//面试官ID
	    page.setMap(map);
		List<CandidateRInterviewer> data = candidateRInterviewerMapper.getCandidateRInterviewerPageList(page);
		for (CandidateRInterviewer c : data) {
			AdminUser in = adminUserMapper.getselcAdminUserById(c.getInterviewerId());
			c.setInterviewerName(in.getRealName());
			c.setInterviewerPostId(in.getPostId());
			c.setInterviewerDepId(in.getDepId());
			
			Candidate ca =  mapper.selectByPrimaryKey(c.getCandidateId());
			c.setCandidateName(ca.getName());
			Recruit r = recruitMapper.selectByPrimaryKey(ca.getRecruitId());
			Position p =  positionMapper.selectByPrimaryKey(r.getPostid());
			c.setPositionName(p.getName());
		}
		page.setData(data);
		return page;
	}
}
