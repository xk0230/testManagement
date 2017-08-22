package com.codyy.oc.admin.entity;

import java.io.Serializable;

public class AdminMenu implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String adminMenuId;
	private String menuName;
	private String parentId;
	private int menuLevel;
	private String url;
	private int menuSort;
	
	public String getAdminMenuId() {
		return adminMenuId;
	}
	public void setAdminMenuId(String adminMenuId) {
		this.adminMenuId = adminMenuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public int getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getMenuSort() {
		return menuSort;
	}
	public void setMenuSort(int menuSort) {
		this.menuSort = menuSort;
	}

}
