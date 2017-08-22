package com.codyy.oc.admin.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.util.StreamUtils;

import com.codyy.commons.context.SpringContext;

/**
 * 
 * ClassName: ImageServlet
 * Function: 根据文件路径读取android文件的内容
 * date: 2015-3-30 下午2:01:25
 * 
 */
public class AndroidServlet extends HttpServlet {	
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(AndroidServlet.class);

    public AndroidServlet() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getPathInfo();
		String filename = path.substring(path.lastIndexOf('/') + 1);
		logger.debug("filename:" + filename);
		AndroidConfig config = SpringContext.getBean(AndroidConfig.class);
		StringBuffer buffer = new StringBuffer();
		buffer.append(config.getFolder());
		buffer.append(File.separatorChar);
		buffer.append(filename);
		File file = new File(buffer.toString());
		if(file.exists()){
			InputStream input = new FileInputStream(file);
			response.addHeader("Cache-Control", "max-age=864000");
			StreamUtils.copy(input, response.getOutputStream());
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	

}
