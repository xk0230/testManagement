package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.dao.MaintenanceOrderMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.view.AttachmentView;
import com.codyy.oc.admin.view.MgOrderView;
import com.codyy.oc.admin.view.OrderDetailView;
import com.codyy.oc.admin.view.OrderReparingView;
import com.codyy.oc.admin.view.ProblemTypeView;
import com.codyy.oc.admin.view.RepairView;
import com.codyy.oc.admin.view.showOrderView;

@Service
public class MaintenanceOrderService {
     
	@Autowired
	private MaintenanceOrderMapper maintenanceOrderMapper;
	
	@Autowired
	private AttachmentMapper attachmentMapper;
	
	/**
	 * @author lichen
	* @Title: mainOrderPageList
	* @Description: (现场维修列表查询)
	* @param @return    设定文件
	* @return List<MaintenanceOrder>    返回类型
	* @throws
	 */
	/*public List<MaintenanceOrder> mainOrderPageList(Page page){
		
		return maintenanceOrderMapper.mainOrderPageList(page);
	}*/
	
	/**
	 * @author lichen
	* @Title: getDetail
	* @Description: (根据单号查询现场维修单号详情)
	* @param @param orderId
	* @param @return    设定文件
	* @return OrderDetailView    返回类型
	* @throws
	 */
	public OrderDetailView getDetail(String orderId){
		
		return maintenanceOrderMapper.getDetail(orderId);
	}
	
	/**
	 * @author lichen
	* @Title: reparingOrderPageList
	* @Description: (按条件查询现场维修)
	* @param @param page
	* @param @param orderView
	* @param @return    设定文件
	* @return List<showOrderView>    返回类型
	* @throws
	 */
	public List<showOrderView> reparingOrderPageList(Page page, OrderReparingView orderView,String userId){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("concat", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getConcat()));
		map.put("phone", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getPhone()));
		map.put("school_name", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getSchoolName()));
		map.put("schArea", orderView.getSchoolArea());
		map.put("project_name", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getProjectName()));
		map.put("proArea", orderView.getProjectArea());
		map.put("statusName", orderView.getStatus());
		map.put("userId", userId);
		page.setMap(map);
		
		return maintenanceOrderMapper.reparingOrderPageList(page);
	
	}
	
	/**
	 * @author lichen
	* @Title: exportReparingList
	* @Description: (现场维修表的导出)
	* @param @param orderView
	* @param @return    设定文件
	* @return HSSFWorkbook    返回类型
	* @throws
	 */
   public HSSFWorkbook exportReparingList(OrderReparingView orderView,String userId){
		 
	   Map<String,Object> map = new HashMap<String,Object>();
		map.put("concat", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getConcat()));
		map.put("phone", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getPhone()));
		map.put("school_name", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getSchoolName()));
		map.put("schArea", orderView.getSchoolArea());
		map.put("project_name", OracleKeyWordUtils.oracleKeyWordReplace(orderView.getProjectName()));
		map.put("proArea", orderView.getProjectArea());
		map.put("statusName", orderView.getStatus());	
		map.put("userId", userId);
		
		List<showOrderView> reparingList =maintenanceOrderMapper.exportReparing(map);
		
		for (showOrderView showOrderView : reparingList) {
			showOrderView.getMaxdataStr();
		}
	   return ExcelAnnocationUtils.exportExcelData(showOrderView.class, reparingList);
	 }
   
   
   /**
    * @author lichen
   * @Title: getOrderAttachmentById
   * @Description: (判断单号是否已上传过附件)
   * @param @param orderId
   * @param @return    设定文件
   * @return Attachment    返回类型
   * @throws
    */
   public Attachment getOrderAttachmentById(String orderId){
	   
	   return maintenanceOrderMapper.getOrderAttachmentById(orderId);
   }
   
   /**
    * @author lichen
   * @Title: insertAttachment
   * @Description: (给工单添加附件)
   * @param @param attachment
   * @param @return    设定文件
   * @return Integer    返回类型
   * @throws
    */
   public Integer insertAttachment(Attachment attachment){
	   
	   attachment.setAttachmentId(UUIDUtils.getUUID());//在service层添加随机数
	   attachment.setCreateTime(new Date());//添加日期
	   attachment.setType("baozhang");
	   return maintenanceOrderMapper.insertAttachment(attachment);
   }
   
   /**
    * @author lichen
   * @Title: delInsertAttachment
   * @Description: (覆盖已上传的文件)
   * @param @param attachment
   * @param @return    设定文件
   * @return Integer    返回类型
   * @throws
    */
   public void delInsertAttachment(Attachment attachment){
	   
	   attachment.setType("baozhang");
	   attachment.setAttachmentId(UUIDUtils.getUUID());//在service层添加随机数
	   attachment.setCreateTime(new Date());//添加日期
	   attachmentMapper.deleteAttachments(attachment.getRelationShipId());
	   maintenanceOrderMapper.insertAttachment(attachment);
   }
   
   /**
    * @author lichen
   * @Title: insertPicture
   * @Description: (将封装好的图片集合进行插入操作)
   * @param @return    设定文件
   * @return Integer    返回类型
   * @throws
    */
   public ResultJson  insertPicture(List<Attachment> attaList){
	   try{
		   if(attaList!=null && attaList.size()>0){
			   attachmentMapper.addAttachment(attaList);//插入图片集合，外加描述   
		   }
		   return new ResultJson(true);
	   }catch(Exception e){
		   
		   e.printStackTrace();
		   return new ResultJson(false);
	   }
	   
   }
   
   /**
    * @author lichen
   * @Title: deleteAttachmentByPicName
   * @Description: (删除图片)
   * @param @param attachment
   * @param @return    设定文件
   * @return Integer    返回类型
   * @throws
    */
   public ResultJson deleteAttachmentByPicName(Attachment attachment){
	   
	   try{
		   attachmentMapper.deleteAttachmentByPicName(attachment); 
		   return new ResultJson(true);
	   }catch(Exception e){
		   
		   e.printStackTrace();
		   return new ResultJson(false);
	   }
	 
   }
   
   /**
    * @author lichen
   * @Title: editPicMark
   * @Description: (进行图片的编辑操作)
   * @param @param attachmentView
   * @param @return    设定文件
   * @return ResultJson    返回类型
   * @throws
    */
   public ResultJson editPicMark(AttachmentView attachmentView){
	   
	   try{
		   maintenanceOrderMapper.editPicMark(attachmentView);
		   return new ResultJson(true);
	   }catch(Exception e){
		   
		   e.printStackTrace();
		   return new ResultJson(false);
	   }
	  
   }
   
   /**
    * @author lichen
   * @Title: selecProblemType
   * @Description: (获得所有的工单问题类型)
   * @param @return    设定文件
   * @return ProblemTypeView    返回类型
   * @throws
    */
   public List<ProblemTypeView> selecProblemType(){
	   return maintenanceOrderMapper.selecProblemType();
   }
   
   /**
    * @author lichen
   * @Title: updateRepair
   * @Description: (修改局部字段)
   * @param @param repairView
   * @param @return    设定文件
   * @return Integer    返回类型
   * @throws
    */
   public ResultJson updateRepair(RepairView repairView){
	   
	   try{
		   maintenanceOrderMapper.updateRepair(repairView);
		   return new ResultJson(true);
	   }catch(Exception e){
		   e.printStackTrace();
		   return new ResultJson(false);
	   }
	   
   }
   /**
    * @author lichen
   * @Title: getUserROrder
   * @Description: (获得指定工单的所有工程师)
   * @param @param maintenanceOrderId
   * @param @return    设定文件
   * @return List<AdminUser>    返回类型
   * @throws
    */
   public List<AdminUser> getUserROrder(String maintenanceOrderId){
	   return maintenanceOrderMapper.getUserROrder(maintenanceOrderId);
   }
   
   /**
    * @author lichen
   * @Title: getManagerByOrderId
   * @Description: (获得某个工单的项目经理)
   * @param @param orderId
   * @param @return    设定文件
   * @return ManagerOrderView    返回类型
   * @throws
    */
    public MgOrderView getManagerByOrderId(String orderId){
	   return maintenanceOrderMapper.getManagerByOrderId(orderId);
   }
    
    /**
     *@author lichen
    * @Title: getProbTypeByOrderId
    * @Description: (这里用一句话描述这个方法的作用)
    * @param @param orderId
    * @param @return    设定文件
    * @return List<ProblemTypeView>    返回类型
    * @throws
     */
    public List<ProblemTypeView> getProbTypeByOrderId(String orderId){
    	return maintenanceOrderMapper.getProbTypeByOrderId(orderId);
    }
}
