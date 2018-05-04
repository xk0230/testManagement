﻿events.addEvent(window,"load",function(){
	//table中的全选框
    $(".selectAll").click(function() {
        var checkValue = this.checked,
            checkboxs = $(this).parents(".tableBox").find("input[type=checkbox]");
        for (var i in checkboxs) checkboxs[i].checked = checkValue;
    });
    events.delegate($tag("body"), ".childChk", "click", function() {
        var e = arguments[0] || window.event,
            target = e.target || e.srcElement;
        var checkValue = target.checked;
        var tableBox = $(target).parents(".tableBox"),
            childChks = $class("childChk", tableBox[0]),
            selectAll = $class("selectAll", tableBox[0])[0];
        if (checkValue) {
            //选中
            for (var i = 0; i < childChks.length; i++) {
                if (!childChks[i].checked) return;
            }
            selectAll.checked = true;
        } else {
            //取消
            selectAll.checked = false;
        }
    });

    //删除当前item
    events.delegate($tag("body"), ".itemDel", "click", function() {
        var e = arguments[0] || window.event,
            target = e.target || e.srcElement;
        if(hasClass(target,"itemDel") && target.getAttribute("customDel") == null){
        	 target.parentNode.removeChild(target);
        }
    });
    
    //切换
    $(".tabRange a").click(function(){
    	if($(this).hasClass("firstRange")){
    		$(this).parent().removeClass("tabCoverRange");
    	}else{
    		if($(this).hasClass("secondRange")) $(this).parent().addClass("tabCoverRange");
    	}
    });
    
    //字数统计
    $("body").on("keyup input propertychange",".counterBox textarea",function(){
    	var realValue = String.trim ? this.value.trim() : this.value.replace(/(^\s*)|(\s*$)/g, ""),
        		len = realValue.replace(/[\u4e00-\u9fa5]/g, 'xx').length/2>>0,
    	    	limit = this.getAttribute("limit-len");
        	$(this).parent(".counterBox").find(".limitCount").html(limit-len);
    });
    

    //星星评分
    events.addEvent($class("starRate"),"mousemove",function(){
    	if(hasClass(this,"disabled")) return;
    	var e = arguments[0] || window.event,
    		posX = e.offsetX || e.layerX,
    		allW = this.offsetWidth,
    		rateValue = Math.round(posX/allW*10);
    		this.setAttribute("rateValue",rateValue);
    		this.id = "star"+rateValue;
    });
    events.addEvent($class("starRate"),"mouseleave",function(){
    	if(hasClass(this,"disabled")) return;
    	this.id = "";
    });
    events.addEvent($class("starRate"),"click",function(){
    	if(hasClass(this,"disabled")) return;
    	var rateValue = this.getAttribute("rateValue");
    	$tag("a",this)[0].className = "star"+rateValue;
    	var inputBox = $tag("input[name=starValue]",this);
    	if(inputBox.length > 0){
    		inputBox[0].value = rateValue;
    	}else{
    		inputBox = document.createElement("INPUT");
    		inputBox.name = "starValue";
    		inputBox.type = "hidden";
    		inputBox.value = rateValue;
    		this.appendChild(inputBox);
    	}
    });
});
