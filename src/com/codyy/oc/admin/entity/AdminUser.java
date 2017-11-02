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
	
	public static final String SUPER_ADMIN_ID = "admin";

	private static final long serialVersionUID = 1L;
	
	//后台session中AdminUser对应的key
	public static final String ADMIN_SESSION_USER = "adminUser";
	
	private String userId ;											// === 用户id
	private String userName ;												// === 用户名
	private String password ;												// === 密码
	private String realName ;												// === 真实姓名
	private String deleteFlag = CommonsConstant.FLAG_NO ;			// === 删除状态
	private Date createTime ;												// === 创建时间
	private String position;                                               //角色
	private String depId; //部门id
	private String postId;//岗位ID
	private String workStatus;//状态：试用等
	private String salaryScale;//薪级
	private Date entryDate;//入职日期
	private String workingYears;//工龄
	private Date salaryBeginDate;//起薪日
	private Date probationPeriod;//试用期限
	private Date expectedDate;//预计转正日
	private String fwqAgreement;//服务期协议
	private String fwqNum;//服务期金额
	private Date labourBeginTime;//合同开始时间
	private Date labourEndTime;//合同结束时间
	private String signTime;//签订次数
	private String insuranceBase;//缴费基数
	private Date filingDate;//备案日期
	private Date leaveDate;//离职日期
	private Date retiredDate;//退工日期

	private  List<AdminUserPermission> adminUserPer= new ArrayList<AdminUserPermission>();
	
	private AdminUserDetail adminUserDetail;
	
	private String postName;//岗位name
	
	private String depName;//部门name
	
	private String positionStr;//角色中文显示  
	
	private String postPc;//岗位默认pc等级
	
	public String getPostPc() {
		return postPc;
	}

	public void setPostPc(String postPc) {
		this.postPc = postPc;
	}

	public String getPositionStr() {
		if(position == null) {
			return null;
		}else if(CommonsConstant.USER_TYPE_ADMIN.equals(position)){
			return "管理员";
		}else if(CommonsConstant.USER_TYPE_MANAGER.equals(position)){
			return "部门经理";
		}else if(CommonsConstant.USER_TYPE_STAFF.equals(position)){
			return "普通员工";
		}else {
			return positionStr;
		}
	}

	public void setPositionStr(String positionStr) {
		this.positionStr = positionStr;
	}

	public List<AdminUserPermission> getAdminUserPer() {
		return adminUserPer;
	}

	public void setAdminUserPer(List<AdminUserPermission> adminUserPer) {
		this.adminUserPer = adminUserPer;
	}

	
	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
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

	public Date getEntryDate() {
		return entryDate;
	}

	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}

	public String getWorkingYears() {
		return workingYears;
	}

	public void setWorkingYears(String workingYears) {
		this.workingYears = workingYears;
	}

	public Date getSalaryBeginDate() {
		return salaryBeginDate;
	}

	public void setSalaryBeginDate(Date salaryBeginDate) {
		this.salaryBeginDate = salaryBeginDate;
	}

	public Date getProbationPeriod() {
		return probationPeriod;
	}

	public void setProbationPeriod(Date probationPeriod) {
		this.probationPeriod = probationPeriod;
	}

	public Date getExpectedDate() {
		return expectedDate;
	}

	public void setExpectedDate(Date expectedDate) {
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

	public Date getLabourBeginTime() {
		return labourBeginTime;
	}

	public void setLabourBeginTime(Date labourBeginTime) {
		this.labourBeginTime = labourBeginTime;
	}

	public Date getLabourEndTime() {
		return labourEndTime;
	}

	public void setLabourEndTime(Date labourEndTime) {
		this.labourEndTime = labourEndTime;
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

	public Date getFilingDate() {
		return filingDate;
	}

	public void setFilingDate(Date filingDate) {
		this.filingDate = filingDate;
	}

	public Date getLeaveDate() {
		return leaveDate;
	}

	public void setLeaveDate(Date leaveDate) {
		this.leaveDate = leaveDate;
	}

	public Date getRetiredDate() {
		return retiredDate;
	}

	public void setRetiredDate(Date retiredDate) {
		this.retiredDate = retiredDate;
	}

	public AdminUserDetail getAdminUserDetail() {
		return adminUserDetail;
	}

	public void setAdminUserDetail(AdminUserDetail adminUserDetail) {
		this.adminUserDetail = adminUserDetail;
	}


	
	
}