package com.codyy.oc.admin.view;

/***
 * 
 * @author zhangshuangquan
 * 查询模板
 */
/**
 * @author ghost
 *
 */
public class UserSearchModel {

	private String userName;
	private String realName;
	private String position;
	private String state;
	private String userId;
	private String depId;
	private String postId;
	private String isIpe;//是否为IPE查询
	private String uid;
	private String did;
	private String userposition;
	
	/**
	 * @return the uid
	 */
	public String getUid() {
		return uid;
	}
	/**
	 * @param uid the uid to set
	 */
	public void setUid(String uid) {
		this.uid = uid;
	}
	/**
	 * @return the did
	 */
	public String getDid() {
		return did;
	}
	/**
	 * @param did the did to set
	 */
	public void setDid(String did) {
		this.did = did;
	}
	/**
	 * @return the userposition
	 */
	public String getUserposition() {
		return userposition;
	}
	/**
	 * @param userposition the userposition to set
	 */
	public void setUserposition(String userposition) {
		this.userposition = userposition;
	}
	/**
	 * @return the isIpe
	 */
	public String getIsIpe() {
		return isIpe;
	}
	/**
	 * @param isIpe the isIpe to set
	 */
	public void setIsIpe(String isIpe) {
		this.isIpe = isIpe;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	
}
