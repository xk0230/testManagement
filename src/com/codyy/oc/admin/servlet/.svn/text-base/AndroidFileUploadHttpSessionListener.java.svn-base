package com.codyy.oc.admin.servlet;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.context.SpringContext;

/**
 * session监听器, 当用户session失效时, 删除用户上传的但未保存的android文件
 */
public class AndroidFileUploadHttpSessionListener implements HttpSessionListener {
	
	private Logger logger = Logger.getLogger(AndroidFileUploadHttpSessionListener.class);

	@Override
	public void sessionCreated(HttpSessionEvent event) {
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
     	System.out.println("sessionDestroyed……");
		AndroidConfig config = SpringContext.getBean(AndroidConfig.class);
		@SuppressWarnings("unchecked")
		List<String> fileList = (List<String>)event.getSession().getAttribute(CommonsConstant.SESSION_ANDROID_FILE);
		if (fileList != null) {
			for (String filename:fileList){
				String buildFilename = config.getFolder()+File.separator+ filename;
				logger.debug("User session destroyed, delete upload file:" + buildFilename);
				File file = new File(buildFilename);
				file.delete();
			}
			event.getSession().removeAttribute(CommonsConstant.SESSION_ANDROID_FILE);
		}
		logger.debug("sessionDestroyed");
	}

}
