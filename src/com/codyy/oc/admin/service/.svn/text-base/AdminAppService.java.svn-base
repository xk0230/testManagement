package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AdminAppMapper;
import com.codyy.oc.admin.entity.AdminApp;
/**
 * 
 * ClassName: AdminAppService
 * Function: 移动端版本管理Service
 * Reason:  ADD REASON(可选)
 * date: 2015年4月1日 下午5:00:35
 * 
 * @author wangqiqi 
 * @version  
 * @since JDK 1.7
 */
@Service
public class AdminAppService {

	@Autowired
	private AdminAppMapper appMapper;
	
	
	public void addAppVersion(AdminApp appVersion){
		appVersion.setAdminAppId(UUIDUtils.getUUID());
		appVersion.setCreateTime(new Date());
		appMapper.insert(appVersion);
	}
	public AdminApp getById(String appId){
		return appMapper.selectByPrimaryKey(appId);
	}
	public void deleteVersionById(String appId){
		appMapper.deleteByPrimaryKey(appId);
	}
	
	public void updateCurrentVersion(String appId,String appType){
		AdminApp appVersion = new AdminApp();
		appVersion.setAppType(appType);
		appMapper.updateToHistoryByAppType(appVersion);
		appMapper.updateToCurrentVersionById(appId);
	}
	
	public List<AdminApp> listByType(String appType){
		return appMapper.listByType(appType);
	}
	
	public List<AdminApp> exits(AdminApp appVersion){
		return appMapper.exits(appVersion);
	}
}
