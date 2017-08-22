//上传类
function UploadFile(wrap, namespace, url, params){
    var self = this;
    var myParams = extendCopy(params || {}, {
        nameSpace : namespace,
        debug : 0,
        fileType : "*.jpg;*.gif;*.png;*.jpeg;*.bmp; *.xls; *.xlsx; *.pdf;",
        typeDesc : "图片",
        multiSelect : false,
        sizeLimit : 20*1024*1024,
        autoStart : false,
        server: "/"
    });
    
    this.init = function(){
        var paramVars = "";
        for(var i in myParams){
            paramVars += i+"="+myParams[i]+"&";
        };
        wrap.innerHTML ="";
        this.obj = FlashPlayer(wrap, url+"?"+paramVars,{wmode:"Opaque"});
    };
    this.startUpload = function(server){
        this.obj.upload(server);
    };
    this.cancelUpload = function(){
        this.obj.cancel();
    };
    this.uploadEvent = new CustomEvent();
    this.init();
};
UploadFile.prototype = {
	noticeTypeError : function(d){
		this.uploadEvent.fire({type:"noticeTypeError",message:d});
	},
	noticeSizeError : function(d){
		this.uploadEvent.fire({type:"noticeSizeError",message:d});
	},
	onCancel : function(d){
		this.uploadEvent.fire({type:"onCancel",message:d});
	},
	onSelect : function(d){
		this.uploadEvent.fire({type:"onSelect",message:d});
	},
	onOpen : function(d){
		this.uploading = true;
		this.uploadEvent.fire({type:"onOpen",message:d});
	},
	onProgress : function(d){
		this.uploadEvent.fire({type:"onProgress",message:d});
	},
	onStop : function(d){
		//由取消上传cancel操作触发
		this.uploading = false;
		this.uploadEvent.fire({type:"onStop",message:d});
	},
	onComplete : function(d){
		this.uploading = false;
		this.uploadEvent.fire({type:"onComplete",message:d});
	},
	onFail : function(d){
		this.uploading = false;
		this.uploadEvent.fire({type:"onFail",message:d});
	}
};
