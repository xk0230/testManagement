package com.codyy.oc.admin.view;

/**
 * 
 * ClassName:AdminRoleView
 * Function: 角色列表
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月26日		下午2:56:46
 *
 */
public class AdminRoleView {

	private String id ;						// === 序号
	private String adminRoleId ;			// === 角色ID
	private String adminRoleName ;		// === 角色名称
	private String adminUserName ;		// === 账号名称
	private Integer adminUserNum ;		// === 账号数
	private String createTime ;			// === 创建时间

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAdminRoleName() {
		return adminRoleName;
	}

	public void setAdminRoleName(String adminRoleName) {
		this.adminRoleName = adminRoleName;
	}

	public String getAdminUserName() {
		return adminUserName;
	}

	public void setAdminUserName(String adminUserName) {
		this.adminUserName = adminUserName;
	}

	public Integer getAdminUserNum() {
		return adminUserNum;
	}

	public void setAdminUserNum(Integer adminUserNum) {
		this.adminUserNum = adminUserNum;
	}

	public String getAdminRoleId() {
		return adminRoleId;
	}

	public void setAdminRoleId(String adminRoleId) {
		this.adminRoleId = adminRoleId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
