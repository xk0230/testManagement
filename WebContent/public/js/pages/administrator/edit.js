var myAppModule = angular.module("myApp",['ui.bootstrap','jcs-autoValidate']);
myAppModule.config(['$locationProvider', function($locationProvider) {  
	  $locationProvider.html5Mode(true);  
	}]);  
myAppModule.controller('UserListController',
	function UserListController($scope,$http,$location, $filter){
		var self = this;
		//模块显示
		self.readOnly = "";
		self.admin;
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
			self.admin =$("#sessionUserType").val();
			//判定是否显示模块
			if(typeof(self.user.userId)!="undefined"){
				self.mode = "2";
				//获取用户信息
				this.getUser();
				if(self.admin != "ADMIN"){
					self.readOnly = true;
				}else
				{
					self.readOnly = false;
				}
				
			}else{
				self.mode = "1";
			}
		}
		
		//获取部门
		self.getDepList = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/dep/getAlldep.do',
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
				url:'/ccydManagement/admin/adminuser/getUserById.do',
				params:{
					id: $scope.vm.user.userId
				}
			}).then(function(res){
				if(res){
					self.user = res.data;
					self.getHasManager($scope.vm.user.depId);
				}else{
					self.user = "";
				}
			})
		}
		
		//获取岗位
		self.getPostionById = function(){
			//获取部门岗位
			$http({
				method:'POST',
				url:'/ccydManagement/admin/position/getPositionByDepId.do',
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
			
			self.getHasManager($scope.vm.user.depId);
		}
		
		//获取部门是否已有部长
		self.getHasManager = function(depId){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/dep/hasManager.do',
				params:{
					depId: depId
				}
			}).then(function(res){
				if(res){
					$scope.hasManager = res.data.message;
				}else{
					return "Y";
				}
			})
			
			
		}
		
		self.Save = function(){
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
				url:'/ccydManagement/admin/adminuser/insertadminuser.do',
				params:{
					// ADMIN_USER
					id               : $scope.vm.Recruitment.id             , 
					postid           : $scope.vm.Recruitment.postid         , 
					education        : $scope.vm.Recruitment.education      , 
					createUser       : $scope.vm.Recruitment.createUser     , 
					recruitA         : $scope.vm.Recruitment.recruitA       , 
					recruitB         : $scope.vm.Recruitment.recruitB       , 
					recruitC         : $scope.vm.Recruitment.recruitC       , 
					recruitD         : $scope.vm.Recruitment.recruitD       , 
					recruitE         : $scope.vm.Recruitment.recruitE       , 
					recruitF         : $scope.vm.Recruitment.recruitF       , 
					educationRemark  : $scope.vm.Recruitment.educationRemark, 
					professional     : $scope.vm.Recruitment.professional   
				}
			}).then(function(res){
				if(res){
					alert("保存成功!");
				}else{
					alert("保存失败!");
				}
			})
		}

		
		//修改用户
		self.updateUser = function(){
			$http({
				method:'POST',
				url:'/ccydManagement/admin/adminuser/updateuseradmin.do',
				params:{
					// ADMIN_USER
					userId       : $scope.vm.user.userId                         , //用户名
					userName       : $scope.vm.user.userName                         , //用户名
					password       : $scope.vm.user.userName                         , //初始密码
					realName       : $scope.vm.user.realname                         , //姓名
					deleteFlag     : $scope.vm.user.delete_flag                      , //Y,N
					depId          : $scope.vm.user.depid                            , //部门id
					postId         : $scope.vm.user.post_id                          , //岗位ID
					workStatus     : $scope.vm.user.work_status                      , //状态：试用等
					salaryScale    : $scope.vm.user.salary_scale                     , //薪级
					entryDate      : $filter('date')($scope.vm.user.entry_date, "yyyy-MM-dd hh:mm:ss")                       , //入职日期
					workingYears   : $scope.vm.user.working_years                    , //工龄
					salaryBeginDate: $filter('date')($scope.vm.user.salary_begin_date, "yyyy-MM-dd")                , //起薪日
					probationPeriod: $filter('date')($scope.vm.user.probation_period, "yyyy-MM-dd")                  , //试用期限
					expectedDate   : $filter('date')($scope.vm.user.expected_date, "yyyy-MM-dd")                    , //预计转正日
					fwqAgreement   : $scope.vm.user.fwq_agreement                    , //服务期协议
					fwqNum         : $scope.vm.user.fwq_num                          , //服务期金额
					labourBeginTime: $filter('date')($scope.vm.user.labour_begin_time, "yyyy-MM-dd")                , //合同开始时间
					labourEndTime  : $filter('date')($scope.vm.user.labour_end_time, "yyyy-MM-dd")                  , //合同结束时间
					signTime       : $scope.vm.user.sign_time                        , //签订次数
					insuranceBase  : $scope.vm.user.insurance_base                   , //缴费基数
					filingDate     : $filter('date')($scope.vm.user.filing_date, "yyyy-MM-dd")                      , //备案日期
					leaveDate      : $filter('date')($scope.vm.user.leave_date, "yyyy-MM-dd")                       , //离职日期
					retiredDate    : $filter('date')($scope.vm.user.retired_date, "yyyy-MM-dd")                     , //退工日期
					position       : $scope.vm.user.position                         ,//角色
					'adminUserDetail.sex'                 : $scope.vm.user.adminUserDetail.sex            , //性别
					'adminUserDetail.birthday'            : $filter('date')($scope.vm.user.adminUserDetail.birthday, "yyyy-MM-dd")       , //生日
					'adminUserDetail.age'                 : $scope.vm.user.adminUserDetail.age            , //年龄
					'adminUserDetail.birthdayMonth'       : $scope.vm.user.adminUserDetail.birthday_month , //出生月份
					'adminUserDetail.idNumber'             : $scope.vm.user.adminUserDetail.id_number      , //身份证
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
					'adminUserDetail.citizenCard'          : $scope.vm.user.adminUserDetail.citizen_card   , //市民卡
					'adminUserDetail.payrollCard'          : $scope.vm.user.adminUserDetail.payroll_card    //工资卡
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.postlist = [];
				}
			})
		}

		//获取岗位
		self.birthDayChanged = function(){
			var today = new Date();
			var birthDay = $scope.vm.user.adminUserDetail.birthday;
			$scope.vm.user.adminUserDetail.age = today.getYear() - birthDay.getYear();
			$scope.vm.user.adminUserDetail.birthdayMonth = birthDay.getMonth() + 1;
		}
		
		
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
		};
	}
);

angular.bootstrap(document.getElementById("content"), ['myApp']);