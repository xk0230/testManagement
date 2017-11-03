/*function getRandomPassword(){
	var password = getNum()+getNum()+getNum()+getNum()+getNum()+getNum();
	return password;
}
function getNum(){
	var r = Math.random();
	if(r>0.5){
		return (Math.random()*10+"").substring(0,1);
	}else{
		r = Math.random();
		return getCharacter(r);
	}
	
}*/

function getCharacter(r){
	var character = "";
	if(r < 0.5){
		character = String.fromCharCode(Math.floor( Math.random() * 26) + "a".charCodeAt(0));
	}else{
		character = String.fromCharCode(Math.floor( Math.random() * 26) + "A".charCodeAt(0));
	}
	return character;
}

function getRandomPassword()
{
	var text=['abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ','1234567890'];
	var rand = function(min, max){return Math.floor(Math.max(min, Math.random() * (max+1)));}
	var len = rand(6, 18); // 长度
	var password = '';
	for(i=0; i<len; ++i)
	{
		var strpos = rand(0, 2);
		password += text[strpos].charAt(rand(0, text[strpos].length-1));
	}
	return password;
}

function spliPageReloadAfterDelete(splitPage){
	var start = splitPage.req.start;
	var pageSize = splitPage.count;
	var total = splitPage.msg.total;
	if(start < pageSize){
		splitPage.reload();
		return ;
	}
	if((start+pageSize) == total){
		splitPage.req.start = start - pageSize;
		splitPage.req.end = start - 1;
		splitPage.reload();
		return ;
	}
	splitPage.reload();
}

function selectBind(id,url){
	$("#"+id).on('change','select',function(){
		var selectValue = $(this).val();
		$(this).nextAll().remove();
		if ("-1" != selectValue){
			buildSelect(id, url, selectValue);
		}
	});
}
function buildSelect(id,url,paramValue){
	$.post(url,{"parentId":paramValue},function(data){
		var html = '<select class="mr20"><option value="-1">请选择</option>';
		var j = data.length;
		if(j == 0){
			return ;
		}
		for(var i = 0; i<j; i++){
			html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
		}
		html += '</select>';
		$("#"+id).append(html);
	},'json');
}

function getBaseAreaId(domId){
	var areas = $("#"+domId+" select");
	var areaLength = areas.length;
	var baseAreaId = "";
	var baseAreaId1 = "";
	if(areaLength == 1){
		baseAreaId = $(areas[0]).val();
	}else{
		baseAreaId = $(areas[areaLength-2]).val();
		baseAreaId1 =$(areas[areaLength-1]).val();
		if("-1" != baseAreaId1){
			baseAreaId = baseAreaId1;
		}
	}
	return baseAreaId;
}
