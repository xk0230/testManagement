package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.vo.ProjectVO;

public interface ProjectMapper {
    int insert(Project record);

    int insertSelective(Project record);

	/**
	 * @param project
	 * @return
	 */
	int updateByPrimaryKey(Project project);

	/**
	 * @param id
	 * @return
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * @param page
	 * @return
	 */
	List<ProjectVO> getProjectPageList(Page page);
	
}