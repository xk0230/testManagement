
package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.TransferPosition;


public interface TransferPositionDaoMapper {

    void insertTransferPositionEntity(TransferPosition transferPosition);

    int updateTransferPositionEntity(TransferPosition transferPosition);
    
    TransferPosition getTransferPositionEntityById(String id);
    
    void delTransferPositionEntityById(String id);
    
    List<TransferPosition> getTransferPositionPageList(Page page);
    
    
}

