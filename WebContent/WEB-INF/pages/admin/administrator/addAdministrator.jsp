<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${root}/public/js/basiccheck.js"></script>
<title>Insert title here</title>

<script type="text/javascript">
var domid = "";
if (window.frameElement) {
	domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
}
$(
    function(){
    	//alert("ok");
        var url="${root}/admin/adminuser/permissionNameList.do";
            var args={};
            $.post(
              url,
              args,
              function(data){
            	  var html='';
            	for(var i=0; i<data.length; i++){
            		
	   html += '<label><input name="functionList" type="checkbox" value="'+data[i].adminPermissionId+'"/>'+data[i].permissionName+'</label>&nbsp;&nbsp;&nbsp;&nbsp;';
            	}
            	
            	$(".boxContent").html("功能:&nbsp;&nbsp;"+html);
              }
            );
            
            return false;
     
    }
    
 )

     //关闭窗口
 	function closeMe() {
 		parent.Win.wins[domid].close();
 	}
</script>

<!--  
   phone 验证
   
   <input type="text" name="repairmanContact" id="repairmanContact" 
class="repairman_contact" value="${mal.repairmanContact}"  errormsg="请输入正确的电话号码！" 
reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" allownull needcheck>

-->
<script>
$(
		function(){
			
			new BasicCheck({
				form: $id("userForm"),
				ajaxReq : function(){
					console.log("tijiao");
					
			 		$currVal=$("#userName").val();
					  $.post('${root}/admin/adminuser/insertadminuser.do',$("#userForm").serialize(),function(r){
			              console.log(r); 
						  try {
			                	console.log(r.result);
			                    if(!r.result){
			                        Win.alert('操作失败！');
			                    }else{
			                    	if(1==r.code){
			                    		parent.Win.alert('用户名已存在!');
			                    	}else if(2==r.code){
			                    		parent.Win.alert('操作成功!');
				                        parent.location.reload();
			                    	}
			                        
			                    }
			                } catch(e) {
			                    Win.alert("错误提示:"+e.message);
			                }
			            });
				},
				warm: function warm(o, msg) {
					Win.alert(msg);
				} 
			});
		}
)


 //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
</script>		

</head>
<body class="chase-ask">
    <form  id="userForm">
    
    <ul class="commonUL" style="margin-left:20px;">
        <li class="clearfix" style="margin:5px 0 15px;">
          <input type="hidden" value="" name="adminUserId"/>  
         <label> 用户名:</label>
          <input type="text" id="userName" name="userName" needcheck nullmsg="请输入用户名!" limit="6,36" limitmsg="很抱歉，用户名长度需要是6到18个字符！"/>
        </li>  
       
<!--        <li class="clearfix" style="margin:5px 0 15px;">    
          <label>状态:</label>
        <label><input name="locked" type="radio" value="N" checked="checked" />开启</label>&nbsp;
         <label><input name="locked" type="radio" value="Y" />关闭</label>
       </li> -->
       <li class="clearfix" style="margin:5px 0 15px;"> 
              <label>姓名:</label>
              <input type="text" name="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名长度为1到10个字"/>
       </li>
  <!--      <li class="clearfix" style="margin:5px 0 15px;"> 
              <label>联系电话:</label>
              <input type="text" name="contact" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
        </li>  -->
       <!-- <li class="clearfix" style="margin:5px 0 15px;">    
              <label>微信号:</label>
              <input type="text" name="weixin_num" needcheck nullmsg="请输入微信号!"/>
       </li> -->
 <!--        <li class="clearfix" style="margin:5px 0 15px;">     
             <label>职位:</label>
              <input type="text" name="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位长度需要为1到10个字"/>
        </li>   -->
         <li class="clearfix" style="margin:5px 0 15px;">   
              <label>密码:</label>
              <input type="text" id="pawd" name="password" value="666666" needcheck nullmsg="请输入密码!"/>
         </li>
        <li class="clearfix" style="margin:5px 0 15px;">
      <!--显示所有复选框组件 -->
		     <div class="boxContent"></div><br/>
		      
		      <input type="submit" class="btn btnGreen" value="确定"/>&nbsp;&nbsp;<input type="reset" class="btn btnGreen" value="取消" onclick="closeMe()"/>  
        </li>
     </ul>
    </form>
    
    <script type="text/javascript">
    //鼠标锁定
         $("#pawd").focus(function(){
        	 
        	 //获得当前的值
        	 $currVal=$(this).val();
        	 if($currVal==this.defaultValue){
        		 $(this).val(""); 	 
        	 }else{
        		 $(this).val($currVal);
        	 }
          }	 
         )
         
         //鼠标移出
         $("#pawd").blur(function(){
        	 
        	 //获得当前的值
        	 $currVal=$(this).val();
        	 if($currVal==""){
        		 $(this).val(this.defaultValue); 	 
        	 }else{
        		 $(this).val($currVal);
        	 }
          }	 
         
     
         )
         
        
         //验证用户名唯一
         $("#userName").blur(function(){
        	 
        	 //获得当前的值
        	 $currVal=$(this).val();
        	 
    		 var url="${root}/admin/adminuser/selUserName.do?userName="+$currVal;
             var args={};
             $.post(
               url,
               args,
               function(datas){
            	    
            	   if(''!=datas){
            		   
            		   Win.alert("用户名已存在！");
            	   }
               }
            
             );
          }	 
         
     
         )
         
         
         
         
    </script>
</body>
</html>