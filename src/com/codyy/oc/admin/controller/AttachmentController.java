
package com.codyy.oc.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dto.JsonDto;
import com.codyy.oc.admin.entity.AttachmentEntity;
import com.codyy.oc.admin.service.AttachmentService;


@Controller
@RequestMapping("/admin/attachment")
public class AttachmentController extends BaseController{
    
    @Resource
    private AttachmentService attachmentService;
    
    @InitBinder  
    public void initBinder(WebDataBinder binder) {  
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
        dateFormat.setLenient(false);  
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
   }
   
   @RequestMapping("/manager.do")
   public String attachmentManager(Model model,String userId){
       
       model.addAttribute("userId", userId);
       
       return "admin/attachment/attachmentManager";
   }
    
   @ResponseBody
   @RequestMapping("/page.do")
   public Page getAttachmentEntityPageList(AttachmentEntity attachmentEntity){
       
       return attachmentService.getAttachmentEntityPageList(attachmentEntity);
       
   }
   
   @ResponseBody
   @RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
   public JsonDto insertOrUpdateAttachmentEntity(HttpServletRequest request,MultipartFile uploadFile,AttachmentEntity attachmentEntity){
       
       return attachmentService.insertOrUpdateAttachmentEntity(request,uploadFile,attachmentEntity);
   }
   
   @ResponseBody
   @RequestMapping("/del/{id}.do")
   public JsonDto delAttachmentEntityById(@PathVariable String id){
       
       return attachmentService.delAttachmentEntityById(id);
       
   }
   
   @ResponseBody
   @RequestMapping("/get/{id}.do")
   public JsonDto getAttachmentEntityById(@PathVariable String id){
       
       return attachmentService.getAttachmentEntityById(id);
       
   }
   
   @RequestMapping("/download.do")
   public ResponseEntity<byte[]> downLoad(String id){
       
       JsonDto dto = attachmentService.getAttachmentEntityById(id);
       if(dto.getCode() == 0){
           AttachmentEntity attachmentEntity = (AttachmentEntity)dto.getObjData();
           String location = attachmentEntity.getLocation();
           File file = new File(location);
           try {
               HttpHeaders headers = new HttpHeaders();
               headers.setContentDispositionFormData("attachment", new String(attachmentEntity.getName().getBytes("UTF-8"),"iso-8859-1"));
               headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
               ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
               return responseEntity ;
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
       
       return null;
   }
   
}

