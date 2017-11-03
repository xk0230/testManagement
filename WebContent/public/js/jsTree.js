(function ($, undefined) {
	var noop = function () {};
	var slice = Array.prototype.slice;
	var _clearSelect; 
	if (window.getSelection) {
		_clearSelect = function () {
			window.getSelection().removeAllRanges()
		}
	} else {
		_clearSelect = function () {
			document.selection.empty();
		}
	}
	var defaults = {
		filter: function () {
			return true;
		},
		onExpand: function (data, $li, callback) {
			this.loadNode(data.childs, $li);
			callback();
		},
		hasCheckBox: true,
		extendTree: {},
		treeType: 1,
		dragSelector: false,
		clickItem: noop,
		onDragEnd: noop,
		extraHtml: '',
		hasChild: false,
		idKey: 'id',
		nameKey: 'name',
		delCheckLeaf: false,
		dragCheck: function (data) {
			return true;
		}
	};
	var $doc = $(document);
	function JsTree($elm, options) {
		this.$elm = $elm;
		this.options = options;
		this.nodeMap = {jsTree: {__deep: 0, childs: []}};
		$.extend(this, options.extendTree);
		this.init();
	}
	JsTree.prototype = {
		init: function () {
			var options = this.options;
			this.$elm.addClass('jsTree-warper jsTree-root jsTree-deep0').attr("data-deep", 0);
			this.$root = $('<div class="jsTree-node"></div>').appendTo(this.$elm).attr('data-id', 'jsTree');
			this['bindEvent' + options.treeType]();
			if (options.dragSelector) {
				this.bindDrag(options.dragSelector);
			}
			if (options.treeData) {
				this.loadNode(options.treeData, this.$root);
			}
		},
		bindDrag: function (dragSelector) {
			var options = this.options;
			var changeCursorTimeId = 0;
			var self = this;
			var $warp = this.$elm.on('mousedown', dragSelector, function (event) {
				if (event.which == 1) {
					event.stopPropagation();//防止冒泡，多结点绑定拖动
					
					var $target = $(event.target);
					if ($target.hasClass('jsTree-expandBtn')) {
						return;
					}
					
					var $dragElm = $(this);
					var res = options.dragCheck.call(self, self.getData($dragElm));
					if (res === false) {
						return;
					}
					var $siblings = $dragElm.siblings();
					//if ($siblings.length == 0) return;
					var downPos = [event.clientX, event.clientY];
					var startIndex = $dragElm.index();
					var nowIndex = startIndex;
					var statrDrag = false;
					var $dragElmClone;
					var $placeHolder;
					var downElm;
					var lastClientY;
					var $siblingsTab = [];
					var dragWidth, dragHeight;
					var dirY = 'down';
					var $upElm, $downElm, upElmHeight;
					clearTimeout(changeCursorTimeId);
					changeCursorTimeId = setTimeout(function () {
						$dragElm.find('label').css("cursor", "move");
					}, 200);
					var target = event.target;
					if (target.setCapture) {
						target.setCapture();
					} else if (document.body.setCapture) {
						document.body.setCapture();
					} else if(window.captureEvents) {
						window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
					}
					var moveTrigger = function (event) {
						_clearSelect();
						if (!statrDrag) {
							statrDrag = true;
							lastClientY = event.clientY;
							dragHeight = $dragElm.height();
							dragWidth = $dragElm.width();
							downElm = [$dragElm[0].offsetLeft, $dragElm[0].offsetTop];
							$siblings.each(function () {
								$siblingsTab.push($(this));
							});
							$dragElmClone = $dragElm.clone()
													.css({position: "absolute", opacity: 0.8, "z-index": 999, height: dragHeight, width: dragWidth})
													.insertAfter($dragElm.hide());
							$placeHolder = $('<li class="jsTree-dragHolder" style="height: ' + dragHeight + 'px; width: ' + dragWidth + 'px;"></li>').insertAfter($dragElm);
							$upElm = $siblingsTab[nowIndex-1];
							$downElm = $siblingsTab[nowIndex];
							if ($upElm) {
								upElmHeight = $upElm.height();
							}
						} else {
							var disX = downElm[0] + (event.clientX - downPos[0]);
							var disY = downElm[1] + (event.clientY - downPos[1]);
							$dragElmClone.css({left: disX, top: disY});
							if (event.clientY - lastClientY >= 6) {
								dirY = "down";
								lastClientY = event.clientY;
							} else if (event.clientY - lastClientY <= -6) {
								dirY = "up";
								lastClientY = event.clientY;
							}
							var isChangePos = false;
							if (dirY == "down") {//向下拖动
								if ($downElm && (disY > $downElm[0].offsetTop)) {//交换位置
									$downElm.after($placeHolder);
									isChangePos = true;
									nowIndex++;
								}
							} else {
								//if ($upElm && (disY < $upElm[0].offsetTop + upElmHeight)) {
								if ($upElm && (disY < $upElm[0].offsetTop)) {
									$upElm.before($placeHolder);
									isChangePos = true;
									nowIndex--;
								}
							}
							if (isChangePos) {
								$upElm = $siblingsTab[nowIndex-1];
								$downElm = $siblingsTab[nowIndex];
								if ($upElm) {
									upElmHeight = $upElm.height();
								}
							}
						}
					};
					$doc.on('mousemove', moveTrigger).one('mouseup', function (event) {
						var target = event.target;
						if (target.setCapture) {
							target.releaseCapture();
						} else if (document.body.setCapture){
							document.body.releaseCapture();
						} else if(window.captureEvents) {
							window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
						}
						$doc.off('mousemove', moveTrigger);
						clearTimeout(changeCursorTimeId);
						$dragElm.show().find('label').css("cursor", "pointer");
						if ($placeHolder) {
							$placeHolder.after($dragElm);
							$placeHolder.remove();
							$dragElmClone.remove();
							if (startIndex != nowIndex){
								options.onDragEnd.call(self, $dragElm, startIndex, nowIndex);
							}
						}
						$siblings = null;
						$dragElm = null;
						statrDrag = false;
					});
				}
			})
		},
		bindEvent1: function () {
			var self = this;
			this.$elm.on('click', '.jsTree-node>.jsTree-content', function (event) {
				var $label = $(this);
				var $li = $label.parent();
				var $ul = $li.find('ul:eq(0)');
				var target = event.target;
				if (target.tagName.toUpperCase() == 'INPUT') {
					var checked = target.checked;
					$ul.find('input').each(function () {
						this.checked = checked;
					})
					self._checkParent($li, checked);
					return;
				}
				if ($ul.hasClass('jsTree-expand')) {
					$label.removeClass('jsTree-expand');
					$ul.removeClass('jsTree-expand');
				} else {
					$label.addClass('jsTree-expand');
					$ul.addClass('jsTree-expand');
				}
				event.preventDefault();
			}).on('click', '.jsTree-leaf input', function () {
				var $li = $(this).parent().parent();
				self._checkParent($li, this.checked);
			});
		},
		bindEvent2: function () {
			var self = this;
			var options = this.options;
			this.$elm.on('click', '.jsTree-content label', function (event) {
				var nodeMap = self.nodeMap;
				var $content = $(this).parent();
				var $li = $content.parent();
				var $ul = $li.find('ul:eq(0)');
				var $ipt = $content.find('input');
				var $target = $(event.target);
				if ($target.hasClass('jsTree-expandBtn')) {
					if ($ul.hasClass('jsTree-expand')) {
						$content.removeClass('jsTree-expand');
						$ul.removeClass('jsTree-expand');
					} else {
						var data = nodeMap[$li.attr('data-id')];
						if (data.childs === true || (data.childs && data.childs.length != $ul.find('li').length)) {
							options.onExpand.call(self, data, $li, function () {
								$content.addClass('jsTree-expand');
								$ul.addClass('jsTree-expand');
							})
						} else {
							$content.addClass('jsTree-expand');
							$ul.addClass('jsTree-expand');
						}
					}
					return false;
				} else {
					options.clickItem.call(self, nodeMap[$li.attr('data-id')], $li);
				}
				event.preventDefault();
			}).on('click', '.jsTree-content', function (event) {
				self.$elm.find('.jsTree-content').removeClass('sel');
				$(this).addClass('sel');
			})
		},
		clear: function () {
			this.$root.html('');
			this.nodeMap = {jsTree: {__deep: 0, childs: []}};
		},
		_checkParent: function ($li, checked) {
			$li.siblings().find('input').each(function () {
				if (this.checked != checked) {
					checked = false;
					return true;
				}
			})
			var $parentLi = $li.parent().parent();
			if ($parentLi.hasClass('jsTree-warper'))  return;
			$parentLi.find('input')[0].checked = checked;
			this._checkParent($parentLi, checked);
		},
		_loadHtml: function (treeData, deep, opt) {
			if (treeData === true) return;
			opt = opt || {};
			var self = this;
			var nodeMap = this.nodeMap;
			var options = $.extend({}, this.options , opt);
			var hasChild = options.hasChild;
			var isHasChildFn = $.isFunction(hasChild);
			var idKey = options.idKey;
			var nameKey = options.nameKey;
			var extraHtml = options.extraHtml;
			var isExtraHtmlFn = $.isFunction(extraHtml);
			var hasCheckBox = options.hasCheckBox;
			var __parent = opt.__parent;
			var html = [];
			var cDeep = deep + 1;			
			$.each(treeData, function () {
				if (options.filter(this) === false) return;
				var id = this[idKey], name = this[nameKey]||id;
				this.__deep = deep;
				this.__key = id;
				this.__parent = __parent;
				opt.__parent = id;
				if (isHasChildFn) {
					var res = hasChild(this);
					if (res) {
						this.childs = res;
					}
				} else if (hasChild) {
					this.childs = this.childs || true;
				}
				nodeMap[id] = this;
				if (this.childs) {//node
					html.push('<li class="jsTree-node" data-id="' + id + '">\
									<div class="jsTree-content clearfix ' + (options.isExpand?" jsTree-expand ": "") + '" >\
										<label>\
											<span class="jsTree-expandBtn"></span>'
											+ (hasCheckBox?'<input type="checkbox" id="jsTree' + id + '" value="' + id + '" autocomplete="off" >' : '' )
											+ '<span class="jsTree-content-text">' + name + '</span>' 
											+ '</label>'
											+ (extraHtml?('<div class="jsTree-operate clearfix">' + (isExtraHtmlFn?extraHtml(this):extraHtml)) + '</div>' :'') +
									'</div>' +
									(options.isExpand? '<ul class="jsTree-deep' + cDeep + ' jsTree-expand" data-deep="' + cDeep + '" >' + self._loadHtml(this.childs, cDeep, opt) + '</ul>' : '') +
								'</li>');
				} else {//leaf
					html.push('<li class="jsTree-node jsTree-leaf" data-id="' + id + '">\
									<div class="jsTree-content clearfix" >\
										<label >'
											+ (hasCheckBox? '<input type="checkbox" id="jsTree' + id + '" value="' + id + '" autocomplete="off" >'  : '' )
											+ '<span class="jsTree-content-text">' + name + '</span>' 
											+ '</label>'
											+ (extraHtml?('<div class="jsTree-operate clearfix">' + (isExtraHtmlFn?extraHtml(this):extraHtml)) + '</div>' :'') +
									'</div>\
								</li>');
				}
			});
			return html.join('');
		},
		rushLeafCheck: function (map) {
			var self = this;
			$('.jsTree-leaf input').each(function () {
				var flag = false;
				var checked = this.checked;
				if (map[this.value]) {
					this.checked = true;
					if (checked == false) {
						flag = true;
					}
				} else {
					this.checked = false;
					if (checked == true) {
						flag = true;
					}
				}
				if (flag) {
					self._checkParent($(this).parent().parent(), true);
				}
			})
		},
		rushNode: function (id, opt) {
			id = id || 'jsTree';
			var $li = this.$elm.find('.jsTree-node[data-id=' + id + ']');
			this.options.onExpand.call(this, this.nodeMap[id], $li, function () {			
				$li.find('.jsTree-content:eq(0)').addClass('jsTree-expand');
				$li.find('ul:eq(0)').addClass('jsTree-expand');
			})
		},
		loadData: function (treeData, opt) {
			this.loadNode(treeData, this.$root, opt);
		},
		loadNode: function (treeData, $li, opt) {
			opt = opt || {};
			var nodeMap = this.nodeMap;
			var id = $li.attr('data-id');
			var action = opt.__action || 'html';
			opt.__action = 'html';//只有第一级可以append设置
			opt.__parent = id;
			var $ul = $li.parent();
			var deep = $ul.attr('data-deep')*1 + 1;
			var node = nodeMap[id];
			if ($li.hasClass('jsTree-leaf')) {
				node.childs = treeData;
				$li.removeClass('jsTree-leaf');
				$li.children('.jsTree-content').addClass('jsTree-expand').children('label').prepend('<span class="jsTree-expandBtn"></span>');
			} else {
				if (action == 'html') {
					node.childs = treeData;//问题，下面节点对象在nodeMap中还是存在的，没有遍历删除,内存消耗
				} else {
					node.childs.push(treeData[0]);//一次只能增加一个
					/*
					if (node.childs === true || node.childs.length == 0) {//无数据刷新
						this.rushNode(id, opt);
						return;
					} else {
						node.childs.push(treeData[0]);//一次只能增加一个
					}*/
				}
				$li.children('.jsTree-content').addClass('jsTree-expand');
			}
			$ul = $li.children('ul').addClass('jsTree-expand');
			if ($ul.length == 0) {
				$ul = $('<ul class="jsTree-deep' + deep + ' jsTree-expand" data-deep="' + deep + '" ></ul>').appendTo($li);
			}
			$ul[action](this._loadHtml(treeData, deep, opt));
		},
		unExpand: function () {
			this.$elm.find('.jsTree-deep1').find('.jsTree-expand').removeClass('jsTree-expand');
		},
		extendOpt: function (opt) {
			if (typeof opt == "object" ) {
				$.extend(this.options, opt);
			} else {
				return this.options[opt];
			}
		},
		getAllLeafData: function () {
			var data = [];
			var data2 = [];
			var nodeMap = this.nodeMap;
			this.$elm.find('.jsTree-leaf input').each(function () {
				if (this.checked)
					data.push(nodeMap[this.value]);
				else 
					data2.push(nodeMap[this.value]);
			});
			return [data, data2];
		},
		getLeafData: function (flag) {
			flag = flag || false;
			var data = [];
			var nodeMap = this.nodeMap;
			this.$elm.find('.jsTree-leaf input').each(function () {
				if (this.checked || flag)
					data.push(nodeMap[this.value]);
			});
			return data;
		},
		getData: function ($node) {
			return this.nodeMap[$node.attr('data-id')]
		},
		updateData: function (id, obj, opt) {
			opt = opt || {};
			var $li = this.$elm.find('.jsTree-node[data-id=' + id + ']');
			var data = this.nodeMap[id];
			var options = $.extend({}, this.options , opt);
			var nameKey = options.nameKey;
			$li.find('.jsTree-content-text:eq(0)').html(obj[nameKey]);
			delete obj.childs;
			$.extend(data, obj);
			var extraHtml = this.options.extraHtml;
			if (extraHtml) {
				var isExtraHtmlFn = $.isFunction(extraHtml);
				$li.find('.jsTree-operate:eq(0)').html(isExtraHtmlFn?extraHtml(data):extraHtml);
			}
		},
		addData: function (id, obj, opt) {
			id = id || "jsTree";
			opt = opt || {};
			opt.__action = 'append';
			var $li = this.$elm.find('.jsTree-node[data-id=' + id + ']');
			if ($li.length > 0) {
				this.loadNode([obj], $li, opt);
			}
		},
		delData: function (id) {
			id = id || "jsTree";
			if (id == 'jsTree') {
				this.clear();
			} else {
				var nodeMap = this.nodeMap;
				this.$elm.find('.jsTree-node[data-id=' + id + ']').remove();
				var res = nodeMap[id];
				var parent = nodeMap[res.__parent];
				var childs = parent.childs;
				for (var i = 0, len = childs.length; i < len ; i++) {
					if (childs[i] == res) {
						childs.splice(i, 1);
						break;
					}
				}
				delete this.nodeMap[id];
				if (this.options.delCheckLeaf && childs.length == 0) {
					var $parent = this.$elm.find('.jsTree-node[data-id=' + parent.__key + ']');
					$parent.removeClass('jsTree-node').addClass('jsTree-leaf').find('ul:eq(0),.jsTree-expandBtn:eq(0)').remove();
				}
			}
		},
		editData: function (id, data) {
			
		}
	}
	
	$.fn.jsTree = function (options) {
		var args = slice.call(arguments, 1);
		var res;
		var flag = false;
		this.each(function () {
			var $elm = $(this);
			var jsTree = $elm.data('jsTree');
			if (typeof options == "string" ) {
				if (jsTree && jsTree[options]) {
					var opt = jsTree[options];
					if ($.isFunction(opt)) {
						res = opt.apply(jsTree, args);
						if (res !== undefined) {
							flag = true;
							return true;
						}
					} else {
						if (args.length == 0) {
							res = opt;
							flag = true;
							return true;
						} else if (args.length == 1) {
							jsTree[options] = args[0];
						}
					}
				}
			} else {
				$elm.data('jsTree', new JsTree($elm, $.extend({}, defaults, options)));
			}
		})
		if (flag) {
			return res;
		} else {
			return this;
		}
	}

	$.fn.jsTree.tab2Tree = function (tab, opt) {//ordery by parentId, sort
		opt = opt || {};
		var _opt = $.extend({idKey: 'id',nameKey: 'name', parentKey: 'parentId'}, opt);
		var parentKey = _opt.parentKey;
		var idKey = _opt.idKey;
		var nameKey = _opt.nameKey;
		var nMap = {};
		var pMap = {};
		var haaNoParentMap = {};
		for (var i = 0, len = tab.length; i < len; i++) {
			var obj = tab[i];
			nMap[obj[idKey]] = obj;
			var parentId = obj[parentKey];
			if (pMap[parentId]) {
				pMap[parentId].childs.push(obj);
			} else {
				pMap[parentId] = {
					childs: [obj]
				}
			}
			if (nMap[parentId]) {
				nMap[parentId].childs = pMap[parentId].childs;
			}
		}
		return pMap;
	}
 })(jQuery);
/***
var treeData = [
	{
		id:'g0',
		name: '老师',
		childs : [
			{id:'t1', name: '老师1'},
			{id:'t2', name: '老师2'}
		]
	},
	{
		id:'c1',
		name: '年级',
		childs : [
			{id:'g1', name: '班级1', childs: [{id:'s1', name: '学生1'},{id:'s2', name: '学生2'}] },
			{id:'g2', name: '班级2', childs: [{id:'s3', name: '学生3'}]},
			{id:'g3', name: '班级3', childs: []}
		]
	}
];
$('div').jsTree({
	treeData: treeData,
	hasCheckBox: false,
	treeType: 1,
	extraHtml: '<div class="jsTree-operate">删除 添加 修改</div>',
	dragSelector: '.jsTree-node,.jsTree-leaf'
});
***/