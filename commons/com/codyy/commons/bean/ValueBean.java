package com.codyy.commons.bean;

/**
 * 
 * ClassName:ValueBean
 * Function: 值Bean
 *
 * @author   zhangtian
 * @Date	 2015	2015年4月1日		下午7:25:56
 *
 */
public class ValueBean {

	private String value ;
	private Boolean isErr ;

	public ValueBean(){
		super();
	}
	public ValueBean(String value){
		super();
		if(value == null){
			this.value = "";
		}else{
			this.value = value;
		}
		this.isErr = false;
	}
	public ValueBean(String value,boolean isErr){
		super();
		this.value = value;
		this.isErr = isErr;
	}
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Boolean getIsErr() {
		return isErr;
	}

	public void setIsErr(Boolean isErr) {
		this.isErr = isErr;
	}
	
	public void valueAppend(String value){
		this.value = this.value+value;
		this.isErr = true;
	}
	
	
}
