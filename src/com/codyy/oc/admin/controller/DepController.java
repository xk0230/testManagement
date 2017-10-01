package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.utils.ResultJson;
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
	
	@RequestMapping("hasManager")
	@ResponseBody
	public ResultJson  hasManager(HttpServletRequest request,@RequestParam(required=true) String depId ){
		int num = service.hasManager(depId);
		if(num > 0) {
			//获取部门经理Id
			return new ResultJson(true,service.getDepManagerId(depId));
		}else {
			return new ResultJson(true,"N");
		}
	}
}
