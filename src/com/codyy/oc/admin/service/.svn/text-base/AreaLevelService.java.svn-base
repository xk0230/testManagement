package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.BaseConfigAreaLevelMapper;
import com.codyy.oc.admin.entity.BaseConfigAreaLevel;

@Service
public class AreaLevelService {
	
	@Autowired
	private BaseConfigAreaLevelMapper areaLevelMapper;
	
	public BaseConfigAreaLevel getById(String id){
		return areaLevelMapper.selectByPrimaryKey(id);
	}
	
	public List<BaseConfigAreaLevel> getAll(){
		return areaLevelMapper.selectAll();
	}
	
	public BaseConfigAreaLevel getByAreaLevel(BaseConfigAreaLevel areaLevel){
		return areaLevelMapper.selectByAreaLevel(areaLevel);
	}
	
	public void addAreaLevel(BaseConfigAreaLevel areaLevel){
		areaLevel.setBaseConfigAreaLevelId(UUIDUtils.getUUID());
		areaLevelMapper.insert(areaLevel);
	}
	
	public void editAreaLevel(BaseConfigAreaLevel areaLevel){
		areaLevelMapper.updateByPrimaryKey(areaLevel);
	}
	
	public void deleteAreaLevel(String id){
		areaLevelMapper.deleteByPrimaryKey(id);
	}

}
