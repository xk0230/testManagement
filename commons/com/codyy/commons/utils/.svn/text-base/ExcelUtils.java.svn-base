package com.codyy.commons.utils;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.CellRangeAddress;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.bean.ValueBean;
import com.hp.hpl.sparta.ParseException;
/**
 * 
 * ClassName:ExcelUtils
 * Function: 操作Excel工具类   
 * 功能 :
 * 		Excel文件的导入
 * 		Excel文件的导出
 * @author   zhangtian
 * @Date	 2014	2014年8月8日		下午7:15:51
 *
 */
public class ExcelUtils {
	
	private final String DEFAULT_SHEET_NAME = "sheet1" ;
	// === HSSFWorkbook对象
	private HSSFWorkbook workbook = null ;
	// === Excel文件的头部标题样式
	private HSSFCellStyle headerStyle = null ;
	// === Excel文件的第二行提示信息样式
	private HSSFCellStyle warnerStyle = null ;
	// === Excel文件列头的样式
	private HSSFCellStyle titleStyle = null ;
	// === Excel文件的数据样式
	private HSSFCellStyle dataStyle = null ;
	// === Excel文件中的错误数据的显示样式
	private HSSFCellStyle errorDataStyle = null ;
	
	// ========================================  Excel 公共方法调用     =============================================
	/*
	 * 获取HSSFWorkbook对象
	 */
	private HSSFWorkbook getHSSFWorkbook() {
		
		return new HSSFWorkbook() ;
	}
	
	private HSSFWorkbook getHSSFWorkbook(POIFSFileSystem in) throws IOException {
		
		return new HSSFWorkbook(in) ;
	}
	
	// =======================================  	创建公共样式	  ==============================================
	/*
	 * 设置Excel文件的头部标题的样式
	 */
	private void setHeaderCellStyles(HSSFWorkbook workbook, HSSFSheet sheet){
		headerStyle = workbook.createCellStyle() ;
		
		// === 设置边框
		headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN) ;
		headerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN) ;
		headerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN) ;
		headerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN) ;
		
		// === 设置背景色
		headerStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index) ;
		headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND) ;
		
		// === 设置居中
		headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER) ;
		headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER) ;
		
		// === 设置字体
		HSSFFont font = workbook.createFont() ;
		font.setFontName("粗体") ;
		
		// === 设置字体大小
		font.setFontHeightInPoints((short) 16) ;

		// === 设置粗体显示
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD) ;

		// === 选择需要用到的字体格式
		headerStyle.setFont(font) ; 
		// === 设置自动换行
		// headerStyle.setWrapText(true) ;
		// sheet.autoSizeColumn((short)0, true); // === 调整第一列宽度
	}

	/*
	 * 设置Excel文件的第二列的注意事项提示信息的样式
	 */
	private void setWarnerCellStyles(HSSFWorkbook workbook, HSSFSheet sheet){
		warnerStyle = workbook.createCellStyle() ;
		
		// === 设置边框
		warnerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN) ;
		warnerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN) ;
		warnerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN) ;
		warnerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN) ;

		// === 设置背景色
		warnerStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index) ;
		warnerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND) ;

		// === 设置左对齐
		warnerStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT) ;

		// === 设置字体
		HSSFFont font = workbook.createFont() ;
		font.setFontName("宋体") ;

		// === 设置字体大小
		font.setFontHeightInPoints((short) 10) ;

		// === 设置粗体显示
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

		// === 设置字体颜色
		font.setColor(HSSFColor.RED.index);
		
		// === 选择需要用到的字体格式
		warnerStyle.setFont(font) ; 

		// === 设置自动换行
		warnerStyle.setWrapText(true) ;
	}
	

	/*
	 * 设置Excel文件的列头样式
	 */
	private void setTitleCellStyles(HSSFWorkbook workbook,HSSFSheet sheet){
		titleStyle = workbook.createCellStyle() ;
		// === 设置边框
		titleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN) ;
		titleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN) ;
		titleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN) ;
		titleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN) ;

		// === 设置背景色
		titleStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index) ;
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND) ;

		// === 设置居中
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER) ;
		titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER) ;

		// === 设置字体
		HSSFFont font = workbook.createFont() ;
		font.setFontName("粗体") ;

		// === 设置字体大小
		font.setFontHeightInPoints((short) 12) ;

		// === 设置粗体显示
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

		// === 选择需要用到的字体格式
		titleStyle.setFont(font) ; 

		// === 设置自动换行
		// titleStyle.setWrapText(true) ;
	}

	/*
	 * 设置Excel文件的数据样式
	 */
	private void setDataCellStyles(HSSFWorkbook workbook, HSSFSheet sheet){
		dataStyle = workbook.createCellStyle() ;
		// === 设置单元格格式为文本格式
		HSSFDataFormat dataFormat = workbook.createDataFormat() ;
		dataStyle.setDataFormat(dataFormat.getFormat("@"));
		dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN) ;
		dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN) ;
		dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN) ;
		dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN) ;

		// === 设置背景色
		dataStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index) ;
		dataStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND) ;

		// === 设置居中
		dataStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT) ;

		// === 设置字体
		HSSFFont font = workbook.createFont() ;
		font.setFontName("宋体") ;
		
		// === 设置字体大小
		font.setFontHeightInPoints((short) 11) ; 
		
		// === 选择需要用到的字体格式
		dataStyle.setFont(font) ;

		// === 设置自动换行
		// dataStyle.setWrapText(true) ;
	}

	/*
	 * 错误数据重新导入Excel中的样式
	 */
	private void setErrorDataStyle(HSSFWorkbook workbook, HSSFSheet sheet) {
		errorDataStyle = workbook.createCellStyle() ;
		// === 设置边框颜色
		errorDataStyle.setBottomBorderColor(HSSFColor.RED.index);
		errorDataStyle.setLeftBorderColor(HSSFColor.RED.index);
		errorDataStyle.setRightBorderColor(HSSFColor.RED.index);
		errorDataStyle.setTopBorderColor(HSSFColor.RED.index);
		
		// === 设置边框
		errorDataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		errorDataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		errorDataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		errorDataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		// === 设置背景色
		errorDataStyle.setFillForegroundColor(HSSFColor.ROSE.index) ;
		errorDataStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND) ;

		// === 设置居中
		errorDataStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT) ;

		// === 设置字体
		HSSFFont font = workbook.createFont() ;
		font.setFontName("宋体") ;

		// === 设置字体大小
		font.setFontHeightInPoints((short) 11) ; 

		// === 选择需要用到的字体格式
		errorDataStyle.setFont(font) ;
	}
	
	// =======================================  	创建公共数据	  ==============================================
	private void createAppRowHeaderData(HSSFSheet sheet, String headerTitle, Integer cellHeaderNum) {
		
		HSSFRow row = sheet.createRow(0) ;
		row.setHeight((short)800) ;
		
		HSSFCell headerCell = row.createCell(0) ;
		headerCell.setCellValue(new HSSFRichTextString(headerTitle)) ;
		headerCell.setCellStyle(headerStyle) ;
		
		if(cellHeaderNum != 0) {
			for(int i = 1; i<cellHeaderNum; i++){
				headerCell = row.createCell(i) ;
				headerCell.setCellStyle(headerStyle) ;
			}
			// === 合并头部单元格   参数：firstRow, lastRow, firstCol, lastCol
			sheet.addMergedRegion(new CellRangeAddress((short) 0, (short) 0, (short) 0, (short)(cellHeaderNum - 1))) ;
			// === 设置单元格自动列宽，中文支持较好
			// sheet.setColumnWidth(0, headerTitle.getBytes().length*2*256);
			for(int i = 0; i<cellHeaderNum; i++) {
				sheet.autoSizeColumn((short) i, true);
			}
		} else {
			sheet.autoSizeColumn((short) 0, true);
		}
	}
	
	private void createAppRowCellHeaderData(HSSFSheet sheet, List<String> cellHeader) {
		
		HSSFRow row = sheet.createRow(1) ;
		row.setHeight((short)500) ;
		
		HSSFCell cellHeaderCell = null ;
		if(CollectionUtils.isNotEmpty(cellHeader)) {
			for(int i = 0; i<cellHeader.size(); i++) {
				cellHeaderCell = row.createCell(i) ;
				cellHeaderCell.setCellValue(new HSSFRichTextString(cellHeader.get(i)));
				cellHeaderCell.setCellStyle(titleStyle) ;
				// === 设置列宽
				sheet.setColumnWidth(i, (short) 7000) ;
			}
		}
		
	}
	
	private void createAppRowHasData(HSSFSheet sheet, List<Object> appData, Class<?> clazz, Integer cellHeaderNum) {
		
		HSSFRow row = null ;
		HSSFCell cellAppDataCell = null ;
		if(cellHeaderNum != 0) {
			if(CollectionUtils.isNotEmpty(appData)) {
				// === 行记录数
				for(int i = 0; i<appData.size(); i++) {
					// === 列记录数
					row = sheet.createRow(i+2) ;
					Object o = appData.get(i) ;
					Field[] fields = o.getClass().getDeclaredFields() ;
					int j = 0 ;
					for(Field field : fields) {
						if(field.isAnnotationPresent(ExcelColumn.class)) {
							field.setAccessible(true);
							try {
								cellAppDataCell = row.createCell(j) ;
								Object value =  field.get(o);
								if(value != null) {
									cellAppDataCell.setCellValue(new HSSFRichTextString(com.codyy.commons.utils.StringUtils.replaceEscapeChar(value.toString()))) ;
								} else {
									cellAppDataCell.setCellValue(new HSSFRichTextString("")) ;
								}
								cellAppDataCell.setCellStyle(dataStyle) ;
								j++ ;
							} catch (Exception e) {
								e.printStackTrace();
							}	
						}
					}
				}
			}
		}
	}
	
	private void createAppRowErrorData(HSSFSheet sheet, List<Object> appData, Class<?> clazz, Integer cellHeaderNum) {
		HSSFRow row = null ;
		HSSFCell cellAppDataCell = null ;
		if(cellHeaderNum != 0) {
			if(CollectionUtils.isNotEmpty(appData)) {
				// === 行记录数
				for(int i = 0; i<appData.size(); i++) {
					// === 列记录数
					row = sheet.createRow(i+2) ;
					Object o = appData.get(i) ;
					Field[] fields = o.getClass().getDeclaredFields() ;
					int j = 0 ;
					for(Field field : fields) {
						if(field.isAnnotationPresent(ExcelColumn.class)) {
							field.setAccessible(true);
							try {
								cellAppDataCell = row.createCell(j) ;
								Object value =  field.get(o);
								if(field.getType().isAssignableFrom(ValueBean.class)) {
									if(value != null) {
										ValueBean valueBean = (ValueBean) value ;
										if(valueBean.getIsErr()) {
											cellAppDataCell.setCellValue(new HSSFRichTextString(valueBean.getValue())) ;
											cellAppDataCell.setCellStyle(errorDataStyle);
										} else {
											cellAppDataCell.setCellValue(new HSSFRichTextString(valueBean.getValue())) ;
											cellAppDataCell.setCellStyle(dataStyle) ;
										}
									} else {
										cellAppDataCell.setCellValue(new HSSFRichTextString("")) ;
										cellAppDataCell.setCellStyle(dataStyle) ;
									}
								} else {
									if(value != null) {
										cellAppDataCell.setCellValue(new HSSFRichTextString(value.toString())) ;
									} else {
										cellAppDataCell.setCellValue(new HSSFRichTextString("")) ;
									}
									cellAppDataCell.setCellStyle(dataStyle) ;
								}
								j++ ;
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					}
				}
			}
		}
		
		
	}
	
	/**
	 * 
	 * exportContainDataExcelSheet:(这里用一句话描述这个方法的作用)
	 *
	 * @param headerTitle		标题信息
	 * @param warnerInfo		警告提示信息
	 * @param cellHeader		列头信息
	 * @param appData			导入Excel的数据  
	 * 							格式：
	 * 								List<List<String>>  外层List封装行数据，内层List封装列数据
	 * @param filePath			Excel文件存放路径
	 */
	// === 导出带有数据的Excel的表格
	@SuppressWarnings("unchecked")
	public HSSFWorkbook exportContainDataExcelSheet(Map<String, Object> results,Class<?> clazz) {
			// ========================  页签创建   ==========================
			// === 获取HSSFWorkbook对象
			workbook = getHSSFWorkbook();

			HSSFSheet sheet = workbook.createSheet(DEFAULT_SHEET_NAME);
			// =========================  样式设置   =========================
			// === 设置表头样式
			setHeaderCellStyles(workbook, sheet);
			// === 设置列头样式
			setTitleCellStyles(workbook, sheet);
			// === 设置数据样式
			setDataCellStyles(workbook, sheet);

			// =========================  数据创建   ==========================
			// === 创建标题数据
			createAppRowHeaderData(sheet, results.get("headerName").toString(), ((List<String>)results.get("columnNames")).size());
			// === 创建列头数据信息
			createAppRowCellHeaderData(sheet, (List<String>)results.get("columnNames")) ;
			// === 为空模板创建初始化数据  空数据样式
			createAppRowHasData(sheet, (List<Object>)results.get("appDatas"), clazz, ((List<String>)results.get("columnNames")).size()) ;
			return workbook;
			// =========================  文件输出   ==========================
			//FileOutputStream out = new FileOutputStream(filePath);
			//workbook.write(out);
			//out.close();
	}
	
	/**
	 * 
	 * exportContainErrorDataExcelSheet:(这里用一句话描述这个方法的作用)
	 *
	 * @param headerTitle		标题信息
	 * @param warnerInfo		警告提示信息
	 * @param cellHeader		列头信息
	 * @param appData			导入Excel的数据  
	 *							格式：
	 * 								List<List<String>>  外层List封装行数据，内层List封装列数据
	 * 								String类型的列数据含有状态为信息，以&分割，且&之后为空或者0，表示正确的数据，&之后为1表示错误的数据
	 * 								错误的数据，在生成的Excel中标记为外层红圈警告 如：张三&1  李四&0  王五
	 * @param filePath			Excel文件存放路径	
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public HSSFWorkbook exportContainErrorDataExcelSheet(Map<String, Object> results,Class<?> clazz) {
		
		try {
			// ========================  页签创建   ==========================
			// === 获取HSSFWorkbook对象
			workbook = getHSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet(DEFAULT_SHEET_NAME);
			
			// =========================  样式设置   =========================
			// === 设置表头样式
			setHeaderCellStyles(workbook, sheet);
			// === 设置列头样式
			setTitleCellStyles(workbook, sheet);
			// === 设置数据样式
			setDataCellStyles(workbook, sheet);
			// === 设置错误数据样式
			setErrorDataStyle(workbook, sheet);
			
			// =========================  数据创建   ==========================
			// === 创建标题数据
			createAppRowHeaderData(sheet, results.get("headerName").toString(), ((List<String>)results.get("columnNames")).size());
			// === 创建列头数据信息
			createAppRowCellHeaderData(sheet, (List<String>)results.get("columnNames")) ;
			// === 为空模板创建初始化数据  空数据样式
			createAppRowErrorData(sheet, (List<Object>)results.get("appDatas"), clazz, ((List<String>)results.get("columnNames")).size()) ;
			
			// =========================  文件输出   ==========================
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return workbook ;
	}
	
	 // ======================================== Excel 导入公共方法 ==============================================
	 /**
	  *
	  * importExcelData:
	  * Excel 模板严格按照生成的模板格式
	  * 获取列头信息 即获取了遍历的集合 每行应该具有的数据列数，必须强制满足条件
	  * 即：导入的数据行 列数必须与列头数保持一致
	  * 需要解析数据中是否有错误标记位，有则全部去掉
	  * @param filePath
	  * @throws FileNotFoundException
	  * @throws IOException
	 * @throws ParseException 
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * @throws NoSuchFieldException 
	 * @throws SecurityException 
	  */
	 public List<Object> importExcelData(String filePath, Class<?> clazz) throws FileNotFoundException, IOException, ParseException, SecurityException, NoSuchFieldException, InstantiationException, IllegalAccessException {
	 
	  POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(filePath));
	 
	  return importExcelData(fs, clazz);
	 }
	 
	 /**
	  *
	  * importExcelDate:
	  * Excel 模板严格按照生成的模板格式
	  * 获取列头信息 即获取了遍历的集合 每行应该具有的数据列数，必须强制满足条件
	  * 即：导入的数据行 列数必须与列头数保持一致
	  * 需要解析数据中是否有错误标记位，有则全部去掉
	  * @param in
	  * @throws IOException
	 * @throws ParseException 
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * @throws NoSuchFieldException 
	 * @throws SecurityException 
	  */
	 public List<Object> importExcelData(InputStream in, Class<?> clazz) throws IOException, ParseException, SecurityException, NoSuchFieldException, InstantiationException, IllegalAccessException {
	 
	  POIFSFileSystem fs = new POIFSFileSystem(in);
	 
	  return importExcelData(fs, clazz);
	 }
	 
	 /**
	  *
	  * importExcelData:
	  * Excel 模板严格按照生成的模板格式
	  * 获取列头信息 即获取了遍历的集合 每行应该具有的数据列数，必须强制满足条件
	  * 即：导入的数据行 列数必须与列头数保持一致
	  * 需要解析数据中是否有错误标记位，有则全部去掉
	  * @param file
	  * @throws FileNotFoundException
	  * @throws IOException
	 * @throws ParseException 
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * @throws NoSuchFieldException 
	 * @throws SecurityException 
	  */
	 public List<Object> importExcelData(File file, Class<?> clazz) throws FileNotFoundException, IOException, ParseException, SecurityException, NoSuchFieldException, InstantiationException, IllegalAccessException {
	 
	  POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(file));
	 
	  return importExcelData(fs, clazz);
	 }
	 
	 /*
	  * Excel 模板严格按照生成的模板格式
	  * 获取列头信息 即获取了遍历的集合 每行应该具有的数据列数，必须强制满足条件
	  * 即：导入的数据行 列数必须与列头数保持一致
	  * 需要解析数据中是否有错误标记位，有则全部去掉
	  * 需要过滤掉全空数据，即每列数据均为空
	  */
	private List<Object> importExcelData(POIFSFileSystem in, Class<?> clazz) throws IOException, ParseException, SecurityException, NoSuchFieldException, InstantiationException, IllegalAccessException {
	 
	  workbook = getHSSFWorkbook(in) ;
	 
	  // === 标记变量，消除全部的空行记录
	  StringBuilder sb = new StringBuilder() ;
	 
	  // === 提取导入数据模板中的列头信息，即第三列的数据
	  HSSFSheet sheet = workbook.getSheetAt(0) ;
	  HSSFRow headerCellRow = sheet.getRow(1) ;
	  Integer cellHeaderNum = Integer.valueOf(headerCellRow.getLastCellNum()) ;
	  HSSFCell dataCell = null ;
	  HSSFRow dataRow = null ;
	  List<Object> rowList = new ArrayList<Object>() ;
	  Map<String, String> columnMap = new HashMap<String, String>() ;
	  
	  dataRow = sheet.getRow(1) ;
	  for(int m = 0; m<cellHeaderNum; m++) {
		  String columnNameE = String.valueOf(dataRow.getCell(m).getRichStringCellValue().toString()).trim() ;
		  // === 循环遍历字节码注解 获取属性名称
		  Field[] fields = clazz.getDeclaredFields() ;
		  for(Field field : fields) {
			  if(field.isAnnotationPresent(ExcelColumn.class)) {
				  ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class) ;
				  String fieldName = field.getName() ;
				  if(StringUtils.equals(excelColumn.columnName().trim(), columnNameE)) {
					  columnMap.put(columnNameE, fieldName) ;
				  }
			  }
		  }
	  }
	 
	  // === 循环遍历数据
	  Integer rowNum = sheet.getLastRowNum() ;
	  for(int i = 2; i<=rowNum; i++) {
	   sb.delete(0, sb.length()) ;
	   sb.append(String.valueOf(i)) ;
	   dataRow = sheet.getRow(i) ;
	   if(dataRow != null){
		   Object obj = clazz.newInstance() ;
		   for(int j = 0; j<cellHeaderNum; j++) {
			   dataCell = dataRow.getCell(j) ;
			   // =================================== 读取Excel文件中的数据 文本，数值或日期类型的条件判断 开始 =============================
			   if(dataCell != null) {
				   Object value = "" ;
				   switch (dataCell.getCellType()) {
				   case HSSFCell.CELL_TYPE_NUMERIC:
					   if (HSSFDateUtil.isCellDateFormatted(dataCell)) {
						   // === 如果是date类型则 ，获取该cell的date值
						   //value = HSSFDateUtil.getJavaDate(dataCell.getNumericCellValue()).toString();
						   Date date = dataCell.getDateCellValue() ;
						   // SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
						   // value = sdf.format(date) ;
						   value = date ;
					   } else {// === 纯数字
						   dataCell.setCellType(Cell.CELL_TYPE_STRING);
						   value = String.valueOf(dataCell.getRichStringCellValue().toString());
					   }
					   break;
					   
				   case HSSFCell.CELL_TYPE_STRING:
					   value = dataCell.getRichStringCellValue().toString();
					   break;
					   
				   case HSSFCell.CELL_TYPE_FORMULA:
					   // === 读公式计算值
					   value = String.valueOf(dataCell.getNumericCellValue());
					   // === 如果获取的数据值为非法值,则转换为获取字符串
					   if (value.equals("NaN")) {
						   value = dataCell.getRichStringCellValue().toString();
					   }
					   // cell.getCellFormula() ;//读公式
					   break;
					   
				   case HSSFCell.CELL_TYPE_BOOLEAN:
					   value = dataCell.getBooleanCellValue();
					   break;
					   
				   case HSSFCell.CELL_TYPE_BLANK:
					   value = "";
					   break;
					   
				   case HSSFCell.CELL_TYPE_ERROR:
					   value = "";
					   break;
					   
				   default:
					   value = dataCell.getRichStringCellValue().toString();
					   break;
				   }
				   sb.append(value) ;
				   
				   // === 每一行数据的列头是否匹配，决定如何反射设置属性的值
				   String columnNameE = String.valueOf((sheet.getRow(1).getCell(j).getRichStringCellValue().toString())).trim() ;
				   String fieldName = columnMap.get(columnNameE) ;
				   Field f = obj.getClass().getDeclaredField(fieldName) ;
				   f.setAccessible(true);
				   f.set(obj, value);
			   }
			   // =================================== 读取Excel文件中的数据 文本，数值或日期类型的条件判断 结束 =============================
		   }
		   if(StringUtils.trimToEmpty(sb.toString()).equals(String.valueOf(i))) {
			   Collections.emptyList() ;
		   } else {
			   rowList.add(obj) ;
		   }
	   }
	   
	  }
	 
	  return rowList ;
	 }
}

