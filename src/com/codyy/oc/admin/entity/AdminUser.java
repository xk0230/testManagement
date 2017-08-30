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
 *
 */
public class AdminUser implements Serializable {

	private static final long serialVersionUID = 1L;
	
	//后台session中AdminUser对应的key
	public static final String ADMIN_SESSION_USER = "adminUser";
	
	private String userId ;											// === 用户id
	private String userName ;												// === 用户名
	private String password ;												// === 密码
	private String realName ;												// === 真实姓名
	private String locked = CommonsConstant.FLAG_NO ;				// === 帐号锁定状态
	private String deleteFlag = CommonsConstant.FLAG_NO ;			// === 删除状态
	private Date createTime ;												// === 创建时间
	private String position;                                               //角色
	private String depId; //部门id
	private String isDepManager; //0:普通员工，1:部门经理
	private String postId;//岗位ID
	private String workStatus;//状态：试用等
	private String salaryScale;//薪级
	private String entryDate;//入职日期
	private String workingYears;//工龄
	private String salaryBeginDate;//起薪日
	private String probationPeriod;//试用期限
	private String expectedDate;//预计转正日
	private String fwqAgreement;//服务期协议
	private String fwqNum;//服务期金额
	private String labourBeginTime;//合同开始时间
	private String labourBeginEnd;//合同结束时间
	private String signTime;//签订次数
	private String insuranceBase;//缴费基数
	private String filingDate;//备案日期
	private String leaveDate;//离职日期
	private String retiredDate;//退工日期


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


	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public String getIsDepManager() {
		return isDepManager;
	}

	public void setIsDepManager(String isDepManager) {
		this.isDepManager = isDepManager;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getWorkStatus() {
		return workStatus;
	}

	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}

	public String getSalaryScale() {
		return salaryScale;
	}

	public void setSalaryScale(String salaryScale) {
		this.salaryScale = salaryScale;
	}

	public String getEntryDate() {
		return entryDate;
	}

	public void setEntryDate(String entryDate) {
		this.entryDate = entryDate;
	}

	public String getWorkingYears() {
		return workingYears;
	}

	public void setWorkingYears(String workingYears) {
		this.workingYears = workingYears;
	}

	public String getSalaryBeginDate() {
		return salaryBeginDate;
	}

	public void setSalaryBeginDate(String salaryBeginDate) {
		this.salaryBeginDate = salaryBeginDate;
	}

	public String getProbationPeriod() {
		return probationPeriod;
	}

	public void setProbationPeriod(String probationPeriod) {
		this.probationPeriod = probationPeriod;
	}

	public String getExpectedDate() {
		return expectedDate;
	}

	public void setExpectedDate(String expectedDate) {
		this.expectedDate = expectedDate;
	}

	public String getFwqAgreement() {
		return fwqAgreement;
	}

	public void setFwqAgreement(String fwqAgreement) {
		this.fwqAgreement = fwqAgreement;
	}

	public String getFwqNum() {
		return fwqNum;
	}

	public void setFwqNum(String fwqNum) {
		this.fwqNum = fwqNum;
	}

	public String getLabourBeginTime() {
		return labourBeginTime;
	}

	public void setLabourBeginTime(String labourBeginTime) {
		this.labourBeginTime = labourBeginTime;
	}

	public String getLabourBeginEnd() {
		return labourBeginEnd;
	}

	public void setLabourBeginEnd(String labourBeginEnd) {
		this.labourBeginEnd = labourBeginEnd;
	}

	public String getSignTime() {
		return signTime;
	}

	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}

	public String getInsuranceBase() {
		return insuranceBase;
	}

	public void setInsuranceBase(String insuranceBase) {
		this.insuranceBase = insuranceBase;
	}

	public String getFilingDate() {
		return filingDate;
	}

	public void setFilingDate(String filingDate) {
		this.filingDate = filingDate;
	}

	public String getLeaveDate() {
		return leaveDate;
	}

	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}

	public String getRetiredDate() {
		return retiredDate;
	}

	public void setRetiredDate(String retiredDate) {
		this.retiredDate = retiredDate;
	}

	
}