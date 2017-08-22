    //编辑图片
    function editPicture(){
        var j = $("#uploadInfoBox").children().length;
        if (j > 0){
            parent.attach = {};
            var images = [];
            var url = null;
            var name = null;
            var picDesc = null;
      
         for(var i = 0; i < j; i++){
             
             url = $($("#uploadInfoBox").find("li")[i]).find("input[name='newFileName']").val();
             name = $($("#uploadInfoBox").find("li")[i]).find("input[name='oraginalFileName']").val();
             picDesc = $($("#uploadInfoBox").find("li")[i]).find("input[name='picDesc']").val();
        
             //创建对象
             var obj = new Object();
              obj.attachment_Url = url;
              obj.name = name;
              obj.remark = picDesc;
              //放入list
              images.push(obj);
         }
          parent.attach["attach"] = images;
          parent.Win.open({
            id   :"editPicture",
            url  :"../classroominspect/toeditphoto.do",
            title:"编辑照片",
            width:800,
            height:550,
            mask:true
        });
       }else{
           Win.alert("请上传图片！");
       }  
    }
    
    //查看图片
    function viewPicture(){
        var j = $("#uploadInfoBox").children().length;
        if (j > 0){
            parent.attach = {};
            var images = [];
            var url = null;
            var name = null;
            var picDesc = null;
      
         for(var i = 0; i < j; i++){
             
             url = $($("#uploadInfoBox").find("li")[i]).find("input[name='newFileName']").val();
             name = $($("#uploadInfoBox").find("li")[i]).find("input[name='oraginalFileName']").val();
             picDesc = $($("#uploadInfoBox").find("li")[i]).find("input[name='picDesc']").val();
        
             //创建对象
             var obj = new Object();
              obj.attachment_Url = url;
              obj.name = name;
              obj.remark = picDesc;
              //放入list
              images.push(obj);
         } 
          parent.attach["attach"] = images;
          parent.Win.open({
                id   :"viewPhoto",
                url  :"../classroominspect/toviewphoto.do?flag=pre",
                title:"查看照片",
                width:800,
                height:550,
                mask:true
            });
           }else{
               Win.alert("请上传图片！");
           }  
    }

    parent.editPicDesc = function (data){
		 var picNames = data.picNames;
		 var picDescs = $("#uploadInfoBox").children().find("input[type='text']");
		 picDescs.each(function(index, elem){
			$(elem).val(picNames[index]);
		 });
	}
	
	parent.deleteImg = function (data){
		 var image = data.imgs;
		 var value = null;
		 var num = $("#number").html();
		 var id = image.substring(image.indexOf("images/")+ "images/".length, image.lastIndexOf("/"));
		 $("#"+id).remove();
	     $("#uploadInfoBox").children().each(function(){
	    	  value = $(this).find("input[name='newFileName']").val();
	    	  if(value === id){
	    		  $(this).find("input[name='newFileName']").parent().parent().remove();
	    		  num--;
	    		  $("#number").html(num);
	    	  }
	     });
	}