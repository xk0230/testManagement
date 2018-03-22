/**
 * 
 */
package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.PaymentMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Payment;
import com.codyy.oc.admin.vo.PaymentVO;

/**  
 * @author Jason(pjx48476) 
 * @version: $ id:PaymentService.java, v 0.1	2018年3月22日	下午8:53:58	Jason(pjx48476) $
 * @Description: TODO  
 */

@Component("PaymentService")
public class PaymentService {

	private static final String INSERT_SUCCESS = "新增成功";
	private static final String INSERT_ERROR = "新增失败";
	private static final String UPDATE_SUCCESS = "修改成功";
	private static final String UPDATE_ERROR = "修改失败";
	private static final String DELETE_SUCCESS = "删除成功";
	private static final String DELETE_ERROR = "删除失败";
	
	@Autowired
	private PaymentMapper paymentMapper;
	
	public void insertContract(Payment record) {
		paymentMapper.insert(record);
	}
	
	/**
	 * 插入，更新合同数据
	 * @param user
	 * @param costEntityBean
	 * @return
	 */
	public JsonDto insertOrUpdatePayment(AdminUser user,Payment payment){
		
		JsonDto jsonDto = new JsonDto();
		//CostID为空时执行插入
		if(StringUtils.isBlank(payment.getId())){
			//部门ID=当前用户的部门
		    String depId = user.getDepId();
			//创建时间和创建者
		    payment.setCreateTime(DateUtils.getCurrentTimestamp());
		    payment.setCreateUser(user.getUserId());
			
		    if(StringUtils.isNotBlank(depId)) {
		    	payment.setId(UUID.randomUUID().toString());
		    	
		    	//执行插入
		    	int insertPaymentEntityNum = paymentMapper.insert(payment);
		    	if(insertPaymentEntityNum == 1) {
					jsonDto.setCode(0);
					jsonDto.setMsg(INSERT_SUCCESS);
		    	}else {
					jsonDto.setMsg(INSERT_ERROR);
		    	}
		    }
		}else{
		    payment.setCreateTime(DateUtils.getCurrentTimestamp());
		    payment.setCreateUser(user.getUserId());
		    
			int updateCostEntityNum = paymentMapper.updateByPrimaryKey(payment);
			if(updateCostEntityNum == 1){
				jsonDto.setCode(0);
				jsonDto.setMsg(UPDATE_SUCCESS);
			}else{
				jsonDto.setMsg(UPDATE_ERROR);
			}
		}
		return jsonDto;
	}
	
	/**
	 * 合同列表查询
	 * @param contract
	 * @return
	 */
	public Page getPaymentPageList(PaymentVO paymentVO){
	    Page page = new Page();
	    page.setStart(paymentVO.getStart());
	    page.setEnd(paymentVO.getEnd());
	    
	    Map<String, Object> map = new HashMap<String, Object>();

	    map.put("name", paymentVO.getName());
	    map.put("bankName", paymentVO.getBankName());
	    map.put("bankNo", paymentVO.getBankNo());
	    map.put("userId", paymentVO.getUserId());
	    map.put("startTime", paymentVO.getStartDate());
	    map.put("endTime", paymentVO.getEndDate());
	    map.put("userDepId", paymentVO.getUserDepId());
	    map.put("userPosition", paymentVO.getUserPosition());
	    
	    page.setMap(map);
	    
	    List<PaymentVO> costPageList = paymentMapper.getPaymentPageList(page);
	    page.setData(costPageList);
	    
	    return page;
	}
	
	public JsonDto deletePayment(PaymentVO payment){
		JsonDto jsonDto = new JsonDto();
		int code = paymentMapper.deleteByPrimaryKey(payment.getId());
		if(code == 1) {
			jsonDto.setCode(0);
			jsonDto.setMsg(DELETE_SUCCESS);
    	}else {
			jsonDto.setMsg(DELETE_ERROR);
    	}
		return jsonDto;
	}
	
}
