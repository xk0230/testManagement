package com.codyy.oc.admin.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.IpeDao;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.IpeBean;
import com.codyy.oc.admin.vo.IpeVO;
import com.codyy.oc.admin.vo.ScorePcSalaryVO;

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
	
	private static Map<String,String> orgFiledMap = new HashMap<String,String>();
	
	static {
		orgFiledMap.put("1", "a");
		orgFiledMap.put("2", "b");
		orgFiledMap.put("3", "c");
		orgFiledMap.put("4", "d");
		orgFiledMap.put("5", "e");
		orgFiledMap.put("6", "f");
		orgFiledMap.put("7", "g");
		orgFiledMap.put("8", "h");
		orgFiledMap.put("9", "i");
		orgFiledMap.put("10", "j");
		orgFiledMap.put("11", "k");
		orgFiledMap.put("12", "l");
		orgFiledMap.put("13", "m");
		orgFiledMap.put("14", "n");
		orgFiledMap.put("15", "o");
		orgFiledMap.put("16", "p");
		orgFiledMap.put("17", "q");
		orgFiledMap.put("18", "r");
		orgFiledMap.put("19", "s");
		orgFiledMap.put("20", "t");
		
	}
	
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
		IpeVO ipe = null;
		if(StringUtils.isNotBlank(id)){
			ipe  = ipeDao.getIpeById(id);
			ipe.setTd(ipe.getTd()+"-"+ipe.getKd());
		}
		
		if(null == ipe){
			ipe = new IpeVO();
		}
		
		if(null != ipe){
			ipe.setOrg(ipeDao.getOrganizationalSize());
			
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
	    		
	    		//计算ipe
	    		double totalScore = calculateTotalScore(ipeVO);
	    		ScorePcSalaryVO scorePcSalaryVO = getMaxScorePcSalaryVO(totalScore);
	    		if(null != scorePcSalaryVO){
	    			ipeVO.setPc(String.valueOf(scorePcSalaryVO.getPc()));
	    			ipeVO.setAdviseSalary(scorePcSalaryVO.getSalary());
	    		}
	    		
	    		ipeVO.setGx(StringUtils.substringAfterLast(gx, ","));
	    		ipeVO.setKj(StringUtils.substringAfterLast(kj, ","));
	    		ipeVO.setFzd(StringUtils.substringAfterLast(fzd, ","));
	    		ipeVO.setTd(StringUtils.substringAfterLast(td, ","));
	    		
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

	public double calculateTotalScore(IpeVO ipe){
		//影响-贡献
		String yxAndOrgValue = calYxAndOrgValue(ipe);
		//沟通-框架
		String gtAndKjValue = calGtAndKjValue(ipe);
		//创新-复杂度
		String cxAndFzdValue = calCxAndFzdValue(ipe);
		//知识-团队-宽度
		String zsAndTdValue = calZsAndTdValue(ipe);
		
		double value = 0.0;
		if(NumberUtils.isNumber(yxAndOrgValue) 
				&& NumberUtils.isNumber(gtAndKjValue)
				&& NumberUtils.isNumber(cxAndFzdValue)
				&& NumberUtils.isNumber(zsAndTdValue)){
			
			BigDecimal yxAndOrgVal = new BigDecimal(yxAndOrgValue);
			BigDecimal gtAndKjVal = new BigDecimal(gtAndKjValue);
			BigDecimal cxAndFzdVal = new BigDecimal(cxAndFzdValue);
			BigDecimal zsAndTdVal = new BigDecimal(zsAndTdValue);
			
			BigDecimal totalVal = yxAndOrgVal.add(gtAndKjVal).add(cxAndFzdVal).add(zsAndTdVal);
			
			value = totalVal.doubleValue();
		}
		
		return value;
		
	}
	
	public String calZsAndTdValue(IpeVO ipe) {
		
		String td = ipe.getTd();
		ipe.setTd(StringUtils.substringBefore(td, ","));
		//知识团队宽度
		String value = ipeDao.getZsAndTdValue(ipe);
		
		return value;
	}

	public String calCxAndFzdValue(IpeVO ipe) {
		
		String fzd = ipe.getFzd();
		ipe.setFzd(StringUtils.substringBefore(fzd, ","));
		//创新复杂度
		String value = ipeDao.getCxAndFzdValue(ipe);
		
		return value;
		
	}

	public String calGtAndKjValue(IpeVO ipe) {
		
		String kj = ipe.getKj();
		ipe.setKj(StringUtils.substringBefore(kj, ","));
		//沟通框架值
		String value = ipeDao.getGtAndKjValue(ipe);
		
		return value;
		
	}

	public String calYxAndOrgValue(IpeVO ipe){
		
		String gx = ipe.getGx();
		ipe.setGx(StringUtils.substringBefore(gx, ","));
		//影响贡献值
		String yxValue = ipeDao.getYxAndGxValue(ipe);
		//影响组织规模结果值
		String value = "";
		if(StringUtils.isNotBlank(yxValue)){
			ipe.setValueName(yxValue);
			String orgValue = orgFiledMap.get(ipe.getOrg());
			if(StringUtils.isNotBlank(orgValue)){
				ipe.setFieldName(orgValue);
				value = ipeDao.getYxAndOrgValue(ipe);
			}
		}
		
		return value;
	}
	
	 
	public ScorePcSalaryVO getMaxScorePcSalaryVO(double score){
		return ipeDao.getMaxScorePcSalaryVO(score);
	}

	public IpeVO calIpeByTotalScore(IpeVO ipeVO) {
		
		BigDecimal yxAndOrgVal = new BigDecimal(ipeVO.getScore1());
		BigDecimal gtAndKjVal = new BigDecimal(ipeVO.getScore2());
		BigDecimal cxAndFzdVal = new BigDecimal(ipeVO.getScore3());
		BigDecimal zsAndTdVal = new BigDecimal(ipeVO.getScore4());
		
		BigDecimal totalVal = yxAndOrgVal.add(gtAndKjVal).add(cxAndFzdVal).add(zsAndTdVal);
		ScorePcSalaryVO scorePcSalary = getMaxScorePcSalaryVO(totalVal.doubleValue());
		if(null != scorePcSalary){
			ipeVO.setPc(String.valueOf(scorePcSalary.getPc()));
			ipeVO.setAdviseSalary(scorePcSalary.getSalary());
			ipeVO.setTotalScore(String.valueOf(totalVal.doubleValue()));
		}
		
		return ipeVO;
	}
	
}
