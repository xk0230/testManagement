package com.codyy.commons.menu;

import java.util.ArrayList;
import java.util.List;

public class MenuEntity {

	private String clazz;
	private String title;
	private String group;
	private List<SubMenuEntity> subMenu = new ArrayList<SubMenuEntity>();
	
	public String getClazz() {
		return clazz;
	}
	public void setClazz(String clazz) {
		this.clazz = clazz;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public List<SubMenuEntity> getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(List<SubMenuEntity> subMenu) {
		this.subMenu = subMenu;
	}
	
}
