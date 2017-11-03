<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../common/meta.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>

var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作

$(
		function(){
			
			new BasicCheck({
				form: $id("updateForm"),
				ajaxReq : function(){
					
					 $.post('${root}/admin/adminuser/updateuseradmin.do',$("#updateForm").serialize(),function(r){
			                try {
			                    if(!r.result){
			                        Win.alert('操作失败！');
			                    }else{
			                    
			                    		parent.Win.alert('操作成功!');
				                        parent.location.reload();
			                    	
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

</script>		

</head>
<body>
 
                                     
   <form  id="updateForm">
   
     <ul class="commonUL" style="margin-left:20px;">
        <li class="clearfix" style="margin:5px 0 15px;">
		     <input type="hidden" id="userId" value="${requestScope.user.adminUserId}" name="adminUserId"/>
		     <input type="hidden" value="${requestScope.user.locked}" id="lock"/>
		     
		     <c:set var="per"  ></c:set>
		     <c:forEach items="${requestScope.user.adminUserPer}" var="adminUser">
		     		<c:set  var="per"  value="${per},${adminUser.adminPersId}" ></c:set>
		     </c:forEach>
		     	
		     	
		     <input type="hidden" value="${requestScope.user.adminUserPer}" id="checkBoxList"/> 
		     
             <label>用户名:</label>
             <input type="text" id="userName" disabled="disabled"  value="${requestScope.user.userName}" name="userName" needcheck nullmsg="请输入用户名!" limit="6,36" limitmsg="很抱歉，用户名长度需要是6到18个字符！" />
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">      
              <label>状态:</label>
              <label><input id="open" name="locked" type="radio" value="N" />开启</label>&nbsp;
              <label><input id="close" name="locked" type="radio" value="Y" />关闭</label>
        </li> 
        <li class="clearfix" style="margin:5px 0 15px;">    
              <label>姓名:</label>
              <input type="text" value="${requestScope.user.realName}" name="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名长度为1到10个字"/>
        </li>        
        <li class="clearfix" style="margin:5px 0 15px;">        
              <label>联系电话:</label>
              <input type="text" value="${requestScope.user.contact}" name="contact" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
        </li>
        <%-- <li class="clearfix" style="margin:5px 0 15px;">        
              <label>微信号:</label>
              <input type="text" value="${requestScope.user.weixin_num}" name="weixin_num" needcheck nullmsg="请输入微信号!"/>
        </li> --%>       
        <li class="clearfix" style="margin:5px 0 15px;">        
              <label>职位:</label>
              <input type="text" value="${requestScope.user.position}" name="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位长度需要为1到10个字"/> 
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">        
               <label>密码:</label>
              <input type="text" name="password"/>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
      <!--显示所有复选框组件 -->
		      <div class="boxContent"></div><br/>
		      <input type="submit" class="btn btnGreen" value="确定"/>&nbsp;&nbsp;<input class="btn btnGreen" type="reset" value="取消" onclick="closeMe()"/>
        </li>
     </ul>
    </form>    
<script type="text/javascript">
   
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
                	
                	var userId=$("#userId").val();
                	//不允许修改超级管理员的权限
                	if("admin"!=userId){
                		$(".boxContent").html("功能:&nbsp;&nbsp;"+html);
                	}
                	
                	
                	//获得传来的复选框的value值  并将用户注册时选择的处于选中状态
                    var $userId =$("input[type='hidden']").val();
                    var locked=document.getElementById("lock").value;
                    $("input[value="+locked+"]").attr("checked","checked");
                    //普通用户不能编辑超级管理员的开启关闭状态(即将超级管理员的开启关闭设置为不可编辑)
                    if("admin"==$userId){
                    	$("#open").attr("disabled","disabled");
                    	$("#close").attr("disabled","disabled");
                    }
                    var permitId="${per}";
                    var idArray=permitId.split(",");
                    //alert("idArray="+idArray[1]);
                    //截取之后下标0为空串即不参与遍历
                    //alert("idArray="+idArray.length);
                    for(var i=1; i<idArray.length; i++){
                    	
                    	//alert("id="+idArray[i]);
                    	$("input:checkbox[value="+idArray[i]+"]").attr("checked","checked");
                    }
                   
                  }
                );   
             
         }
        
        
        
    ) 
    
    //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
</script>
</body>

</html>