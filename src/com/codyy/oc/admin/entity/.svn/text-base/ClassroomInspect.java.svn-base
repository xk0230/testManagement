package com.codyy.oc.admin.entity;

import java.util.Date;


import org.apache.commons.lang.StringUtils;

public class ClassroomInspect {
    private String classroomInspectId;

    private String name;

    private Integer sort;

    private String deleteFlag;

    private Date createTime;

    private String typeName;

    private Integer type;

    private String istxt;
    
    private String options;
    
    private String[] optionList;
    
    
    public String getOptions() {
		return options;
	}

	public void setOptions(String options) {
		this.options = options;
	}

	public String[] getOptionList() {
		if(StringUtils.isNotBlank(options)){
			return options.split(",");
		}
		return optionList;
	}

	public void setOptionList(String[] optionList) {
		this.optionList = optionList;
	}

	public String getIstxt() {
		return istxt;
	}

	public void setIstxt(String istxt) {
		this.istxt = istxt;
	}

	public String getClassroomInspectId() {
        return classroomInspectId;
    }

    public void setClassroomInspectId(String classroomInspectId) {
        this.classroomInspectId = classroomInspectId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}