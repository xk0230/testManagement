package com.codyy.oc.admin.entity;

import java.util.Date;

/**
 * 成本实体类
 * @author Administrator
 *
 */
public class CostSeqBean {
	//分类
	private String type;
	//日期
	private String date;
	//seq
	private int seq;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}

	
}
