var myAppModule = angular.module("myApp",['ui.bootstrap']);
realname_init = $('#realname').val();
myAppModule.controller('UserListController',
	function UserListController($scope,$http){
		var self = this;
		//模块显示
		self.add = true;
		self.edit = true;
		self.mode;
		//
		self.user = {
				userName :"",
				password :"",
				realname :realname_init,
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
				position :""		 //角色'
		}
		
		self.userDetail = {
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
		
		self.$onInit = function(){
			//设置模块显示
			self.add = true;
			self.edit = true;
			//设置部门下拉框
			this.getDepList();
		}
		
		//获取部门
		self.getDepList = function(){
			$http({
				method:'POST',
				url:'../dep/getAlldep.do',
				params:{
				}
			}).then(function(res){
				if(res){
					self.deplist = res.data || [];
				}else{
					self.list = [];
				}
			})
		}
		
		//获取岗位
		self.getPostionById = function(){
			$http({
				method:'POST',
				url:'../position/getPositionByDepId.do',
				params:{
					depId: $scope.vm.user.depid
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.list = [];
				}
			})
		}
		
		//新增用户
		self.addUser = function(){
			$http({
				method:'POST',
				url:'insertadminuser.do',
				params:{
					userName       : $scope.vm.user.userName                         , //用户名
					password       : $scope.vm.user.userName                         , //初始密码
					realName       : $scope.vm.user.realname                         , //姓名
					deleteFlag     : $scope.vm.user.delete_flag                      , //Y,N
					depId          : $scope.vm.user.depid                            , //部门id
					postId         : $scope.vm.user.post_id                          , //岗位ID
					workStatus     : $scope.vm.user.work_status                      , //状态：试用等
					salaryScale    : $scope.vm.user.salary_scale                     , //薪级
					entryDate      : $scope.vm.user.entry_date                       , //入职日期
					workingYears   : $scope.vm.user.working_years                    , //工龄
					salaryBeginDate: $scope.vm.user.salary_begin_date                , //起薪日
					probationPeriod: $scope.vm.user.probation_period                 , //试用期限
					expectedDate   : $scope.vm.user.expected_date                    , //预计转正日
					fwqAgreement   : $scope.vm.user.fwq_agreement                    , //服务期协议
					fwqNum         : $scope.vm.user.fwq_num                          , //服务期金额
					labourBeginTime: $scope.vm.user.labour_begin_time                , //合同开始时间
					labourEndTime  : $scope.vm.user.labour_end_time                  , //合同结束时间
					signTime       : $scope.vm.user.sign_time                        , //签订次数
					insuranceBase  : $scope.vm.user.insurance_base                   , //缴费基数
					filingDate     : $scope.vm.user.filing_date                      , //备案日期
					leaveDate      : $scope.vm.user.leave_date                       , //离职日期
					retiredDate    : $scope.vm.user.retired_date                     , //退工日期
					position       : $scope.vm.user.position                          //角色'
				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.list = [];
				}
			})
		}
		
		//修改用户
		self.updateUser = function(){
			$http({
				method:'POST',
				url:'updateuseradmin.do',
				params:{
					// ADMIN_USER
					userName       : $scope.vm.user.userName                         , //用户名
					password       : $scope.vm.user.userName                         , //初始密码
					realName       : $scope.vm.user.realname                         , //姓名
					deleteFlag     : $scope.vm.user.delete_flag                      , //Y,N
					depId          : $scope.vm.user.depid                            , //部门id
					postId         : $scope.vm.user.post_id                          , //岗位ID
					workStatus     : $scope.vm.user.work_status                      , //状态：试用等
					salaryScale    : $scope.vm.user.salary_scale                     , //薪级
					entryDate      : $scope.vm.user.entry_date                       , //入职日期
					workingYears   : $scope.vm.user.working_years                    , //工龄
					salaryBeginDate: $scope.vm.user.salary_begin_date                , //起薪日
					probationPeriod: $scope.vm.user.probation_period                 , //试用期限
					expectedDate   : $scope.vm.user.expected_date                    , //预计转正日
					fwqAgreement   : $scope.vm.user.fwq_agreement                    , //服务期协议
					fwqNum         : $scope.vm.user.fwq_num                          , //服务期金额
					labourBeginTime: $scope.vm.user.labour_begin_time                , //合同开始时间
					labourEndTime  : $scope.vm.user.labour_end_time                  , //合同结束时间
					signTime       : $scope.vm.user.sign_time                        , //签订次数
					insuranceBase  : $scope.vm.user.insurance_base                   , //缴费基数
					filingDate     : $scope.vm.user.filing_date                      , //备案日期
					leaveDate      : $scope.vm.user.leave_date                       , //离职日期
					retiredDate    : $scope.vm.user.retired_date                     , //退工日期
					position       : $scope.vm.user.position                         ,//角色
					
					sex                 : $scope.vm.userDetail.sex            , //性别
					birthday            : $scope.vm.userDetail.birthday       , //生日
					age                 : $scope.vm.userDetail.age            , //年龄
					birthdayMonth       : $scope.vm.userDetail.birthday_month , //出生月份
					dNumber             : $scope.vm.userDetail.id_number      , //身份证
					rigin               : $scope.vm.userDetail.origin         , //籍贯
					omicile             : $scope.vm.userDetail.domicile       , //户籍
					ation               : $scope.vm.userDetail.nation         , //民族
					arriage             : $scope.vm.userDetail.marriage       , //婚姻
					olitical            : $scope.vm.userDetail.political      , //政治面貌
					ducation            : $scope.vm.userDetail.education      , //学历
					ajor                : $scope.vm.userDetail.major          , //专业
					niversity           : $scope.vm.userDetail.university     , //毕业院校
					hone1               : $scope.vm.userDetail.phone1         , //电话号码
					hone2               : $scope.vm.userDetail.phone2         , //电话号码
					itizenCard          : $scope.vm.userDetail.citizen_card   , //市民卡
					ayrollCard          : $scope.vm.userDetail.payroll_card    //工资卡

				}
			}).then(function(res){
				if(res){
					self.postlist = res.data || [];
				}else{
					self.list = [];
				}
			})
		}
		
		//获取岗位
		self.birthDayChanged = function(){
			var today = new Date();
			var birthDay = $scope.vm.userDetail.birthday;
			$scope.vm.userDetail.age = today.getYear() - birthDay.getYear();
			$scope.vm.userDetail.birthday_month = birthDay.getMonth() + 1;
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