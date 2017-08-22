package com.codyy.oc.admin.view;

import java.util.Date;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;


/**
 * 
 * ClassName:AdminUserModal
 * Function: 批量导出Excel的临时用户对象
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月24日		下午2:23:10
 *
 */
@ExcelHeader(headerName = "管理员帐号信息列表")
public class AdminUserView {

	@ExcelColumn(columnName = "序号")
	private String id ;							// === 序号
	private String adminUserId ;				// === 用户ID
	@ExcelColumn(columnName = "账号名称")
	private String userName ;					// === 帐号名称
	@ExcelColumn(columnName = "角色")
	private String roleName ;					// === 角色
	@ExcelColumn(columnName = "创建人")
	private String createAdminUser ;		// === 创建人
	@ExcelColumn(columnName="创建时间")
	private Date createTime ;				// === 创建时间

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getCreateAdminUser() {
		return createAdminUser;
	}

	public void setCreateAdminUser(String createAdminUser) {
		this.createAdminUser = createAdminUser;
	}

	public String getAdminUserId() {
		return adminUserId;
	}

	public void setAdminUserId(String adminUserId) {
		this.adminUserId = adminUserId;
	}
}
