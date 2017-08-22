package com.codyy.oc.admin.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.RegionalResource;
import com.codyy.oc.admin.service.AttachmentService;
import com.codyy.oc.admin.service.BaseAreaService;
import com.codyy.oc.admin.service.RegionalResourceService;
import com.codyy.oc.admin.view.SelectModel;

/**
 * 
 * @author zhangshuangquan
 * @version
 * @since JDK 1.7
 */
@Controller
@RequestMapping("/admin/area/")
public class AreaController extends BaseController {

	@Autowired
	private BaseAreaService baseAreaService;
	
	@Autowired
	private RegionalResourceService regionalResourceService;
	
	@Autowired
	private AttachmentService attachmentService;


	/**
	 * 
		* @author zhangshuangquan
		* @Title: getBaseAreaByParentId
		* @Description: (获取区域列表)
		* @param  parentId   
		* @return  List<SelectModel>
	 */
	@ResponseBody
	@RequestMapping("getBaseAreaByParentId")
	public List<SelectModel> getBaseAreaByParentId(String parentId){
		return baseAreaService.getBaseAreaByParentId(parentId);
	}
	
	@ResponseBody
	@RequestMapping("getBaseArea")
	public List<SelectModel> getBaseArea(String id){
		return baseAreaService.getBaseArea(id);
	}
	
	/**
	 * @author lichen
	* @Title: jumpToListArea
	* @Description: (区域资源跳转)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptolistarea")
	public String jumpToListArea(){

		//return "admin/resource/addAreaResource";
	  return "admin/resource/showAreaResourceList";
	}
	
	
	/**
	 * @author lichen
	* @Title: jumpToEditPage
	* @Description: (跳转到区域资源编辑界面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoeditpage")
	public String jumpToEditPage(HttpServletRequest request,String regionalResourceId){
		RegionalResource regionalResource =regionalResourceService.selcRegResById(regionalResourceId);
		//获取资源对应的附件信息
		List<Attachment> attachList =attachmentService.attachmentListByResourceId(regionalResourceId);
		request.setAttribute("attachList",attachList );
		request.setAttribute("regresObj",regionalResource );
		return "admin/resource/editAreaResource";
	}
	
	
	/**
	 * @author lichen
	* @Title: jumpToDetailPage
	* @Description: (跳转到对应的资源详情页面)
	* @param @param request
	* @param @param regionalResourceId
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptodetailpage")
	public String jumpToDetailPage(HttpServletRequest request,String regionalResourceId){
		RegionalResource regionalResource =regionalResourceService.selcRegResById(regionalResourceId);
		//获取资源对应的附件信息
	    List<Attachment> attachList =attachmentService.attachmentListByResourceId(regionalResourceId);
		request.setAttribute("attachList",attachList );
		request.setAttribute("regresObj",regionalResource );
		return "admin/resource/showAreaResourceDetail";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToAddList
	* @Description: (跳转到资源添加列表)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoaddlist")
	public String jumpToAddList(){
		
		return "admin/resource/addAreaResource";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToSelcProj
	* @Description: (点击添加项目按钮跳转到项目列表选择页面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoselcproj")
	public String jumpToSelcProj(){
		
		return "admin/resource/showProjList";
	}
	
	
	/**
	 * @author lichen
	* @Title: jumpToEditSelecPro
	* @Description: (跳转到项目编辑选择页面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoeditselecpro")
	public String jumpToEditSelecPro(){
		
		return "admin/resource/editProjectList";
	}
	
	/**
	 * 行政区管理首页
	 * 
	 * @author Gwang
	 * @return
	 *//*
	@RequestMapping("index")
	public String index() {
		return "admin/system/areaManager/area_list";
	}

	*//**
	 * 获取各级行政区
	 * 
	 * @author Gwang
	 * @param parentId
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("areaTree")
	public List<BaseArea> areaTree(String parentId) {
		return areaService.getAreaByparentId(parentId);
	}


	*//**
	 * 添加行政区
	 * 
	 * @author Gwang
	 * @param area
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("areaCreate")
	public ResultJson areaCreate(BaseArea area, BaseUser baseUser, HttpServletRequest request) {
		if (areaCreateCheck(area)) {
			try {
				// 设定等级
				if (StringUtils.isNotBlank(area.getParentId())) {
					BaseArea pArea = areaService.getAreaById(area.getParentId());
					if (pArea != null) {
						area.setAreaLevel(pArea.getAreaLevel() + 1);
					} else {
						return new ResultJson(false, "参数错误！");
					}
				} else {
					area.setAreaLevel(1);
				}
				// 重名判断
				Map<String, Object> selMap = new HashMap<String, Object>();
				selMap.put("type", "name");
				selMap.put("value", area.getAreaName());
				if (areaService.getAreaByProperty(selMap) != null) {
					return new ResultJson(false, "很抱歉，行政区名称已存在，请重新输入！");
				}
				selMap.put("type", "code");
				selMap.put("value", area.getAreaCode());
				if (areaService.getAreaByProperty(selMap) != null) {
					return new ResultJson(false, "很抱歉，行政区代码存在，请重新输入！");
				}
				baseUser.setCreateUserId(getSessionUserId(request));
				return areaService.areaCreate(area, baseUser);
			} catch (RuntimeException e) {
				return new ResultJson(false, e.getMessage());
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		} else {
			return new ResultJson(false, "参数错误！");
		}
	}


	*//**
	 * 修改行政区
	 * 
	 * @author Gwang
	 * @param area
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("areaEdit")
	public ResultJson areaEdit(BaseArea area, BaseUser baseUser) {
		if (areaCreateCheck(area)) {
			try {
				BaseArea oldArea = areaService.getAreaById(area.getBaseAreaId());
				// 重名判断
				Map<String, Object> selMap = new HashMap<String, Object>();
				selMap.put("type", "name");
				selMap.put("value", area.getAreaName());
				BaseArea nameArea = areaService.getAreaByProperty(selMap);
				if (nameArea != null && !nameArea.getBaseAreaId().equals(area.getBaseAreaId())) {
					return new ResultJson(false, "很抱歉，行政区名称已存在，请重新输入！");
				}
				selMap.put("type", "code");
				selMap.put("value", area.getAreaCode());
				BaseArea codeArea = areaService.getAreaByProperty(selMap);
				if (codeArea != null && !codeArea.getBaseAreaId().equals(area.getBaseAreaId())) {
					return new ResultJson(false, "很抱歉，行政区代码存在，请重新输入！");
				}
				boolean isEditName = false;
				if (!oldArea.getAreaName().equals(area.getAreaName())) {
					isEditName = true;
				}
				oldArea.setAreaName(area.getAreaName());
				oldArea.setAreaCode(area.getAreaCode());
				oldArea.setCreateSchool(area.getCreateSchool());
				oldArea.setEditSchedule(area.getEditSchedule());
				oldArea.setSoftwareUpgrade(area.getSoftwareUpgrade());
				oldArea.setBaseFileServerId(area.getBaseFileServerId());
				oldArea.setBasePmsServerId(area.getBasePmsServerId());
				return areaService.areaEdit(oldArea, baseUser, isEditName);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		} else {
			return new ResultJson(false, "参数错误！");
		}
	}

	public boolean areaCreateCheck(BaseArea area) {
		if (StringUtils.isBlank(area.getAreaName())) {
			return false;
		}
		if (StringUtils.isBlank(area.getAreaCode())) {
			return false;
		}
		if (StringUtils.isBlank(area.getBaseFileServerId())) {
			return false;
		}
		if (StringUtils.isBlank(area.getBasePmsServerId())) {
			return false;
		}
		if (!CommonsConstant.FLAG_NO.equals(area.getEditSchedule()) && !CommonsConstant.FLAG_YES.equals(area.getEditSchedule())) {
			return false;
		}
		if (!CommonsConstant.FLAG_NO.equals(area.getCreateSchool()) && !CommonsConstant.FLAG_YES.equals(area.getCreateSchool())) {
			return false;
		}
		if (!CommonsConstant.FLAG_NO.equals(area.getSoftwareUpgrade()) && !CommonsConstant.FLAG_YES.equals(area.getSoftwareUpgrade())) {
			return false;
		}
		return true;
	}

	*//**
	 * 删除行政区
	 * 
	 * @author Gwang
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("areaDelete")
	public ResultJson areaDelete(@RequestParam(required = true) String id) {
		BaseArea area = areaService.getAreaById(id);
		if (area == null) {
			return new ResultJson(false, "参数错误！");
		}
		List<BaseArea> areas = areaService.getAreaByparentId(id);
		if (areas != null && areas.size() > 0) {
			return new ResultJson(false, "无法删除 " + area.getAreaName() + " ，请先删除 " + area.getAreaName() + " 下辖的子行政区！");
		}
		try {
			areaService.areaDelete(id);
		} catch (Exception e) {
			return new ResultJson(false, "无法删除 " + area.getAreaName() + " ，请先删除 " + area.getAreaName() + " 下的内容！");
		}
		return new ResultJson(true);
	}

	*//**
	 * 行政区排序
	 * 
	 * @author Gwang
	 * @param json
	 * @return
	 *//*
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("areaSort")
	public ResultJson areaSort(@RequestParam(required = true) String json) {
		try {
			List<BaseArea> areas = (List<BaseArea>) JSONArray.toCollection(JSONArray.fromObject(json), BaseArea.class);
			if (areas != null && areas.size() > 0) {
				areaService.updateAreaSort(areas);
			}
		} catch (Exception e) {
			return new ResultJson(false, "行政区排序错误！");
		}
		return new ResultJson(true);
	}

	*//**
	 * 地图获取行政区接口
	 * 
	 * @author Gwang
	 * @param areaId
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("mapAreas")
	public List<BaseArea> mapAreas(@RequestParam(required = true) String areaId) {
		return areaService.getChildrenAreaByParentId(areaId);
	}

	*//**
	 * 读取地图信息接口
	 * 
	 * @author Gwang
	 * @param areaId
	 * @param request
	 * @param response
	 * @param multipartFile
	 * @return
	 * @throws IOException 
	 *//*
	@RequestMapping("readMapFile")
	public void readMapFile(@RequestParam(required = true) String areaId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			BaseArea area = areaService.getAreaById(areaId);
			if (area == null) {
				response.getWriter().write("0:行政区不存在！");
				return;
			}

			CustomMultipartResolver resolver = new CustomMultipartResolver();
			resolver.setDefaultEncoding("UTF-8");
			resolver.setMaxUploadSize(1024 * 1024 * 1024);
			resolver.setServletContext(request.getSession().getServletContext());
			resolver.setMaxInMemorySize(1024 * 1024);
			MultipartHttpServletRequest multiRequest = null;
			try {
				multiRequest = resolver.resolveMultipart(request);
			} catch (MaxUploadSizeExceededException e) {
				response.getWriter().write("0:文件过大！");
				return;
			}

			Collection<MultipartFile> files = multiRequest.getFileMap().values();
			if (files == null || files.size() == 0) {
				response.getWriter().write("0:请选择文件！");
				return;
			}
			MultipartFile multipartFile = files.iterator().next();

			if (multipartFile.isEmpty()) {
				response.getWriter().write("0:请选择文件！");
				return;
			}
			InputStreamReader read = new InputStreamReader(multipartFile.getInputStream(), "utf-8");
			BufferedReader bufferedReader = new BufferedReader(read);
			String lineTxt = null;
			StringBuffer stringBuffer = new StringBuffer();
			while ((lineTxt = bufferedReader.readLine()) != null) {
				stringBuffer.append(lineTxt);
			}
			BaseArea mapArea = new BaseArea();
			mapArea.setMapSource(stringBuffer.toString());
			mapArea.setBaseAreaId(areaId);
			areaService.updateAreaMap(mapArea);
			response.getWriter().write(stringBuffer.toString());
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("0:上传文件错误！");
		}
	}

	*//**
	 * 保存行政区svg数据
	 * 
	 * @author Gwang
	 * @param areaId
	 * @param svgString
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("saveAreaMap")
	public ResultJson saveAreaMap(@RequestParam(required = true) String areaId, @RequestParam(required = true) String svgString) {
		try {
			BaseArea area = areaService.getAreaById(areaId);
			if (area == null) {
				return new ResultJson(false, "行政区不存在！");
			}
			BaseArea mapArea = new BaseArea();
			mapArea.setMapOutput(svgString);
			mapArea.setBaseAreaId(areaId);
			areaService.updateAreaMap(mapArea);
			return new ResultJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResultJson(false, "保存行政区svg数据错误！");
		}
	}

	*//**
	 * 获取行政区svg数据
	 * 
	 * @author Gwang
	 * @param areaId
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("getAreaMap")
	public String getAreaMap(@RequestParam(required = true) String areaId) {
		BaseArea area = areaService.getAreaById(areaId);
		if (area != null) {
			return area.getMapOutput();
		}
		return null;
	}

	*//**
	 * 地图编辑页面
	 * 
	 * @author Gwang
	 * @return
	 *//*
	@RequestMapping("areaMapPre")
	public String areaMapPre(HttpServletRequest request, @RequestParam(required = true) String areaId) {
		BaseArea area = areaService.getAreaById(areaId);
		if (area != null) {
			request.setAttribute("areaCode", area.getAreaCode());
			request.setAttribute("mapSource", area.getMapSource());
			String mapOutput = area.getMapOutput();
			if (mapOutput == null || "".equals(mapOutput)) {
				request.setAttribute("mapOutput", "{}");
			} else {
				request.setAttribute("mapOutput", mapOutput);
			}
			JSONArray array = JSONArray.fromObject(areaService.getChildrenAreaByParentId(areaId));
			request.setAttribute("areas", array.toString());
		}
		return "admin/system/areaManager/area_map";
	}
*/
}
