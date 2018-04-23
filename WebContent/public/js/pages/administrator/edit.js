﻿var myAppModule = angular.module("myApp",['ui.bootstrap','jcs-autoValidate','materialDatePicker']);
/*$('#containerpdp').highcharts({
    chart: {
        polar: true,
        type: 'line'
    },
    title: {
        text: '预算与支出',
        x: -80
    },
    pane: {
        size: '80%'
    },
    xAxis: {
        categories: ['销售', '市场营销', '发展', '客户支持',
                     '信息技术', '行政管理'],
        tickmarkPlacement: 'on',
        lineWidth: 0
    },
    yAxis: {
        gridLineInterpolation: 'polygon',
        lineWidth: 0,
        min: 0
    },
    tooltip: {
        shared: true,
        pointFormat: '<span style="color:{series.color}">{series.name}: <b>${point.y:,.0f}</b><br/>'
    },
    legend: {
        align: 'right',
        verticalAlign: 'top',
        y: 70,
        layout: 'vertical'
    },
    series: [{
        name: '预算拨款',
        data: [1, 2, 3, 4, 5, 6],
        pointPlacement: 'on'
    }, {
        name: '实际支出',
        data: [2, 3, 4, 1, 8, 5],
        pointPlacement: 'on'
    }]
});*/
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location, $filter){
		var self = this;
		
		//附件分页参数
		$scope.attachmentTotalItems = 0;
		$scope.attachmentCurrentPage = 1;
		$scope.attachmentItemsPerPage = 10;
		//培训分页参数
		$scope.trainTotalItems = 0;
		$scope.trainCurrentPage = 1;
		$scope.trainItemsPerPage = 10;
		//调岗分页参数
		$scope.transferPositionTotalItems = 0;
		$scope.transferPositionCurrentPage = 1;
		$scope.transferPositionItemsPerPage = 10;
		
		//模块显示
		self.readOnly = "";
		self.sessionUserId;
		self.mode = "";
		self.user = {
				userId:"",
				userName :"",
				password :"",
				realname :"",
				create_time :"",
				delete_flag :"",         //Y,N
				depid :"",		 //部门id
				post_id :"",		 //岗位ID
				work_status :"",	 //状态：试用等
				salary_scale :"",	 //薪级
				entry_date :"",		 //入职日期
				working_years :"",	 //工龄
				salary_begin_date :"",	 //起薪日
				probation_period :"",	 //试用期限
				expected_date :"",	 //预计转正日
				fwq_agreement :"",	 //服务期协议
				fwq_num :"",		 //服务期金额
				labour_begin_time :"",	 //合同开始时间
				labour_end_time :"",	 //合同结束时间
				sign_time :"",		 //签订次数
				insurance_base :"",	 //缴费基数
				filing_date :"",	 //备案日期
				leave_date :"",		 //离职日期
				retired_date :"",	 //退工日期
				position :""	,	 //角色'
				adminUserDetail : {
						sex:"",                     //性别
						birthday:"",                //生日
						age:"",                     //年龄
						birthday_month:"",          //出生月份
						id_number:"",               //身份证
						origin:"",                  //籍贯
						domicile:"",                //户籍
						nation:"",                  //民族
						marriage:"",                //婚姻
						political:"",               //政治面貌
						education:"",               //学历
						major:"",                   //专业
						university:"",              //毕业院校
						phone1:"",                  //
						phone2:"",                  //
						citizen_card:"",            //市民卡
						payroll_card:""             //工资卡
				}
		}
		
		self.$onInit = function(){
			//设置模块显示
			self.add = true;
			self.edit = true;
			//设置部门下拉框
			this.getDepList();
			//获取用户ID
			self.user.userId = $location.search().id;
			//获取角色
			self.sessionUserId =$("#sessionUserId").val();
			//判定是否显示模块
			if(typeof(self.user.userId)!="undefined"){
				self.mode = "2";
				//获取用户信息
				this.getUser();
				if(self.sessionUserId != "admin"){
					self.readOnly = true;
				}else
				{
					self.readOnly = false;
				}
				
			}else{
				self.mode = "1";
			}
			
			if($scope.vm.user.userId){
				self.getAttachmentEntityPageList();
				self.getTrainList();
				self.getTransferPositionList();
			}
			
		}
		
		//获取部门
		self.getDepList = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/dep/getAlldep.do',
				params:{
				}
			}).then(function(res){
				if(res){
					self.deplist = res.data || [];
				}else{
					self.deplist = [];
				}
			})
		}
		
		//获取
		self.getUser = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/adminuser/getUserById.do',
				params:{
					id: $scope.vm.user.userId
				}
			}).then(function(res){
				if(res){
					self.user = res.data;
					self.getHasManager($scope.vm.user.depId);
					self.getPostionById();
					if(self.user.workingYears == null){
						rzDayChanged('','','');
					}
					
					//console.log(self.user.adminUserDetail.pdpSjA);
					$('#containerpdp').highcharts({
				        chart: {
				            polar: true,
				            type: 'line'
				        },
				        title: {
				            text: '',
				            x: -80
				        },
				        pane: {
				            size: '80%'
				        },
				        xAxis: {
				            categories: ['谦和', '韧性', '理性', '自信'],
				            tickmarkPlacement: 'on',
				            lineWidth: 0
				        },
				        yAxis: {
				            gridLineInterpolation: 'polygon',
				            lineWidth: 0,
				            min: 0
				        },
				        tooltip: {
				            shared: true,
				            pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:,.0f}</b><br/>'
				        },
				        legend: {
				            align: 'right',
				            verticalAlign: 'top',
				            y: 70,
				            layout: 'vertical'
				        },
				        series: [{
				            name: '顺境',
				            data: [Number(self.user.adminUserDetail.pdpSjA), Number(self.user.adminUserDetail.pdpSjB),
				            	Number(self.user.adminUserDetail.pdpSjC), Number(self.user.adminUserDetail.pdpSjD)],
//				            data: [11,22,33,44],
				            pointPlacement: 'on'
				        }, {
				            name: '逆境',
				            data: [Number(self.user.adminUserDetail.pdpNjA), Number(self.user.adminUserDetail.pdpNjB), 
				            		Number(self.user.adminUserDetail.pdpNjC), Number(self.user.adminUserDetail.pdpNjD)],
//				            data: [44,33,11,22],
				            pointPlacement: 'on'
				        }]
				    });
				}else{
					self.user = "";
				}
			})
		}
		
		//获取岗位
		self.getPostionById = function(){
			
			if(typeof($scope.vm.user.depId)!="undefined"){
				$scope.vm.user.depId;
				//获取部门岗位
				$http({
					method:'POST',
					url:'/ssc/admin/position/getPositionByDepId.do',
					params:{
						depId: $scope.vm.user.depId
					}
				}).then(function(res){
					if(res){
						self.postlist = res.data || [];
					}else{
						self.postlist = [];
					}
				})
				// 判断当前是否部长
				self.getHasManager($scope.vm.user.depId);
			}
		}
		
		//获取部门是否已有部长
		self.getHasManager = function(depId){
			$http({
				method:'POST',
				url:'/ssc/admin/dep/hasManager.do',
				params:{
					depId: depId
				}
			}).then(function(res){
				if(res){
					if($scope.vm.user.userId == res.data.message || res.data.message=="N"){
						$scope.hasManager = "N";
					}else{
						$scope.hasManager = "Y";
					}
				}else{
					return "Y";
				}
			})
		}
		
		self.onSubmit = function(){
			if(self.mode == "1"){
				this.addUser();
			}else{
				this.updateUser();
			}
		}
		
		//获取部门
		self.addUser = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/adminuser/insertadminuser.do',
				params:{
					// ADMIN_USER
					userId       : $scope.vm.user.userId                         , //用户名
					userName       : $scope.vm.user.userName                         , //用户名
					password       : $scope.vm.user.userName                         , //初始密码
					realName       : $scope.vm.user.realName                         , //姓名
					deleteFlag     : $scope.vm.user.delete_flag                      , //Y,N
					depId          : $scope.vm.user.depId                            , //部门id
					postId         : $scope.vm.user.postId                          , //岗位ID
					workStatus     : $scope.vm.user.workStatus                      , //状态：试用等
					salaryScale    : $scope.vm.user.salaryScale                     , //薪级
					entryDate      : $filter('date')($scope.vm.user.entryDate, "yyyy-MM-dd hh:mm:ss")                       , //入职日期
					workingYears   : $scope.vm.user.workingYears                    , //工龄
					salaryBeginDate: $filter('date')($scope.vm.user.salaryBeginDate, "yyyy-MM-dd")                , //起薪日
					probationPeriod: $filter('date')($scope.vm.user.probationPeriod, "yyyy-MM-dd")                  , //试用期限
					expectedDate   : $filter('date')($scope.vm.user.expectedDate, "yyyy-MM-dd")                    , //预计转正日
					fwqAgreement   : $scope.vm.user.fwqAgreement                    , //服务期协议
					fwqNum         : $scope.vm.user.fwqNum                          , //服务期金额
					labourBeginTime: $filter('date')($scope.vm.user.labourBeginTime, "yyyy-MM-dd")                , //合同开始时间
					labourEndTime  : $filter('date')($scope.vm.user.labourEndTime, "yyyy-MM-dd")                  , //合同结束时间
					signTime       : $scope.vm.user.signTime                        , //签订次数
					insuranceBase  : $scope.vm.user.insuranceBase                   , //缴费基数
					filingDate     : $filter('date')($scope.vm.user.filingDate, "yyyy-MM-dd")                      , //备案日期
					leaveDate      : $filter('date')($scope.vm.user.leaveDate, "yyyy-MM-dd")                       , //离职日期
					retiredDate    : $filter('date')($scope.vm.user.retiredDate, "yyyy-MM-dd")                     , //退工日期
					position       : $scope.vm.user.position                         ,//角色
					'adminUserDetail.sex'                 : $scope.vm.user.adminUserDetail.sex            , //性别
					'adminUserDetail.birthday'            : $filter('date')($scope.vm.user.adminUserDetail.birthday, "yyyy-MM-dd")       , //生日
					'adminUserDetail.age'                 : $scope.vm.user.adminUserDetail.age            , //年龄
					'adminUserDetail.birthdayMonth'       : $scope.vm.user.adminUserDetail.birthdayMonth , //出生月份
					'adminUserDetail.idNumber'             : $scope.vm.user.adminUserDetail.idNumber      , //身份证
					'adminUserDetail.origin'               : $scope.vm.user.adminUserDetail.origin         , //籍贯
					'adminUserDetail.domicile'             : $scope.vm.user.adminUserDetail.domicile       , //户籍
					'adminUserDetail.nation'               : $scope.vm.user.adminUserDetail.nation         , //民族
					'adminUserDetail.marriage'             : $scope.vm.user.adminUserDetail.marriage       , //婚姻
					'adminUserDetail.political'            : $scope.vm.user.adminUserDetail.political      , //政治面貌
					'adminUserDetail.education'            : $scope.vm.user.adminUserDetail.education      , //学历
					'adminUserDetail.major'                : $scope.vm.user.adminUserDetail.major          , //专业
					'adminUserDetail.university'           : $scope.vm.user.adminUserDetail.university     , //毕业院校
					'adminUserDetail.phone1'               : $scope.vm.user.adminUserDetail.phone1         , //电话号码
					'adminUserDetail.phone2'               : $scope.vm.user.adminUserDetail.phone2         , //电话号码
					'adminUserDetail.citizenCard'          : $scope.vm.user.adminUserDetail.citizenCard   , //市民卡
					'adminUserDetail.payrollCard'          : $scope.vm.user.adminUserDetail.payrollCard,    //工资卡
					'adminUserDetail.pdpSjA'          : $scope.vm.user.adminUserDetail.pdpSjA,
					'adminUserDetail.pdpSjB'          : $scope.vm.user.adminUserDetail.pdpSjB,
					'adminUserDetail.pdpSjC'          : $scope.vm.user.adminUserDetail.pdpSjC,
					'adminUserDetail.pdpSjD'          : $scope.vm.user.adminUserDetail.pdpSjD,
					'adminUserDetail.pdpNjA'          : $scope.vm.user.adminUserDetail.pdpNjA,
					'adminUserDetail.pdpNjB'          : $scope.vm.user.adminUserDetail.pdpNjB,
					'adminUserDetail.pdpNjC'          : $scope.vm.user.adminUserDetail.pdpNjC,
					'adminUserDetail.pdpNjD'          : $scope.vm.user.adminUserDetail.pdpNjD,
					'adminUserDetail.gx'          : $scope.vm.user.adminUserDetail.gx,
					'adminUserDetail.sj'          : $scope.vm.user.adminUserDetail.sj,
					'adminUserDetail.english'          : $scope.vm.user.adminUserDetail.english,
					'adminUserDetail.otherLanguage'          : $scope.vm.user.adminUserDetail.otherLanguage,
					'adminUserDetail.homeIdcard'          : $scope.vm.user.adminUserDetail.homeIdcard,
					'adminUserDetail.homeName'          : $scope.vm.user.adminUserDetail.homeName  ,
					'adminUserDetail.homePhone'          : $scope.vm.user.adminUserDetail.homePhone ,
					'adminUserDetail.homeWork'          : $scope.vm.user.adminUserDetail.homeWork  ,
					'adminUserDetail.homeXl'          : $scope.vm.user.adminUserDetail.homeXl    ,
					'adminUserDetail.homeZw'          : $scope.vm.user.adminUserDetail.homeZw    ,
					'adminUserDetail.homeZy'          : $scope.vm.user.adminUserDetail.homeZy    ,
					'adminUserDetail.homeBirthday'        : $filter('date')($scope.vm.user.adminUserDetail.homeBirthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child1Birthday'          : $filter('date')($scope.vm.user.adminUserDetail.child1Birthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child1Name'          : $scope.vm.user.adminUserDetail.child1Name    ,
					'adminUserDetail.child1Sex'          : $scope.vm.user.adminUserDetail.child1Sex     ,
					'adminUserDetail.child1Work'          : $scope.vm.user.adminUserDetail.child1Work    ,
					'adminUserDetail.child2Birthday'          : $filter('date')($scope.vm.user.adminUserDetail.child2Birthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child2Name'          : $scope.vm.user.adminUserDetail.child2Name    ,
					'adminUserDetail.child2Sex'          : $scope.vm.user.adminUserDetail.child2Sex     ,
					'adminUserDetail.child2Work'          : $scope.vm.user.adminUserDetail.child2Work    ,
					'adminUserDetail.child3Birthday'          : $filter('date')($scope.vm.user.adminUserDetail.child3Birthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child3Name'          : $scope.vm.user.adminUserDetail.child3Name    ,
					'adminUserDetail.child3Sex'          : $scope.vm.user.adminUserDetail.child3Sex     ,
					'adminUserDetail.child3Work'          : $scope.vm.user.adminUserDetail.child3Work    ,
					'adminUserDetail.citizenCard'          : $scope.vm.user.adminUserDetail.citizenCard   ,
					'adminUserDetail.work1Job'          : $scope.vm.user.adminUserDetail.work1Job   ,
					'adminUserDetail.work1Place'          : $scope.vm.user.adminUserDetail.work1Place ,
					'adminUserDetail.work1Reason'          : $scope.vm.user.adminUserDetail.work1Reason,
					'adminUserDetail.work1Time'          : $filter('date')($scope.vm.user.adminUserDetail.work1Time, "yyyy-MM-dd")  ,
					'adminUserDetail.work1Zyyj'          : $scope.vm.user.adminUserDetail.work1Zyyj  ,
					'adminUserDetail.work2Job'          : $scope.vm.user.adminUserDetail.work2Job   ,
					'adminUserDetail.work2Place'          : $scope.vm.user.adminUserDetail.work2Place ,
					'adminUserDetail.work2Reason'          : $scope.vm.user.adminUserDetail.work2Reason,
					'adminUserDetail.work2Time'          : $filter('date')($scope.vm.user.adminUserDetail.work2Time, "yyyy-MM-dd")  ,
					'adminUserDetail.work2Zyyj'          : $scope.vm.user.adminUserDetail.work2Zyyj  ,
					'adminUserDetail.work3Job'          : $scope.vm.user.adminUserDetail.work3Job   ,
					'adminUserDetail.work3Place'          : $scope.vm.user.adminUserDetail.work3Place ,
					'adminUserDetail.work3Reason'          : $scope.vm.user.adminUserDetail.work3Reason,
					'adminUserDetail.work3Time'          : $filter('date')($scope.vm.user.adminUserDetail.work3Time, "yyyy-MM-dd")  ,
					'adminUserDetail.work3Zyyj'          : $scope.vm.user.adminUserDetail.work3Zyyj  ,
					'adminUserDetail.work4Job'          : $scope.vm.user.adminUserDetail.work4Job   ,
					'adminUserDetail.work4Place'          : $scope.vm.user.adminUserDetail.work4Place ,
					'adminUserDetail.work4Reason'          : $scope.vm.user.adminUserDetail.work4Reason,
					'adminUserDetail.work4Time'          : $filter('date')($scope.vm.user.adminUserDetail.work4Time, "yyyy-MM-dd")  ,
					'adminUserDetail.work4Zyyj'          : $scope.vm.user.adminUserDetail.work4Zyyj  ,
					'adminUserDetail.work5Job'          : $scope.vm.user.adminUserDetail.work5Job   ,
					'adminUserDetail.work5Place'          : $scope.vm.user.adminUserDetail.work5Place ,
					'adminUserDetail.work5Reason'          : $scope.vm.user.adminUserDetail.work5Reason,
					'adminUserDetail.work5Time'          : $filter('date')($scope.vm.user.adminUserDetail.work5Time, "yyyy-MM-dd")  ,
					'adminUserDetail.work5Zyyj'          : $scope.vm.user.adminUserDetail.work5Zyyj  ,
					'adminUserDetail.work6Job'          : $scope.vm.user.adminUserDetail.work6Job   ,
					'adminUserDetail.work6Place'          : $scope.vm.user.adminUserDetail.work6Place ,
					'adminUserDetail.work6Reason'          : $scope.vm.user.adminUserDetail.work6Reason,
					'adminUserDetail.work6Time'          : $filter('date')($scope.vm.user.adminUserDetail.work6Time, "yyyy-MM-dd")  ,
					'adminUserDetail.work6Zyyj'          : $scope.vm.user.adminUserDetail.work6Zyyj  ,
					'adminUserDetail.firstWorkTime'          : $filter('date')($scope.vm.user.adminUserDetail.firstWorkTime, "yyyy-MM-dd")  ,
					'adminUserDetail.address'          : $scope.vm.user.adminUserDetail.address
				}
			}).then(function(res){
				if(res){
					//swal("保存成功!","","sucess");
					alert("保存成功!");
				}else{
					//swal("保存失败!","","error");
					alert("保存失败!");
				}
			})
		}

		
		//修改用户
		self.updateUser = function(){
			$http({
				method:'POST',
				url:'/ssc/admin/adminuser/updateuseradmin.do',
				params:{
					// ADMIN_USER
					userId       : $scope.vm.user.userId                         , //用户名
					userName       : $scope.vm.user.userName                         , //用户名
					password       : $scope.vm.user.userName                         , //初始密码
					realName       : $scope.vm.user.realName                         , //姓名
					deleteFlag     : $scope.vm.user.delete_flag                      , //Y,N
					depId          : $scope.vm.user.depId                            , //部门id
					postId         : $scope.vm.user.postId                          , //岗位ID
					workStatus     : $scope.vm.user.workStatus                      , //状态：试用等
					salaryScale    : $scope.vm.user.salaryScale                     , //薪级
					entryDate      : $filter('date')($scope.vm.user.entryDate, "yyyy-MM-dd hh:mm:ss")                       , //入职日期
					workingYears   : $scope.vm.user.workingYears                    , //工龄
					salaryBeginDate: $filter('date')($scope.vm.user.salaryBeginDate, "yyyy-MM-dd")                , //起薪日
					probationPeriod: $filter('date')($scope.vm.user.probationPeriod, "yyyy-MM-dd")                  , //试用期限
					expectedDate   : $filter('date')($scope.vm.user.expectedDate, "yyyy-MM-dd")                    , //预计转正日
					fwqAgreement   : $scope.vm.user.fwqAgreement                    , //服务期协议
					fwqNum         : $scope.vm.user.fwqNum                          , //服务期金额
					labourBeginTime: $filter('date')($scope.vm.user.labourBeginTime, "yyyy-MM-dd")                , //合同开始时间
					labourEndTime  : $filter('date')($scope.vm.user.labourEndTime, "yyyy-MM-dd")                  , //合同结束时间
					signTime       : $scope.vm.user.signTime                        , //签订次数
					insuranceBase  : $scope.vm.user.insuranceBase                   , //缴费基数
					filingDate     : $filter('date')($scope.vm.user.filingDate, "yyyy-MM-dd")                      , //备案日期
					leaveDate      : $filter('date')($scope.vm.user.leaveDate, "yyyy-MM-dd")                       , //离职日期
					retiredDate    : $filter('date')($scope.vm.user.retiredDate, "yyyy-MM-dd")                     , //退工日期
					position       : $scope.vm.user.position                         ,//角色
					'adminUserDetail.sex'                 : $scope.vm.user.adminUserDetail.sex            , //性别
					'adminUserDetail.birthday'            : $filter('date')($scope.vm.user.adminUserDetail.birthday, "yyyy-MM-dd")       , //生日
					'adminUserDetail.age'                 : $scope.vm.user.adminUserDetail.age            , //年龄
					'adminUserDetail.birthdayMonth'       : $scope.vm.user.adminUserDetail.birthdayMonth , //出生月份
					'adminUserDetail.idNumber'             : $scope.vm.user.adminUserDetail.idNumber      , //身份证
					'adminUserDetail.origin'               : $scope.vm.user.adminUserDetail.origin         , //籍贯
					'adminUserDetail.domicile'             : $scope.vm.user.adminUserDetail.domicile       , //户籍
					'adminUserDetail.nation'               : $scope.vm.user.adminUserDetail.nation         , //民族
					'adminUserDetail.marriage'             : $scope.vm.user.adminUserDetail.marriage       , //婚姻
					'adminUserDetail.political'            : $scope.vm.user.adminUserDetail.political      , //政治面貌
					'adminUserDetail.education'            : $scope.vm.user.adminUserDetail.education      , //学历
					'adminUserDetail.major'                : $scope.vm.user.adminUserDetail.major          , //专业
					'adminUserDetail.university'           : $scope.vm.user.adminUserDetail.university     , //毕业院校
					'adminUserDetail.phone1'               : $scope.vm.user.adminUserDetail.phone1         , //电话号码
					'adminUserDetail.phone2'               : $scope.vm.user.adminUserDetail.phone2         , //电话号码
					'adminUserDetail.citizenCard'          : $scope.vm.user.adminUserDetail.citizenCard   , //市民卡
					'adminUserDetail.payrollCard'          : $scope.vm.user.adminUserDetail.payrollCard ,   //工资卡
					'adminUserDetail.pdpSjA'          : $scope.vm.user.adminUserDetail.pdpSjA,
					'adminUserDetail.pdpSjB'          : $scope.vm.user.adminUserDetail.pdpSjB,
					'adminUserDetail.pdpSjC'          : $scope.vm.user.adminUserDetail.pdpSjC,
					'adminUserDetail.pdpSjD'          : $scope.vm.user.adminUserDetail.pdpSjD,
					'adminUserDetail.pdpNjA'          : $scope.vm.user.adminUserDetail.pdpNjA,
					'adminUserDetail.pdpNjB'          : $scope.vm.user.adminUserDetail.pdpNjB,
					'adminUserDetail.pdpNjC'          : $scope.vm.user.adminUserDetail.pdpNjC,
					'adminUserDetail.pdpNjD'          : $scope.vm.user.adminUserDetail.pdpNjD,
					'adminUserDetail.gx'          : $scope.vm.user.adminUserDetail.gx,
					'adminUserDetail.sj'          : $scope.vm.user.adminUserDetail.sj,
					'adminUserDetail.english'          : $scope.vm.user.adminUserDetail.english,
					'adminUserDetail.otherLanguage'          : $scope.vm.user.adminUserDetail.otherLanguage,
					'adminUserDetail.homeIdcard'          : $scope.vm.user.adminUserDetail.homeIdcard,
					'adminUserDetail.homeName'          : $scope.vm.user.adminUserDetail.homeName  ,
					'adminUserDetail.homePhone'          : $scope.vm.user.adminUserDetail.homePhone ,
					'adminUserDetail.homeWork'          : $scope.vm.user.adminUserDetail.homeWork  ,
					'adminUserDetail.homeXl'          : $scope.vm.user.adminUserDetail.homeXl    ,
					'adminUserDetail.homeZw'          : $scope.vm.user.adminUserDetail.homeZw    ,
					'adminUserDetail.homeZy'          : $scope.vm.user.adminUserDetail.homeZy    ,
					'adminUserDetail.homeBirthday'        : $filter('date')($scope.vm.user.adminUserDetail.homeBirthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child1Birthday'          : $filter('date')($scope.vm.user.adminUserDetail.child1Birthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child1Name'          : $scope.vm.user.adminUserDetail.child1Name    ,
					'adminUserDetail.child1Sex'          : $scope.vm.user.adminUserDetail.child1Sex     ,
					'adminUserDetail.child1Work'          : $scope.vm.user.adminUserDetail.child1Work    ,
					'adminUserDetail.child2Birthday'          : $filter('date')($scope.vm.user.adminUserDetail.child2Birthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child2Name'          : $scope.vm.user.adminUserDetail.child2Name    ,
					'adminUserDetail.child2Sex'          : $scope.vm.user.adminUserDetail.child2Sex     ,
					'adminUserDetail.child2Work'          : $scope.vm.user.adminUserDetail.child2Work    ,
					'adminUserDetail.child3Birthday'          : $filter('date')($scope.vm.user.adminUserDetail.child3Birthday, "yyyy-MM-dd")  ,
					'adminUserDetail.child3Name'          : $scope.vm.user.adminUserDetail.child3Name    ,
					'adminUserDetail.child3Sex'          : $scope.vm.user.adminUserDetail.child3Sex     ,
					'adminUserDetail.child3Work'          : $scope.vm.user.adminUserDetail.child3Work    ,
					'adminUserDetail.citizenCard'          : $scope.vm.user.adminUserDetail.citizenCard   ,
					'adminUserDetail.work1Job'          : $scope.vm.user.adminUserDetail.work1Job   ,
					'adminUserDetail.work1Place'          : $scope.vm.user.adminUserDetail.work1Place ,
					'adminUserDetail.work1Reason'          : $scope.vm.user.adminUserDetail.work1Reason,
					'adminUserDetail.work1Time'          : $scope.vm.user.adminUserDetail.work1Time,
					'adminUserDetail.work1Zyyj'          : $scope.vm.user.adminUserDetail.work1Zyyj  ,
					'adminUserDetail.work2Job'          : $scope.vm.user.adminUserDetail.work2Job   ,
					'adminUserDetail.work2Place'          : $scope.vm.user.adminUserDetail.work2Place ,
					'adminUserDetail.work2Reason'          : $scope.vm.user.adminUserDetail.work2Reason,
					'adminUserDetail.work2Time'          : $scope.vm.user.adminUserDetail.work2Time,
					'adminUserDetail.work2Zyyj'          : $scope.vm.user.adminUserDetail.work2Zyyj  ,
					'adminUserDetail.work3Job'          : $scope.vm.user.adminUserDetail.work3Job   ,
					'adminUserDetail.work3Place'          : $scope.vm.user.adminUserDetail.work3Place ,
					'adminUserDetail.work3Reason'          : $scope.vm.user.adminUserDetail.work3Reason,
					'adminUserDetail.work3Time'          : $scope.vm.user.adminUserDetail.work3Time,
					'adminUserDetail.work3Zyyj'          : $scope.vm.user.adminUserDetail.work3Zyyj  ,
					'adminUserDetail.work4Job'          : $scope.vm.user.adminUserDetail.work4Job   ,
					'adminUserDetail.work4Place'          : $scope.vm.user.adminUserDetail.work4Place ,
					'adminUserDetail.work4Reason'          : $scope.vm.user.adminUserDetail.work4Reason,
					'adminUserDetail.work4Time'          : $scope.vm.user.adminUserDetail.work4Time,
					'adminUserDetail.work4Zyyj'          : $scope.vm.user.adminUserDetail.work4Zyyj  ,
					'adminUserDetail.work5Job'          : $scope.vm.user.adminUserDetail.work5Job   ,
					'adminUserDetail.work5Place'          : $scope.vm.user.adminUserDetail.work5Place ,
					'adminUserDetail.work5Reason'          : $scope.vm.user.adminUserDetail.work5Reason,
					'adminUserDetail.work5Time'          : $scope.vm.user.adminUserDetail.work5Time,
					'adminUserDetail.work5Zyyj'          : $scope.vm.user.adminUserDetail.work5Zyyj  ,
					'adminUserDetail.work6Job'          : $scope.vm.user.adminUserDetail.work6Job   ,
					'adminUserDetail.work6Place'          : $scope.vm.user.adminUserDetail.work6Place ,
					'adminUserDetail.work6Reason'          : $scope.vm.user.adminUserDetail.work6Reason,
					'adminUserDetail.work6Time'          : $scope.vm.user.adminUserDetail.work6Time,
					'adminUserDetail.work6Zyyj'          : $scope.vm.user.adminUserDetail.work6Zyyj  ,
					'adminUserDetail.firstWorkTime'          : $filter('date')($scope.vm.user.adminUserDetail.firstWorkTime, "yyyy-MM-dd")  ,
					'adminUserDetail.address'          : $scope.vm.user.adminUserDetail.address
				}
			}).then(function(res){
				if(res){
					//swal("保存成功!","","sucess");
					//self.postlist = res.data || [];
					alert("保存成功!");
				}else{
					//swal("保存失败!","","error");
					//self.postlist = [];
					alert("保存失败!");
				}
			})
		}

		//获取岗位
		function birthDayChanged(newValue, oldValue, scope){
			var today = new Date();
			var birthDay = new Date($scope.vm.user.adminUserDetail.birthday);
			$scope.vm.user.adminUserDetail.age = today.getYear() - birthDay.getYear();
			$scope.vm.user.adminUserDetail.birthdayMonth = birthDay.getMonth() + 1;
		}
		$scope.$watch('vm.user.adminUserDetail.birthday',birthDayChanged);
		
		function rzDayChanged(newValue, oldValue, scope){
			if (!$scope.vm.user.entryDate){
				time2 = new Date().valueOf()/1000
			}else{
				time2 = new Date($scope.vm.user.entryDate)/1000;
			}
		    time1 = Date.parse(new Date())/1000;
		    console.log(time2);
		    console.log(time1);
		    var times = time1 - time2;
		    $scope.vm.user.workingYears = (times/(3600*24*365)).toFixed(2);
		}
		
		$scope.$watch('vm.user.entryDate',rzDayChanged);
		
		$scope.setPage = function (pageNo) {
			$scope.attachmentCurrentPage = pageNo;
			$scope.trainCurrentPage = pageNo;
			$scope.transferPositionCurrentPage = pageNo;
		};

		//设置附件分页参数
		$scope.attachmentPageChanged = function() {
			self.getAttachmentEntityPageList();
		};
		
		$scope.trainPageChanged = function() {
			self.getTrainList();
		};
		
		$scope.transferPositionPageChanged = function() {
			self.getTransferPositionList();
		}
		
		// 获取数据列表
		this.getTransferPositionList = function(){
			
			$http({
				method:'POST',
				url:'/ssc/admin/transferPosition/page.do',
				params:{
					userId:$scope.vm.user.userId,
					start:(($scope.transferPositionCurrentPage - 1) * $scope.transferPositionItemsPerPage),
					end:$scope.transferPositionCurrentPage * $scope.transferPositionItemsPerPage -1
				}
			
			}).then(function(res){
				if(res){
					self.listTransferPosition = res.data.data || [];
					$scope.transferPositionTotalItems = res.data.total;
				}else{
					self.listTransferPosition = [];
					$scope.transferPositionTotalItems = 0;
				}
			});
		};
		
		this.getTrainList = function(){
			
			$http({
				method:'POST',
				url:'/ssc/admin/train/page.do',
				params:{
					userId:$scope.vm.user.userId,
					start:(($scope.trainCurrentPage - 1) * $scope.trainItemsPerPage),
					end:$scope.trainCurrentPage * $scope.trainItemsPerPage -1
				}
			
			}).then(function(res){
				if(res){
					self.listTrain = res.data.data || [];
					$scope.trainTotalItems = res.data.total;
				}else{
					self.listTrain = [];
					$scope.trainTotalItems = 0;
				}
			});
		};
		
		// 获取数据列表
		this.getAttachmentEntityPageList = function(){
			
			$http({
				method:'POST',
				url:'/ssc/admin/attachment/page.do',
				params:{
					fId:$scope.vm.user.userId,
					start:(($scope.attachmentCurrentPage - 1) * $scope.attachmentItemsPerPage),
					end:$scope.attachmentCurrentPage * $scope.attachmentItemsPerPage -1
				}
			
			}).then(function(res){
				if(res){
					self.listAttachment = res.data.data || [];
					$scope.attachmentTotalItems = res.data.total;
				}else{
					self.listAttachment = [];
					$scope.attachmentTotalItems = 0;
				}
			});
		};
		
		//
		
		//日期模块加载
		$scope.today = function() {
			$scope.dt = new Date();
		};
		$scope.clear = function() {
			$scope.dt = null;
		};

		$scope.dateOptions = {
			dateDisabled: "",
			formatYear: 'yyyy',
			maxDate: new Date(9999, 12, 31),
			minDate: new Date(1000, 1,1),
			startingDay: 1,
		};

		
		$scope.open = function(mode) {
			if(mode == 1){
				$scope.popup.opened1 = true;
			}else if (mode == 2){
				$scope.popup.opened2 = true;
			}else if (mode == 3){
				$scope.popup.opened3 = true;
			}else if (mode == 4){
				$scope.popup.opened4 = true;
			}else if (mode == 5){
				$scope.popup.opened5 = true;
			}else if (mode == 6){
				$scope.popup.opened6 = true;
			}else if (mode == 7){
				$scope.popup.opened7 = true;
			}else if (mode == 8){
				$scope.popup.opened8 = true;
			}else if (mode == 9){
				$scope.popup.opened9 = true;
			}else if (mode == 10){
				$scope.popup.opened10 = true;
			}
			else if (mode == 11){
				$scope.popup.opened11 = true;
			}
			else if (mode == 12){
				$scope.popup.opened12 = true;
			}
			else if (mode == 13){
				$scope.popup.opened13 = true;
			}
			else if (mode == 14){
				$scope.popup.opened14 = true;
			}
			else if (mode == 15){
				$scope.popup.opened15 = true;
			}
			else if (mode == 16){
				$scope.popup.opened16 = true;
			}
			else if (mode == 17){
				$scope.popup.opened17 = true;
			}
			else if (mode == 18){
				$scope.popup.opened18 = true;
			}
			else if (mode == 19){
				$scope.popup.opened19 = true;
			}
			else if (mode == 20){
				$scope.popup.opened20 = true;
			}
			else if (mode == 21){
				$scope.popup.opened21 = true;
			}
			else if (mode == 22){
				$scope.popup.opened22 = true;
			}
			
		};
	
		$scope.popup = {
			opened1: false,
			opened2: false,
			opened2: false,
			opened4: false,
			opened5: false,
			opened6: false,
			opened7: false,
			opened8: false,
			opened9: false,
			opened10: false,
			opened11: false,
			opened12: false,
			opened13: false,
			opened14: false,
			opened15: false,
			opened16: false,
			opened17: false,
			opened18: false,
			opened19: false,
			opened20: false,
			opened21: false,
			opened22: false
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);