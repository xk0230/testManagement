package com.codyy.oc.admin.entity;



/**
 * 
 * ClassName: TreeBean
 * Function:  生成jstree所用的bean 
 * date: 2015年3月25日 上午9:11:43
 * 
 * @author Xiaokan 
 * @version  
 * @since JDK 1.7
 */
public class TreeBean {
	private String id;
	private String name;
//	private List<TreeBean> childs;
	private Object childs;
	
	private String sort;
	
	public TreeBean(){
		
	}
	
	public TreeBean(String id,String name){
		this.id = id;
		this.name = name;
	}
	
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public Object getChilds() {
		return childs;
	}

	public void setChilds(Object childs) {
		this.childs = childs;
	}

	
}
