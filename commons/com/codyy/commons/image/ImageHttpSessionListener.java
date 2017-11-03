package com.codyy.commons.image;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.context.SpringContext;

/**
 * session监听器, 当用户session失效时, 删除用户上传的但未保存的图片
 */
public class ImageHttpSessionListener implements HttpSessionListener {
	
	private Logger logger = Logger.getLogger(ImageHttpSessionListener.class);

	@Override
	public void sessionCreated(HttpSessionEvent event) {
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		ImageConfig config = SpringContext.getBean(ImageConfig.class);
		@SuppressWarnings("unchecked")
		List<String> images = (List<String>)event.getSession().getAttribute(CommonsConstant.SESSION_IMAGES);
		if (CollectionUtils.isNotEmpty(images)){
			for (String filename:images){
				if (ImageUtil.globalImageListHasFilename(filename)){
					String buildFilename = ImageUtil.buildFile(config.getFolder(), filename);
					logger.info("User session destroyed, delete upload file:" + buildFilename);
					File file = new File(buildFilename);
					file.delete();
					ImageUtil.removeGlobalImage(filename);
				}
			}
			event.getSession().removeAttribute(CommonsConstant.SESSION_IMAGES);
		}
	}

}
