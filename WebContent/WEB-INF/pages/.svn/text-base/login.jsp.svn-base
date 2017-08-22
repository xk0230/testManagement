<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/meta.jsp" %>
<script src="${root }/public/js/basiccheck.js"></script>
</head>
<body class="adminSchool">
<div class="container">
	<div class="wrap">
		<div class="textBg"><img src="${root }/public/img/login/text.png" /></div>	
		<div class="box">
			<form id="loginForm" name="LoginForm"  method="post" >
				<p><input type="text" name="userName" id="userName" class="nameValue" placeholder="账号" needcheck nullmsg="请输入账号!" limit="6" limitmsg="账号长度不少于6个字符！"></p>
				<p><input type="password" name="password" class="nameValue" placeholder="密码" needcheck nullmsg="账号或密码错误，请重新输入!"></p>
				<p class="initBtn" >
					<input class="startBtn btn" type="submit" value="登录"/>
				</p>
			</form>
		</div>
	</div>
	<div class="footer">
		<div class="footerInner">
			<p>版权所有&copy;2007-2015  阔地教育科技有限公司</p>
			<div class="footerBox">
				<img src="${root }/public/img/common/logo.gif"/>
				<img src="${root }/public/img/login/contact.gif"/>
			</div>
		</div>
	</div>
</div>
<script>
	$("#userName").focus();
	//表单验证
	new BasicCheck({
		form: $id("loginForm"),
		ajaxReq : function(){
			//ajax提交
			$.post('${root}/loginValidate.do', $("#loginForm").serializeArray(), function(data){
				if(data){
					if(data.result){
						window.location.href = "${root}/admin/index.html";
					}else{
						Win.alert(data.message);
					}
				}else{
					Win.alert("登录失败!");
				}
			});
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
	});

</script>

</body>
</html>