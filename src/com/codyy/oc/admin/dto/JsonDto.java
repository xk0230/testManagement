package com.codyy.oc.admin.dto;

/**
 * 前端json数据
 * @author Administrator
 *
 */
public class JsonDto {

	//-1:失败  0：成功
	private int code = -1;
	
	private String msg;
	
	private Object objData;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObjData() {
		return objData;
	}

	public void setObjData(Object objData) {
		this.objData = objData;
	}
	
}
