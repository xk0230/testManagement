package com.codyy.oc.admin.vo;

import com.codyy.oc.admin.entity.IpeBean;

public class IpeVO extends IpeBean{

	private int start;
	
	private int end;
	
	private String realname;
	
	private String depName;
	
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

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}
	
	
}
