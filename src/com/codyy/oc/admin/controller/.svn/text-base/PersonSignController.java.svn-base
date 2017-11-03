package com.codyy.oc.admin.controller;

import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.service.SignService;
import com.codyy.oc.admin.view.ShowNewSignMessageView;
import com.codyy.oc.admin.view.SignDetailView;
import com.codyy.oc.admin.view.SignView;

@Controller
@RequestMapping("/admin/personsigncontroller/")
public class PersonSignController {
	
	@Autowired
	private SignService signService;

	/**
	 * @author lichen
	* @Title: jumpToSignList
	* @Description: (跳转到签到列表)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptosignlist")
	public String jumpToSignList(){
		
		return "admin/signStatus/signStatusList";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToSignDetail
	* @Description: (跳转到指定用户的所有项目的详情页)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptosigndetail")
	public String jumpToSignDetail(HttpServletRequest request,String userId){
		request.setAttribute("uId", userId);
		return "admin/signStatus/PersonSignDetail";
	}
	
	/**
	 * @author lichen
	* @Title: showSignMessage
	* @Description: (获得签到表的最新签到记录)
	* @param @param page
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("showsignmessage")
	public Page showSignMessage(Page page,SignView signView,String sortDesc){
		
		List<ShowNewSignMessageView> showSignList =signService.showNewSignPageList(page,signView,sortDesc);
		page.setData(showSignList);
		return page;
	}
	
	
	/**
	 * @author lichen
	* @Title: selcSignDetail
	* @Description: (获得指定用户的所有分页签到信息)
	* @param @param userId
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selcsigndetail")
	public Page selcSignDetail(String userId,String maintenanceOrderId,Page page){
		
		List<SignDetailView> sigDetaiList = signService.selcSignDetailPageList(page, userId,maintenanceOrderId);
		page.setData(sigDetaiList);
		return page;
	}
	
	/**
	 * @author lichen
	* @Title: exportNewSignList
	* @Description: (导出所有最新签到信息)
	* @param @param signView
	* @param @param sortDesc
	* @param @param response    设定文件
	* @return void    返回类型
	* @throws
	 */
	@RequestMapping("exportnewsignlist")
	public void exportNewSignList(String sortDesc,HttpServletResponse response,SignView signView){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportAllNewSign.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=signService.exportAllSignList(sortDesc,signView);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author lichen
	* @Title: exportSignDetailList
	* @Description: (导出指定工程师参与的所有项目签到)
	* @param @param userId
	* @param @param response    设定文件
	* @return void    返回类型
	* @throws
	 */
	@RequestMapping("exportsigndetaillist")
	public void exportSignDetailList(String userId,HttpServletResponse response){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportDetailNewSign.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=signService.exportDetailList(userId);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author lichen
	* @Title: jumpToWorkerSignInfo
	* @Description:(跳转到工单签到列表显示)
	* @param @param maintenanceOrderId
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoworkersigninfo")
	public String jumpToWorkerSignInfo(String maintenanceOrderId,HttpServletRequest request){
		request.setAttribute("maintenanceOrderId", maintenanceOrderId);
		return "admin/workOrderManager/WorkerSignDetail";
	}
	
	
	/**
	 * @author lichen
	* @Title: getSignPic
	* @Description: (获得签到上传图片的集合)
	* @param @param signId
	* @param @return    设定文件
	* @return List<Attachment>    返回类型
	* @throws
	 */
	@RequestMapping("getsignpic")
	 public String getSignPic(String signId,HttpServletRequest request){
		List<Attachment> attList=signService.getSignPic(signId);
		request.setAttribute("picture", attList);
		 return "admin/workOrderManager/viewPicture";
	 }
	
}
