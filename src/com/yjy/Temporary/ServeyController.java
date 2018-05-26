package com.yjy.Temporary;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Formula;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Temporary.entity.Servey;
import com.yjy.Temporary.service.ServeyService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value="/servey")
public class ServeyController {
	
	@Autowired
	private ServeyService serveyService;
	
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping
	public String getServey(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10", required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		if (searchParams.containsKey("GTE_acttime")) {
			String startDate = ((String) searchParams.get("GTE_acttime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_acttime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				searchParams.put("GTE_acttime", date);
				model.addAttribute("GTE_acttime", startDate);
			}
		}

		if (searchParams.containsKey("LTE_acttime")) {
			String endDate = ((String) searchParams.get("LTE_acttime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_acttime");
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
				searchParams.put("LTE_acttime", calendar.getTime());
				model.addAttribute("LTE_acttime", endDate);
			}
		}
		
		int totalcount = serveyService.countTotalWuxi();
		model.addAttribute("total", new Integer(totalcount));
		
		Page<Servey> serveys = serveyService.getServey(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("serveys", serveys);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "temporary/datirecord";
	}
	
	@RequestMapping(value="setsend/{serid}")
	public String setSend(@PathVariable("serid") Long id) {
		
		Servey servey = serveyService.get(id);
		servey.setSend(1);
		serveyService.save(servey);
		
		return "redirect:/servey/";
	}
	
	
	@RequestMapping(value = "outdata")
	public void outdata(HttpServletResponse response) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		try {
			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			String fileName = Util.getRootPath() + File.separator + "qa" + File.separator + now.getTime();
			
			File fs = new File(fileName);
			if (!fs.exists()) {
				fs.mkdirs();
			}
			File file = new File(fileName + File.separator + "有奖问答名单.xls");
			if (!file.exists()) {
				file.createNewFile();
			}
			
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook
			List<Object[]> lo1 = serveyService.gatAllServey();
			WritableSheet ws = wwb.createSheet("参与者列表", 0); // 创建工作表
			ws.addCell(new Label(0, 0, "排名"));
			ws.addCell(new Label(1, 0, "微信昵称"));
			ws.addCell(new Label(2, 0, "手机号"));
			ws.addCell(new Label(3, 0, "运营商"));
			ws.addCell(new Label(4, 0, "参与时间"));
			ws.addCell(new Label(5, 0, "Openid"));
			for (int i = 0; i < lo1.size(); i++) {
				System.out.println("####---- "+ (i+1));
				ws.addCell(new Label(0, i + 1, lo1.get(i)[0].toString()));
				ws.addCell(new Label(1, i + 1, lo1.get(i)[1] != null ? lo1.get(i)[1].toString() : ""));
				ws.addCell(new Label(2, i + 1, lo1.get(i)[2] != null ? lo1.get(i)[2].toString() : ""));
				ws.addCell(new Label(3, i + 1, lo1.get(i)[2] != null ? Util.getYYS(lo1.get(i)[2].toString()) : ""));
				ws.addCell(new Label(4, i + 1, lo1.get(i)[3] == null ? "" : lo1.get(i)[3].toString()));
				ws.addCell(new Label(5, i + 1, lo1.get(i)[4].toString()));
			}

			
			wwb.write();
			wwb.close();
			Util.makeFile_Zip(Util.getRootPath() + File.separator + "qa" + File.separator + now.getTime() + ".zip",
					fileName);

			response.setContentType("text/html;charset=utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition",
					"attachment; filename=" + new String((now.getTime() + ".zip").getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length",
					String.valueOf(new File(
							Util.getRootPath() + File.separator + "qa" + File.separator + now.getTime() + ".zip")
									.length()));
			bis = new BufferedInputStream(new FileInputStream(
					Util.getRootPath() + File.separator + "qa" + File.separator + now.getTime() + ".zip"));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}
	
	
}
