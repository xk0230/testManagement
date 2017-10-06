package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.IpeBean;
import com.codyy.oc.admin.vo.IpeVO;
import com.codyy.oc.admin.vo.ScorePcSalaryVO;

public interface IpeDao {
	
	String getOrganizationalSize();

	int insertIpe(IpeBean ipe);

	int updateIpe(IpeBean ipe);

	IpeBean getIpeById(String id);
	
	List<IpeBean> getIpeByUserId(String id);

	List<IpeVO> getIpePageList(Page page);

	int delIpeById(String id);

	String getYxAndGxValue(IpeVO ipe);

	String getYxAndOrgValue(IpeVO ipe);

	String getGtAndKjValue(IpeVO ipe);

	String getCxAndFzdValue(IpeVO ipe);

	String getZsAndTdValue(IpeVO ipe);
	
	ScorePcSalaryVO getMaxScorePcSalaryVO(double score);
	
}
