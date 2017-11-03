package com.codyy.oc.admin.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.codyy.commons.CommonsConstant;
/**
 * 
 * ClassName:AdminUser
 * Function: 用户基本信息实体
 *
 * @author   zhangtian
 * @Date	 2015	2015年3月23日		上午9:48:25
 *
 */
public class AdminUser implements Serializable {

	private static final long serialVersionUID = 1L;
	
	//后台session中AdminUser对应的key
	public static final String ADMIN_SESSION_USER = "adminUser";
	
	private String adminUserId ;											// === 用户id
	private String userName ;												// === 用户名
	private String password ;												// === 密码
	private String realName ;												// === 真实姓名
	private String contact ;												// === 联系方式
	private String locked = CommonsConstant.FLAG_NO ;				// === 帐号锁定状态
	private String remark ;												// === 备注
	private String createUserId ;										// === 创建者
	private String deleteFlag = CommonsConstant.FLAG_NO ;			// === 删除状态
	private Date createTime ;												// === 创建时间
	private String weixin_num;                                              //微信号
	private String position;                                               //角色
	
	private  List<AdminUserPermission> adminUserPer= new ArrayList<AdminUserPermission>();
	
	
	public List<AdminUserPermission> getAdminUserPer() {
		return adminUserPer;
	}

	public void setAdminUserPer(List<AdminUserPermission> adminUserPer) {
		this.adminUserPer = adminUserPer;
	}

	private List<AdminUserRole> adminUserRoles ;

	private List<String> functionList = new ArrayList<String>();//选择的功能
	
	public List<String> getFunctionList() {
		return functionList;
	}

	public void setFunctionList(List<String> functionList) {
		this.functionList = functionList;
	}
	
	public String getAdminUserId() {
		return adminUserId;
	}

	public void setAdminUserId(String adminUserId) {
		this.adminUserId = adminUserId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getLocked() {
		return locked;
	}

	public void setLocked(String locked) {
		this.locked = locked;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public List<AdminUserRole> getAdminUserRoles() {
		return adminUserRoles;
	}

	public void setAdminUserRoles(List<AdminUserRole> adminUserRoles) {
		this.adminUserRoles = adminUserRoles;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getWeixin_num() {
		return weixin_num;
	}

	public void setWeixin_num(String weixin_num) {
		this.weixin_num = weixin_num;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	@Override
	public String toString() {
		return "AdminUser [adminUserId=" + adminUserId + ", userName="
				+ userName + ", password=" + password + ", realName="
				+ realName + ", contact=" + contact + ", locked=" + locked
				+ ", remark=" + remark + ", createUserId=" + createUserId
				+ ", deleteFlag=" + deleteFlag + ", createTime=" + createTime
				+ ", weixin_num=" + weixin_num + ", position=" + position
				+ ", adminUserPer=" + adminUserPer + ", adminUserRoles="
				+ adminUserRoles + ", functionList=" + functionList
				+ ", toString()=" + super.toString() + "]";
	}

	

	

	
	
	
}