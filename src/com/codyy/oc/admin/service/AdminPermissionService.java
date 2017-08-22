package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.AdminPermissionMapper;
import com.codyy.oc.admin.entity.AdminPermission;

@Service
public class AdminPermissionService {

	@Autowired
	private AdminPermissionMapper adminPermissionMapper;
	
	public List<AdminPermission> adminPermissionList(){
		
		return adminPermissionMapper.adminPermissionList();
	}
}
