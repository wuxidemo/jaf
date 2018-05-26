package com.yjy.web.controller;

import java.io.File;

import java.text.ParseException;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.IntegralRecord;

import com.yjy.service.IntegralRecordService;
import com.yjy.service.MyService;
import com.yjy.utils.StuService1;
import com.yjy.utils.Util;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Controller
@RequestMapping(value = "/export")
public class ExportController {
	@Autowired
	private IntegralRecordService integralRecordService;
	@Autowired
	MyService myService;

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	@RequestMapping()
	public String getshow(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		/*searchParams = Util.changeEncoding(searchParams);*/

		String startDate = "";
		if (searchParams.containsKey("GTE_createtime")) {
			startDate = ((String) searchParams.get("GTE_createtime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				searchParams.put("GTE_createtime", calendar.getTime());
			}
			model.addAttribute("a", startDate);
		}

		String endDate = "";
		if (searchParams.containsKey("LTE_createtime")) {
			endDate = ((String) searchParams.get("LTE_createtime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.HOUR, +24);
				searchParams.put("LTE_createtime", calendar.getTime());
			}
			model.addAttribute("b", endDate);
		}

		/*
		 * if(searchParams.containsKey("GTE_createtime")){ String real=(String)
		 * searchParams.get("GTE_createtime");
		 * if(real==null||"".equals(real.trim())){
		 * searchParams.remove("GTE_createtime"); } }
		 * if(searchParams.containsKey("LTE_createtime")){ String real=(String)
		 * searchParams.get("LTE_createtime");
		 * if(real==null||"".equals(real.trim())){
		 * searchParams.remove("LTE_createtime"); } }
		 */
		Page<IntegralRecord> IntegralRecords = integralRecordService.getList(searchParams, pageNumber, pageSize,
				sortType);
		model.addAttribute("IntegralRecords", IntegralRecords);
		model.addAttribute("totalcount", myService.getIntrgralRecordCountByParam(searchParams));
		model.addAttribute("totalprice", myService.getIntrgralRecordPriceByParam(searchParams));
		model.addAttribute("totaljf", myService.getIntrgralRecordJFByParam(searchParams));
		model.addAttribute("usecount", myService.getIntrgralRecordUseCountByParam(searchParams));
		model.addAttribute("useprice", myService.getIntrgralRecordUsePriceByParam(searchParams));

		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "text/export";
	}

	@RequestMapping(value = "/showpage")
	public String bypage() {

		return "text/export";
	}

	/**
	 * 根据开始时间和结束时间查找相关数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/timefind")
	public String getone(@RequestParam(value = "search_GTE_starttime") String sta,
			@RequestParam(value = "search_LTE_starttime") String sta1, Model model) {
		Date date = new Date();
		Date date1 = new Date();
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(sta);
			date1 = new SimpleDateFormat("yyyy-MM-dd").parse(sta1);
			// 截止时间向后进行推移
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date1);
			calendar.add(Calendar.HOUR, +24);
			date1 = calendar.getTime();

			List<Object[]> list = integralRecordService.getSumList(date, date1);
			int size1 = list.size();
			model.addAttribute("size1", size1);
			model.addAttribute("lists", list);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return "text/export";
	}

	/**
	 * 导出到excel表
	 * 
	 * @param model
	 */
	@RequestMapping(value = "/oufile3")
	public String getcreate6(Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "d1", required = false) String time1,
			@RequestParam(value = "d2", required = false) String time2) {

		try {
			if (time1.trim().equals("") && time2.trim().equals("")) {
				// 创建独处数据保存的位置
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
				String filename = sdf.format(d) + ".xls";
				String mypath = pbasepath + "download" + File.separator + "excel";
				File file = new File(mypath);
				if (!file.exists()) {
					file.mkdirs();
				}

				WritableWorkbook wwb = null; // 创建可以写入的工作簿
				File filepath = new File(file.getPath() + File.separator + filename);
				if (!filepath.exists()) {
					filepath.createNewFile();
				}
				wwb = Workbook.createWorkbook(filepath);// 以fileName为文件名来创建一个Workbook

				WritableSheet ws = wwb.createSheet("Sheet1", 0); // 创建工作表
				// 设置各个单元格的宽高
				ws.setColumnView(0, 10);
				ws.setColumnView(1, 10);
				ws.setColumnView(2, 40);
				ws.setColumnView(3, 25);
				ws.setColumnView(4, 20);
				ws.setColumnView(5, 20);
				List<IntegralRecord> list = StuService1.getAllByDb();
				// 要插入到excel表格的行号，默认从0开始
				/* ws.mergeCells(0,0,5,0); */
				Label labelId = new Label(0, 0, "序号");
				Label labelno1 = new Label(1, 0, "积分 ");
				Label labelno2 = new Label(2, 0, "卡号");
				Label labelno3 = new Label(3, 0, "时间");
				Label labelno4 = new Label(4, 0, "名字");
				Label labelno5 = new Label(5, 0, "电话");
				ws.addCell(labelId);
				ws.addCell(labelno1);
				ws.addCell(labelno2);
				ws.addCell(labelno3);
				ws.addCell(labelno4);
				ws.addCell(labelno5);
				for (int i = 0; i < list.size(); i++) {
					Label labelId_i = new Label(0, i + 1, i + 1 + "");
					Label labelno1_i = new Label(1, i + 1, list.get(i).getCount() + "");
					Label labelno2_i = new Label(2, i + 1, list.get(i).getCardnum());
					Label labelno3_i = new Label(3, i + 1, list.get(i).getCreatetime() + "");
					Label labelno4_i = new Label(4, i + 1, list.get(i).getName());
					Label labelno5_i = new Label(5, i + 1, list.get(i).getPhone());
					ws.addCell(labelId_i);
					ws.addCell(labelno1_i);
					ws.addCell(labelno2_i);
					ws.addCell(labelno3_i);
					ws.addCell(labelno4_i);
					ws.addCell(labelno5_i);
				}
				wwb.write();
				wwb.close();

				// 文件的下载
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/x-msdownload;");
				response.setHeader("Content-Disposition", "attachment;fileName=" + filename);
				InputStream inputstream = new FileInputStream(filepath);
				OutputStream os = response.getOutputStream();
				byte[] b = new byte[2048];
				int length;
				while ((length = inputstream.read(b)) > 0) {
					os.write(b, 0, length);
				}
				// 关闭下载
				os.flush();
				os.close();
				inputstream.close();
			} else {
				Date a = new Date();
				Date e = new Date();
				a = new SimpleDateFormat("yyyy-MM-dd").parse(time1);
				e = new SimpleDateFormat("yyyy-MM-dd").parse(time2);
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(e);
				calendar.add(Calendar.HOUR, +24);
				e = calendar.getTime();
				// 创建独处数据保存的位置
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
				String filename = sdf.format(d) + ".xls";
				String mypath = pbasepath + "download" + File.separator + "excel";
				File file = new File(mypath);
				if (!file.exists()) {
					file.mkdirs();
				}

				WritableWorkbook wwb = null; // 创建可以写入的工作簿
				File filepath = new File(file.getPath() + File.separator + filename);
				if (!filepath.exists()) {
					filepath.createNewFile();
				}
				wwb = Workbook.createWorkbook(filepath);// 以fileName为文件名来创建一个Workbook

				WritableSheet ws = wwb.createSheet("Sheet1", 0); // 创建工作表
				// 设置各个单元格的宽高
				ws.setColumnView(0, 10);
				ws.setColumnView(1, 10);
				ws.setColumnView(2, 40);
				ws.setColumnView(3, 25);
				ws.setColumnView(4, 20);
				ws.setColumnView(5, 20);
				// 查询数据库中所有的数据
				List<Object[]> list = integralRecordService.getSumList(a, e);
				// 要插入到excel表格的行号，默认从0开始
				ws.mergeCells(0, 0, 5, 0);
				Label labelId1 = new Label(0, 0, time1 + "---" + time2);
				Label labelId = new Label(0, 1, "序号");
				Label labelno1 = new Label(1, 1, "积分 ");
				Label labelno2 = new Label(2, 1, "卡号");
				Label labelno3 = new Label(3, 1, "时间");
				Label labelno4 = new Label(4, 1, "名字");
				Label labelno5 = new Label(5, 1, "电话");
				ws.addCell(labelId1);
				ws.addCell(labelId);
				ws.addCell(labelno1);
				ws.addCell(labelno2);
				ws.addCell(labelno3);
				ws.addCell(labelno4);
				ws.addCell(labelno5);
				for (int i = 0; i < list.size(); i++) {
					Label labelId_i = new Label(0, i + 2, i + 1 + "");
					Label labelno1_i = new Label(1, i + 2, list.get(i)[0].toString());
					Label labelno2_i = new Label(2, i + 2, list.get(i)[1] + "");
					Label labelno3_i = new Label(3, i + 2, list.get(i)[2].toString());
					Label labelno4_i = new Label(4, i + 2, list.get(i)[3].toString());
					Label labelno5_i = new Label(5, i + 2, list.get(i)[4].toString());
					ws.addCell(labelId_i);
					ws.addCell(labelno1_i);
					ws.addCell(labelno2_i);
					ws.addCell(labelno3_i);
					ws.addCell(labelno4_i);
					ws.addCell(labelno5_i);
				}
				wwb.write();
				wwb.close();

				// 文件的下载
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/x-msdownload;");
				response.setHeader("Content-Disposition", "attachment;fileName=" + filename);
				InputStream inputstream = new FileInputStream(filepath);
				OutputStream os = response.getOutputStream();
				byte[] b = new byte[2048];
				int length;
				while ((length = inputstream.read(b)) > 0) {
					os.write(b, 0, length);
				}
				// 关闭下载
				os.flush();
				os.close();
				inputstream.close();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		/* return "redirect:/export/showpage"; */
		return null;

	}

	/**
	 * 导出昨天的数据
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/oufile2")
	public String getcreate5(Model model, HttpServletRequest request, HttpServletResponse response) {
		try {
			// 创建数据保存的位置
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
			String filename = sdf.format(d) + ".xls";
			String mypath = pbasepath + "download" + File.separator + "excel";
			File file = new File(mypath);
			if (!file.exists()) {
				file.mkdirs();
			}

			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			File filepath = new File(file.getPath() + File.separator + filename);
			if (!filepath.exists()) {
				filepath.createNewFile();
			}
			wwb = Workbook.createWorkbook(filepath);// 以fileName为文件名来创建一个Workbook
			WritableSheet ws = wwb.createSheet("Sheet1", 0); // 创建工作表
			// 设置各个单元格的宽高
			ws.setColumnView(0, 10);
			ws.setColumnView(1, 10);
			ws.setColumnView(2, 40);
			ws.setColumnView(3, 25);
			ws.setColumnView(4, 20);
			ws.setColumnView(5, 20);
			// 查询数据库中前一天的数据
			List<Object[]> list = integralRecordService.getYesterdayList();
			// 要插入到excel表格的行号，默认从0开始

			Label labelId = new Label(0, 0, "序号");
			Label labelno1 = new Label(1, 0, "积分 ");
			Label labelno2 = new Label(2, 0, "卡号");
			Label labelno3 = new Label(3, 0, "时间");
			Label labelno4 = new Label(4, 0, "名字");
			Label labelno5 = new Label(5, 0, "电话");

			ws.addCell(labelId);
			ws.addCell(labelno1);
			ws.addCell(labelno2);
			ws.addCell(labelno3);
			ws.addCell(labelno4);
			ws.addCell(labelno5);
			for (int i = 0; i < list.size(); i++) {
				Label labelId_i = new Label(0, i + 1, i + 1 + "");
				Label labelno1_i = new Label(1, i + 1, list.get(i)[0].toString());
				Label labelno2_i = new Label(2, i + 1, list.get(i)[1] + "");
				Label labelno3_i = new Label(3, i + 2, list.get(i)[2].toString());
				Label labelno4_i = new Label(4, i + 1, list.get(i)[3].toString());
				Label labelno5_i = new Label(5, i + 1, list.get(i)[4].toString());
				ws.addCell(labelId_i);
				ws.addCell(labelno1_i);
				ws.addCell(labelno2_i);
				ws.addCell(labelno3_i);
				ws.addCell(labelno4_i);
				ws.addCell(labelno5_i);
			}
			wwb.write();
			wwb.close();
			// 文件的下载
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-Disposition", "attachment;fileName=" + filename);
			InputStream inputstream = new FileInputStream(filepath);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputstream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			// 关闭下载
			os.flush();
			os.close();
			inputstream.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

		}
		return null;
	}

	/**
	 * 导出到excel表
	 * 
	 * @param model
	 */
	@RequestMapping(value = "/oufile1")
	public String getcreate4(Model model, HttpServletRequest request, HttpServletResponse response) {

		try {
			// 创建独处数据保存的位置
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
			String filename = sdf.format(d) + ".xls";
			String mypath = pbasepath + "download" + File.separator + "excel";
			File file = new File(mypath);
			if (!file.exists()) {
				file.mkdirs();
			}

			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			File filepath = new File(file.getPath() + File.separator + filename);
			if (!filepath.exists()) {
				filepath.createNewFile();
			}
			wwb = Workbook.createWorkbook(filepath);// 以fileName为文件名来创建一个Workbook

			WritableSheet ws = wwb.createSheet("Shee1", 0); // 创建工作表
			// 查询数据库中所有的数据
			List<IntegralRecord> list = StuService1.getAllByDb();
			// 要插入到excel表格的行号，默认从0开始
			ws.mergeCells(0, 0, 5, 0);
			Label labelId = new Label(0, 1, "序号");
			Label labelno1 = new Label(1, 1, "积分 ");
			Label labelno2 = new Label(2, 1, "卡号");
			Label labelno3 = new Label(3, 1, "时间");
			Label labelno4 = new Label(4, 1, "名字");
			Label labelno5 = new Label(5, 1, "电话");
			ws.addCell(labelId);
			ws.addCell(labelno1);
			ws.addCell(labelno2);
			ws.addCell(labelno3);
			ws.addCell(labelno4);
			ws.addCell(labelno5);
			for (int i = 0; i < list.size(); i++) {
				Label labelId_i = new Label(0, i + 2, i + 1 + "");
				Label labelno1_i = new Label(1, i + 2, list.get(i).getCount() + "");
				Label labelno2_i = new Label(2, i + 2, list.get(i).getCardcode());
				Label labelno3_i = new Label(3, i + 2, list.get(i).getCreatetime() + "");
				Label labelno4_i = new Label(4, i + 2, list.get(i).getName());
				Label labelno5_i = new Label(5, i + 2, list.get(i).getPhone());
				ws.addCell(labelId_i);
				ws.addCell(labelno1_i);
				ws.addCell(labelno2_i);
				ws.addCell(labelno3_i);
				ws.addCell(labelno4_i);
				ws.addCell(labelno5_i);
			}
			wwb.write();
			wwb.close();

			// 文件的下载
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-Disposition", "attachment;fileName=" + filename);
			InputStream inputstream = new FileInputStream(filepath);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputstream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			// 关闭下载
			os.close();
			inputstream.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "text/export";

	}
}
