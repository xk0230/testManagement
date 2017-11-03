package com.codyy.oc.commons.sso;

import java.util.List;

public class SessionUser {
	
	private String userId;
	private String username;
	private String userType;			//AREA_USR,SCHOOL_USR,TEACHER
	private String schoolId;
	private String areaId;
	private Boolean hasSubArea;			//用户是否有下级管理，只对AREA_USR类型有效
	private Boolean admin;				//是否是学校管理员或机构管理员，对AREA_USR,SCHOOL_USR有效
	private Boolean locked;
	private Boolean editSchedule;		//是否可以编辑课表
	private List<String> permGrant;		//用户功能授权
	private Boolean createEva;			//是否有创建评课的权限，只对TEACHER有效
	private Boolean createSchool;		//是否有学校管理的权限，只对AREA_USR类型有效
	
	
	private String realname;
	private String headPic;
	private String position;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getHeadPic() {
		return headPic;
	}
	public void setHeadPic(String headPic) {
		this.headPic = headPic;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	public Boolean getHasSubArea() {
		return hasSubArea;
	}
	public void setHasSubArea(Boolean hasSubArea) {
		this.hasSubArea = hasSubArea;
	}
	public Boolean getAdmin() {
		return admin;
	}
	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}
	public List<String> getPermGrant() {
		return permGrant;
	}
	public void setPermGrant(List<String> permGrant) {
		this.permGrant = permGrant;
	}
	public Boolean getLocked() {
		return locked;
	}
	public void setLocked(Boolean locked) {
		this.locked = locked;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Boolean getCreateEva() {
		return createEva;
	}
	public void setCreateEva(Boolean createEva) {
		this.createEva = createEva;
	}
	public Boolean getEditSchedule() {
		return editSchedule;
	}
	public void setEditSchedule(Boolean editSchedule) {
		this.editSchedule = editSchedule;
	}
	public Boolean getCreateSchool() {
		return createSchool;
	}
	public void setCreateSchool(Boolean createSchool) {
		this.createSchool = createSchool;
	}
	

}
