/**
 * 
 */
package com.codyy.oc.admin.vo;

import java.sql.Timestamp;

import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.entity.TravelDetail;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:TravelVO.java, v 0.1	2018年4月18日	下午9:17:13	Jason(pjx48476) $
 * @Description: TODO  
 */

public class TravelDetailVO extends TravelDetail {
	private String travelId;
	
	private String typeName;
	
	private String startTimeStr;
	
	private Timestamp endTime;
	
	private String name;
	
	private int start;
	
	private int end = 10;
	
	private String depName;
	
	private String travelDetailSubName;
	
	private String travelDetailTypeName;
	
	private String travelDetailDate = "";
	
	private String createDate = "";
	
	private String startDate;
    
    private String endDate;
    
    private String UserId;
    
    private String editMode;
    
    private String contractNo;
    
	private String status;
	
	private String statusName;
	
	private String UserPosition;//用户类型
	
	private String UserDepId;//用户部门ID
	
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTravelId() {
		return travelId;
	}

	public void setTravelId(String travelId) {
		this.travelId = travelId;
	}

	/**
	 * @return the startTimeStr
	 */
	public String getStartTimeStr() {
		if(this.getStartTime() != null){
			startTimeStr = DateUtils.format(this.getStartTime(),DateUtils.PATTERN_DATE);
		}
		return startTimeStr;
	}

	/**
	 * @param startTimeStr the startTimeStr to set
	 */
	public void setStartTimeStr(String startTimeStr) {
		this.startTimeStr = startTimeStr;
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

	public String getTravelDetailSubName() {
		return travelDetailSubName;
	}

	public void setTravelDetailSubName(String travelDetailSubName) {
		this.travelDetailSubName = travelDetailSubName;
	}

	public String getTravelDetailTypeName() {
		return travelDetailTypeName;
	}

	public void setTravelDetailTypeName(String travelDetailTypeName) {
		this.travelDetailTypeName = travelDetailTypeName;
	}

	public String getTravelDetailDate() {
		return travelDetailDate;
	}

	public void setTravelDetailDate(String travelDetailDate) {
		this.travelDetailDate = travelDetailDate;
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
	 * @return the contractNo
	 */
	public String getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
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
