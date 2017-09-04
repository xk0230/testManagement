package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.PositionMapper;
import com.codyy.oc.admin.entity.Position;

@Service
public class PositionService {
	@Autowired
	private PositionMapper mapper;
	
	public List<Position> getPositionByDepId(String depId){
		return mapper.selectByDepId(depId);
	}
	
}
