package com.codyy.oc.admin.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.context.SpringContext;
import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminApp;
import com.codyy.oc.admin.service.AdminAppService;
import com.codyy.oc.admin.servlet.AndroidConfig;
/**
 * 
 * ClassName: AdminAppController
 * Function:移动端版本发布管理controller
 * Reason:  ADD REASON(可选)
 * date: 2015年4月1日 下午4:59:13
 * 
 * @author wangqiqi 
 * @version  
 * @since JDK 1.7
 */
@Controller
@RequestMapping("admin/app/")
public class AdminAppController extends BaseController {

	private static final Logger logger = Logger.getLogger(AdminAppController.class);
	@Autowired
	private AdminAppService appService;
	
	@RequestMapping("appVersion")
	public String index(){
		return "admin/system/appVersionManager/appVersion";
	}
	/**
	 * 
	 * listByType:根据appType查询
	 * @author wangqiqi 
	 * @param appType
	 * @return
	 */
	@ResponseBody
	@RequestMapping("list")
	public List<AdminApp> listByType(@RequestParam String appType){
		List<AdminApp> list = appService.listByType(appType);
		if(list==null){
			return new ArrayList<AdminApp>(0);
		}
		return list;
	}
	/**
	 * 
	 * addAppVersion:增加版本
	 * @author wangqiqi 
	 * @param appVersion
	 * @return
	 */
	@ResponseBody
	@RequestMapping("addAppVersion")
	public ResultJson addAppVersion(AdminApp appVersion){
		boolean flag = true;
		ResultJson result = new ResultJson(false);
		if(exits(appVersion)){
			result.setMessage("抱歉，已经存在相同的版本号！");
			return result;
		}
		String oldFileName = "";//附件随机名称
		if(appVersion.getAppType().equals(AdminApp.APP_TYPE_ANDROID_PHONE)){//ANDROID_PHONE 
			oldFileName = appVersion.getAndroidFile();
			appVersion.setAndroidFile("ANDROID_PHONE_"+appVersion.getAppVersion()+".apk");
		}else if(appVersion.getAppType().equals(AdminApp.APP_TYPE_ANDROID_PAD)){//ANDROID_PAD
			oldFileName = appVersion.getAndroidFile();
			appVersion.setAndroidFile("ANDROID_PAD_"+appVersion.getAppVersion()+".apk");
		}
		if(StringUtils.isNotBlank(oldFileName)){//有附件
			AndroidConfig config = SpringContext.getBean(AndroidConfig.class);
			String oldFile =config.getFolder()+File.separatorChar+oldFileName;//重命名附件
			String newFile =config.getFolder()+File.separatorChar+appVersion.getAndroidFile();
			File oldF= new File(oldFile);
			File newF = new File(newFile);
			oldF.renameTo(newF);
		}
		try {
			appService.addAppVersion(appVersion);
		} catch (Exception e) {
			flag = false;
			logger.error(e);
		}finally{
			result.setResult(flag);
		}
		return result ;
	}
	/**
	 * 
	 * deleteVersion:根据ID删除
	 * @author wangqiqi 
	 * @param appId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deleteVersion")
	public ResultJson deleteVersion(@RequestParam String appId){
		boolean flag = true;
		ResultJson result = new ResultJson(false);
		AdminApp load = appService.getById(appId);
		if(load.getCurrentVersion().equals(AdminApp.CURRENT_VERSION_YES)){//如果是最新版本，不允许删除
			result.setMessage("不允许删除最新版本！");
			return result;
		}
		try {
			appService.deleteVersionById(appId);
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}finally{
			result.setResult(flag);
			if(flag){
				String appType = load.getAppType();
				if(appType.equals(AdminApp.APP_TYPE_ANDROID_PHONE)||appType.equals(AdminApp.APP_TYPE_ANDROID_PAD)){//如果是android需要删除附件
					AndroidConfig config = SpringContext.getBean(AndroidConfig.class);
					String oldFile =config.getFolder()+File.separatorChar+load.getAndroidFile();
					File file= new File(oldFile);
					file.delete();
				}
				
			}
		}
		return result ;
	}
	/**
	 * 
	 * setCurrentVersion:设置为当前版本
	 * @author wangqiqi 
	 * @param appId
	 * @param appType
	 * @return
	 */
	@ResponseBody
	@RequestMapping("setCurrentVersion")
	public ResultJson setCurrentVersion(@RequestParam String appId,@RequestParam String appType){
		boolean flag = true;
		ResultJson result = new ResultJson(false);
		try {
			appService.updateCurrentVersion(appId, appType);
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}finally{
			result.setResult(flag);
		}
		return result;
	}
	/**
	 * 
	 * exits:验证是否存在相同版本号的记录
	 * @author wangqiqi 
	 * @param appVersion
	 * @return true:存在 false:不存在
	 */
	public boolean exits(AdminApp appVersion){
		
		List<AdminApp> list = appService.exits(appVersion);
		if(list.size()==0){
			return false;
		}
		return true;
	}
}
