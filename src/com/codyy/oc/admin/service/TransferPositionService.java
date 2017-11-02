
package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.DateUtils;
import com.codyy.oc.admin.dao.TransferPositionDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.TransferPosition;

@Service("transferPositionService")
public class TransferPositionService {
    
    private static final String INSERT_SUCCESS = "保存成功";
    private static final String INSERT_ERROR = "保存失败";
    private static final String UPDATE_SUCCESS = "修改成功";
    private static final String UPDATE_ERROR = "修改失败";
    private static final String DEL_SUCCESS = "删除成功";
    private static final String DEL_ERROR = "删除失败";
    private static final String NO_EXIT_DATA = "数据不存在";

    @Autowired
    private TransferPositionDaoMapper transferPositionDaoMapper;
    
    /**
     * 获取调岗记录列表
     * @param transferPosition
     * @return
     */
    public Page getTransferPositionPageList(TransferPosition transferPosition) {
       
        Page page = new Page();
        page.setStart(transferPosition.getStart());
        page.setEnd(transferPosition.getEnd());
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", transferPosition.getUserId());
        map.put("startDate", transferPosition.getStartDate());
        map.put("endDate", transferPosition.getEndDate());
        
        page.setMap(map);
        
        List<TransferPosition> transferPositionPageList = transferPositionDaoMapper.getTransferPositionPageList(page);
        if(CollectionUtils.isNotEmpty(transferPositionPageList)){
            for(int i = 0;i<transferPositionPageList.size();i++){
                transferPositionPageList.get(i).setOrder(i+1);
            }
        }
        
        page.setData(transferPositionPageList);
        
        return page;
        
    }

    /**
     * 保存更新记录
     * @param sessionUser
     * @param transferPosition
     * @return
     */
    public JsonDto insertOrUpdateTransferPositionEntity(AdminUser sessionUser,TransferPosition transferPosition)
    {

        JsonDto jsonDto = new JsonDto();
        
        if(StringUtils.isBlank(transferPosition.getId())){
            
            transferPosition.setCreateTime(DateUtils.getCurrentTimestamp());
            transferPosition.setId(UUID.randomUUID().toString());
            
            transferPositionDaoMapper.insertTransferPositionEntity(transferPosition);
            
            jsonDto.setCode(0);
            
        }else{
            int updateCostEntityNum = transferPositionDaoMapper.updateTransferPositionEntity(transferPosition);
            if(updateCostEntityNum == 1){
                jsonDto.setCode(0);
                jsonDto.setMsg(UPDATE_SUCCESS);
            }else{
                jsonDto.setMsg(UPDATE_ERROR);
            }
        }
        
        return jsonDto;
        
    }
    
    public JsonDto getTransferPositionEntityById(String id){
        
        JsonDto jsonDto = new JsonDto();
        TransferPosition transferPosition = transferPositionDaoMapper.getTransferPositionEntityById(id);
        if(transferPosition != null){
            jsonDto.setCode(0);
            jsonDto.setObjData(transferPosition);
        }else{
            jsonDto.setMsg(NO_EXIT_DATA);
        }
        
        return jsonDto;
        
    }

    public JsonDto delTransferPositionEntityById(String id){
        
        JsonDto jsonDto = new JsonDto();
        transferPositionDaoMapper.delTransferPositionEntityById(id);
        jsonDto.setCode(0);
        
        return jsonDto;
    }
    
    
}

