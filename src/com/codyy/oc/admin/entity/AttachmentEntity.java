
package com.codyy.oc.admin.entity;

import java.util.Date;


public class AttachmentEntity {
    
    private String id;
    
    private String fId;
    
    private String name;
    
    private String location;
    
    private String type;
    
    private Date createTime;
    
    //----页面查询-----//
    private String typeName;
    
    private int start;
    
    private int end = 10;
    
    private String startDate;
    
    private String endDate;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getfId() {
        return fId;
    }

    public void setfId(String fId) {
        this.fId = fId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getTypeName() {
        if("1".equals(this.getType())){
            typeName = "PDF";
        }else if("0".equals(this.getType())){
            typeName = "图片";
        }
        return typeName;
    }
    
}

