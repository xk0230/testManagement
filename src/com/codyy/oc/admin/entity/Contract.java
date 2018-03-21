package com.codyy.oc.admin.entity;

import java.util.Date;

import org.springframework.web.util.HtmlUtils;

/**  
 * @author Jason
 * @version: $ id:Contract.java, v 0.1	2018年3月6日	下午8:45:23	Jason $
 * @Description: TODO  
 */  
public class Contract {
    private String id;

    private String contractId;

    private String contractType;

    private String content;

    private String dept;

    private Double cost;

    private String company;

    private Date url;

    private String serialid;
    
	//合同记录创建时间
	private Date createTime;
	
	//合同记录实际时间
	private Date costTime;
	
	private String createUserId;
	
	private String status;
	
	private String remakes;
	
	/**
	 * @return the remakes
	 */
	public String getRemakes() {
		return remakes;
	}

	/**
	 * @param remakes the remakes to set
	 */
	public void setRemakes(String remakes) {
		this.remakes = HtmlUtils.htmlUnescape(remakes);
	}

	public String getStatus() {
		return HtmlUtils.htmlUnescape(status);
	}

	public void setStatus(String status) {
		this.status = status;
	}

    /**
	 * @return the createUserId
	 */
	public String getCreateUserId() {
		return createUserId;
	}

	/**
	 * @param createUserId the createUserId to set
	 */
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
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

	/**
	 * @return the costTime
	 */
	public Date getCostTime() {
		return costTime;
	}

	/**
	 * @param costTime the costTime to set
	 */
	public void setCostTime(Date costTime) {
		this.costTime = costTime;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContractId() {
        return contractId;
    }

    public void setContractId(String contractId) {
        this.contractId = contractId;
    }

    public String getContractType() {
        return contractType;
    }

    public void setContractType(String contractType) {
        this.contractType = contractType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Date getUrl() {
        return url;
    }

    public void setUrl(Date url) {
        this.url = url;
    }

    public String getSerialid() {
        return serialid;
    }

    public void setSerialid(String serialid) {
        this.serialid = serialid;
    }
}