package com.codyy.oc.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.AdminUserTrainDaoMapper;

@Service("userTrainService")
public class AdminUserTrainService {
	
	@Autowired
	private AdminUserTrainDaoMapper userTrainDaoMapper; 
	
	

}
