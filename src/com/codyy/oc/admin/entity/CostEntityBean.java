package com.codyy.oc.admin.entity;

import java.util.Date;
import java.util.List;

import org.springframework.web.util.HtmlUtils;

import net.sf.json.JSONArray;

/**
 * 成本实体类
 * @author Administrator
 *
 */
public class CostEntityBean {

	private String costId;
	
	//成本记录创建时间
	private Date createTime;
	
	//成本记录实际时间
	private Date costTime;
	
	//创建人ID
	private String createUserId;
	
	//成本类型,0:收入，1:支出
	private String costType ;
	
	//成本子类型ID
	private String costSubtypeId;
	
	//成本数目
	private double costNum = 0.00;
	
	private String remark;
	
	//部门ID
	private String depId;
	
	private String depAmount;
	
	//成本状态
	private String status;
	
	//成本单号
	private String costNo;
	
	//审核通过人
	private String auditUser;
	
	//合同id
	private String contractId;
	
	private List<CostDepEntityBean> cosDepList;
	



	public List<CostDepEntityBean> getCosDepList() {
		return cosDepList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setCosDepList(String jsonData) {
		List list = (List)json2ObjectList(jsonData, CostDepEntityBean.class); 
		this.cosDepList = list;
	}

	public static Object json2ObjectList(String strJson, @SuppressWarnings("rawtypes")Class beanClass) {
		  return JSONArray.toCollection(JSONArray.fromObject(strJson), beanClass); 
	}  
	
	public String getCostId() {
		return costId;
	}

	public void setCostId(String costId) {
		this.costId = costId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getCostTime() {
		return costTime;
	}

	public void setCostTime(Date costTime) {
		this.costTime = costTime;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public String getCostType() {
		return costType;
	}

	public void setCostType(String costType) {
		this.costType = costType;
	}

	public String getCostSubtypeId() {
		return costSubtypeId;
	}

	public void setCostSubtypeId(String costSubtypeId) {
		this.costSubtypeId = costSubtypeId;
	}

	public double getCostNum() {
		return costNum;
	}

	public void setCostNum(double costNum) {
		this.costNum = costNum;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

    public String getDepAmount() {
        return depAmount;
    }

    public void setDepAmount(String depAmount) {
        this.depAmount = depAmount;
    }

    public String getRemark() {
        return HtmlUtils.htmlUnescape(remark);
    }

    public void setRemark(String remark) {
        this.remark = HtmlUtils.htmlUnescape(remark);
    }

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCostNo() {
		return costNo;
	}

	public void setCostNo(String costNo) {
		this.costNo = costNo;
	}

	public String getAuditUser() {
		return auditUser;
	}

	public void setAuditUser(String auditUser) {
		this.auditUser = auditUser;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

}
