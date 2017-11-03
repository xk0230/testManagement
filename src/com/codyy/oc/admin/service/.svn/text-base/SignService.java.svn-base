package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.oc.admin.dao.SignMapper;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.view.ShowNewSignMessageView;
import com.codyy.oc.admin.view.SignDetailView;
import com.codyy.oc.admin.view.SignView;
@Service
public class SignService {

	@Autowired
	private SignMapper signMapper;
	
	/**
	 * @author lichen
	* @Title: showNewSignPageList
	* @Description: (查询签到记录的最新数据)
	* @param @param page
	* @param @return    设定文件
	* @return List<ShowNewSignMessageView>    返回类型
	* @throws
	 */
	public List<ShowNewSignMessageView> showNewSignPageList(Page page,SignView signView,String sortDesc){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("projectArea", signView.getProjectArea());
		map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(signView.getProjectName()));
		map.put("userName", OracleKeyWordUtils.oracleKeyWordReplace(signView.getUserName()));
		map.put("position", OracleKeyWordUtils.oracleKeyWordReplace(signView.getPosition()));
		map.put("status", signView.getStatus());
		map.put("sortDesc", sortDesc);
		page.setMap(map);
		return signMapper.showNewSignPageList(page);
	}
	
	
	/**
	 * @author lichen
	* @Title: selcSignDetailPageList
	* @Description: (获取指定用户的所有签到信息)
	* @param @param page
	* @param @param userId
	* @param @return    设定文件
	* @return List<SignDetailView>    返回类型
	* @throws
	 */
	public List<SignDetailView> selcSignDetailPageList(Page page,String userId,String maintenanceOrderId){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userId);
		map.put("maintenanceOrderId", maintenanceOrderId);
		page.setMap(map);
		return signMapper.selcSignDetailPageList(page);
	}
	
	
	/**
	 * @author lichen
	* @Title: exportClassroomList
	* @Description: (导出所有签到资源)
	* @param @param search
	* @param @param sortDesc
	* @param @return    设定文件
	* @return HSSFWorkbook    返回类型
	* @throws
	 */
	 public HSSFWorkbook exportAllSignList(String sortDesc,SignView signView) {
		 Map<String,Object> map = new HashMap<String,Object>();
			map.put("sortDesc", sortDesc);
			map.put("projectArea", signView.getProjectArea());
			map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(signView.getProjectName()));
			map.put("userName", OracleKeyWordUtils.oracleKeyWordReplace(signView.getUserName()));
			map.put("position", OracleKeyWordUtils.oracleKeyWordReplace(signView.getPosition()));
			map.put("status", signView.getStatus());
			map.put("sortDesc", sortDesc);
			
			List<ShowNewSignMessageView> allSignList =signMapper.exportAllSign(map);
		return ExcelAnnocationUtils.exportExcelData(ShowNewSignMessageView.class,allSignList);
	 }
	 
	 
	 /**
	  * @author lichen
	 * @Title: exportDetailList
	 * @Description: (导出指定用户的所有有关项目信息)
	 * @param @param userId
	 * @param @return    设定文件
	 * @return HSSFWorkbook    返回类型
	 * @throws
	  */
	 public HSSFWorkbook exportDetailList(String userId) {
		 Map<String,Object> map = new HashMap<String,Object>();
			map.put("userId", userId);
			
			List<SignDetailView> SignDetailList =signMapper.exportDetailSignById(map);
		return ExcelAnnocationUtils.exportExcelData(SignDetailView.class,SignDetailList);
	 }
	 
	 /**
	  * @author lichen
	 * @Title: getSignPic
	 * @Description: (获得签到图片的集合)
	 * @param @param signId
	 * @param @return    设定文件
	 * @return List<Attachment>    返回类型
	 * @throws
	  */
	 public List<Attachment> getSignPic(String signId){
		 return signMapper.getSignPic(signId);
	 }
}
