package com.codyy.oc.admin.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.ShortDateSerializer;

@ExcelHeader(headerName="工单列表")
public class WorkOrderView {
	
	private String maintenanceOrderId;

    private String clsSchoolId;
    
    private String projectPath;
    
    @ExcelColumn(columnName="单号")
    private String orderNum;

    @ExcelColumn(columnName="学校名称")
    private String schoolName;
    
    @ExcelColumn(columnName="学校区域")
    private String schoolPath;

    @ExcelColumn(columnName="联系人")
    private String contact;
    
    private String address;

    @ExcelColumn(columnName="联系电话")
    private String phone;
    
    @ExcelColumn(columnName="项目")
    private String projectName;

    @ExcelColumn(columnName="最新状态")
    private String maxDateStr;
    @ExcelColumn(columnName="工单提交人")
    private String submitRealName;

    @ExcelColumn(columnName="维修人员")
    private String repair;
    
    private String engineer;
    @ExcelColumn(columnName="设备寄送")
    private Integer equipNum;//设备的个数
    
    @ExcelColumn(columnName="备注")
    private String remark;

    @JsonSerialize(using=ShortDateSerializer.class)
    private Date maxdate;
    
    private String maxdatestr;
    
    
    private Date customerCallsTime;

    private Date laborProcessTime;

    private Date taskTime;

    private Date doorMaintenance;

    private Date solvingTime;

    private Date returnVisit;
    
    private String projectId;
    
    
    private  String attachmentId;
    
    private String name;
    
    private String numcount;
    
    private String attachmentURL;
    
    
    private String problem;//问题描述
    
    private String problemResolvDesc;//问题解决描述
    
   
    
    private String createUser;

	public Integer getEquipNum() {
		return equipNum;
	}

	public void setEquipNum(Integer equipNum) {
		this.equipNum = equipNum;
	}

	public String getSubmitRealName() {
		return submitRealName;
	}

	public void setSubmitRealName(String submitRealName) {
		this.submitRealName = submitRealName;
	}

	public String getProblem() {
		return problem;
	}

	public void setProblem(String problem) {
		this.problem = problem;
	}

	public String getProblemResolvDesc() {
		return problemResolvDesc;
	}

	public void setProblemResolvDesc(String problemResolvDesc) {
		this.problemResolvDesc = problemResolvDesc;
	}

	public String getRepair() {
		if("-".equals(engineer)){
			repair="";
		}else{
			repair=engineer;
		}
		return repair;
	}

	public void setRepair(String repair) {
		this.repair = repair;
	}

	public String getNumcount() {
		return numcount;
	}

	public void setNumcount(String numcount) {
		this.numcount = numcount;
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

	public String getAttachmentURL() {
		return attachmentURL;
	}

	public void setAttachmentURL(String attachmentURL) {
		this.attachmentURL = attachmentURL;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getProjectPath() {
		return projectPath;
	}

	public void setProjectPath(String projectPath) {
		this.projectPath = projectPath;
	}

	public Date getCustomerCallsTime() {
		return customerCallsTime;
	}

	public void setCustomerCallsTime(Date customerCallsTime) {
		this.customerCallsTime = customerCallsTime;
	}

	public Date getLaborProcessTime() {
		return laborProcessTime;
	}

	public void setLaborProcessTime(Date laborProcessTime) {
		this.laborProcessTime = laborProcessTime;
	}

	public Date getTaskTime() {
		return taskTime;
	}

	public void setTaskTime(Date taskTime) {
		this.taskTime = taskTime;
	}

	public Date getDoorMaintenance() {
		return doorMaintenance;
	}

	public void setDoorMaintenance(Date doorMaintenance) {
		this.doorMaintenance = doorMaintenance;
	}

	public Date getSolvingTime() {
		return solvingTime;
	}

	public void setSolvingTime(Date solvingTime) {
		this.solvingTime = solvingTime;
	}

	public Date getReturnVisit() {
		return returnVisit;
	}

	public void setReturnVisit(Date returnVisit) {
		this.returnVisit = returnVisit;
	}

	public String getMaxDateStr() {
		if(maxdate==null){
			maxDateStr="";
		}else{
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			maxDateStr=sdf.format(maxdate)+" "+maxdatestr;
		}
		return maxDateStr;
	}

	public void setMaxDateStr(String maxDateStr) {
		this.maxDateStr = maxDateStr;
	}


	public String getEngineer() {
		return engineer;
	}

	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}

	public String getMaintenanceOrderId() {
		return maintenanceOrderId;
	}

	public void setMaintenanceOrderId(String maintenanceOrderId) {
		this.maintenanceOrderId = maintenanceOrderId;
	}

	public String getClsSchoolId() {
		return clsSchoolId;
	}

	public void setClsSchoolId(String clsSchoolId) {
		this.clsSchoolId = clsSchoolId;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}


	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getSchoolPath() {
		return schoolPath;
	}

	public void setSchoolPath(String schoolPath) {
		this.schoolPath = schoolPath;
	}

	public String getMaxdatestr() {
		return maxdatestr;
	}

	public void setMaxdatestr(String maxdatestr) {
		this.maxdatestr = maxdatestr;
	}

	public Date getMaxdate() {
		return maxdate;
	}

	public void setMaxdate(Date maxdate) {
		this.maxdate = maxdate;
	}
	

    

}
