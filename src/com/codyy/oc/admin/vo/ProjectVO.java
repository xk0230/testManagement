/**
 * 
 */
package com.codyy.oc.admin.vo;

import java.sql.Timestamp;

import com.codyy.oc.admin.entity.Project;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ProjectVO.java, v 0.1	2018年3月29日	下午8:22:10	Jason(pjx48476) $
 * @Description: TODO  
 */

public class ProjectVO extends Project {


	private Timestamp startTime;
	
	private Timestamp endTime;
	
	private String name;
	
	private int start;
	
	private int end = 10;
	
	private String paymentDate = "";
	
	private String createDate = "";
	
	private String startDate;
	
	private String endDate;
	
	private String UserId;
	
	private String editMode;
	
	private String paymentNo;

	private String UserPosition;//用户类型
	
	private String UserDepId;//用户部门ID

	/**
	 * @return the startTime
	 */
	public Timestamp getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	/**
	 * @return the endTime
	 */
	public Timestamp getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the start
	 */
	public int getStart() {
		return start;
	}

	/**
	 * @param start the start to set
	 */
	public void setStart(int start) {
		this.start = start;
	}

	/**
	 * @return the end
	 */
	public int getEnd() {
		return end;
	}

	/**
	 * @param end the end to set
	 */
	public void setEnd(int end) {
		this.end = end;
	}

	/**
	 * @return the paymentDate
	 */
	public String getPaymentDate() {
		return paymentDate;
	}

	/**
	 * @param paymentDate the paymentDate to set
	 */
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}

	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the userId
	 */
	public String getUserId() {
		return UserId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		UserId = userId;
	}

	/**
	 * @return the editMode
	 */
	public String getEditMode() {
		return editMode;
	}

	/**
	 * @param editMode the editMode to set
	 */
	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}

	/**
	 * @return the paymentNo
	 */
	public String getPaymentNo() {
		return paymentNo;
	}

	/**
	 * @param paymentNo the paymentNo to set
	 */
	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
	}

	/**
	 * @return the userPosition
	 */
	public String getUserPosition() {
		return UserPosition;
	}

	/**
	 * @param userPosition the userPosition to set
	 */
	public void setUserPosition(String userPosition) {
		UserPosition = userPosition;
	}

	/**
	 * @return the userDepId
	 */
	public String getUserDepId() {
		return UserDepId;
	}

	/**
	 * @param userDepId the userDepId to set
	 */
	public void setUserDepId(String userDepId) {
		UserDepId = userDepId;
	}
}
