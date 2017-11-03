package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.EquipmentDelivery;
import com.codyy.oc.admin.entity.MaintenanceOrder;
import com.codyy.oc.admin.entity.UserROrder;
import com.codyy.oc.admin.view.AttachmentView;
import com.codyy.oc.admin.view.MgOrderView;
import com.codyy.oc.admin.view.OrderDetailView;
import com.codyy.oc.admin.view.ProblemRMainTenance;
import com.codyy.oc.admin.view.ProblemTypeView;
import com.codyy.oc.admin.view.RepairView;
import com.codyy.oc.admin.view.SearchSchoolInfoView;
import com.codyy.oc.admin.view.WorkOrderView;
import com.codyy.oc.admin.view.showOrderView;

public interface MaintenanceOrderMapper {
  
    
    /**
     * @author lichen
    * @Title: mainOrderList
    * @Description: (查询工单列表在现场维修模块的所有字段)
    * @param @return    设定文件
    * @return List<MaintenanceOrder>    返回类型
    * @throws
     */
   // public List<MaintenanceOrder> mainOrderPageList(Page page);
    
    /**
     * @author lichen
    * @Title: getDetail
    * @Description: (查询现场维修详情)
    * @param @param orderId
    * @param @return    设定文件
    * @return OrderDetailView    返回类型
    * @throws
     */
    public OrderDetailView getDetail(String orderId);
    
    /**
     * @author lichen
    * @Title: exportReparing
    * @Description: (实现现场维修的列表导出操作)
    * @param @param map
    * @param @return    设定文件
    * @return List<showOrderView>    返回类型
    * @throws
     */
    public List<showOrderView> exportReparing(Map<String,Object> map);
    
    /**
     * @author lichen
    * @Title: getOrderAttachmentById
    * @Description: (在用户上传文件的时候进行验证本工单是否已有上传的文件)
    * @param @param orderId
    * @param @return    设定文件
    * @return Attachment    返回类型
    * @throws
     */
    public Attachment getOrderAttachmentById(String orderId);
    
    /**
     * @author lichen
    * @Title: insertAttachment
    * @Description: (插入工单表上传的记录)
    * @param @param attachment
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
    public Integer insertAttachment(Attachment attachment);
    
    /**
     * @author lichen
    * @Title: delInsertAttachment
    * @Description: (若附件存在根据id来删除原有的图片再插入新上传的文件)
    * @param @param attachment
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
    public Integer delInsertAttachment(Attachment attachment);
    

	public int insertSelective(MaintenanceOrder mOrder);

	public void addEquipDelivery(List<EquipmentDelivery> eDeliveries);

	public void addUserROrder(List<UserROrder> userROrders);

	public int checkOrderNum(String orderNum);
	
	/**
	 * @author lichen
	* @Title: reparingOrderPageList
	* @Description: (实现多重条件查询分页)
	* @param @param page
	* @param @return    设定文件
	* @return List<showOrderView>    返回类型
	* @throws
	 */
	public List<showOrderView> reparingOrderPageList(Page page);
	
	/**
	 * @author lichen
	* @Title: editPicMark
	* @Description: (进行图片的编辑操作)
	* @param @param attachmentView
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer editPicMark(AttachmentView attachmentView);
	

	public List<WorkOrderView> getWorkOrderPageList(Page page);

	public List<WorkOrderView> exportWorkOrderList(Map<String, Object> map);

	public WorkOrderView getWorkOrderById(String maintenanceOrderId);

	public List<AdminUser> getUserROrder(String maintenanceOrderId);

	public List<EquipmentDelivery> getEquipDelivery(String maintenanceOrderId);

	public List<AdminUser> getEngineersById(List<String> strs);

	public int updateByPrimaryKeySelective(MaintenanceOrder mOrder);

	public void updateUserROrder(List<UserROrder> userROrders);

	public void updateEquipDelivery(List<EquipmentDelivery> eDeliveries);

	public void deleteUserROrder(String maintenanceOrderId);

	public void deleteEquipDelivery(String maintenanceOrderId);

	public int deleteByPrimaryKey(String maintenanceOrderId);

	public void deleteWorkOrder(String maintenanceOrderId);

	public List<Attachment> downloadPicture(Map<String, Object> map);

	public List<Attachment> getPicturesPageList(Page page);

	public void deleteAttachment(String maintenanceOrderId);

	public Integer checkWorkOrderBySchoolId(String clsSchoolId);

	public Integer checkUserROrder(String maintenanceOrderId);

	public Integer checkEquipDelivery(String maintenanceOrderId);

	public List<AdminUser> getEngineerPageList(Page page);
	
	/**
	 * @author lichen
	* @Title: selecProblemType
	* @Description: (获得所有的问题类型)
	* @param @return    设定文件
	* @return ProblemTypeView    返回类型
	* @throws
	 */
	public List<ProblemTypeView> selecProblemType();
	
	/**
	 * @author lichen
	* @Title: getOrderNum
	* @Description: (自动生成工单号)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String getOrderNum();
	
	/**
	 * @author lichen
	* @Title: insertProblemType
	* @Description:(循环插入问题类型到对应的工单)
	* @param @param ProblemRMainList
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertProblemType(List<ProblemRMainTenance> ProblemRMainList);
	
	/**
	 * @author lichen
	* @Title: updateRepair
	* @Description: (县城维修修改局部字段)
	* @param @param repairView
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer updateRepair(RepairView repairView);
	
	/**
	 * @author lichen
	* @Title: getManagerByOrderId
	* @Description: (获得指定工单的项目经理)
	* @param @param orderId
	* @param @return    设定文件
	* @return ManagerOrderView    返回类型
	* @throws
	 */
	public MgOrderView getManagerByOrderId(String orderId);
	
	/**
	 * @author lichen
	* @Title: searchSchoolPageList
	* @Description: (搜索学校并实现项目区域地址回填)
	* @param @param page
	* @param @return    设定文件
	* @return List<SearchSchoolInfoView>    返回类型
	* @throws
	 */
	public List<SearchSchoolInfoView> searchSchoolPageList(Page page);
	
	
	/**
	 * @author lichen
	* @Title: getProbTypeByOrderId
	* @Description: (获得指定工单对应的所有问题类型)
	* @param @param orderId
	* @param @return    设定文件
	* @return List<ProblemTypeView>    返回类型
	* @throws
	 */
	public List<ProblemTypeView> getProbTypeByOrderId(String orderId);
	
	/**
	 * @author lichen
	 * 获得工单创建人信息
	 */
	public String getOrderSumitter(String orderId);
	
	/**
	 * @author lichen
	* @Title: deleProblemById
	* @Description: (删除指定工单对应的问题类型)
	* @param @param orderId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleProblemById(String orderId);

	public Integer getSignCountByOrderId(String maintenanceOrderId);
	
}