package com.yjy.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.User;
import com.yjy.entity.WXCardRecord;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXMerchantService;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Controller
@RequestMapping(value = "/cardrecord")
public class CardRecordController {
	@Autowired
	WXCardRecordService wxcardrecordService;
	@Autowired
	WXMerchantService wXMerchantService;
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		// sortTypes.put("state", "状态");
	}

	@RequestMapping()
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}
		if (searchParams.containsKey("EQ_isbank")) {
			if (searchParams.get("EQ_isbank").toString().equals("-1")) {
				searchParams.remove("EQ_isbank");
			}
		}
		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}
		if (searchParams.containsKey("EQ_wxmerchantid")) {
			if (searchParams.get("EQ_wxmerchantid").toString().equals("0")) {
				searchParams.remove("EQ_wxmerchantid");
			}
		}
		if (searchParams.containsKey("LIKE_merchantname")) {
			if (searchParams.get("LIKE_merchantname").toString().equals("")) {
				searchParams.remove("LIKE_merchantname");
			} else {
				try {
					searchParams.put("LIKE_merchantname", URLDecoder.decode(
							URLDecoder.decode(searchParams.get("LIKE_merchantname").toString(), "utf-8"), "utf-8"));
				} catch (Exception e) {
				}
			}

		}
		if (searchParams.containsKey("GTE_usetime")) {
			String startDate = ((String) searchParams.get("GTE_usetime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_usetime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				searchParams.put("GTE_usetime", date);
			}
		}

		if (searchParams.containsKey("LTE_usetime")) {
			String endDate = ((String) searchParams.get("LTE_usetime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_usetime");
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
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_usetime", calendar.getTime());
			}
		}
		
		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime")).trim();

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
				searchParams.put("GTE_createtime", date);
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime")).trim();

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
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_createtime", calendar.getTime());
			}
		}
		
		
		Page<WXCardRecord> dvlist = wxcardrecordService.getWXCardRecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("mers", wXMerchantService.getAll());
		model.addAttribute("dvs", dvlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);

		if (searchParams.containsKey("LTE_usetime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTime((Date) searchParams.get("LTE_usetime"));
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
			String str = sdf.format(calendar.getTime());
			searchParams.put("LTE_usetime", str);
		}

		if (searchParams.containsKey("GTE_usetime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_usetime", sdf.format(searchParams.get("GTE_usetime")));
		}
		
		if (searchParams.containsKey("LTE_createtime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTime((Date) searchParams.get("LTE_createtime"));
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
			String str = sdf.format(calendar.getTime());
			searchParams.put("LTE_createtime", str);
		}

		if (searchParams.containsKey("GTE_createtime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_createtime", sdf.format(searchParams.get("GTE_createtime")));
		}

		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "wxcard/cardrecord";
	}

	@RequestMapping(value = "rct")
	@ResponseBody
	public String refreshcardtime() {
		wxcardrecordService.refreshCardRrcord();
		wxcardrecordService.updateOverCard();
		return "1";
	}

	@RequestMapping(value = "mylist")
	public String getMyList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		User u = (User) request.getSession().getAttribute("user");
		if (u.getMerchant() != null) {
			searchParams.put("EQ_merchantid", u.getMerchant().getId().toString());
		}
		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}

		if (searchParams.containsKey("EQ_isbank")) {
			if (searchParams.get("EQ_isbank").toString().equals("-1")) {
				searchParams.remove("EQ_isbank");
			}
		}
		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}
		if (searchParams.containsKey("EQ_wxmerchantid")) {
			if (searchParams.get("EQ_wxmerchantid").toString().equals("0")) {
				searchParams.remove("EQ_wxmerchantid");
			}
		}
		if (searchParams.containsKey("LIKE_merchantname")) {
			if (searchParams.get("LIKE_merchantname").toString().equals("")) {
				searchParams.remove("LIKE_merchantname");
			}
		}
		if (searchParams.containsKey("GTE_usetime")) {
			String startDate = ((String) searchParams.get("GTE_usetime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_usetime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				searchParams.put("GTE_usetime", date);
			}
		}

		if (searchParams.containsKey("LTE_usetime")) {
			String endDate = ((String) searchParams.get("LTE_usetime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_usetime");
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
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_usetime", calendar.getTime());
			}
		}
		Page<WXCardRecord> dvlist = wxcardrecordService.getWXCardRecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("mers", wXMerchantService.getAll());
		model.addAttribute("dvs", dvlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		if (searchParams.containsKey("LTE_usetime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTime((Date) searchParams.get("LTE_usetime"));
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
			String str = sdf.format(calendar.getTime());
			searchParams.put("LTE_usetime", str);
		}

		if (searchParams.containsKey("GTE_usetime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_usetime", sdf.format(searchParams.get("GTE_usetime")));
		}
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "wxcard/mycardrecord";
	}

	/*
	 * @RequestMapping(value = "imp")
	 * 
	 * }
	 */

	/* 查找数据下载 */
	@RequestMapping(value = "imp")
	public void getMyList6(Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "search_LIKE_merchantname") String name) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}
		if (searchParams.containsKey("EQ_isbank")) {
			if (searchParams.get("EQ_isbank").toString().equals("-1")) {
				searchParams.remove("EQ_isbank");
			}
		}
		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}
		if (searchParams.containsKey("EQ_wxmerchantid")) {
			if (searchParams.get("EQ_wxmerchantid").toString().equals("0")) {
				searchParams.remove("EQ_wxmerchantid");
			}
		}
		if (searchParams.containsKey("LIKE_merchantname")) {
			if (searchParams.get("LIKE_merchantname").toString().equals("")) {
				searchParams.remove("LIKE_merchantname");
			} /*
				 * else { try {
				 * 
				 * searchParams.put("LIKE_merchantname", new String(
				 * searchParams.get("LIKE_merchantname").toString().getBytes(
				 * "iso-8859-1"), "UTF-8")); } catch (Exception e) { } }
				 */
		}
		if (searchParams.containsKey("GTE_usetime")) {
			String startDate = ((String) searchParams.get("GTE_usetime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_usetime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				searchParams.put("GTE_usetime", date);
			}
		}

		if (searchParams.containsKey("LTE_usetime")) {
			String endDate = ((String) searchParams.get("LTE_usetime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_usetime");
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
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_usetime", calendar.getTime());
			}
		}
		
		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime")).trim();

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
				searchParams.put("GTE_createtime", date);
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime")).trim();

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
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_createtime", calendar.getTime());
			}
		}
		
		
		List<WXCardRecord> dvlist = wxcardrecordService.getDownRecord(searchParams);
		/*
		 * model.addAttribute("mers", wXMerchantService.getAll());
		 * model.addAttribute("dvs", dvlist); model.addAttribute("sortType",
		 * sortType); model.addAttribute("sortTypes", sortTypes); if
		 * (searchParams.containsKey("LTE_usetime")) { SimpleDateFormat sdf =
		 * new SimpleDateFormat("yyyy-MM-dd"); Calendar calendar =
		 * Calendar.getInstance(); calendar.setTime((Date)
		 * searchParams.get("LTE_usetime")); calendar.set(Calendar.DATE,
		 * calendar.get(Calendar.DATE) - 1); String str =
		 * sdf.format(calendar.getTime()); searchParams.put("LTE_usetime", str);
		 * }
		 * 
		 * if (searchParams.containsKey("GTE_usetime")) { SimpleDateFormat sdf =
		 * new SimpleDateFormat("yyyy-MM-dd"); searchParams.put("GTE_usetime",
		 * sdf.format(searchParams.get("GTE_usetime"))); } //
		 * 将搜索条件编码成字符串，用于排序，分页的URL model.addAttribute("searchParams",
		 * Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		 * return "wxcard/mycardrecord";
		 */

		try {
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
			String filename = sdf.format(d) + ".xls";
			String mypath = pbasepath + "downloadKJ" + File.separator + "excelKJ";
			File file = new File(mypath);
			if (!file.exists()) {
				file.mkdirs();
			}

			WritableWorkbook wwb = null;// 创建可以写入的工作簿
			File filepath = new File(file.getPath() + File.separator + filename);
			if (!filepath.exists()) {
				filepath.createNewFile();
			}
			wwb = Workbook.createWorkbook(filepath);// 以fileName为文件名来创建一个Workbook
			WritableSheet ws = wwb.createSheet("Shee1", 0); // 创建工作表
			// 要插入到excel表格的行号，默认从0开始
			/* ws.mergeCells(0, 0, 5, 0); */
			Label labelId = new Label(0, 0, "序号");
			Label labelno1 = new Label(1, 0, "卡券名称");
			Label labelno2 = new Label(2, 0, "类型");
			Label labelno3 = new Label(3, 0, "银行");
			Label labelno4 = new Label(4, 0, "持有人");
			Label labelno5 = new Label(5, 0, "使用时间");
			Label labelno6 = new Label(6, 0, "使用商店");
			ws.addCell(labelId);
			ws.addCell(labelno1);
			ws.addCell(labelno2);
			ws.addCell(labelno3);
			ws.addCell(labelno4);
			ws.addCell(labelno5);
			ws.addCell(labelno6);
			for (int i = 0; i < dvlist.size(); i++) {
				Label labelId_i = new Label(0, i + 1, i + 1 + "");
				Label labelno1_i = new Label(1, i + 1, dvlist.get(i).getCardname());

				Label labelno2_i = null;
				if (dvlist.get(i).getCardtype() == "CASH") {
					labelno2_i = new Label(2, i + 1, "现金券");
				} else {
					labelno2_i = new Label(2, i + 1, "折扣券");
				}

				Label labelno3_i = null;
				if (dvlist.get(i).getIsbank() != null) {
					labelno3_i = new Label(3, i + 1, "是");
				} else {
					labelno3_i = new Label(3, i + 1, "否");
				}
				Label labelno4_i = new Label(4, i + 1, dvlist.get(i).getOwnname());
				Label labelno5_i = null;
				if (dvlist.get(i).getUsetime() != null) {
					labelno5_i = new Label(5, i + 1, dvlist.get(i).getUsetime() + "");
				} else {
					labelno5_i = new Label(5, i + 1, "");
				}
				Label labelno6_i = new Label(6, i + 1, dvlist.get(i).getMerchantname());
				ws.addCell(labelId_i);
				ws.addCell(labelno1_i);
				ws.addCell(labelno2_i);
				ws.addCell(labelno3_i);
				ws.addCell(labelno4_i);
				ws.addCell(labelno5_i);
				ws.addCell(labelno6_i);
			}
			wwb.write();
			wwb.close();

			// 文件下载
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
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "dddd")
	@ResponseBody
	public String dddd() {
		int i = 1 / 0;
		return "aa";
	}
}