package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.Department;
import com.codyy.oc.admin.service.DepartmentService;

@Controller
@RequestMapping("/admin/dep/")
public class DepController extends BaseController {
	
	
	@Autowired
	private DepartmentService service;
	
	
	/**
	 * 
	 * 获取所有部门
	 * @param request
	 * @param adUser
	 * @return
	 */
	@RequestMapping("getAlldep")
	@ResponseBody
	public List<Department>  testimg(HttpServletRequest request ){
		return service.getAllDepartment();
	}
	
}
