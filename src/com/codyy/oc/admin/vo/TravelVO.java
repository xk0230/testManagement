/**
 * 
 */
package com.codyy.oc.admin.vo;

import java.sql.Timestamp;
import java.util.List;

import com.codyy.oc.admin.entity.Travel;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:TravelVO.java, v 0.1	2018年4月18日	下午9:17:13	Jason(pjx48476) $
 * @Description: TODO  
 */

public class TravelVO extends Travel {
	private Timestamp startTime;
	
	private Timestamp endTime;
	
	private String name;
	
	private int start;
	
	private int end = 10;
	
	private String depName;
	
	private String travelSubName;
	
	private String travelTypeName;
	
	private String travelDate = "";
	
	private String createDate = "";
	
	private String startDate;
    
    private String endDate;
    
    private String UserId;
    
    private String editMode;
    
	private String status;
	
	private String statusName;
	
	private String UserPosition;//用户类型
	
	private String UserDepId;//用户部门ID

	private String createUserName;
	
	private List<TravelDetailVO> travelDetailVOList;
	

	public List<TravelDetailVO> getTravelDetailVOList() {
		return travelDetailVOList;
	}

	public void setTravelDetailVOList(List<TravelDetailVO> travelDetailVOList) {
		this.travelDetailVOList = travelDetailVOList;
	}

	public String getCreateUserName() {
		return createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

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
	 * @return the depName
	 */
	public String getDepName() {
		return depName;
	}

	/**
	 * @param depName the depName to set
	 */
	public void setDepName(String depName) {
		this.depName = depName;
	}

	/**
	 * @return the travelSubName
	 */
	public String getTravelSubName() {
		return travelSubName;
	}

	/**
	 * @param travelSubName the travelSubName to set
	 */
	public void setTravelSubName(String travelSubName) {
		this.travelSubName = travelSubName;
	}

	/**
	 * @return the travelTypeName
	 */
	public String getTravelTypeName() {
		return travelTypeName;
	}

	/**
	 * @param travelTypeName the travelTypeName to set
	 */
	public void setTravelTypeName(String travelTypeName) {
		this.travelTypeName = travelTypeName;
	}

	/**
	 * @return the travelDate
	 */
	public String getTravelDate() {
		return travelDate;
	}

	/**
	 * @param travelDate the travelDate to set
	 */
	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the statusName
	 */
	public String getStatusName() {
		return statusName;
	}

	/**
	 * @param statusName the statusName to set
	 */
	public void setStatusName(String statusName) {
		this.statusName = statusName;
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
