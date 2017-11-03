package com.codyy.oc.admin.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Attachment {

	private String attachmentId;
	private String name;
	private String relationShipId;
	private String remark;
	private String type;
	private Date create_time;
	private List<Attachment> quaList = new ArrayList<Attachment>();//来封装填充好值的资质对象
	 
	private String attachment_Url;
	
	private Date createTime;

	
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getAttachment_Url() {
		return attachment_Url;
	}
	public void setAttachment_Url(String attachment_Url) {
		this.attachment_Url = attachment_Url;
	}
	public List<Attachment> getQuaList() {
		return quaList;
	}
	public void setQuaList(List<Attachment> quaList) {
		this.quaList = quaList;
	}
	public String getAttachmentId() {
		return attachmentId;
	}
	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getRelationShipId() {
		return relationShipId;
	}
	public void setRelationShipId(String relationShipId) {
		this.relationShipId = relationShipId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	public Attachment(){}//反射调用
	public Attachment(String attachmentId, String name, String relationShipId,
			String remark, String type, List<Attachment> quaList,
			String attachment_Url) {
		super();
		this.attachmentId = attachmentId;
		this.name = name;
		this.relationShipId = relationShipId;
		this.remark = remark;
		this.type = type;
		this.quaList = quaList;
		this.attachment_Url = attachment_Url;
	}
	@Override
	public String toString() {
		return "Attachment [attachmentId=" + attachmentId + ", name=" + name
				+ ", relationShipId=" + relationShipId + ", remark=" + remark
				+ ", type=" + type + ", quaList=" + quaList
				+ ", attachment_Url=" + attachment_Url + ", toString()="
				+ super.toString() + "]";
	}
	
	
	
	
}
