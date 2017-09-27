
package com.codyy.oc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.DeptPostLevelMapper;
import com.codyy.oc.admin.vo.DeptPostLevel;

@Service("depPostLevel")
public class DeptPostLevelService {
    
    @Autowired
    private DeptPostLevelMapper deptPostLevelMapper;
    
    public List<DeptPostLevel> getDeptPostLevel(){
        
        return deptPostLevelMapper.getDeptPostLevel();
    }
    
}

