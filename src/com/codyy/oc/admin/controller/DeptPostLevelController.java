
package com.codyy.oc.admin.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.service.DeptPostLevelService;
import com.codyy.oc.admin.vo.DeptPostLevel;

/**
 * 部门岗位等级分布
 */
@Controller
@RequestMapping("/admin/depPostLevel")
public class DeptPostLevelController extends BaseController{
   
    @Resource
    private DeptPostLevelService depPostLevel;
    
    @RequestMapping("/distribute.do")
    public String costManager(Model model){
        
        List<DeptPostLevel> deptPostLevels = depPostLevel.getDeptPostLevel();
        
        model.addAttribute("deptPostLevels", deptPostLevels);
        
        return "admin/depPostLevel/distribute";
    }
    
    
}

