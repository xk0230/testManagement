package com.codyy.commons.image;

import java.io.File;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.utils.SecurityUtil;

public class ImageUtil {
	
	public static String buildFile(String folder, String filename){
		String md5 = SecurityUtil.MD5String(filename);
		StringBuffer buffer = new StringBuffer();
		buffer.append(folder);
		buffer.append(File.separatorChar);
		buffer.append(md5.substring(0, 2));
		buffer.append(File.separatorChar);
		buffer.append(md5.substring(2, 4));
		buffer.append(File.separatorChar);
		buffer.append(md5.substring(4, 6));
		buffer.append(File.separatorChar);
		buffer.append(filename);
		return buffer.toString();
	}
	
	public static String buildFileParentPath(String folder, String filename){
		String md5 = SecurityUtil.MD5String(filename);
		StringBuffer buffer = new StringBuffer();
		buffer.append(folder);
		buffer.append(File.separatorChar);
		buffer.append(md5.substring(0, 2));
		buffer.append(File.separatorChar);
		buffer.append(md5.substring(2, 4));
		buffer.append(File.separatorChar);
		buffer.append(md5.substring(4, 6));
		return buffer.toString();
	}
	
	//全局的图片文件列表
	private static List<String> imageList = new LinkedList<String>();
	private static Object lock = new Object();
	
	/**
	 * 判断全局图片文件列表中是否包含此文件
	 * @param filename
	 * @return
	 */
	public static boolean globalImageListHasFilename(String filename){
		synchronized (lock) {
			return imageList.contains(filename);
		}
	}
	
	public static void removeGlobalImage(String filename){
		synchronized (lock) {
			imageList.remove(filename);
		}
	}
	
	/**
	 * 将用户上传的图片信息保存于session中的图片文件列表和全局文件列表
	 * @param request
	 * @param filename
	 */
	public static void addUploadImage(HttpServletRequest request, String filename){
		@SuppressWarnings("unchecked")
		List<String> list = (List<String>)request.getSession().getAttribute(CommonsConstant.SESSION_IMAGES);
		if (list == null){
			list = new LinkedList<String>();
			request.getSession().setAttribute(CommonsConstant.SESSION_IMAGES, list);
		}
		list.add(filename);
		synchronized (lock) {
			imageList.add(filename);
		}
	}
	
	/**
	 * 从用户session的图片文件列表和全局图片列表中清除文件记录
	 * @param request
	 * @param filename
	 */
	public static void removeUploadImage(HttpServletRequest request, String filename){
		@SuppressWarnings("unchecked")
		List<String> list = (List<String>)request.getSession().getAttribute(CommonsConstant.SESSION_IMAGES);
		if (CollectionUtils.isNotEmpty(list)){
			list.remove(filename);
		}
		synchronized (lock) {
			if (imageList.contains(filename))
				imageList.remove(filename);
			else
				throw new RuntimeException("Image file not exist.");//当Controller尝试保存一个已经不存在的图片时返回错误
		}
	}
	
	/**
	 * 在富文本编辑中, 从content中过滤出使用的图片并从session中删除
	 * @return
	 */
	public static void removeUploadImageByFilteringContent(final HttpServletRequest request, final String content) {
		if(StringUtils.isEmpty(content)) {
			return;
		}
		final Pattern pattern = Pattern.compile("src=\"[a-z0-9A-Z/\\-_:\\.]+\"");
		final Matcher matcher = pattern.matcher(content);
		while(matcher.find()) {
			String src = content.substring(matcher.start(), matcher.end());
			String fileName = src.substring(src.lastIndexOf("/")+1,src.length()-1);
			ImageUtil.removeUploadImage(request, fileName);
		}
	}
	
	public static void main(String[] args){
		File file = new File(buildFile("C:", UUID.randomUUID().toString() + ".jpg"));
		System.out.println(file.getName());
	}
}
