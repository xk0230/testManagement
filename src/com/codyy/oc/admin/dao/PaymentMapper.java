package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Payment;
import com.codyy.oc.admin.vo.PaymentVO;

public interface PaymentMapper {
    int deleteByPrimaryKey(String id);

    int insert(Payment record);

    int insertSelective(Payment record);

    Payment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Payment record);

    int updateByPrimaryKey(Payment record);
	List<PaymentVO> getPaymentPageList(Page page);
}