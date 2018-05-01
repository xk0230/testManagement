package com.codyy.oc.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
import com.codyy.oc.admin.entity.Book;
import com.codyy.oc.admin.entity.BookHistory;
import com.codyy.oc.admin.service.BookService;
import com.codyy.oc.admin.service.CostService;
import com.codyy.oc.admin.vo.BookVO;

/**
 * 图书管理
 * @author Administrator
 *
 */

@Controller
@RequestMapping("/admin/book")
public class BookController extends BaseController{

	@Resource
	private CostService costService;
	
	@Resource
	private BookService bookService;
	
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	@RequestMapping("/manager.do")
	public String bookManager(){
		
		return "admin/book/bookManager";
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveOrUpdate.do",method = RequestMethod.POST)
	public JsonDto insertOrUpdateCost(HttpServletRequest request,Book book){
		
		return bookService.insertOrUpdateBookEntity(this.getSessionUser(request),book);
	}
	
	
	@ResponseBody
	@RequestMapping("/getOrBack/{id}.do")
	public JsonDto getOrBack(HttpServletRequest request,@PathVariable String id){
		return bookService.putOrBack(this.getSessionUserId(request),id);
		
	}
	
	@ResponseBody
	@RequestMapping("/get/{costId}.do")
	public JsonDto getBookEntityById(@PathVariable String costId){
		
		return bookService.getBookEntityById(costId);
		
	}
	
	@ResponseBody
    @RequestMapping("/page.do")
    public Page getCostPageList(BookVO cost){
        
        return bookService.getBookPageList(cost);
        
    }
	
	
	@ResponseBody
	@RequestMapping("/gethistory.do")
	public List<BookHistory> getBookHistory(BookHistory bh){
		
		return bookService.getHistory(bh);
		
	}
	
	
	
}
