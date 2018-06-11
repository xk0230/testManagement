
package com.codyy.oc.admin.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.AttachmentDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AttachmentEntity;


@Service("attachmentService")
public class AttachmentService {
    
    @Autowired
    private AttachmentDaoMapper attachmentDaoMapper;
    
    private static final String INSERT_SUCCESS = "保存成功";
    private static final String INSERT_ERROR = "保存失败";
    private static final String UPDATE_SUCCESS = "修改成功";
    private static final String UPDATE_ERROR = "修改失败";
    private static final String DEL_SUCCESS = "删除成功";
    private static final String DEL_ERROR = "删除失败";
    private static final String NO_EXIT_DATA = "数据不存在";
    
    
    /**
     * 获取记录列表
     * @param attachmentEntity
     * @return
     */
    public Page getAttachmentEntityPageList(AttachmentEntity attachmentEntity) {
       
        Page page = new Page();
        page.setStart(attachmentEntity.getStart());
        page.setEnd(attachmentEntity.getEnd());
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fId", attachmentEntity.getfId());
        map.put("name", attachmentEntity.getName());
        map.put("type", attachmentEntity.getType());
        map.put("startDate", attachmentEntity.getStartDate());
        map.put("endDate", attachmentEntity.getEndDate());
        
        page.setMap(map);
        
        List<AttachmentEntity> attachmentList = attachmentDaoMapper.getAttachmentEntityPageList(page);
        page.setData(attachmentList);
        
        return page;
        
    }

    /**
     * 保存更新记录
     * @param sessionUser
     * @param attachmentEntity
     * @return
     */
    public JsonDto insertOrUpdateAttachmentEntity(HttpServletRequest request,MultipartFile uploadFile,AttachmentEntity attachmentEntity)
    {

        JsonDto jsonDto = new JsonDto();
        
        if(uploadFile!=null){
            
            String uuid = UUID.randomUUID().toString();
            try {
                String originalFilename = uploadFile.getOriginalFilename();
                String realPath = request.getServletContext().getRealPath("/")+"upload/";
                if(StringUtils.isBlank(realPath)){
                    realPath = "d:\\upload\\";
                }
                
                File fileDire = new File(realPath);
                if(!fileDire.exists()){
                    fileDire.mkdirs();
                }
                
                String fileName = uuid +"-"+originalFilename;
                
                attachmentEntity.setName(originalFilename);
                attachmentEntity.setLocation(realPath + fileName);
                
                File file = new File(realPath, fileName);
                uploadFile.transferTo(file);
                
                //如果fid为myoc则为附件查找对应的id
                if("myoc".equals(attachmentEntity.getfId())){
                	List<AttachmentEntity> ats =  attachmentDaoMapper.getAttachmentEntityByFId(attachmentEntity.getfId());
                	if(ats!=null &&ats.size()>0){
                		attachmentEntity.setId(ats.get(0).getId());
                	}
                }
                
                if(StringUtils.isBlank(attachmentEntity.getId())){
                    
                    attachmentEntity.setCreateTime(DateUtils.getCurrentTimestamp());
                    attachmentEntity.setId(uuid);
                    
                    int insNum = attachmentDaoMapper.insertAttachmentEntity(attachmentEntity);
                    if(insNum == 1){
                        jsonDto.setCode(0);
                        jsonDto.setMsg(INSERT_SUCCESS);
                    }else{
                        jsonDto.setMsg(INSERT_ERROR);
                    }
                }else{
                    int num = attachmentDaoMapper.updateAttachmentEntity(attachmentEntity);
                    if(num == 1){
                        jsonDto.setCode(0);
                        jsonDto.setMsg(UPDATE_SUCCESS);
                    }else{
                        jsonDto.setMsg(UPDATE_ERROR);
                    }
                }
            }catch (Exception e) {
                jsonDto.setMsg(INSERT_ERROR);
                e.printStackTrace();
            }
        }else{
        	int num = attachmentDaoMapper.updateAttachmentEntity(attachmentEntity);
            if(num == 1){
                jsonDto.setCode(0);
                jsonDto.setMsg(UPDATE_SUCCESS);
            }else{
                jsonDto.setMsg(UPDATE_ERROR);
            }
            //jsonDto.setMsg("请选择上传文件"); 
        }
        
        return jsonDto;
        
    }
    
    public JsonDto getAttachmentEntityById(String id){
        
        JsonDto jsonDto = new JsonDto();
        AttachmentEntity attachmentEntity = attachmentDaoMapper.getAttachmentEntityById(id);
        if(attachmentEntity != null){
            jsonDto.setCode(0);
            jsonDto.setObjData(attachmentEntity);
        }else{
            jsonDto.setMsg(NO_EXIT_DATA);
        }
        
        return jsonDto;
        
    }
    
    public AttachmentEntity getAttachmentEntityByFId(String id){
        List<AttachmentEntity> attachmentEntity = attachmentDaoMapper.getAttachmentEntityByFId(id);
        if(attachmentEntity != null && attachmentEntity.size()>0 ){
            return (attachmentEntity.get(0));
        }else{
            return new AttachmentEntity() ;
        }
    }

    public JsonDto delAttachmentEntityById(String id){
        
        JsonDto jsonDto = new JsonDto();
        attachmentDaoMapper.delAttachmentEntityById(id);
        jsonDto.setCode(0);
        
        return jsonDto;
    }
    
}

