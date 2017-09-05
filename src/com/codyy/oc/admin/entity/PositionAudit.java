package com.codyy.oc.admin.entity;

import java.util.Date;

public class PositionAudit {
    private String positionAuditId;

    private String positionId;

    private String auditUserId;

    private String createUserId;

    private Integer result;

    private Date auditTime;

    private Date createTime;

    public String getPositionAuditId() {
        return positionAuditId;
    }

    public void setPositionAuditId(String positionAuditId) {
        this.positionAuditId = positionAuditId;
    }

    public String getPositionId() {
        return positionId;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public String getAuditUserId() {
        return auditUserId;
    }

    public void setAuditUserId(String auditUserId) {
        this.auditUserId = auditUserId;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}