package com.codyy.oc.admin.entity;

import java.util.Date;

public class TravelDetail {
    private String id;

    private String travelId;

    private String type;

    private String startPlace;

    private String endPlace;

    private Date startTime;

    private Double costNum;

    private String remark;

    private Date createTime;

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the travelId
	 */
	public String getTravelId() {
		return travelId;
	}

	/**
	 * @param travelId the travelId to set
	 */
	public void setTravelId(String travelId) {
		this.travelId = travelId;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the startPlace
	 */
	public String getStartPlace() {
		return startPlace;
	}

	/**
	 * @param startPlace the startPlace to set
	 */
	public void setStartPlace(String startPlace) {
		this.startPlace = startPlace;
	}

	/**
	 * @return the endPlace
	 */
	public String getEndPlace() {
		return endPlace;
	}

	/**
	 * @param endPlace the endPlace to set
	 */
	public void setEndPlace(String endPlace) {
		this.endPlace = endPlace;
	}

	/**
	 * @return the startTime
	 */
	public Date getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	/**
	 * @return the costNum
	 */
	public Double getCostNum() {
		return costNum;
	}

	/**
	 * @param costNum the costNum to set
	 */
	public void setCostNum(Double costNum) {
		this.costNum = costNum;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the createTime
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime the createTime to set
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
    
}