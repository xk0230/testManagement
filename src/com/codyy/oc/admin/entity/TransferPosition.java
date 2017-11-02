
package com.codyy.oc.admin.entity;

import java.util.Date;

/**
 *调岗记录 
 *
 */
public class TransferPosition {
    
    private String id;
    
    private Date createTime;
    
    private String postOld;
    
    private String postNew;
    
    private int salaryOld;
    
    private int salaryNew;
    
    private Date transferTime;
    
    private String remark;
    
    private String userId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getPostOld() {
        return postOld;
    }

    public void setPostOld(String postOld) {
        this.postOld = postOld;
    }

    public String getPostNew() {
        return postNew;
    }

    public void setPostNew(String postNew) {
        this.postNew = postNew;
    }

    public int getSalaryOld() {
        return salaryOld;
    }

    public void setSalaryOld(int salaryOld) {
        this.salaryOld = salaryOld;
    }

    public int getSalaryNew() {
        return salaryNew;
    }

    public void setSalaryNew(int salaryNew) {
        this.salaryNew = salaryNew;
    }

    public Date getTransferTime() {
        return transferTime;
    }

    public void setTransferTime(Date transferTime) {
        this.transferTime = transferTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
}

