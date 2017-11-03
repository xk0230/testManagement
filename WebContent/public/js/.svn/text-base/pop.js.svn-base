var popUi = (function () {
	var $popUi, showingTarget, showedTarget;
	var time,  //浮出层定时器
		posX,  //弹出层x轴位置
		posY,  //弹出层y轴位置
		tipW,  //浮出层宽
		tipH,  //悬浮层高
		bodyW = document.documentElement.clientWidth;
		bodyH = document.documentElement.clientHeight;
		
	return {
		init: function () {
			var self = this;
			$popUi = $('<div class="pop-ui"><div class="pop-in"><div class="pop-cont"></div><div class="arr"></div><div class="arr-in"></div></div></div>').appendTo('body');
			$(window).resize(function(){
				bodyW = document.documentElement.clientWidth;
				bodyH = document.documentElement.clientHeight;
			});					
			
			$popUi.on('mouseenter', function(){
				showingTarget = showedTarget;
				clearTimeout(time);
			}).on('mouseleave', function(){
				self._hide($(showingTarget));
			});
			this.bindEvent(".pop-target");
		},
		bindEvent: function (selector) {
			var self = this;
			$(document).on('mouseenter mouseover', selector, function(event){		
				if (showedTarget == this) {
					self._pos(this);
				}
				if (event.type == "mouseenter") {
					self._show($(this));
				}
			}).on('mouseleave', selector, function(){
				self._hide($(this));
			});
		},
		_pos: function (elm) {
			tipW = $popUi.width();
			tipH = $popUi.height();
			var $target = $(elm);
			var targetW = $target.width(),  //目标元素的宽
				targetH = $target.height(),  //目标元素的高
				targetX = $target.offset().left;  //目标元素的x轴位置
				targetY = $target.offset().top;  //目标元素的y轴位置

			//判断悬浮层位置在左或右
			if (bodyW - (targetX + targetW) >= tipW) {
				posX = targetX + targetW + 12;
				$popUi.removeClass('arr-to-right')
						.css({
							left: posX
						})
			} else {
				console.log(tipW)
				posX = targetX - tipW - 12;
				$popUi.addClass('arr-to-right')
						.css({
							left: posX
						})
			}

			//判断悬浮层位置在上或下
			if (bodyH - (targetY + targetH) >= tipH) {
				posY = targetY - 22;
				$popUi.removeClass('arr-to-bottom').css({
					top: posY,
					bottom: 'auto'
				})
			} else {
				posY = bodyH - targetY - 62;
				$popUi.addClass('arr-to-bottom').css({
					top: 'auto',
					bottom: posY
				})
			}

		},
		_hide: function ($target) {
			var self = this;
			showingTarget = null;
			clearTimeout(time);
			time = setTimeout(function(){
				if (showedTarget == $target[0] || showingTarget == null) {
					self.onHide();
					$popUi.hide();
					showingTarget = showedTarget = null;
				}
			}, 200);
		},
		_show: function ($target) {
			var self = this;
			clearTimeout(time);
			showingTarget =  $target[0];
			time = setTimeout(function(){
				self.onShow($target, function () {
					if (showingTarget ==  $target[0]) {
						self._pos(showingTarget);
						$popUi.show();
						showedTarget = $target[0];
					}
				})
			}, 200);
		},
		html: function (h) {
			$popUi.find('.pop-cont').html(h);
		},
		onShow: function ($target, showFn) {
			showFn();
		},
		onHide: function () {
			
		}
	}
})();