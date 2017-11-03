$(function(){
	var $box = $('#category');
	var getChild = function (pId,type) {
		var html = '';
		if(type == 'zs'){
			getSchoolByAreaId(pId);
			return;
		}
		$.post(ROOT+"/admin/commons/getAreasAndLevelByParentId.do",{"parentId":pId},function(data){
			if (data && data.length > 0) {
				html += '<span><label class="labelText">'+data[0].levelName+'：</label><select class="selectArea"><option data-type="all" value="'+pId+'">请选择</option>';
				$.each(data, function () {
					html += '<option data-type="normal" value="'+this.baseAreaId+'">'+this.areaName+'</option>';
				});
				
				if(pId){
					$.post(ROOT+"/admin/commons/getAreaById.do",{"id":pId},function(datazs){
						if(datazs.hasDirectlySchool == 0){
							html += '</select></span>';
						} else {
							html += '<option data-type="zs" value="'+datazs.baseAreaId+'">直属校</option>';
						}
						$box.append(html);
					},"json");
				}else{
					html += '</select></span>';
					$box.append(html);
				}
			}else{
				getSchoolByAreaId(pId);
			}
		},"json");
	};
	$('#category').on('change', '.selectArea', function () {
		$(this).parent().nextAll("span").remove();
		var type = $(this).find("option:selected").attr("data-type");
		if(type != 'all'){
			getChild($(this).val(),type);
		}
	});
	getChild("");
	function getSchoolByAreaId(areaId){
		var html = '';
		$.post(ROOT+"/admin/commons/getSchoolByAreaId.do",{"areaId":areaId},function(data){
			html += '<span><label class="labelText">学校：</label><select data-areaid="'+areaId+'" class="mr20 selectSchool"><option value="">请选择</option>';
			$.each(data,function(){
				html += '<option value="'+this.id+'">'+this.name+'</option>';
			});
			html += '</select></span>';
			$box.append(html);
		},"json");
	}
});

function getSearchHtml(){
	var $searchSel = $('#category').find("span:last select");
	var value = '';
	if($searchSel[0]){
		var searchId = $searchSel.val();
		if($searchSel.hasClass('selectArea')){
			value += $searchSel.val() + ',area';
		}else if($searchSel.hasClass('selectSchool')){
			if(searchId){
				value += $searchSel.val() + ',school';
			}else{
				value += $searchSel.attr("data-areaid") + ',schoolAll';
			}
		}
	}
	return value;
}

