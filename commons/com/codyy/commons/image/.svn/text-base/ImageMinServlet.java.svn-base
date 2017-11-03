package com.codyy.commons.image;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.util.StreamUtils;

import sun.misc.BASE64Encoder;

import com.codyy.commons.context.SpringContext;

/**
 * 
 * ClassName: ImageServlet
 * Function: 根据文件路径读取图片的内容
 * date: 2015-3-30 下午2:01:25
 * 
 */
public class ImageMinServlet extends HttpServlet {	
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(ImageServlet.class);

    public ImageMinServlet() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//设置下载响应头
		response.setContentType("application/x-msdownload");
		String path = request.getPathInfo();
		String filename=path.substring(1,path.indexOf("/",1) );
		String orginalName = path.substring(path.lastIndexOf('/') + 1);
	    
		if(filename!=null && orginalName!=null){//当源文件名和新文件名都不为null的时候才支持下载操作
			
		 if(filename.contains("headPicDefault")){
			InputStream input = new FileInputStream(request.getServletContext().getRealPath("/") + "public" + File.separatorChar + "img" + File.separatorChar + "common" + File.separatorChar + "headPicDefault.jpg");
			response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(orginalName, "UTF-8"));
			response.addHeader("Cache-Control", "max-age=864000");
			StreamUtils.copy(input, response.getOutputStream());
			input.close();
		} else {
			ImageConfig config = SpringContext.getBean(ImageConfig.class);
			File file = new File(ImageUtil.buildFile(config.getFolder(), filename).replace(".", "_min."));
			if (file.exists()) {
				InputStream input = new FileInputStream(file);
				//response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(orginalName, "UTF-8"));
				
				String agent = request.getHeader("User-Agent");
				boolean isFireFox = (agent != null && agent.indexOf("Firefox") != -1);
				//System.out.println(agent);
			
				//将谷歌和火狐进行判断 而ie作为默认
				if (isFireFox) {//火狐
					response.setHeader("Content-Disposition", "attachment;filename="+new String(orginalName.getBytes("UTF-8"), "ISO-8859-1"));
					
				}else if(agent != null && agent.indexOf("AppleWebKit") != -1){//谷歌
					
					response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(orginalName, "UTF-8"));
					
				} else {//默认ie
					response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(orginalName, "UTF-8"));
				}
				response.addHeader("Cache-Control", "max-age=864000");
				StreamUtils.copy(input, response.getOutputStream());
				input.close();
			}
		}
		
	 }
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
