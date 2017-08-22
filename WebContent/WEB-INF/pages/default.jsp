<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/meta.jsp" %>
<link media="all" type="text/css" rel="stylesheet" href="${root}/public/css/photo.css"/>
<style>
html,body{height:100%}
</style>
</head>
<body>
<%@ include file="common/header.jsp" %>
<div id="menuTree">
	<%@ include file="common/side.jsp" %>
</div>
<div id="main">
	<iframe scrolling="yes" frameborder="0" id="mainFrame" name="mainFrame" > </iframe>
</div>
<script src="${root}/public/js/feed.js" type="text/javascript"></script>
<script type='text/javascript'>
	$(document).ready(function(){
		var $tmenu = $('#tmenu').on('click', 'li', function () {
			$tmenu.find('li').removeClass("currMenu");
			var menu = $(this).addClass("currMenu").attr('data-menu');
			$('.submenu>ul').addClass("hide");
			$('.submenu>ul.menu_' + menu).removeClass("hide").find('.menusub a:eq(0)')[0].click();
		})
		$(".quit").click(function(){
			Win.confirm({html:"<p class='noticeWrap'><span>确定退出吗？</span></p>",mask:true},function(){
				$.get("${root}/logOut.do",{},function(data){
					if(data){
						if(data.result){
							location.href='${root}/login.html'
						}else{
							Win.alert("退出失败！");
						}
					}else{
						Win.alert("退出失败！");
					}
				},'json');
			},function(){});
		});
	
		$(".menu .menusub li a").on('click', function() {
			$(".menu .menusub li a").removeClass('tabon');
			$(this).addClass('tabon');
			$(".menu ul li.menulist .menutree1").removeClass('asdfon');
			$(this).parent().parent().parent().find(".menutree1").addClass("asdfon");
		});
	
		$(".menu ul li a").on('click', function() {
			var thisa = $(this);
			$(this).parent().parent().find(".menusub").slideToggle(100,function(){
				if ($(this).css("display") == "block") {
					thisa.removeClass("plus").addClass("mius");
				} else
				thisa.removeClass("mius").addClass("plus");
			});
		});
		$tmenu.find('li:eq(0)').click();
	});
</script>
</body>
</html>
