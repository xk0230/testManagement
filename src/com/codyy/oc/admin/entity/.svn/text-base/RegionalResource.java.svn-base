package com.codyy.oc.admin.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
@ExcelHeader(headerName="区域资源列表")
public class RegionalResource {
	
    private String regionalResourceId;//资源编号
   
    private String baseAreaId;//地区
    
    private Date create_Time;//创建时间
    private String create_User;//创建用户
    
    
    
    public Date getCreate_Time() {
		return create_Time;
	}

	public void setCreate_Time(Date create_Time) {
		this.create_Time = create_Time;
	}

	public String getCreate_User() {
		return create_User;
	}

	public void setCreate_User(String create_User) {
		this.create_User = create_User;
	}

	@ExcelColumn(columnName="供应商名称")
    private String name;//供应商名称
   
    @ExcelColumn(columnName="类别")
    private String type;//类别
    
    @ExcelColumn(columnName="合作项目")
    private Integer num;//统计查询出每个资源的项目的总个数
    
    @ExcelColumn(columnName = "区域")
	private String areaPath;
    
    @ExcelColumn(columnName="地址")
    private String address;//地址
    
    @ExcelColumn(columnName="联系人")
    private String contactPersonName;//联系人姓名

    private String contactPersonJob;//联系人职位
    
    @ExcelColumn(columnName="联系电话")
    private String contactPersonPhone;

    @ExcelColumn(columnName="服务内容")
    private String serviceContent;//服务内容
    @ExcelColumn(columnName="备注")
    private String remark;//备注

	private BaseArea baseArea;//区域资源对象
	
	//获得实体中存储的对象的属性值
	public String getAreaPath() {
		return this.areaPath;
	}

	public void setAreaPath(String areaPath) {
		this.areaPath = areaPath;
	}

	//获得本用户的所有项目集合
    private List<Project> myproject = new ArrayList<Project>();
    

	public List<Project> getMyproject() {
		return myproject;
	}

	public void setMyproject(List<Project> myproject) {
		this.myproject = myproject;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public BaseArea getBaseArea() {
		return baseArea;
	}

	public void setBaseArea(BaseArea baseArea) {
		this.baseArea = baseArea;
		this.areaPath = this.baseArea.getAreaPath();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegionalResourceId() {
        return regionalResourceId;
    }

    public void setRegionalResourceId(String regionalResourceId) {
        this.regionalResourceId = regionalResourceId;
    }

    public String getBaseAreaId() {
        return baseAreaId;
    }

    public void setBaseAreaId(String baseAreaId) {
        this.baseAreaId = baseAreaId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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


    public String getServiceContent() {
        return serviceContent;
    }

    public void setServiceContent(String serviceContent) {
        this.serviceContent = serviceContent;
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

	@Override
	public String toString() {
		return "RegionalResource [regionalResourceId=" + regionalResourceId
				+ ", baseAreaId=" + baseAreaId + ", address=" + address
				+ ", contactPersonName=" + contactPersonName
				+ ", contactPersonJob=" + contactPersonJob
				+ ", contactPersonPhone=" + contactPersonPhone
				+ ", serviceContent=" + serviceContent + ", remark=" + remark
				+ ", type=" + type + ", name=" + name + ", baseArea="
				+ baseArea + ", num=" + num + ", myproject=" + myproject
				+ ", toString()=" + super.toString() + "]";
	}
	
}