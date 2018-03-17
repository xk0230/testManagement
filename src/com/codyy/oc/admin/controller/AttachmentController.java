
package com.codyy.oc.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
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

    @RequestMapping("/contractManager.do")
    public String contractAttachmentManager(Model model,String contractId){
        
        model.addAttribute("contractId", contractId);
        
        return "admin/attachment/contractAttachmentManager";
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
   public ResponseEntity<byte[]> downLoad(HttpServletRequest request,String id){
       
       JsonDto dto = attachmentService.getAttachmentEntityById(id);
       if(dto.getCode() == 0){
           AttachmentEntity attachmentEntity = (AttachmentEntity)dto.getObjData();
           String location = attachmentEntity.getLocation();
           File file = new File(location);
           try {
               HttpHeaders headers = new HttpHeaders();
               headers.add("Content-Disposition", "attachment;filename=" + encodeChineseDownloadFileName(request, attachmentEntity.getName()));
               //headers.setContentDispositionFormData("attachment", new String(attachmentEntity.getName().getBytes("UTF-8"),"iso-8859-1"));
               headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
               ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
               return responseEntity ;
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
       
       return null;
   }
   
   @RequestMapping("/preview.do")
   public ResponseEntity<byte[]> preview(String id){
       
       JsonDto dto = attachmentService.getAttachmentEntityById(id);
       if(dto.getCode() == 0){
           AttachmentEntity attachmentEntity = (AttachmentEntity)dto.getObjData();
           String location = attachmentEntity.getLocation();
           File file = new File(location);
           try {
               HttpHeaders headers = new HttpHeaders();
               if(attachmentEntity.getType().equals("1")){
                   headers.setContentType(MediaType.parseMediaType("application/pdf"));
               }else{
                   String name = attachmentEntity.getName();
                   String picType = StringUtils.substringAfterLast(name, ".");
                   if("jpg".equals(picType)){
                	   picType = "jpeg";
                   }
                   headers.setContentType(MediaType.parseMediaType("image/"+picType));
               }
               ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
               return responseEntity ;
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
       
       return null;
   }
   
   private String encodeChineseDownloadFileName(  
           HttpServletRequest request, String pFileName) throws UnsupportedEncodingException {  
         
        String filename = null;    
        String agent = request.getHeader("USER-AGENT");    
        if (null != agent){    
           if (-1 != agent.indexOf("Firefox")) {//Firefox    
               filename = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(pFileName.getBytes("UTF-8"))))+ "?=";    
           }else if (-1 != agent.indexOf("Chrome")) {//Chrome    
               filename = new String(pFileName.getBytes(), "ISO8859-1");    
           } else {//IE7+    
               filename = java.net.URLEncoder.encode(pFileName, "UTF-8");    
               filename = StringUtils.replace(filename, "+", "%20");//替换空格    
           }    
       } else {    
           filename = pFileName;    
       }    
       return filename;   
   }
}

