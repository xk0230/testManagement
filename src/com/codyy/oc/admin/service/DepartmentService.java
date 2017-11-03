package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.DepartmentMapper;
import com.codyy.oc.admin.entity.Department;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper mapper;
	
	public List<Department> getAllDepartment(){
		return mapper.getAllDep();
	}
	
	public int hasManager(String depId) {
		return mapper.hasManager(depId);
	}
	
	public String getDepManagerId(String depId) {
		
		return mapper.getDepManagerId(depId);
	}
}
