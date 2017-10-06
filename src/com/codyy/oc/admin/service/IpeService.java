package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.IpeDao;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.IpeBean;
import com.codyy.oc.admin.vo.IpeVO;

@Service("ipeServer")
public class IpeService {
	
	private static final String INSERT_SUCCESS = "保存成功";
	private static final String INSERT_ERROR = "保存失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DEL_SUCCESS = "删除成功";
	private static final String DEL_ERROR = "删除失败";
	private static final String NO_EXIT_DATA = "数据不存在";
	
	@Resource
	private IpeDao ipeDao;

	public JsonDto insertOrUpdateIpe(AdminUser user, IpeBean ipe) {
		
		JsonDto jsonDto = new JsonDto();
		
		ipe.setCreateUser(user.getUserName());
		String td = ipe.getTd();
		ipe.setTd(StringUtils.substringBeforeLast(td, "-"));
		ipe.setKd(StringUtils.substringAfterLast(td, "-"));
		
		if(StringUtils.isBlank(ipe.getId())){
			ipe.setCreateTime(DateUtils.getCurrentTimestamp());
			ipe.setId(UUID.randomUUID().toString());
			int insertNum = ipeDao.insertIpe(ipe);
			if(insertNum == 1){
				jsonDto.setCode(0);
				jsonDto.setMsg(INSERT_SUCCESS);
			}else{
				jsonDto.setMsg(INSERT_ERROR);
			}
			
		}else{
			int updateNum = ipeDao.updateIpe(ipe);
			if(updateNum == 1){
				jsonDto.setCode(0);
				jsonDto.setMsg(UPDATE_SUCCESS);
			}else{
				jsonDto.setMsg(UPDATE_ERROR);
			}
		}
		
		return jsonDto;
	}

	public JsonDto getOrganizationalSize() {
		JsonDto jsonDto = new JsonDto();
		String orgSize = ipeDao.getOrganizationalSize();
		if(StringUtils.isNotBlank(orgSize)){
			jsonDto.setCode(0);
			jsonDto.setObjData(orgSize);
		}
		return jsonDto;
	}

	public JsonDto getIpeById(String id) {
		JsonDto jsonDto = new JsonDto();
		IpeBean ipe = null;
		if(StringUtils.isNotBlank(id)){
			ipe  = ipeDao.getIpeById(id);
		}
		
		if(null == ipe){
			ipe = new IpeBean();
		}
		
		if(null != ipe){
			ipe.setOrg(ipeDao.getOrganizationalSize());
			ipe.setTd(ipe.getTd()+"-"+ipe.getKd());
			
			jsonDto.setCode(0);
			jsonDto.setObjData(ipe);
		}
		return jsonDto;
	}

	public Page getIpePageList(IpeVO ipe) {
		
		Page page = new Page();
	    page.setStart(ipe.getStart());
	    page.setEnd(ipe.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    map.put("userId", ipe.getUserId());
	    
	    page.setMap(map);
	    
	    List<IpeVO> ipePageList = ipeDao.getIpePageList(page);
	    
	    if(CollectionUtils.isNotEmpty(ipePageList)){
	    	//组织规模
	    	String organizationalSize = ipeDao.getOrganizationalSize();
	    	for(IpeVO ipeVO : ipePageList){
	    		ipeVO.setOrg(organizationalSize);
	    		
	    		String gx = ipeVO.getGx();
	    		String kj = ipeVO.getKj();
	    		String fzd = ipeVO.getFzd();
	    		String td = ipeVO.getTd();
	    		
	    		ipeVO.setGx(StringUtils.substringAfterLast(gx, ","));
	    		ipeVO.setKj(StringUtils.substringAfterLast(kj, ","));
	    		ipeVO.setFzd(StringUtils.substringAfterLast(fzd, ","));
	    		ipeVO.setTd(StringUtils.substringAfterLast(td, ","));
	    		
	    		
	    		//计算ipe
	    		
	    	};
	    	
	    }
	    
	    
	    page.setData(ipePageList);
	    
	    return page;
		
	}

	public JsonDto delIpeById(String id) {
		JsonDto jsonDto = new JsonDto();
		int delNum = ipeDao.delIpeById(id);
		if(delNum == 1){
			jsonDto.setCode(0);
		}
		
		return jsonDto;
	}

	
	
}
