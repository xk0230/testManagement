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
import com.codyy.oc.admin.dao.AdminUserTrainDaoMapper;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.AdminUserTrain;

@Service("userTrainService")
public class AdminUserTrainService {
	
	private static final String INSERT_SUCCESS = "保存成功";
    private static final String INSERT_ERROR = "保存失败";
    private static final String UPDATE_SUCCESS = "修改成功";
    private static final String UPDATE_ERROR = "修改失败";
    private static final String DEL_SUCCESS = "删除成功";
    private static final String DEL_ERROR = "删除失败";
    private static final String NO_EXIT_DATA = "数据不存在";
	
	@Autowired
	private AdminUserTrainDaoMapper userTrainDaoMapper;

	public Page getTrainPageList(AdminUserTrain train) {
		
		Page page = new Page();
        page.setStart(train.getStart());
        page.setEnd(train.getEnd());
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", train.getUserId());
        map.put("project", train.getProject());
        page.setMap(map);
        
        List<AdminUserTrain> trainList = userTrainDaoMapper.getAdminUserTrainPageList(page);
        
        page.setData(trainList);
        
        return page;
		
	}

	public JsonDto insertOrUpdateTrainEntity(AdminUser sessionUser,
			AdminUserTrain train) {
		
		JsonDto jsonDto = new JsonDto();
	        
        if(StringUtils.isBlank(train.getId())){
            
        	train.setCreateTime(DateUtils.getCurrentTimestamp());
        	train.setId(UUID.randomUUID().toString());
            
        	int insNum = userTrainDaoMapper.saveUserTrain(train);
        	if(insNum == 1){
	            jsonDto.setCode(0);
	            jsonDto.setMsg(INSERT_SUCCESS);
        	}else {
        		jsonDto.setCode(1);
        		jsonDto.setMsg(INSERT_ERROR);
        	}
        }else{
            int num = userTrainDaoMapper.updateUserTrain(train);;
            if(num == 1){
                jsonDto.setCode(0);
                jsonDto.setMsg(UPDATE_SUCCESS);
            }else{
            	jsonDto.setCode(1);
                jsonDto.setMsg(UPDATE_ERROR);
            }
        }
        return jsonDto;
	}

	public JsonDto delTrainEntityById(String id) {
		JsonDto jsonDto = new JsonDto();
		int delNum = userTrainDaoMapper.deleteUserTrain(id);
        
        if(delNum == 1){
            jsonDto.setCode(0);
            jsonDto.setMsg(DEL_SUCCESS);
        }else{
        	jsonDto.setCode(1);
            jsonDto.setMsg(DEL_ERROR);
        }
        
        return jsonDto;
	}
}
