<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/OperationManagement/public/js/basiccheck.js"></script>
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>  
<title>Insert title here</title>

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
                		
					   html += '<label><input name="functionList" type="checkbox" value="'+data[i].adminPermissionId+'"/>'+data[i].permissionName+'</label>';
                	}
                	
                	$(".boxContent").html(html);
                  }
                );
                
                return false;
         
        }
     )

</script>

<!--  
   phone 验证
   
   <input type="text" name="repairmanContact" id="repairmanContact" 
class="repairman_contact" value="${mal.repairmanContact}"  errormsg="请输入正确的电话号码！" 
reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" allownull needcheck>

-->
		

</head>
<body>


<label class="text">上传附件：</label>
            				<span style="display: none" id="attached">上传成功！</span>
							<span style="display: none" id="uploadAttachedProgress"></span>
							<input id="attachedVal" type="hidden"/>
							<a href="javascript:;" id="attachedBtn" class="uploadBox btn" onclick="return false;">
								上传<span id="uploadAttachedCont" class="uploadCont"></span>
							</a>
							<span id="originalName"></span>
							<span style="color:red">（注：支持上传最大5M的附件）</span>

    
<script>
//---------------------------------  附件上传 ------------------------------------
var paramsAttached = {
		autoStart 	: false,
		fileType	: "*.ppt; *.pptx; *.doc; *.docx; *.xls; *.xlsx; *.pdf;" ,
		typeDesc 	: "附件",
		sizeLimit 	: 5*1024*1024,// 5M大小限制
		server: encodeURIComponent("${root}/ImageUploadServlet")
	};
window.uploadSwf = new UploadFile($id("uploadAttachedCont"), "uploadSwf", "${root}/public/upload/uploadFile.swf",paramsAttached);

uploadSwf.uploadEvent.add("onSelect",function(){
	$("#originalName").text(arguments[0].message.name) ;
	var info = arguments[0].message;
	$("#attached").hide();
	uploadSwf.startUpload();  //如未设置autoStart，此处正式调用上传,可传入server地址
});
uploadSwf.uploadEvent.add("onProgress",function(){
	var d = arguments[0].message;
	$("#uploadAttachedProgress").show();
	$("#uploadAttachedProgress").html("上传进度：" + (d[0]/d[1]*100 >>0)+"%");
});
uploadSwf.uploadEvent.add("onFail",function(){
		var data = arguments[0].message;
		$("#uploadAttachedProgress").html("<span class='red'>上传失败！</span>");
	});
	
	
uploadSwf.uploadEvent.add("onComplete",function(){
	var jsonData = JSON.parse(arguments[0].message);
	$("#uploadAttachedProgress").hide();// 隐藏进度
	$("#attached").show();// 显示图片
	$id("attachedVal").value = jsonData.message;
});
uploadSwf.uploadEvent.add("noticeSizeError",function(){
	Win.alert("附件限制大小5M！");
});

</script>
</body>
</html>