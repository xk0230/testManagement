package com.codyy.oc.admin.vo;

import com.codyy.oc.admin.entity.Book;

public class BookVO extends Book{
	
	private int start;
	
	private int end = 10;

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
	

}
