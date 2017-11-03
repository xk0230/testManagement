(function(win) {
	var slide = function(config) {
		if(!config.id) return ;
		config.ele = document.getElementById(config.id);
		config.images = config.images || [];
		this.config = config;
		var slideObj = new _slide(config);
		this.slideObj = slideObj;
		slideObj.build();
	};

	slide.prototype = {
		"construtor": this,
		"addImage": function(images) {
			this.slideObj.addImage(images);
		},
		"delImage": function(images) {
			this.slideObj.delImage(images);
		},
		"getImageCount": function() {
			return this.slideObj.config.images.length;
		},
		"getImages": function() {
			return this.slideObj.config.images;
		},
		"getImageByIndex": function(i) {
			if(isNaN(i)) return ;
			var img = "";
			try {
				if(i<0) throw "脚标太小";
				if(i>=this.slideObj.config.images.length) throw "脚标太大"
				img = this.slideObj.config.images[i] || "";
			} catch(e) {
				return e;
			}
			return img;
		},
		"getCurrentImage": function() {
			return this.slideObj.getCurrentImage();
		},
		"getPreImage": function() {
			return this.slideObj.getPreImage();
		},
		"getNextImage": function() {
			return this.slideObj.getNextImage();
		}
	};

	function _slide(config) {
		this.eleWidth = config.ele.offsetWidth;
		this.eleHeight = config.ele.offsetHeight;
		config.ratio = this.eleWidth/this.eleHeight;
		this.config = config;
	};

	_slide.prototype = {
		"construtor": this,
		"build": function() {
			var self = this;
			var ele = self.config.ele;
			var config = self.config;
			var wrap = document.createElement("DIV");
			wrap.className = "slide_wrap";
			var bgk = document.createElement("DIV");
			bgk.className = "slide_bgk";
			var leftArrow = document.createElement("SPAN");
			leftArrow.className = "slide_left_arrow hide_arrow";
			var preImg = document.createElement("IMG");
			preImg.className = "pre_img";
			self.preImg = preImg;
			var img = document.createElement("IMG");
			img.className = "slide_img";
			self.img = img;
			var nextImg = document.createElement("IMG");
			nextImg.className = "next_img";
			self.nextImg = nextImg;
			var countWrap = document.createElement("SPAN");
			countWrap.className = "count_wrap"
			var indWrap = document.createElement("SPAN");
			indWrap.innerHTML = 1;
			self.indWrap = indWrap;
			var totalWrap = document.createElement("SPAN");
			totalWrap.innerHTML = config.images.length;
			countWrap.appendChild(indWrap);
			self.totalWrap = totalWrap;
			if(config.images.length==0) {
				countWrap.className = "hide_arrow";
			}
			countWrap.appendChild(document.createTextNode("/"));
			countWrap.appendChild(totalWrap);
			var rightArrow = document.createElement("SPAN");
			rightArrow.className = "slide_right_arrow hide_arrow"
			wrap.appendChild(bgk);
			wrap.appendChild(leftArrow);
			wrap.appendChild(preImg);
			wrap.appendChild(img);
			wrap.appendChild(nextImg);
			wrap.appendChild(countWrap);
			wrap.appendChild(rightArrow);
			ele.appendChild(wrap);
			config.rect = ELE.getRect(wrap);

			if(config.images.length>0) {
				img.src = (config.basePath||"") + config.images[0];
				config.presentShow.call(self, config.images[0]);
				self.imgIndex = 0;
				setTimeout(function() {
					var imgRatio = img.offsetWidth/img.offsetHeight;
					if(imgRatio<config.ratio) {
						img.height = self.eleHeight;
						img.style.left = (self.eleWidth-img.offsetWidth)/2 + "px";
					} else {
						img.width = self.eleWidth;
						img.style.top = (self.eleHeight-img.offsetHeight)/2 + "px";
					}
				}, 50);
				self.dealOthers();
			}

			ELE.addEvent(wrap, "mouseout", function() {
				if(leftArrow.className.indexOf("hide_arrow")==-1) {
					leftArrow.className = leftArrow.className.replace(/(^\s*)|(\s*$)/g, "") + " hide_arrow";
				}
				if(rightArrow.className.indexOf("hide_arrow")==-1) {
					rightArrow.className = rightArrow.className.replace(/(^\s*)|(\s*$)/g, "") + " hide_arrow";
				}
			});

			ELE.addEvent(wrap, "mousemove", function() {
				var ev = arguments[0] || win.event;
				var mouseOrignal = {
					"top": ev.clientY,
					"left": ev.clientX
				};
				if(mouseOrignal.left<=config.rect.left+config.rect.width/2) {
					if(leftArrow.className.indexOf("hide_arrow")!=-1) {
						leftArrow.className = leftArrow.className.replace("hide_arrow", "").replace(/(^\s*)|(\s*$)/g, "");
					}
					if(rightArrow.className.indexOf("hide_arrow")==-1) {
						rightArrow.className = rightArrow.className.replace(/(^\s*)|(\s*$)/g, "") + " hide_arrow";
					}
				} else {
					if(rightArrow.className.indexOf("hide_arrow")!=-1) {
						rightArrow.className = rightArrow.className.replace("hide_arrow", "").replace(/(^\s*)|(\s*$)/g, "");
					}
					if(leftArrow.className.indexOf("hide_arrow")==-1) {
						leftArrow.className = leftArrow.className.replace(/(^\s*)|(\s*$)/g, "") + " hide_arrow";
					}
				}
			});

			ELE.addEvent(wrap, "click", function() {
				if(config.images.length==0) return ;
				var key = "pre";
				var ev = arguments[0] || win.event;
				var mouseOrignal = {
					"top": ev.clientY,
					"left": ev.clientX
				};
				if(mouseOrignal.left<=config.rect.left+config.rect.width/2) {
					self.imgIndex = self.imgIndex-1>=0?self.imgIndex-1:config.images.length-1;
				} else {
					key = "next";
					self.imgIndex = self.imgIndex+1>config.images.length-1?0:self.imgIndex+1;
				}
				img.removeAttribute("style");
				img.removeAttribute("width");
				img.removeAttribute("height");
				img.src = (config.basePath||"") + config.images[self.imgIndex];
				if("pre"==key) {
					config.preImgOpt.width?img.width = config.preImgOpt.width:"";
					config.preImgOpt.height?img.height = config.preImgOpt.height:"";
					img.style.top = config.preImgOpt.top + "px";
					img.style.left = config.preImgOpt.left + "px";
				} else {
					config.nextImgOpt.width?img.width = config.nextImgOpt.width:"";
					config.nextImgOpt.height?img.height = config.nextImgOpt.height:"";
					img.style.top = config.nextImgOpt.top + "px";
					img.style.left = config.nextImgOpt.left + "px";
				}
				config.presentShow.call(self, config.images[self.imgIndex]);
				indWrap.innerHTML = self.imgIndex + 1;
				self.dealOthers();
			});
		},
		"delImage": function(images) {
			var self = this;
			var config = self.config
			if(Object.prototype.toString.call(images)=="[object Array]") {
				for(var len=images.length,i=0; i<len; i++) {
					var img = images[i];
					if(isNaN(img)) {
						var ind = config.images.indexOf(img);
						if(ind!=-1) {
							config.images.splice(ind, 1);
							if(ind==self.imgIndex) {
								self.imgIndex = self.imgIndex>=config.images.length?0:self.imgIndex;
								self.img.src = config.images[self.imgIndex];
								self.indWrap.innerHTML = self.imgIndex + 1;

								setTimeout(function() {
									var imgRatio = self.img.offsetWidth/self.img.offsetHeight;
									if(imgRatio<config.ratio) {
										self.img.height = self.eleHeight;
										self.img.style.left = (self.eleWidth-self.img.offsetWidth)/2 + "px";
									} else {
										self.img.width = self.eleWidth;
										self.img.style.top = (self.eleHeight-self.img.offsetHeight)/2 + "px";
									}
								}, 10);
							}
							if(ind<self.imgIndex) {
								self.indWrap.innerHTML = self.indWrap.innerHTML-1?self.indWrap.innerHTML-1:1;
								self.imgIndex--;
							}
						}
					} else {
						if(img>=0 && config.images.length>0) {
							config.images.splice(img, 1);
							if(img==self.imgIndex) {
								self.imgIndex = self.imgIndex>=config.images.length?0:self.imgIndex;
								self.img.src = config.images[self.imgIndex];
								self.indWrap.innerHTML = self.imgIndex + 1;

								setTimeout(function() {
									var imgRatio = self.img.offsetWidth/self.img.offsetHeight;
									if(imgRatio<config.ratio) {
										self.img.height = self.eleHeight;
										self.img.style.left = (self.eleWidth-self.img.offsetWidth)/2 + "px";
									} else {
										self.img.width = self.eleWidth;
										self.img.style.top = (self.eleHeight-self.img.offsetHeight)/2 + "px";
									}
								}, 10);
							}
							if(img<self.imgIndex) {
								self.indWrap.innerHTML = self.indWrap.innerHTML-1?self.indWrap.innerHTML-1:1;
								self.imgIndex--;
							}
						}
					}
				}
			} else {
				if(isNaN(images)) {
					var ind = config.images.indexOf(images);
					if(ind!=-1) {
						config.images.splice(ind, 1);
						if(ind==self.imgIndex) {
							self.imgIndex = self.imgIndex>=config.images.length?0:self.imgIndex;
							self.img.src = config.images[self.imgIndex];
							self.indWrap.innerHTML = self.imgIndex + 1;

							setTimeout(function() {
								var imgRatio = self.img.offsetWidth/self.img.offsetHeight;
								if(imgRatio<config.ratio) {
									self.img.height = self.eleHeight;
									self.img.style.left = (self.eleWidth-self.img.offsetWidth)/2 + "px";
								} else {
									self.img.width = self.eleWidth;
									self.img.style.top = (self.eleHeight-self.img.offsetHeight)/2 + "px";
								}
							}, 10);
						}
						if(ind<self.imgIndex) {
							self.indWrap.innerHTML = self.indWrap.innerHTML-1?self.indWrap.innerHTML-1:1;
							self.imgIndex--;
						}
					}
				} else {
					if(images>=0 && config.images.length>0) {
						config.images.splice(images, 1);
						if(images==self.imgIndex) {
							self.imgIndex = self.imgIndex>=config.images.length?0:self.imgIndex;
							self.img.src = config.images[self.imgIndex];
							self.indWrap.innerHTML = self.imgIndex + 1;

							setTimeout(function() {
								var imgRatio = self.img.offsetWidth/self.img.offsetHeight;
								if(imgRatio<config.ratio) {
									self.img.height = self.eleHeight;
									self.img.style.left = (self.eleWidth-self.img.offsetWidth)/2 + "px";
								} else {
									self.img.width = self.eleWidth;
									self.img.style.top = (self.eleHeight-self.img.offsetHeight)/2 + "px";
								}
							}, 10);
						}
						if(images<self.imgIndex) {
							self.indWrap.innerHTML = self.indWrap.innerHTML-1?self.indWrap.innerHTML-1:1;
							self.imgIndex--;
						}
					}
				}
			}
			self.totalWrap.innerHTML = config.images.length;
			self.dealOthers();
		},
		"addImage": function(images) {
			var self = this;
			var config = self.config
			if(Object.prototype.toString.call(images)=="[object Array]") {
				for(var len=images.length,i=0; i<len; i++) {
					config.images.push(images[i]);
				}
			} else {
				config.images.push(images);
			}
			self.totalWrap.innerHTML = config.images.length;
			self.dealOthers();
		},
		"getCurrentImage": function() {
			return this.config.images[this.imgIndex];
		},
		"getPreImage": function() {
			return this.config.images[this.imgIndex>0?this.imgIndex-1:this.config.images.length-1];
		},
		"getNextImage": function() {
			return this.config.images[this.imgIndex==this.config.images.length-1?0:this.imgIndex+1];
		},
		"dealOthers": function() {
			var self = this;
			var config = self.config;
			self.preImg.removeAttribute("width");
			self.preImg.removeAttribute("height");
			self.nextImg.removeAttribute("width");
			self.nextImg.removeAttribute("height");
			self.preImg.src = (config.basePath||"") + config.images[self.imgIndex-1<0?config.images.length-1:self.imgIndex-1];
			self.nextImg.src = (config.basePath||"") + config.images[self.imgIndex+1>=config.images.length?0:self.imgIndex+1];

			setTimeout(function() {
				var imgRatio = self.preImg.offsetWidth/self.preImg.offsetHeight;
				config.preImgOpt = {};
				if(imgRatio<config.ratio) {
					self.preImg.height = self.eleHeight;
					config.preImgOpt.height = self.eleHeight;
					config.preImgOpt.left = (self.eleWidth-self.preImg.offsetWidth)/2;
					config.preImgOpt.top = 0;
				} else {
					self.preImg.width = self.eleWidth;
					config.preImgOpt.width = self.eleWidth;
					config.preImgOpt.top = (self.eleHeight-self.preImg.offsetHeight)/2;
					config.preImgOpt.left = 0;
				}
			}, 100);

			setTimeout(function() {
				var imgRatio = self.nextImg.offsetWidth/self.nextImg.offsetHeight;
				config.nextImgOpt = {};
				if(imgRatio<config.ratio) {
					self.nextImg.height = self.eleHeight;
					config.nextImgOpt.height = self.eleHeight;
					config.nextImgOpt.left = (self.eleWidth-self.nextImg.offsetWidth)/2;
					config.nextImgOpt.top = 0;
				} else {
					self.nextImg.width = self.eleWidth;
					config.nextImgOpt.width = self.eleWidth;
					config.nextImgOpt.top = (self.eleHeight-self.nextImg.offsetHeight)/2;
					config.nextImgOpt.left = 0;
				}
			}, 100);
		}
	};

	var ELE = {
		"addEvent": function(ele, ev, fn, use) {
			if(win.addEventListener) {
				ele.addEventListener(ev, fn, use||false);
			} else {
				ele.attachEvent("on"+ev, fn);
			}
		},
		"getRect": function(ele) {
			var rect = ele.getBoundingClientRect();
			return {
				"top": rect.top,
				"left": rect.left,
				"width": rect.width || ele.offsetWidth,
				"height": rect.height || ele.offsetHeight
			};
		}
	};

	win.slide = {
		init: function(config) {
			return new slide(config);
		}
	};
})(window)