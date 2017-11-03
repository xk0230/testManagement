package com.codyy.oc.admin.entity;

import java.util.Date;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;

@ExcelHeader(headerName="系统集成商资源列表")
public class Supplier {
    private String supplierId;//主键id
    @ExcelColumn(columnName="供应商名称")
    private String name;//提供商名称
    
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

	private BaseArea baseArea;//根据传来的地区的id获得地区的名称
    
    @ExcelColumn(columnName="所属区域")
    private String areaPath;
    
   

	public String getAreaPath() {
		return areaPath;
	}

	public void setAreaPath(String areaPath) {
		this.areaPath = areaPath;
	}

	private String baseAreaId;//区域id
    @ExcelColumn(columnName="地址")
    private String address;
   
    private String countContactNum;//记录注册的联系人的个数
    @ExcelColumn(columnName="注册资本(万元)")
    private Float registeredCapital;//注册资金
    @ExcelColumn(columnName="历史合作项目")
    private String countNum;//获取集成商的合作项目的个数
    @ExcelColumn(columnName="资质")
    private String qualification;//集成商的资质
    @ExcelColumn(columnName="主要服务内容")
    private String serviceContent;//主要服务内容

    private String contactPersonNameOne;//第一联系人姓名

    private String contactPersonJobOne;//第一联系人职位

    private String contactPersonPhoneOne;//第一联系人电话

    private String contactPersonNameTwo;

    private String contactPersonJobTwo;

    private String contactPersonPhoneTwo;

    private String contactPersonNameThree;

    private String contactPersonJobThree;

    private String contactPersonPhoneThree;
    
    

    

	public String getCountContactNum() {
		return countContactNum;
	}

	public void setCountContactNum(String countContactNum) {
		this.countContactNum = countContactNum;
	}

	public String getCountNum() {
		return countNum;
	}

	public void setCountNum(String countNum) {
		this.countNum = countNum;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	

    public BaseArea getBaseArea() {
		return baseArea;
	}

	public void setBaseArea(BaseArea baseArea) {
		this.baseArea = baseArea;
		this.areaPath=this.baseArea.getAreaPath();//直接从封装好的对象给本实体类的属性赋值
	}

	public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
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

    public String getContactPersonNameOne() {
        return contactPersonNameOne;
    }

    public void setContactPersonNameOne(String contactPersonNameOne) {
        this.contactPersonNameOne = contactPersonNameOne;
    }

    public String getContactPersonJobOne() {
        return contactPersonJobOne;
    }

    public void setContactPersonJobOne(String contactPersonJobOne) {
        this.contactPersonJobOne = contactPersonJobOne;
    }

    public String getContactPersonPhoneOne() {
        return contactPersonPhoneOne;
    }

    public void setContactPersonPhoneOne(String contactPersonPhoneOne) {
        this.contactPersonPhoneOne = contactPersonPhoneOne;
    }

    public String getContactPersonNameTwo() {
        return contactPersonNameTwo;
    }

    public void setContactPersonNameTwo(String contactPersonNameTwo) {
        this.contactPersonNameTwo = contactPersonNameTwo;
    }

    public String getContactPersonJobTwo() {
        return contactPersonJobTwo;
    }

    public void setContactPersonJobTwo(String contactPersonJobTwo) {
        this.contactPersonJobTwo = contactPersonJobTwo;
    }

    public String getContactPersonPhoneTwo() {
        return contactPersonPhoneTwo;
    }

    public void setContactPersonPhoneTwo(String contactPersonPhoneTwo) {
        this.contactPersonPhoneTwo = contactPersonPhoneTwo;
    }

    public String getContactPersonNameThree() {
        return contactPersonNameThree;
    }

    public void setContactPersonNameThree(String contactPersonNameThree) {
        this.contactPersonNameThree = contactPersonNameThree;
    }

    public String getContactPersonJobThree() {
        return contactPersonJobThree;
    }

    public void setContactPersonJobThree(String contactPersonJobThree) {
        this.contactPersonJobThree = contactPersonJobThree;
    }

    public String getContactPersonPhoneThree() {
        return contactPersonPhoneThree;
    }

    public void setContactPersonPhoneThree(String contactPersonPhoneThree) {
        this.contactPersonPhoneThree = contactPersonPhoneThree;
    }

    public Float getRegisteredCapital() {
        return registeredCapital;
    }

    public void setRegisteredCapital(Float registeredCapital) {
        this.registeredCapital = registeredCapital;
    }

    public String getServiceContent() {
        return serviceContent;
    }

    public void setServiceContent(String serviceContent) {
        this.serviceContent = serviceContent;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

	@Override
	public String toString() {
		return "Supplier [supplierId=" + supplierId + ", baseAreaId="
				+ baseAreaId + ", address=" + address
				+ ", contactPersonNameOne=" + contactPersonNameOne
				+ ", contactPersonJobOne=" + contactPersonJobOne
				+ ", contactPersonPhoneOne=" + contactPersonPhoneOne
				+ ", contactPersonNameTwo=" + contactPersonNameTwo
				+ ", contactPersonJobTwo=" + contactPersonJobTwo
				+ ", contactPersonPhoneTwo=" + contactPersonPhoneTwo
				+ ", contactPersonNameThree=" + contactPersonNameThree
				+ ", contactPersonJobThree=" + contactPersonJobThree
				+ ", contactPersonPhoneThree=" + contactPersonPhoneThree
				+ ", registeredCapital=" + registeredCapital
				+ ", serviceContent=" + serviceContent + ", name=" + name
				+ ", qualification=" + qualification + ", baseArea=" + baseArea
				+ ", countNum=" + countNum + ", countContactNum="
				+ countContactNum + ", toString()=" + super.toString() + "]";
	}

	

   
    
}