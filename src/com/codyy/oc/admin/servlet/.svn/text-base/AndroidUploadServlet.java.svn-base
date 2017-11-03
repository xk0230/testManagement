package com.codyy.oc.admin.servlet;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codyy.commons.context.SpringContext;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.web.CustomMultipartResolver;

/**
 * Servlet implementation class ImageUploadServlet
 */
public class AndroidUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(AndroidUploadServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AndroidUploadServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomMultipartResolver resolver = new CustomMultipartResolver();
		resolver.setDefaultEncoding("UTF-8");
		resolver.setMaxUploadSize(1024*1024*1024);
		resolver.setServletContext(request.getSession().getServletContext());
		resolver.setMaxInMemorySize(1024*1024);
		AndroidConfig config = SpringContext.getBean(AndroidConfig.class);
		resolver.setUploadTempDir(new FileSystemResource(config.getFolder() +  File.separator + "temp"));
		MultipartHttpServletRequest multiRequest = null;
		try {
			multiRequest = resolver.resolveMultipart(request);
		} catch (MaxUploadSizeExceededException e) {
			logger.debug("Upload file is too big");
			ResultJson json = new ResultJson(false, 1, "File is too big");
			response.getWriter().write(json.toString());
			return;
		}
		
		Collection<MultipartFile> files = multiRequest.getFileMap().values();
		if (files == null || files.size() == 0) {
			response.getWriter().write(new ResultJson(false, 2, "File content is empty!").toString());
			logger.debug("Upload file is empty");
			return;
		}
		
		MultipartFile multiFile = files.iterator().next();
		String original = multiFile.getOriginalFilename();
		original = (original == null) ? "" : original;
		String suffix = "";
		if (original != null){
			int x = original.lastIndexOf('.');
			if (x >= 0){
				suffix = original.substring(x);
			}
		}
		File file = createFile(suffix);
		multiFile.transferTo(file);// 写入目标文件
		ResultJson json = new ResultJson(true, 0, file.getName());
		AndroidFileUploadUtil.addUploadFileToSession(request, file.getName());
		response.getWriter().write(json.toString());
		logger.debug("File upload transferTo over");
	}
	
	private File createFile(String suffix) throws IOException{
		String uuid = UUID.randomUUID().toString();
		AndroidConfig config = SpringContext.getBean(AndroidConfig.class);
		StringBuffer buffer = new StringBuffer();
		buffer.append(config.getFolder());
		buffer.append(File.separatorChar);
		buffer.append(uuid + suffix);
		File file = new File(buffer.toString());
		if (file.exists()){
			return createFile(suffix);
		} else {
			file.getParentFile().mkdirs();
			file.createNewFile();
			return file;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
