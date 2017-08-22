package com.codyy.oc.admin.entity;

import java.util.ArrayList;
import java.util.List;

public class AdminUserPermission {

	private String adminPersId;
	private String adminUserId;//UUID生成的
	private List<String> functionList = new ArrayList<String>();
	
	public String getAdminPersId() {
		return adminPersId;
	}
	public void setAdminPersId(String adminPersId) {
		this.adminPersId = adminPersId;
	}
	public String getAdminUserId() {
		return adminUserId;
	}
	public void setAdminUserId(String adminUserId) {
		this.adminUserId = adminUserId;
	}
	
	public List<String> getFunctionList() {
		return functionList;
	}
	public void setFunctionList(List<String> functionList) {
		this.functionList = functionList;
	}
	public AdminUserPermission(){}//反射调用
	public AdminUserPermission(String adminPersId, String adminUserId,
			List<String> functionList) {
		super();
		this.adminPersId = adminPersId;
		this.adminUserId = adminUserId;
		this.functionList = functionList;
	}
	@Override
	public String toString() {
		return "AdminUserPermission [adminPersId=" + adminPersId
				+ ", adminUserId=" + adminUserId + ", functionList="
				+ functionList + ", toString()=" + super.toString() + "]";
	}

	
	
}
