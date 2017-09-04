package com.codyy.oc.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.page.Page;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.SecurityUtil;
import com.codyy.oc.admin.dao.BaseUserMapper;
import com.codyy.oc.admin.dao.CommonsMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.BaseUser;
import com.codyy.oc.admin.view.UserImportModel;
import com.codyy.oc.admin.view.UserSearchModel;

import net.sf.json.util.JSONStringer;

/** 
 * ClassName: BaseUserManagerService
 * 
 */  
@Service
public class BaseUserService {
	
	@Autowired
	private BaseUserMapper baseUserMapper;
	
	@Autowired
	private CommonsMapper commonsMapper;
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getOrgUserList
		* @Description: (获取用户列表)
		* @param strStart,strEnd,userSearch
		* @return Page    
	 */
	public Page getOrgUserList(String strStart,String strEnd,UserSearchModel userSearch){
		int start = 0;
		int end = 19;
		if(StringUtils.isNotBlank(strStart)){
			start = Integer.parseInt(strStart);
		}
		if(StringUtils.isNotBlank(strEnd)){
			end = Integer.parseInt(strEnd);
		}
		end++;
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("userName", OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getUserName()));
		map.put("realName",OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getUserName()));
		map.put("contact", userSearch.getContact());
		map.put("position",userSearch.getPosition());
		/*map.put("adminUserType", CommonsConstant.CREATE_USER_TYPE_BASE_ADMIN);
		map.put("baseUserType", CommonsConstant.CREATE_USER_TYPE_BASE_USER);
		map.put("userType", CommonsConstant.USER_TYPE_AREA_USER);*/
		int total = baseUserMapper.getOrgUserCount(map);
		Page page = new Page();
		page.setTotal(total);
		if(total == 0){
			page.setData(new ArrayList<String>());
			return page;
		}
		List<AdminUser> data = baseUserMapper.getOrgUserList(map);
		System.out.println(data.size());
		for(AdminUser user:data){
			System.out.println(user.getUserId());
			System.out.println(user.getRealName());
		}
		page.setData(data);
		return page;
	}
	
	/**
	 * 
	 * addOrgBaseUser:(添加机构用户)
	 * 
	 * @author yangyongwu 
	 * @param baseUser
	 * @return
	 */
//	public ResultJson addOrgBaseUser(BaseUser baseUser){
//		String userName = baseUser.getUserName();
//		if(StringUtils.isBlank(userName)){
//			return new ResultJson(false,"用户名不能为空！");
//		}
//		if(baseUserMapper.getBaseUserCountByUserName(userName)>0){
//			return new ResultJson(false, "很抱歉，账号名称已存在，请重新输入！");
//		}
//		baseUser.setBaseUserId(UUIDUtils.getUUID());
//		String password = baseUser.getPassword();
//		if(StringUtils.isNotBlank(password)){
//			baseUser.setPassword(SecurityUtil.MD5String(password));
//		}else{
//			return new ResultJson(false, "添加失败！");
//		}
//		baseUser.setHeadPic(CommonsConstant.HEAD_PIC_DEFAULT);
//		baseUser.setUserType(CommonsConstant.USER_TYPE_AREA_USER);
//		baseUser.setCreateTime(new Date());
//		baseUser.setDeleteFlag(CommonsConstant.FLAG_NO);
//		baseUser.setCreateUserType(CommonsConstant.CREATE_USER_TYPE_BASE_ADMIN);
//		if(baseUserMapper.insertSelective(baseUser)>0){
//			return new ResultJson(true);
//		}else{
//			return new ResultJson(false, "添加失败！");
//		}
//	}
	
	/**
	 * 
	 * addSchoolBaseUser:(创建学校用户)
	 *
	 * @param baseUser
	 * @return
	 * @author zhangtian
	 */
	public String addSchoolBaseUser(BaseUser baseUser) {
		
		// === 校验用户名唯一性
		Integer count = baseUserMapper.getBaseUserCountByUserName(baseUser.getUserName()) ;
		if(count > 0) {
			return new JSONStringer().object().key("result").value(false).endObject().toString() ;
		} else {
			Integer num = baseUserMapper.insertSelective(baseUser) ;
			if(num > 0) {
				return new JSONStringer().object().key("result").value(true).key("flag").value(true).endObject().toString() ;
			} else {
				return new JSONStringer().object().key("result").value(true).key("flag").value(false).endObject().toString() ;
			}
		}
	}
	
	
	public ResultJson deleteBaseUserById(String baseUserId){
		if(StringUtils.isNotBlank(baseUserId)){
			Map<String,String> map = new HashMap<String, String>();
			map.put("baseUserId", baseUserId);
			map.put("adminFlag", CommonsConstant.FLAG_YES);
			if(baseUserMapper.deleteBaseUserById(map)>0){
				return new ResultJson(true);
			}else{
				return new ResultJson(false);
			}
		}else{
			return new ResultJson(false);
		}
	}
	
	public BaseUser getBaseUserById(String baseUserId){
		return baseUserMapper.getBaseUserById(baseUserId);
	}
	
	/**
	 * 
	 * getOrgUserInfoForUpdate:(获取机构用户的基本信息)
	 * @author yangyognwu 
	 * @param baseUserId
	 * @return
	 */
	public Map<String,Object> getOrgUserInfoForUpdate(String baseUserId){
		if(StringUtils.isBlank(baseUserId)){
			return null;
		}
		Map<String,Object> result = new HashMap<String, Object>();
		BaseUser baseUser = baseUserMapper.getBaseUserById(baseUserId);
		if(baseUser == null){
			return null;
		}
		String baseAreaId = baseUser.getBaseAreaId();
		String areaNames = commonsMapper.getFullAreaName(baseAreaId);
		result.put("baseUser", baseUser);
		result.put("areaNames", areaNames);
		return result;
	}
	
	/**
	 * 
	 * updateOrgUser:(更新区域账号)
	 * @author yangyongwu 
	 * @param baseUser
	 * @return
	 */
	public ResultJson updateOrgUser(BaseUser baseUser){
		if(baseUser == null){
			return new ResultJson(false, "编辑失败！");
		}
		String baseUserId = baseUser.getBaseUserId();
		if(StringUtils.isBlank(baseUserId)){
			return new ResultJson(false, "编辑失败！");
		}
		BaseUser u = baseUserMapper.getBaseUserById(baseUserId);
		if(u == null){
			return new ResultJson(false, "编辑失败！");
		}
		
		if(CommonsConstant.FLAG_YES.equals(u.getAdminFlag())){
			baseUser.setPermGrant(null);
		}
		String pasword = baseUser.getPassword();
		if(StringUtils.isBlank(pasword)){
			pasword = "";
		}
		if(pasword.trim().length() == 0){
			baseUser.setPassword(null);
		}else{
			baseUser.setPassword(SecurityUtil.MD5String(pasword));
		}
		if(baseUserMapper.updateOrgUser(baseUser)>0){
			return new ResultJson(true);
		}else{
			return new ResultJson(false,"编辑失败！");
		}
	}
	

	
	/*public Page getTeaUserPageList(UserSearchModel userSearch, Page page){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("baseAreaId", userSearch.getBaseAreaId());
		map.put("semesterId", userSearch.getSemesterId());
		map.put("schoolName", userSearch.getSchoolName());
		map.put("userName", OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getUserName()));
		map.put("classLevelId", userSearch.getClassLevelId());
		map.put("subjectId", userSearch.getSubjectId());
		map.put("locked", userSearch.getLocked());
		map.put("userType", CommonsConstant.USER_TYPE_TEACHER);
		int total = baseUserMapper.getTeaUserCount(map);
		page.setTotal(total);
		if(total == 0){
			page.setData(new ArrayList<String>());
			return page;
		}
		page.setMap(map);
		List<BaseUser> data = baseUserMapper.getTeaUserPageList(page);
		page.setData(data);
		return page;
	}
	*/


	/**
	 * 
	 * editSchoolBaseUser:(编辑用户)
	 *
	 * @param baseUser
	 * @return
	 * @author zhangtian
	 */
	public String editSchoolBaseUser(BaseUser baseUser) {

		// === 校验用户名唯一性
		Integer num = baseUserMapper.updateOrgUser(baseUser) ;
		if(num > 0) {
			return new JSONStringer().object().key("result").value(true).endObject().toString() ;
		} else {
			return new JSONStringer().object().key("result").value(true).endObject().toString() ;
		}
	}
	
	/**
	 * 
	 * getTeaUserInfo:编辑教师，获取教师用户信息
	 * @author chenjing
	 * @param baseUserId
	 * @return
	 */
	public BaseUser getTeaUserInfo(String baseUserId){
		if(StringUtils.isBlank(baseUserId)){
			return null;
		}
		BaseUser baseUser = baseUserMapper.getBaseUserById(baseUserId);
		if(baseUser == null){
			return null;
		}
		baseUser.setAreaNames(commonsMapper.getFullAreaName(baseUser.getBaseAreaId()));
		return baseUser;
	}
	
	
	private String getPassword(String password){
		if(StringUtils.isEmpty(password)){
			password = "666666";
		}
		return password;
	}
	
	private String strTrim(String str){
		if(StringUtils.isBlank(str)){
			return "";
		}else{
			return str.trim();
		}
	}
	
	private boolean userNameCheck(String userName,Map<String,String> userMap){
		if(userMap.get(userName)==null){
			return false;
		}else{
			return true;
		}
	}
	
	
	
	/**
	 * 
	 * getPermGrand:(获取用户拥有的功能)
	 * @author yangyongwu 
	 * @param orgUser
	 * @return
	 */
	private String getPermGrant(UserImportModel orgUser){
		StringBuffer permGrand = new StringBuffer(100);
		permGrand.append(",");
		if("Y".equals(orgUser.getCourseTable())){
			permGrand.append("1,");
		}
		if("Y".equals(orgUser.getBroadcastCourse())){
			permGrand.append("2,");
		}
		if("Y".equals(orgUser.getCourseAround())){
			permGrand.append("3,");
		}
		if("Y".equals(orgUser.getResourceMgr())){
			permGrand.append("4,");
		}
		if("Y".equals(orgUser.getTeachAct())){
			permGrand.append("5,");
		}
		if("Y".equals(orgUser.getStatistics())){
			permGrand.append("6,");
		}
		if("Y".equals(orgUser.getUserMgr())){
			permGrand.append("7,");
		}
		if("Y".equals(orgUser.getLowerMgr())){
			permGrand.append("8,");
		}
		if("Y".equals(orgUser.getSchoolMgr())){
			permGrand.append("9,");
		}
		if("Y".equals(orgUser.getTeacherMgr())){
			permGrand.append("10,");
		}
		if("Y".equals(orgUser.getClassroomMgr())){
			permGrand.append("11,");
		}
		return permGrand.toString();
	}
	

	public String getLockedState(String locked){
		if(StringUtils.isBlank(locked)){
			return "N";
		}
		if("N".equals(locked)){
			return "Y";
		}else if("Y".equals(locked)){
			return "N";
		}else{
			return null;
		}
	}
	

}
