<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/meta.jsp" %>
<script src="${root }/public/js/basiccheck.js"></script>
</head>
<body class="login-page">

        <div id="login" class="animated bounceIn">
            <img id="logo" src="assets/img/logo.png">
            <!-- Start .login-wrapper -->
            <div class="login-wrapper">
                <ul id="myTab" class="nav nav-tabs nav-justified bn">
                    <li>
                        <a href="#log-in" data-toggle="tab">Login</a>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content bn">
                    <div class="tab-pane fade active in" id="log-in">
                        <form id="loginForm" name="LoginForm"   method="post" class="form-horizontal mt10" >
                           <div class="form-group">
                              <div class="col-lg-12">
                                  <input type="text" name="userName" id="userName" class="form-control left-icon" placeholder="账号" needcheck nullmsg="请输入账号!" limit="6" limitmsg="账号长度不少于6个字符！">
                                  <i class="ec-user s16 left-input-icon"></i>
                              </div>
                           </div>
                           <div class="form-group">
                               <div class="col-lg-12">
                                   <input type="password" name="password" class="form-control left-icon" placeholder="密码" needcheck nullmsg="账号或密码错误，请重新输入!">
                                   <i class="ec-locked s16 left-input-icon"></i>
                                   <span class="help-block"><a href="#"><small>Forgout password ?</small></a></span> 
                               </div>
                           </div>
                           <div class="form-group">
                               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-8">
                                   <!-- col-lg-12 start here -->
                                   <label class="checkbox">
                                       <input type="checkbox" name="remember" id="remember" value="option">Remember me ?
                                   </label>
                               </div>
                               <!-- col-lg-12 end here -->
                               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-4">
                                   <!-- col-lg-12 start here -->
                                   <input class="btn btn-success pull-right" type="submit" value="登录"/>
                               </div>
                               <!-- col-lg-12 end here -->
                           </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- End #.login-wrapper -->
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