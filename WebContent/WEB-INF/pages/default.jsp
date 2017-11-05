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
	<div id="content">
      <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Dashboard</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                        <!-- Start .row -->
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="carousel-tile carousel vertical slide">
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <div class="tile red">
                                            <div class="tile-icon">
                                                <i class="br-cart s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">107</div>
                                                <h3>Orders</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="tile orange">
                                            <!-- tile start here -->
                                            <div class="tile-icon">
                                                <i class="ec-cog s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">5</div>
                                                <h3>Settings changed</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Carousel -->
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="carousel-tile carousel slide">
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <div class="tile blue">
                                            <div class="tile-icon">
                                                <i class="st-chat s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">24</div>
                                                <h3>New Comments</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="tile brown">
                                            <!-- tile start here -->
                                            <div class="tile-icon">
                                                <i class="ec-mail s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">17</div>
                                                <h3>New emails</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Carousel -->
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="carousel-tile carousel vertical slide">
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <div class="tile green">
                                            <div class="tile-icon">
                                                <i class="ec-users s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">325</div>
                                                <h3>New users</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="tile purple">
                                            <!-- tile start here -->
                                            <div class="tile-icon">
                                                <i class="ec-search s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">2540</div>
                                                <h3>Searches</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Carousel -->
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="carousel-tile carousel slide">
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <div class="tile teal">
                                            <!-- tile start here -->
                                            <div class="tile-icon">
                                                <i class="ec-images s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">45</div>
                                                <h3>New images</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="tile magenta">
                                            <!-- tile start here -->
                                            <div class="tile-icon">
                                                <i class="ec-share s64"></i>
                                            </div>
                                            <div class="tile-content">
                                                <div class="number">3548</div>
                                                <h3>Posts shared</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Carousel -->
                        </div>
                    </div>
        </div>
	</div>

</body>
</html>
