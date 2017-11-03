package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.Type;
@Service
public class AttachmentService {
   
	@Autowired
	private AttachmentMapper AttachmentMapper;
	
	
	/**
	 * @author lichen
	* @Title: classRoomDetailBycId
	* @Description: (根据教室的id和type来获取对应的所有附件)
	* @param @param supplierId
	* @param @return    设定文件
	* @return List<Attachment>    返回类型
	* @throws
	 */
	public List<Attachment> classRoomDetailBycId(Type classRoomType){
		
		return AttachmentMapper.classRoomDetailBycId(classRoomType);
	}
	
	/**
	 * @author lichen
	* @Title: deleteAttachmentByPicName
	* @Description: (删除指定的图片)
	* @param @param attachment
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteAttachmentByPicName(Attachment attachment){
		
		return AttachmentMapper.deleteAttachmentByPicName(attachment);
	}
	
	/**
	 * @author lichen
	* @Title: qualifiListBySuId
	* @Description: (根据资源的id获取对应上传的资源内容)
	* @param @param supplierId
	* @param @return    设定文件
	* @return List<Attachment>    返回类型
	* @throws
	 */
	public List<Attachment> attachmentListByResourceId(String resourceId){
		return AttachmentMapper.qualifiListBySuId(resourceId);
	}

	public List<Attachment> getAttachByRelationshipId(String envirSurveyId) {
		return AttachmentMapper.getAttachByRelationshipId(envirSurveyId);	
	}
}
