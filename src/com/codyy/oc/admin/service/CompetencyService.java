package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.CompetencyMapper;
import com.codyy.oc.admin.dao.RecruitRCompetencyMapper;
import com.codyy.oc.admin.entity.Competency;
import com.codyy.oc.admin.entity.RecruitRCompetency;

/**
 * 胜任特征server
 * @author Administrator
 *
 */
@Service("competencyService")
public class CompetencyService {
	@Autowired
	private  CompetencyMapper mapper;
	
	@Autowired
	private  RecruitRCompetencyMapper recruitRCompetencyMapper;
	
	public List<Competency> getAll(){
		return mapper.getAll(); 
	}
	
	public void  insertRecruitRCompetency(RecruitRCompetency record) {
		recruitRCompetencyMapper.insert(record);
	}
}
