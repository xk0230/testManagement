/**
 * 
 */
package com.codyy.oc.admin.vo;

import java.sql.Timestamp;

import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.entity.Contract;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:ContractVO.java, v 0.1	2018年3月9日	下午6:11:21	Jason(pjx48476) $
 * @Description: TODO  
 */

public class ContractVO extends Contract {

	private Timestamp startTime;
	
	private Timestamp endTime;
	
	private String name;
	
	private int start;
	
	private int end = 10;
	
	private String depName;
	
	private String contractSubName;
	
	private String contractTypeName;
	
	private String contractDate = "";
	
	private String createDate = "";
	
	private String startDate;
    
    private String endDate;
    
    private String UserId;
    
    private String editMode;
    
    private String contractNo;
    
	private String status;
	
	private String statusName;

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
	 * @return the contractSubName
	 */
	public String getContractSubName() {
		return contractSubName;
	}

	/**
	 * @param contractSubName the contractSubName to set
	 */
	public void setContractSubName(String contractSubName) {
		this.contractSubName = contractSubName;
	}

	/**
	 * @return the contractTypeName
	 */
	public String getContractTypeName() {
//		if(this.getContractType().equals("1")){
//			contractTypeName = "支出";
//		}else if(this.getContractType().equals("0")){
//			contractTypeName = "收入";
//		}else{
//			contractTypeName = "";
//		}
		return contractTypeName;
	}

	/**
	 * @param contractTypeName the contractTypeName to set
	 */
	public void setContractTypeName(String contractTypeName) {
		this.contractTypeName = contractTypeName;
	}

	/**
	 * @return the contractDate
	 */
	public String getContractDate() {
		if(this.getCostTime() != null){
			contractDate = DateUtils.format(this.getCostTime(),DateUtils.PATTERN_DATE);
		}
		return contractDate;
	}

	/**
	 * @param contractDate the contractDate to set
	 */
	public void setContractDate(String contractDate) {
		this.contractDate = contractDate;
	}

	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		if(this.getCreateTime() != null){
			createDate = DateUtils.format(this.getCreateTime());
		}
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
	
}
