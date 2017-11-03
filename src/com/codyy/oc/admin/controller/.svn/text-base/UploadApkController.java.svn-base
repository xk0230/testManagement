package com.codyy.oc.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.UploadAndroidApk;
import com.codyy.oc.admin.service.UploadApkService;
@Controller
@RequestMapping("/admin/apk/")
public class UploadApkController extends BaseController {
	
	@Autowired
	private UploadApkService uploadApkService;

	/**
	 * @author lichen
	* @Title: jumpToUploadApk
	* @Description: (跳转到上传apk页面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptouploadapk")
	public String jumpToUploadApk(){
		return "admin/uploadVersion/uploadApk";
	}
	
	@ResponseBody
	@RequestMapping("insertApk")
	public ResultJson insertApk(UploadAndroidApk apk){
		
		return uploadApkService.insertApk(apk);
	}
}
