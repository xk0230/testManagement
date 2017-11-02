
package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.TransferPosition;
import com.codyy.oc.admin.service.TransferPositionService;

@Controller
@RequestMapping("/admin/transferPosition")
public class TransferPositionController extends BaseController{
    
    @Resource
    private TransferPositionService transferPositionService;
    
    @InitBinder  
    public void initBinder(WebDataBinder binder) {  
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
        dateFormat.setLenient(false);  
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
    }
    
   
    @RequestMapping("/manager.do")
    public String transferPositionManager(){
        
        return "admin/transferPosition/transferPositionManager";
    }
    
    @ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(TransferPosition transferPosition){
        
        return transferPositionService.getTransferPositionPageList(transferPosition);
        
    }
    
    @ResponseBody
    @RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
    public JsonDto insertOrUpdateCost(HttpServletRequest request,TransferPosition transferPosition){
        
        return transferPositionService.insertOrUpdateTransferPositionEntity(this.getSessionUser(request),transferPosition);
    }
    
    @ResponseBody
    @RequestMapping("/del/{id}.do")
    public JsonDto delTransferPositionEntityById(@PathVariable String id){
        
        return transferPositionService.delTransferPositionEntityById(id);
        
    }
    
    @ResponseBody
    @RequestMapping("/get/{id}.do")
    public JsonDto getTransferPositionEntityById(@PathVariable String id){
        
        return transferPositionService.getTransferPositionEntityById(id);
        
    }
    
}

