package com.codyy.oc.admin.entity;

/**
 * 
 * @author lichen-----封装联系人的基本信息
 *
 */
public class ContactPerson {
 
	private String contactPersonName;
	private String contactPersonJob;
	private String contactPersonPhone;
	private String concatPersonFlag;//联系人标识
	
	
	public String getConcatPersonFlag() {
		return concatPersonFlag;
	}
	public void setConcatPersonFlag(String concatPersonFlag) {
		this.concatPersonFlag = concatPersonFlag;
	}
	public String getContactPersonName() {
		return contactPersonName;
	}
	public void setContactPersonName(String contactPersonName) {
		this.contactPersonName = contactPersonName;
	}
	public String getContactPersonJob() {
		return contactPersonJob;
	}
	public void setContactPersonJob(String contactPersonJob) {
		this.contactPersonJob = contactPersonJob;
	}
	public String getContactPersonPhone() {
		return contactPersonPhone;
	}
	public void setContactPersonPhone(String contactPersonPhone) {
		this.contactPersonPhone = contactPersonPhone;
	}
	@Override
	public String toString() {
		return "ContactPerson [contactPersonName=" + contactPersonName
				+ ", contactPersonJob=" + contactPersonJob
				+ ", contactPersonPhone=" + contactPersonPhone
				+ ", toString()=" + super.toString() + "]";
	}
	
	public ContactPerson(){}//反射调用
	public ContactPerson(String contactPersonName, String contactPersonJob,
			String contactPersonPhone, String concatPersonFlag) {
		super();
		this.contactPersonName = contactPersonName;
		this.contactPersonJob = contactPersonJob;
		this.contactPersonPhone = contactPersonPhone;
		this.concatPersonFlag = concatPersonFlag;
	}
	
	
	
	
	
	

	
	
	
	
}
