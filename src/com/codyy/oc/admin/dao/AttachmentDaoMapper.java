
package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.AttachmentEntity;


public interface AttachmentDaoMapper {
    
	int insertAttachmentEntity(AttachmentEntity attachment);

    int updateAttachmentEntity(AttachmentEntity attachment);
    
    AttachmentEntity getAttachmentEntityById(String id);
    
    void delAttachmentEntityById(String id);
    
    List<AttachmentEntity> getAttachmentEntityPageList(Page page);
    
}

