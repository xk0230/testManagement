package com.codyy.commons;

import org.apache.commons.lang.StringUtils;

public class CommonsConstant {
	public static final String FLAG_YES = "Y";
	//DELETE_FLAG已删除
	//LOCKED已经锁定无法再登录
	//BASE_USER.ADMIN_FLAG区县管理员或学校管理员
	//BASE_AREA.EDIT_SCHEDULE区域用户可以编辑课表
	//BASE_AREA.SOFTWARE_UPGRADE区域教室自动更新软件
	//BASE_AREA.CREATE_SCHOOL区域下可以挂学校
	//CLS_CLASSROOM.WHITE_PAD_SWITCH, CLS_SCHEDULE_DETAIL.WHITE_PAD_SWITCH白板打开
	//CLS_CLASSROOM.RECORD_SWITCH, CLS_SCHEDULE_DETAIL.RECORD_SWITCH录制打开
	//CLS_CLASSROOM.REMOTE_SWITCH远程导播打开
	//CLS_SCHEDUEL_DETAIL.SELF_DEFINE自主开课
	//EVA_STANDARD.SYSTEM_PROVIDED系统默认评课标准
	
	public static final String FLAG_NO = "N";
	//DELETE_FLAG未删除
	//LOCKED未锁定可以登录
	//BASE_USER.ADMIN_FLAG区县普通用户或学校普通用户
	//BASE_AREA.EDIT_SCHEDULE区域用户不能编辑课表
	//BASE_AREA.SOFTWARE_UPGRADE区域教室不更新软件
	//BASE_AREA.CREATE_SCHOOL区域下不能挂学校
	//CLS_CLASSROOM.WHITE_PAD_SWITCH, CLS_SCHEDULE_DETAIL.WHITE_PAD_SWITCH白板关闭
	//CLS_CLASSROOM.RECORD_SWITCH, CLS_SCHEDULE_DETAIL.RECORD_SWITCH录制关闭
	//CLS_CLASSROOM.REMOTE_SWITCH远程导播关闭
	//CLS_SCHEDUEL_DETAIL.SELF_DEFINE课表开课
	//EVA_STANDARD.SYSTEM_PROVIDED非系统默认评课标准
	
	
	//BASE_USER的用户类型
	public static final String USER_TYPE_AREA_USER = "AREA_USR";//行政机构用户
	public static final String USER_TYPE_SCHOOL_USER = "SCHOOL_USR";//学校用户
	public static final String USER_TYPE_TEACHER = "TEACHER";//教师
	
	//BASE_USER.CREATE_USER_TYPE用户的创建人类型
	public static final String CREATE_USER_TYPE_BASE_ADMIN = "ADMIN_USER";//管理员用户创建
	public static final String CREATE_USER_TYPE_BASE_USER = "BASE_USER";//BaseUser创建
	
	//CLS_CLASSROMM.ROOM_TYPE教室类型
	public static final String CLASSROOM_TYPE_MASTER = "MASTER";//主讲教室
	public static final String CLASSROOM_TYPE_RECEIVE = "RECEIVE";//接收教室
	
	//CLS_SCHEDULE_DETAIL.STATUS课堂状态
	//CLS_SCHEDULE_DETAIL_RECEIVE.STATUS课堂状态
	public static final String SCHE_DETAIL_INIT = "INIT";//未开始, 
	public static final String SCHE_DETAIL_PROGRESS = "PROGRESS";//进行中 
	public static final String SCHE_DETAIL_END = "END";//已结束 
	public static final String SCHE_DETAIL_CANCEL = "CANCEL";//取消
	
	
	//CLS_SCHEDULE_DETAIL.VIDEO_UPLOAD状态
	public static final String VIDEO_UPLOAD_N = "N";//初始状态 ：未上传
	public static final String VIDEO_UPLOAD_F = "F";//上传失败
	public static final String VIDEO_UPLOAD_Y = "Y";//已经上传
	public static final String VIDEO_UPLOAD_S = "S";//转换成功
	
	//CLS_SCHEDULE_DETAIL_GUEST.GUEST_TYPE课堂来宾类型
	public static final String GUEST_TYPE_GUEST = "GUEST";//课堂来宾 
	public static final String GUEST_TYPE_WATCH = "WATCH";//观摩用户
	
	//MAL_DETAIL.STATUS报修状态
	public static final String MAL_DETAIL_NEW = "NEW";//待处理
	public static final String MAL_DETAIL_PROGRESS = "PROGRESS";//处理中
	public static final String MAL_DETAIL_DONE = "DONE";//已处理 
	public static final String MAL_DETAIL_VERFIED = "VERIFIED";//已验收
	
	//EVA_EVALUATION.STATUS评课状态
	public static final String EVALUATION_STATUS_INIT = "INIT";//未开始
	public static final String EVALUATION_STATUS_PROGRESS = "PROGRESS";//进行中
	public static final String EVALUATION_STATUS_END = "END";//已结束
	
	//EVA_EVALUATION.EVA_TYPE评课类型
	public static final String EVALUATION_TYPE_LIVE = "LIVE";//直播
	public static final String EVALUATION_TYPE_VIDEO = "VIDEO";//录播
	
	//EVA_EVALUATION.SCORE_TYPE评课的评分类型
	public static final String EVALUATION_SCORE_TYPE_ADD_ALL = "ADD_ALL";//所有相加取平均数
	public static final String EVALUATION_SCORE_TYPE_REMOVE_SIDE = "REMOVE_SIDE";//多于五个评分去掉最高和最低再取平均数
	
	//EVA_RECEIVE_SCHOOL.STATUS评课接收学校的处理状态
	public static final String EVALUATION_RECEIVE_SCHOOL_STATUS_WAIT = "WAIT";//待处理
	public static final String EVALUATION_RECEIVE_SCHOOL_STATUS_REJECT = "REJECT";//已拒绝
	public static final String EVALUATION_RECEIVE_SCHOOL_STATUS_ACCEPT = "ACCEPT";//已接受
	
	//EVA_STANDARD.AVAILABLE_SCOPE评分标准可用范围
	public static final String EVA_STANDARD_SCOPE_PUBLIC = "PUBLIC";//公开
	public static final String EVA_STANDARD_SCOPE_PRIVATE = "PRIVATE";//私有
	
	//默认头像
	public static final String HEAD_PIC_DEFAULT = "headPicDefault.jpg";
	
	public static final String ERROR_PAGE_404 = "common/error/404";
	
	//默认密码
	public static final String CLASSROOM_PASSWORD_DEFAULT = "666666";
	
	// 资源转换标记
	public static final String TRANS_PENDDING = "TRANS_PENDDING" ;// 【视频：等待获取基本信息，文档：等待转换】
	public static final String TRANS_CAPTURING = "TRANS_CAPTURING";//视频基本信息获取中
	public static final String TRANS_CAPTURED = "TRANS_CAPTURED";//获取基本信息成功，等待转换。只针对视频
	public static final String TRANS_TRANSING = "TRANS_TRANSING" ;// 转换中
	public static final String TRANS_SUCCESS = "TRANS_SUCCESS" ;// 转换成功
	public static final String TRANS_FAILED = "TRANS_FAILED" ;// 转换失败[包含获取基本信息失败的数据]
	
	//资源来源
	public static final String RES_SOURCE_TYPE_UPLOAD = "UPLOAD";
	public static final String RES_SOURCE_TYPE_TRANSFER = "TRANSFER";
	
	//资源推荐类型：
	public static final String TEA_TO_SCH_UP = "TEA_TO_SCH_UP"; //1.老师推荐到上级学校
	public static final String SCH_TO_SCH_HOME = "SCH_TO_SCH_HOME"; //2.学校推荐到学校主页
	public static final String SCH_TO_AREA_UP = "SCH_TO_AREA_UP"; //3.学校推荐到上级区域
	public static final String AREA_TO_AREA_UP = "AREA_TO_AREA_UP";//4.区域推荐到上级区域
	public static final String AREA_TO_AREA_HOME = "AREA_TO_AREA_HOME";//5.区域推荐到区域主页

	//系统参数定义
	public static final String CONFIG_SYS_TITLE = "sys.title";		//系统标题
	public static final String CONFIG_SYS_FOOTER = "sys.footer";	//底部版权声明定义
	//是否开启首页主讲课堂数等数值的自定义,不开启则从数据库计算,开启则从配置文件中读取, Y=开启, N=关闭
	public static final String CONFIG_SYS_CLASS_NUMBER_DEFINE = "sys.classNumber";		
	//public static final String CONFIG_DCLASS_VALID_DURATION = "1200";//统计课堂时,超过多长时间的算有效课堂,单位秒
	
	//session名称定义
	public static final String SESSION_USER = "SESSION_USER";	//SessionUser对象, 用于用户中心,资源,评课,在线课堂模块
	public static final String SESSION_STATE = "SESSION_STATE";	//String对象, 单点登录时的state值,用于单点登录中的重放攻击
	public static final String SESSION_IMAGES = "SESSION_IMAGES";//List<String>对象,存储用户已经上传的图片文件地址,保存后应该从List中清除已经保存的图片文件
	public static final String SESSION_RES_FILE_ITEM= "SESSION_RES_FILE_ITEM";//资源项目中上传的文件回话key
	public static final String SESSION_ANDROID_FILE = "SESSION_ANDROID_FILE";//List<String>对象,存储用户已经上传的文件地址,保存后应该从List中清除已经保存的文件
	public static final String COOKIE_USERNAME = "COOKIE_USERNAME";			//自动登录时的cookie 用户名
	public static final String COOKIE_REMEMBER_TAG = "COOKIE_REMEMBER_TAG";	//自动登录时的cookie 标识
	
	// 其余分割符
	public static final String AREA_SPLIT = "-" ;
	
	//直录播统计数据类型
	public static final String CLASS_STA_AREA = "AREA"; //地区
	public static final String CLASS_STA_D_SCH = "DSCH";//直属学校
	public static final String CLASS_STA_SCH = "SCH";//学校
	
	//直录播统计课程状态
	public static final String CLASS_STA_STATUS_VALID = "VALID";//有效授课：正常已结束的课程
	public static final String CLASS_STA_STATUS_INVALID = "INVALID";//无效授课：小于30分钟的课程
	public static final String CLASS_STA_STATUS_REASONABLE_MISSED = "REASONABLE_MISSED";//因故停课：已取消的课程
	public static final String CLASS_STA_STATUS_UNREASONABLE_MISSED = "UNREASONABLE_MISSED";//无故停课：当前时间前的未开始的课程
	
	//移动端常量
	public static final String RESULT_SUCCESS = "success";
	public static final String RESULT_ERROR = "error";
	
	//系统配置参数
	public static final String SYS_CONFIG_SYS_CLASSNUMBER = "sys.classNumber";
	public static final String SYS_CONFIG_CLASS_VALIDDURATION = "class.validDuration";
	public static final String SYS_CONFIG_SYS_TITLE = "sys.title";
	public static final String SYS_CONFIG_SYS_FOOTER = "sys.footer";
	
	public static final String SYS_CONFIG_SYS_MAINCLASSNUMBER = "sys.mainClassNumber";
	public static final String SYS_CONFIG_SYS_RECEIVECLASSNUMBER = "sys.receiveClassNumber";
	public static final String SYS_CONFIG_SYS_SEMESTER_TOTALCLASSNUMBER = "sys.semeterTotalClassNumber";
	public static final String SYS_CONFIG_SYS_SEMESTER_STUDENTNUMBER = "sys.semeterStudentNumber";
	public static final String SYS_CONFIG_SYS_SEMESTER_TEACHERNUMBER = "sys.semeterTeacherNumber";
	public static final String SYS_CONFIG_SYS_WEEK_CLASSNUMBER = "sys.weekClassNumber";
	public static final String SYS_CONFIG_SYS_WEEK_PLANCLASSNUMBER = "sys.weekPlanClassNumber";
	public static final String SYS_CONFIG_SYS_WEEK_TAUGHTCLASSNUMBER = "sys.weekTaughtClassNumber";
	
	public static final String MEET_CONFIG = "MEET-CONFIG:";
	public static final String SYS_CONFIG = "SYS-CONFIG:";
	public static final String MEET_CONFIG_MEET = "meetConfig";
	public static final String MEET_CONFIG_LICENSE = "license";
	
	
	public enum ResourceColumnEnum {
		video("video", "视频类"),doc("doc","文档类");
		
		private ResourceColumnEnum(String value, String desc) {
			this.value = value;
			this.desc = desc;
		}
		private String value;
		private String desc;

		public String getValue() {
			return value;
		}

		public String getDesc() {
			return desc;
		}

		public static ResourceColumnEnum getDes(String value) {
			if(StringUtils.isNotBlank(value)) {
				for(ResourceColumnEnum p : ResourceColumnEnum.values()) {
					if(p.getValue().equals(value)){
						return p;
					}
				}
			}
			return null;
		}
	}

	public enum ResourceDeleteFlagEnum {
		DELETE_NOT_DELETE("DELETE_NOT_DELETE", "未删除"),
		DELETE_BY_MANAGER("DELETE_BY_MANAGER","管理员删除"),
		DELETE_BY_USER("DELETE_BY_USER","用户删除");

		private ResourceDeleteFlagEnum(String value, String desc) {
			this.value = value;
			this.desc = desc;
		}
		private String value;
		private String desc;

		public String getValue() {
			return value;
		}

		public String getDesc() {
			return desc;
		}

		public static ResourceDeleteFlagEnum getDes(String value) {
			if(StringUtils.isNotBlank(value)) {
				for(ResourceDeleteFlagEnum p : ResourceDeleteFlagEnum.values()) {
					if(p.getValue().equals(value)){
						return p;
					}
				}
			}
			return null;
		}
	}
	
	public enum EvaStandardAvailableScopeEnum {
		PUBLIC("PUBLIC", "公开 "),PRIVATE("PRIVATE","私有");
		
		private EvaStandardAvailableScopeEnum(String value, String desc) {
			this.value = value;
			this.desc = desc;
		}
		private String value;
		private String desc;

		public String getValue() {
			return value;
		}

		public String getDesc() {
			return desc;
		}

		public static EvaStandardAvailableScopeEnum getDes(String value) {
			if(StringUtils.isNotBlank(value)) {
				for(EvaStandardAvailableScopeEnum p : EvaStandardAvailableScopeEnum.values()) {
					if(p.getValue().equals(value)){
						return p;
					}
				}
			}
			return null;
		}
	}
	public enum ResPermissionEnum {
		PUBLIC("PUBLIC", "公开 "),PRIVATE("PRIVATE","私有");
		
		private ResPermissionEnum(String value, String desc) {
			this.value = value;
			this.desc = desc;
		}
		private String value;
		private String desc;

		public String getValue() {
			return value;
		}

		public String getDesc() {
			return desc;
		}

		public static ResPermissionEnum getDes(String value) {
			if(StringUtils.isNotBlank(value)) {
				for(ResPermissionEnum p : ResPermissionEnum.values()) {
					if(p.getValue().equals(value)){
						return p;
					}
				}
			}
			return null;
		}
	}
	
	/**
	 * 基本数据类型
	 * @author yaodaqing
	 *
	 */
	public enum BaseCategoryType{
		
		/**学段*/SEMESTER("semester",1),
		/**年级*/CLASSLEVEL("classlevel",2),
		/**学科*/CLASSLEVELSUBJECT("classlevelSubject",3),
		/**版本*/CLASSLEVELSUBJECTVERSION("classlevelSubjectVersion",4),
		/**分册*/VOLUME("volume",5),
		/** 章*/CHAPTER("chapter",6),
		/** 节*/SECTION("section",7);
		
		// 成员变量
		private String name;
		private Integer index;

		// 构造方法
		private BaseCategoryType(String name, int index) {
			this.name = name;
			this.index = index;
		}
		
		public  String getName(){
			return name;
		}
		
		public Integer getIndex(){
			return this.index;
		}
		
		public static BaseCategoryType getType(String name){
			if(StringUtils.isNotBlank(name)) {
				for(BaseCategoryType bt:BaseCategoryType.values()){
					if(bt.getName().equalsIgnoreCase(name)){
						return bt;
					}
				}
			}
			return null;
		}
	}

}
