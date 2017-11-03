package com.codyy.oc.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.RegRProjectMapper;
import com.codyy.oc.admin.entity.RegRProject;

@Service
public class RegRProjectService {
    
	@Autowired
	private RegRProjectMapper regRProjectMapper;
	
	
    /**
     * @author lichen
    * @Title: insertProRUser
    * @Description: (添加资源表与项目表之间的关系)
    * @param @param regRProject
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
	public Integer insertProRUser(RegRProject regRProject){
		
		return regRProjectMapper.insertRegRProject(regRProject);
	}
	
	
	/**
	 * @author lichen
	* @Title: delResouceRProjectByResId
	* @Description: (根据地区的资源id来删除资源项目关系表的对应所有记录)
	* @param @param regionalResourceId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer delResouceRProjectByResId(String regionalResourceId){
		System.out.println("regionalResourceId="+regionalResourceId);
		return regRProjectMapper.delResouceRProjectByResId(regionalResourceId);
	}
}
