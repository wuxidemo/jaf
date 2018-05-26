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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Temporary.entity.Actcardrecord;
import com.yjy.Temporary.entity.TicketRecord;
import com.yjy.Temporary.entity.WinningRecord;
import com.yjy.Temporary.service.ActService;
import com.yjy.Temporary.service.ActcardrecordService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.Temporary.service.WinningRecordService;
import com.yjy.entity.Activity;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

import jxl.Workbook;
import jxl.write.Formula;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Controller
@RequestMapping(value = "/ticketrecord")
public class TicketRecordController {
	@Autowired
	TicketRecordService ticketRecordService;
	@Autowired
	WinningRecordService winningRecordService;
	@Autowired
	ActService actService;
	@Autowired
	ActcardrecordService actcardrecordService;
	@Autowired
	WeChatAccountService weChatAccountService;
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping
	public String list(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

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
				model.addAttribute("GTE_createtime", startDate);
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
				model.addAttribute("LTE_createtime", endDate);
			}
		}

		Page<TicketRecord> trs = ticketRecordService.getTicketRecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("trs", trs);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("token", WXManage.WCA.getAccesstoken());
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "temporary/trList";
	}

	@RequestMapping(value = "/del/{id}")
	public String del(@PathVariable(value = "id") Long id) {
		ticketRecordService.updatestate(id, 3);
		return "redirect:/ticketrecord";
	}

	@RequestMapping(value = "lucklist")
	public String lucklist() {
		return "temporary/lucklist";
	}

	@RequestMapping(value = "luckform")
	public String luckform(Model model) {
		model.addAttribute("token", WXManage.WCA.getAccesstoken());
		return "temporary/luckform";
	}

	@RequestMapping(value = "luckdata")
	@ResponseBody
	public Map<String, Object> getLuckData(@RequestParam(value = "time") String time,
			@RequestParam(value = "type") String type, @RequestParam(value = "count") int count,
			@RequestParam(value = "ids") String ids, @RequestParam(value = "openids") String openids) {
		List<TicketRecord> ltr = ticketRecordService.getWinRecord(time, count, ids, openids);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data", ltr);
		if (!ids.equals("")) {
			count -= ids.split(",").length;
		}
		if (ltr.size() == (count)) {
			result.put("result", "1");
		} else {
			result.put("result", "2");
		}
		return result;
	}

	@RequestMapping(value = "/delr/{id}")
	@ResponseBody
	public String delr(@PathVariable(value = "id") Long id) {
		ticketRecordService.updatestate(id, 3);
		return "1";
	}

	@RequestMapping(value = "/sure/{id}")
	@ResponseBody
	public String sure(@PathVariable(value = "id") Long id) {
		ticketRecordService.updatestate(id, 2);
		return "1";
	}

	String wecardqrpath = "weqrcode";

	@RequestMapping(value = "savewin")
	@ResponseBody
	public String savewin(@RequestParam(value = "ids") String ids, @RequestParam(value = "sort") int sort,
			@RequestParam(value = "time") String time) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		winningRecordService.delByData(time, "qccjhd", sort);
		for (String id : ids.split(",")) {
			WinningRecord wr = new WinningRecord();
			TicketRecord tr = ticketRecordService.get(Long.parseLong(id));
			wr.setCreatetime(now);
			wr.setName(tr.getName());
			wr.setOpenid(tr.getOpenid());
			wr.setState(1);
			wr.setType("qccjhd");
			wr.setWinname(sort);
			wr.setTkid(Long.parseLong(tr.getCode()));
			try {
				wr.setWintime(sdf.parse(time));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			winningRecordService.save(wr);
			tr.setState(2);
			ticketRecordService.save(tr);

			// TODO 生成卡券记录

			if (wr.getWinname() != 4) {
				Actcardrecord ar = new Actcardrecord();
				String filename = Util.getRandomNumber(10) + now.getTime() + ".jpg";
				Date coded = new Date();
				String code = "we" + Util.getRandomNumber(10) + (coded.getTime() + "")
						.substring((coded.getTime() + "").length() - 11, (coded.getTime() + "").length() - 1);

				ar.setCode(code);
				ar.setCreatetime(now);
				try {
					ar.setEndtime(sdf1.parse("2015-11-30 23:59:59"));
					ar.setStarttime(sdf1.parse("2015-11-01 00:00:00"));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ar.setFromact("qccjhd");
				ar.setNickname(tr.getName());
				ar.setOpenid(tr.getOpenid());
				ar.setState(1);
				ar.setTrid(wr.getId());
				Util.createCode(wecardqrpath + File.separator + sdf.format(now), filename, code);
				ar.setUrl(wecardqrpath + "/" + sdf.format(now) + "/" + filename);
				ar.setWinname(sort);
				ar.setWintime(wr.getWintime());
				if (sort == 1) {
					ar.setName("300元现金抵用券");
				} else if (sort == 2) {
					ar.setName("200元现金抵用券");
				} else if (sort == 3) {
					ar.setName("100元现金抵用券");
				} else if (sort == 4) {
					ar.setName("10元现金抵用券");
				}
				actcardrecordService.save(ar);
			}
			WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), tr.getOpenid(), "恭喜您中奖了", "中奖了",
					SysConfig.BASEURL + "/wxurl/redirect?url=wxact/luckwin",
					SysConfig.BASEURL + "/static/11act/images/getwin.jpg");
		}
		return "1";
	}

	@RequestMapping(value = "savewin11")
	@ResponseBody
	public String savewin11(@RequestParam(value = "ids") String ids, @RequestParam(value = "sort") int sort,
			@RequestParam(value = "time") String time) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int price = 1111 / ids.split(",").length;
		winningRecordService.delByData(time, "qccjhd", sort);
		for (String id : ids.split(",")) {
			WinningRecord wr = new WinningRecord();
			TicketRecord tr = ticketRecordService.get(Long.parseLong(id));
			wr.setCreatetime(now);
			wr.setName(tr.getName());
			wr.setOpenid(tr.getOpenid());
			wr.setState(1);
			wr.setType("qccjhd");
			wr.setWinname(sort);
			wr.setTkid(Long.parseLong(tr.getCode()));
			try {
				wr.setWintime(sdf.parse(time));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			wr.setSubname(price);
			winningRecordService.save(wr);
			tr.setState(2);
			ticketRecordService.save(tr);
			WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), tr.getOpenid(), "恭喜您中奖了", "中奖了",
					SysConfig.BASEURL + "/wxurl/redirect?url=wxact/luckwin",
					SysConfig.BASEURL + "/static/11act/images/getwin.jpg");
		}
		return "1";
	}

	@RequestMapping(value = "getwindata")
	@ResponseBody
	public Map<String, Object> getoldwindata(@RequestParam(value = "time") String time,
			@RequestParam(value = "type") String type) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data1", winningRecordService.getListByData(time, type, 1));
		result.put("data2", winningRecordService.getListByData(time, type, 2));
		result.put("data3", winningRecordService.getListByData(time, type, 3));
		result.put("data4", winningRecordService.getListByData(time, type, 4));
		return result;
	}

	@RequestMapping(value = "luckform11")
	public String luckform11(Model model) {
		model.addAttribute("token", WXManage.WCA.getAccesstoken());
		return "temporary/luckform11";
	}

	@RequestMapping(value = "data11")
	@ResponseBody
	public List<TicketRecord> get11Data(@RequestParam(value = "time") String time) {
		return ticketRecordService.get11Data(time);
	}

	@RequestMapping(value = "stop")
	@ResponseBody
	public String stop() {
		actService.stopQCCJ();
		return "1";
	}

	@RequestMapping(value = "outdata")
	public void outdata(@RequestParam(value = "time") String time, HttpServletResponse response) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		try {
			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			String fileName = Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime();
			File fs = new File(fileName);
			if (!fs.exists()) {
				fs.mkdirs();
			}
			File file = new File(fileName + File.separator + "全城抽奖结果.xls");
			if (!file.exists()) {
				file.createNewFile();
			}
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook
			List<Object[]> lo1 = winningRecordService.getOUTData(time, "qccjhd", 1);
			WritableSheet ws = wwb.createSheet("一等奖", 0); // 创建工作表
			ws.addCell(new Label(0, 0, "序号"));
			ws.addCell(new Label(1, 0, "流水号"));
			ws.addCell(new Label(2, 0, "微信昵称"));
			ws.addCell(new Label(3, 0, "手机号"));
			ws.addCell(new Label(4, 0, "运营商"));
			ws.addCell(new Label(5, 0, "时间"));
			ws.addCell(new Label(6, 0, "奖项"));
			ws.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo1.size(); i++) {
				ws.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws.addCell(new Label(1, i + 1, lo1.get(i)[0].toString()));
				ws.addCell(new Label(2, i + 1, lo1.get(i)[1] != null ? lo1.get(i)[1].toString() : ""));
				ws.addCell(new Label(3, i + 1, lo1.get(i)[2] != null ? lo1.get(i)[2].toString() : ""));
				ws.addCell(new Label(4, i + 1, lo1.get(i)[2] != null ? Util.getYYS(lo1.get(i)[2].toString()) : ""));
				ws.addCell(new Label(5, i + 1, lo1.get(i)[3].toString()));
				ws.addCell(new Label(6, i + 1, "300"));
				ws.addCell(new Formula(7, i + 1,
						"HYPERLINK(\"" + Util.downloadNet(
								"http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
										+ WXManage.WCA.getAccesstoken() + "&media_id=" + lo1.get(i)[5].toString(),
								fileName) + "\",\"查看图片\")"));

			}

			List<Object[]> lo2 = winningRecordService.getOUTData(time, "qccjhd", 2);
			WritableSheet ws2 = wwb.createSheet("二等奖", 1); // 创建工作表
			ws2.addCell(new Label(0, 0, "序号"));
			ws2.addCell(new Label(1, 0, "流水号"));
			ws2.addCell(new Label(2, 0, "微信昵称"));
			ws2.addCell(new Label(3, 0, "手机号"));
			ws2.addCell(new Label(4, 0, "运营商"));
			ws2.addCell(new Label(5, 0, "时间"));
			ws2.addCell(new Label(6, 0, "奖项"));
			ws2.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo2.size(); i++) {
				ws2.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws2.addCell(new Label(1, i + 1, lo2.get(i)[0].toString()));
				ws2.addCell(new Label(2, i + 1, lo2.get(i)[1].toString()));
				ws2.addCell(new Label(3, i + 1, lo2.get(i)[2] != null ? lo2.get(i)[2].toString() : ""));
				ws2.addCell(new Label(4, i + 1, lo2.get(i)[2] != null ? Util.getYYS(lo2.get(i)[2].toString()) : ""));
				ws2.addCell(new Label(5, i + 1, lo2.get(i)[3].toString()));
				ws2.addCell(new Label(6, i + 1, "200"));
				ws2.addCell(new Formula(7, i + 1,
						"HYPERLINK(\"" + Util.downloadNet(
								"http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
										+ WXManage.WCA.getAccesstoken() + "&media_id=" + lo2.get(i)[5].toString(),
								fileName) + "\",\"查看图片\")"));

			}

			List<Object[]> lo3 = winningRecordService.getOUTData(time, "qccjhd", 3);
			WritableSheet ws3 = wwb.createSheet("三等奖", 2); // 创建工作表
			ws3.addCell(new Label(0, 0, "序号"));
			ws3.addCell(new Label(1, 0, "流水号"));
			ws3.addCell(new Label(2, 0, "微信昵称"));
			ws3.addCell(new Label(3, 0, "手机号"));
			ws3.addCell(new Label(4, 0, "运营商"));
			ws3.addCell(new Label(5, 0, "时间"));
			ws3.addCell(new Label(6, 0, "奖项"));
			ws3.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo3.size(); i++) {
				ws3.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws3.addCell(new Label(1, i + 1, lo3.get(i)[0].toString()));
				ws3.addCell(new Label(2, i + 1, lo3.get(i)[1] != null ? lo3.get(i)[1].toString() : ""));
				ws3.addCell(new Label(3, i + 1, lo3.get(i)[2] != null ? lo3.get(i)[2].toString() : ""));
				ws3.addCell(new Label(4, i + 1, lo3.get(i)[2] != null ? Util.getYYS(lo3.get(i)[2].toString()) : ""));
				ws3.addCell(new Label(5, i + 1, lo3.get(i)[3].toString()));
				ws3.addCell(new Label(6, i + 1, "100"));
				ws3.addCell(new Formula(7, i + 1,
						"HYPERLINK(\"" + Util.downloadNet(
								"http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
										+ WXManage.WCA.getAccesstoken() + "&media_id=" + lo3.get(i)[5].toString(),
								fileName) + "\",\"查看图片\")"));
			}

			List<Object[]> lo4 = winningRecordService.getOUTData(time, "qccjhd", 4);
			WritableSheet ws4 = wwb.createSheet("幸运奖", 3); // 创建工作表
			ws4.addCell(new Label(0, 0, "序号"));
			ws4.addCell(new Label(1, 0, "流水号"));
			ws4.addCell(new Label(2, 0, "微信昵称"));
			ws4.addCell(new Label(3, 0, "手机号"));
			ws4.addCell(new Label(4, 0, "运营商"));
			ws4.addCell(new Label(5, 0, "时间"));
			ws4.addCell(new Label(6, 0, "奖项"));
			ws4.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo4.size(); i++) {
				ws4.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws4.addCell(new Label(1, i + 1, lo4.get(i)[0].toString()));
				ws4.addCell(new Label(2, i + 1, lo4.get(i)[1] != null ? lo4.get(i)[1].toString() : ""));
				ws4.addCell(new Label(3, i + 1, lo4.get(i)[2] != null ? lo4.get(i)[2].toString() : ""));
				ws4.addCell(new Label(4, i + 1, lo4.get(i)[2] != null ? Util.getYYS(lo4.get(i)[2].toString()) : ""));
				ws4.addCell(new Label(5, i + 1, lo4.get(i)[3].toString()));
				ws4.addCell(new Label(6, i + 1, "10"));
				ws4.addCell(new Formula(7, i + 1,
						"HYPERLINK(\"" + Util.downloadNet(
								"http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
										+ WXManage.WCA.getAccesstoken() + "&media_id=" + lo4.get(i)[5].toString(),
								fileName) + "\",\"查看图片\")"));
			}

			List<Object[]> lo5 = winningRecordService.getOUTData(time, "qccjhd", 5);
			WritableSheet ws5 = wwb.createSheet("脱光奖", 4); // 创建工作表
			ws5.addCell(new Label(0, 0, "序号"));
			ws5.addCell(new Label(1, 0, "流水号"));
			ws5.addCell(new Label(2, 0, "微信昵称"));
			ws5.addCell(new Label(3, 0, "手机号"));
			ws5.addCell(new Label(4, 0, "运营商"));
			ws5.addCell(new Label(5, 0, "时间"));
			ws5.addCell(new Label(6, 0, "奖项"));
			ws5.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo5.size(); i++) {
				ws5.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws5.addCell(new Label(1, i + 1, lo5.get(i)[0].toString()));
				ws5.addCell(new Label(2, i + 1, lo5.get(i)[1].toString()));
				ws5.addCell(new Label(3, i + 1, lo5.get(i)[2] != null ? lo5.get(i)[2].toString() : ""));
				ws5.addCell(new Label(4, i + 1, lo5.get(i)[2] != null ? Util.getYYS(lo5.get(i)[2].toString()) : ""));
				ws5.addCell(new Label(5, i + 1, lo5.get(i)[3].toString()));
				ws5.addCell(new Label(6, i + 1, lo5.get(i)[6] != null ? lo5.get(i)[6].toString() : ""));
				ws5.addCell(new Formula(7, i + 1,
						"HYPERLINK(\"" + Util.downloadNet(
								"http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
										+ WXManage.WCA.getAccesstoken() + "&media_id=" + lo5.get(i)[5].toString(),
								fileName) + "\",\"查看图片\")"));
			}

			/* Label labelno5 = new Label(5, 0, "no5"); */
			// Label labelId_i = new Label(0, 1, "aaa");
			// ws.addCell(labelId_i);
			wwb.write();
			wwb.close();
			Util.makeFile_Zip(Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip",
					fileName);

			response.setContentType("text/html;charset=utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition",
					"attachment; filename=" + new String((now.getTime() + ".zip").getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length",
					String.valueOf(new File(
							Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip")
									.length()));
			bis = new BufferedInputStream(new FileInputStream(
					Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip"));
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

	@RequestMapping(value = "fxoutdata")
	public void fxoutdata(@RequestParam(value = "time") String time, HttpServletResponse response) {

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		try {
			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			String fileName = Util.getRootPath() + File.separator + "gzfxhd" + File.separator + now.getTime();
			File fs = new File(fileName);
			if (!fs.exists()) {
				fs.mkdirs();
			}
			File file = new File(fileName + File.separator + "关注分享结果.xls");
			if (!file.exists()) {
				file.createNewFile();
			}
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook
			List<Object[]> lo1 = winningRecordService.getOUTData(time, "gzfxhd", 1);
			WritableSheet ws = wwb.createSheet("一等奖", 0); // 创建工作表
			ws.addCell(new Label(0, 0, "序号"));
			ws.addCell(new Label(1, 0, "流水号"));
			ws.addCell(new Label(2, 0, "微信昵称"));
			ws.addCell(new Label(3, 0, "手机号"));
			ws.addCell(new Label(4, 0, "运营商"));
			ws.addCell(new Label(5, 0, "时间"));
			ws.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo1.size(); i++) {
				ws.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws.addCell(new Label(1, i + 1, lo1.get(i)[0].toString()));
				ws.addCell(new Label(2, i + 1, lo1.get(i)[1].toString()));
				ws.addCell(new Label(3, i + 1, lo1.get(i)[2] != null ? lo1.get(i)[2].toString() : ""));
				ws.addCell(new Label(4, i + 1, lo1.get(i)[2] != null ? Util.getYYS(lo1.get(i)[2].toString()) : ""));
				ws.addCell(new Label(5, i + 1, lo1.get(i)[3].toString()));
				ws.addCell(new Label(6, i + 1, "300"));
			}

			List<Object[]> lo2 = winningRecordService.getOUTData(time, "gzfxhd", 2);
			WritableSheet ws2 = wwb.createSheet("二等奖", 1); // 创建工作表
			ws2.addCell(new Label(0, 0, "序号"));
			ws2.addCell(new Label(1, 0, "流水号"));
			ws2.addCell(new Label(2, 0, "微信昵称"));
			ws2.addCell(new Label(3, 0, "手机号"));
			ws2.addCell(new Label(4, 0, "运营商"));
			ws2.addCell(new Label(5, 0, "时间"));
			ws2.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo2.size(); i++) {
				ws2.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws2.addCell(new Label(1, i + 1, lo2.get(i)[0].toString()));
				ws2.addCell(new Label(2, i + 1, lo2.get(i)[1].toString()));
				ws2.addCell(new Label(3, i + 1, lo2.get(i)[2] != null ? lo2.get(i)[2].toString() : ""));
				ws2.addCell(new Label(4, i + 1, lo2.get(i)[2] != null ? Util.getYYS(lo2.get(i)[2].toString()) : ""));
				ws2.addCell(new Label(5, i + 1, lo2.get(i)[3].toString()));
				ws2.addCell(new Label(6, i + 1, "200"));
			}

			List<Object[]> lo3 = winningRecordService.getOUTData(time, "gzfxhd", 3);
			WritableSheet ws3 = wwb.createSheet("三等奖", 2); // 创建工作表
			ws3.addCell(new Label(0, 0, "序号"));
			ws3.addCell(new Label(1, 0, "流水号"));
			ws3.addCell(new Label(2, 0, "微信昵称"));
			ws3.addCell(new Label(3, 0, "手机号"));
			ws3.addCell(new Label(4, 0, "运营商"));
			ws3.addCell(new Label(5, 0, "时间"));
			ws3.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo3.size(); i++) {
				ws3.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws3.addCell(new Label(1, i + 1, lo3.get(i)[0].toString()));
				ws3.addCell(new Label(2, i + 1, lo3.get(i)[1].toString()));
				ws3.addCell(new Label(3, i + 1, lo3.get(i)[2] != null ? lo3.get(i)[2].toString() : ""));
				ws3.addCell(new Label(4, i + 1, lo3.get(i)[2] != null ? Util.getYYS(lo3.get(i)[2].toString()) : ""));
				ws3.addCell(new Label(5, i + 1, lo3.get(i)[3].toString()));
				ws3.addCell(new Label(6, i + 1, "100"));
			}
			wwb.write();
			wwb.close();

			response.setContentType("text/html;charset=utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition",
					"attachment; filename=" + new String(("关注分享结果.xls").getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(file));
			bis = new BufferedInputStream(new FileInputStream(file.getPath()));
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

	@RequestMapping(value = "outdata1")
	public void outdata1(@RequestParam(value = "time") String time, HttpServletResponse response) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		try {
			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			String fileName = Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime();
			File fs = new File(fileName);
			if (!fs.exists()) {
				fs.mkdirs();
			}
			File file = new File(fileName + File.separator + "全城抽奖结果.xls");
			if (!file.exists()) {
				file.createNewFile();
			}
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook
			List<Object[]> lo1 = winningRecordService.getOUTData1(time, "qccjhd", 1);
			WritableSheet ws = wwb.createSheet("一等奖", 0); // 创建工作表
			ws.addCell(new Label(0, 0, "序号"));
			ws.addCell(new Label(1, 0, "流水号"));
			ws.addCell(new Label(2, 0, "微信昵称"));
			ws.addCell(new Label(3, 0, "手机号"));
			ws.addCell(new Label(4, 0, "运营商"));
			ws.addCell(new Label(5, 0, "时间"));
			ws.addCell(new Label(6, 0, "奖项"));
			ws.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo1.size(); i++) {
				ws.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws.addCell(new Label(1, i + 1, lo1.get(i)[0].toString()));
				ws.addCell(new Label(2, i + 1, lo1.get(i)[1].toString()));
				ws.addCell(new Label(3, i + 1, lo1.get(i)[2] != null ? lo1.get(i)[2].toString() : ""));
				ws.addCell(new Label(4, i + 1, lo1.get(i)[2] != null ? Util.getYYS(lo1.get(i)[2].toString()) : ""));
				ws.addCell(new Label(5, i + 1, lo1.get(i)[3].toString()));
				ws.addCell(new Label(6, i + 1, "300"));
				// ws.addCell(new Formula(6, i + 1,
				// "HYPERLINK(\"" + Util.downloadNet(
				// "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				// + WXManage.WCA.getAccesstoken() + "&media_id=" +
				// lo1.get(i)[5].toString(),
				// fileName) + "\",\"查看图片\")"));
				winningRecordService.updateState(Long.parseLong(lo1.get(i)[7].toString()));

			}

			List<Object[]> lo2 = winningRecordService.getOUTData1(time, "qccjhd", 2);
			WritableSheet ws2 = wwb.createSheet("二等奖", 1); // 创建工作表
			ws2.addCell(new Label(0, 0, "序号"));
			ws2.addCell(new Label(1, 0, "流水号"));
			ws2.addCell(new Label(2, 0, "微信昵称"));
			ws2.addCell(new Label(3, 0, "手机号"));
			ws2.addCell(new Label(4, 0, "运营商"));
			ws2.addCell(new Label(5, 0, "时间"));
			ws2.addCell(new Label(6, 0, "奖项"));
			ws2.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo2.size(); i++) {
				ws2.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws2.addCell(new Label(1, i + 1, lo2.get(i)[0].toString()));
				ws2.addCell(new Label(2, i + 1, lo2.get(i)[1].toString()));
				ws2.addCell(new Label(3, i + 1, lo2.get(i)[2] != null ? lo2.get(i)[2].toString() : ""));
				ws2.addCell(new Label(4, i + 1, lo2.get(i)[2] != null ? Util.getYYS(lo2.get(i)[2].toString()) : ""));
				ws2.addCell(new Label(5, i + 1, lo2.get(i)[3].toString()));
				ws2.addCell(new Label(6, i + 1, "200"));
				// ws2.addCell(new Formula(6, i + 1,
				// "HYPERLINK(\"" + Util.downloadNet(
				// "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				// + WXManage.WCA.getAccesstoken() + "&media_id=" +
				// lo2.get(i)[5].toString(),
				// fileName) + "\",\"查看图片\")"));
				winningRecordService.updateState(Long.parseLong(lo2.get(i)[7].toString()));

			}

			List<Object[]> lo3 = winningRecordService.getOUTData1(time, "qccjhd", 3);
			WritableSheet ws3 = wwb.createSheet("三等奖", 2); // 创建工作表
			ws3.addCell(new Label(0, 0, "序号"));
			ws3.addCell(new Label(1, 0, "流水号"));
			ws3.addCell(new Label(2, 0, "微信昵称"));
			ws3.addCell(new Label(3, 0, "手机号"));
			ws3.addCell(new Label(4, 0, "运营商"));
			ws3.addCell(new Label(5, 0, "时间"));
			ws3.addCell(new Label(6, 0, "奖项"));
			ws3.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo3.size(); i++) {
				ws3.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws3.addCell(new Label(1, i + 1, lo3.get(i)[0].toString()));
				ws3.addCell(new Label(2, i + 1, lo3.get(i)[1].toString()));
				ws3.addCell(new Label(3, i + 1, lo3.get(i)[2] != null ? lo3.get(i)[2].toString() : ""));
				ws3.addCell(new Label(4, i + 1, lo3.get(i)[2] != null ? Util.getYYS(lo3.get(i)[2].toString()) : ""));
				ws3.addCell(new Label(5, i + 1, lo3.get(i)[3].toString()));
				ws3.addCell(new Label(6, i + 1, "100"));
				// ws3.addCell(new Formula(6, i + 1,
				// "HYPERLINK(\"" + Util.downloadNet(
				// "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				// + WXManage.WCA.getAccesstoken() + "&media_id=" +
				// lo3.get(i)[5].toString(),
				// fileName) + "\",\"查看图片\")"));
				winningRecordService.updateState(Long.parseLong(lo3.get(i)[7].toString()));
			}

			List<Object[]> lo4 = winningRecordService.getOUTData1(time, "qccjhd", 4);
			WritableSheet ws4 = wwb.createSheet("幸运奖", 3); // 创建工作表
			ws4.addCell(new Label(0, 0, "序号"));
			ws4.addCell(new Label(1, 0, "流水号"));
			ws4.addCell(new Label(2, 0, "微信昵称"));
			ws4.addCell(new Label(3, 0, "手机号"));
			ws4.addCell(new Label(4, 0, "运营商"));
			ws4.addCell(new Label(5, 0, "时间"));
			ws4.addCell(new Label(6, 0, "奖项"));
			ws4.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo4.size(); i++) {
				ws4.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws4.addCell(new Label(1, i + 1, lo4.get(i)[0].toString()));
				ws4.addCell(new Label(2, i + 1, lo4.get(i)[1].toString()));
				ws4.addCell(new Label(3, i + 1, lo4.get(i)[2] != null ? lo4.get(i)[2].toString() : ""));
				ws4.addCell(new Label(4, i + 1, lo4.get(i)[2] != null ? Util.getYYS(lo4.get(i)[2].toString()) : ""));
				ws4.addCell(new Label(5, i + 1, lo4.get(i)[3].toString()));
				ws4.addCell(new Label(6, i + 1, "10"));
				// ws4.addCell(new Formula(6, i + 1,
				// "HYPERLINK(\"" + Util.downloadNet(
				// "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				// + WXManage.WCA.getAccesstoken() + "&media_id=" +
				// lo4.get(i)[5].toString(),
				// fileName) + "\",\"查看图片\")"));
				winningRecordService.updateState(Long.parseLong(lo4.get(i)[7].toString()));
			}

			List<Object[]> lo5 = winningRecordService.getOUTData1(time, "qccjhd", 5);
			WritableSheet ws5 = wwb.createSheet("脱光奖", 4); // 创建工作表
			ws5.addCell(new Label(0, 0, "序号"));
			ws5.addCell(new Label(1, 0, "流水号"));
			ws5.addCell(new Label(2, 0, "微信昵称"));
			ws5.addCell(new Label(3, 0, "手机号"));
			ws5.addCell(new Label(4, 0, "运营商"));
			ws5.addCell(new Label(5, 0, "时间"));
			ws5.addCell(new Label(6, 0, "奖项"));
			ws5.addCell(new Label(7, 0, "图片"));
			for (int i = 0; i < lo5.size(); i++) {
				ws5.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws5.addCell(new Label(1, i + 1, lo5.get(i)[0].toString()));
				ws5.addCell(new Label(2, i + 1, lo5.get(i)[1].toString()));
				ws5.addCell(new Label(3, i + 1, lo5.get(i)[2] != null ? lo5.get(i)[2].toString() : ""));
				ws5.addCell(new Label(4, i + 1, lo5.get(i)[2] != null ? Util.getYYS(lo5.get(i)[2].toString()) : ""));
				ws5.addCell(new Label(5, i + 1, lo5.get(i)[3].toString()));
				ws5.addCell(new Label(6, i + 1, lo5.get(i)[6] != null ? lo5.get(i)[6].toString() : ""));
				// ws5.addCell(new Formula(6, i + 1,
				// "HYPERLINK(\"" + Util.downloadNet(
				// "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				// + WXManage.WCA.getAccesstoken() + "&media_id=" +
				// lo5.get(i)[5].toString(),
				// fileName) + "\",\"查看图片\")"));
				winningRecordService.updateState(Long.parseLong(lo5.get(i)[7].toString()));
			}

			/* Label labelno5 = new Label(5, 0, "no5"); */
			// Label labelId_i = new Label(0, 1, "aaa");
			// ws.addCell(labelId_i);
			wwb.write();
			wwb.close();
			Util.makeFile_Zip(Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip",
					fileName);

			response.setContentType("text/html;charset=utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition",
					"attachment; filename=" + new String((now.getTime() + ".zip").getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length",
					String.valueOf(new File(
							Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip")
									.length()));
			bis = new BufferedInputStream(new FileInputStream(
					Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip"));
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

	@RequestMapping(value = "fxoutdata1")
	public void fxoutdata1(@RequestParam(value = "time") String time, HttpServletResponse response) {

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		try {
			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			String fileName = Util.getRootPath() + File.separator + "gzfxhd" + File.separator + now.getTime();
			File fs = new File(fileName);
			if (!fs.exists()) {
				fs.mkdirs();
			}
			File file = new File(fileName + File.separator + "关注分享结果.xls");
			if (!file.exists()) {
				file.createNewFile();
			}
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook
			List<Object[]> lo1 = winningRecordService.getOUTData1(time, "gzfxhd", 1);
			WritableSheet ws = wwb.createSheet("一等奖", 0); // 创建工作表
			ws.addCell(new Label(0, 0, "序号"));
			ws.addCell(new Label(1, 0, "流水号"));
			ws.addCell(new Label(2, 0, "微信昵称"));
			ws.addCell(new Label(3, 0, "手机号"));
			ws.addCell(new Label(4, 0, "运营商"));
			ws.addCell(new Label(5, 0, "时间"));
			ws.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo1.size(); i++) {
				ws.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws.addCell(new Label(1, i + 1, lo1.get(i)[0].toString()));
				ws.addCell(new Label(2, i + 1, lo1.get(i)[1].toString()));
				ws.addCell(new Label(3, i + 1, lo1.get(i)[2] != null ? lo1.get(i)[2].toString() : ""));
				ws.addCell(new Label(4, i + 1, lo1.get(i)[2] != null ? Util.getYYS(lo1.get(i)[2].toString()) : ""));
				ws.addCell(new Label(5, i + 1, lo1.get(i)[3].toString()));
				ws.addCell(new Label(6, i + 1, "300"));
				winningRecordService.updateState(Long.parseLong(lo1.get(i)[7].toString()));
			}

			List<Object[]> lo2 = winningRecordService.getOUTData1(time, "gzfxhd", 2);
			WritableSheet ws2 = wwb.createSheet("二等奖", 1); // 创建工作表
			ws2.addCell(new Label(0, 0, "序号"));
			ws2.addCell(new Label(1, 0, "流水号"));
			ws2.addCell(new Label(2, 0, "微信昵称"));
			ws2.addCell(new Label(3, 0, "手机号"));
			ws2.addCell(new Label(4, 0, "运营商"));
			ws2.addCell(new Label(5, 0, "时间"));
			ws2.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo2.size(); i++) {
				ws2.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws2.addCell(new Label(1, i + 1, lo2.get(i)[0].toString()));
				ws2.addCell(new Label(2, i + 1, lo2.get(i)[1].toString()));
				ws2.addCell(new Label(3, i + 1, lo2.get(i)[2] != null ? lo2.get(i)[2].toString() : ""));
				ws2.addCell(new Label(4, i + 1, lo2.get(i)[2] != null ? Util.getYYS(lo2.get(i)[2].toString()) : ""));
				ws2.addCell(new Label(5, i + 1, lo2.get(i)[3].toString()));
				ws2.addCell(new Label(6, i + 1, "200"));
				winningRecordService.updateState(Long.parseLong(lo2.get(i)[7].toString()));
			}

			List<Object[]> lo3 = winningRecordService.getOUTData1(time, "gzfxhd", 3);
			WritableSheet ws3 = wwb.createSheet("三等奖", 2); // 创建工作表
			ws3.addCell(new Label(0, 0, "序号"));
			ws3.addCell(new Label(1, 0, "流水号"));
			ws3.addCell(new Label(2, 0, "微信昵称"));
			ws3.addCell(new Label(3, 0, "手机号"));
			ws3.addCell(new Label(4, 0, "运营商"));
			ws3.addCell(new Label(5, 0, "时间"));
			ws3.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo3.size(); i++) {
				ws3.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws3.addCell(new Label(1, i + 1, lo3.get(i)[0].toString()));
				ws3.addCell(new Label(2, i + 1, lo3.get(i)[1].toString()));
				ws3.addCell(new Label(3, i + 1, lo3.get(i)[2] != null ? lo3.get(i)[2].toString() : ""));
				ws3.addCell(new Label(4, i + 1, lo3.get(i)[2] != null ? Util.getYYS(lo3.get(i)[2].toString()) : ""));
				ws3.addCell(new Label(5, i + 1, lo3.get(i)[3].toString()));
				ws3.addCell(new Label(6, i + 1, "100"));
				winningRecordService.updateState(Long.parseLong(lo3.get(i)[7].toString()));
			}
			wwb.write();
			wwb.close();

			response.setContentType("text/html;charset=utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition",
					"attachment; filename=" + new String(("关注分享结果.xls").getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(file));
			bis = new BufferedInputStream(new FileInputStream(file.getPath()));
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

	@RequestMapping(value = "outdata2")
	public void outdata2(HttpServletResponse response) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		try {
			WritableWorkbook wwb = null; // 创建可以写入的工作簿
			String fileName = Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime();
			File fs = new File(fileName);
			if (!fs.exists()) {
				fs.mkdirs();
			}
			File file = new File(fileName + File.separator + "人气值活动.xls");
			if (!file.exists()) {
				file.createNewFile();
			}
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook
			List<Object[]> lo1 = winningRecordService.getOUTData("2015-11-12", "rqzhd", 3);
			WritableSheet ws = wwb.createSheet("三等奖", 0); // 创建工作表
			ws.addCell(new Label(0, 0, "序号"));
			ws.addCell(new Label(1, 0, "流水号"));
			ws.addCell(new Label(2, 0, "微信昵称"));
			ws.addCell(new Label(3, 0, "手机号"));
			ws.addCell(new Label(4, 0, "运营商"));
			ws.addCell(new Label(5, 0, "时间"));
			ws.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo1.size(); i++) {
				ws.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws.addCell(new Label(1, i + 1, lo1.get(i)[0].toString()));
				ws.addCell(new Label(2, i + 1, lo1.get(i)[1].toString()));
				ws.addCell(new Label(3, i + 1, lo1.get(i)[2] != null ? lo1.get(i)[2].toString() : ""));
				ws.addCell(new Label(4, i + 1, lo1.get(i)[2] != null ? Util.getYYS(lo1.get(i)[2].toString()) : ""));
				ws.addCell(new Label(5, i + 1, lo1.get(i)[3].toString()));
				ws.addCell(new Label(6, i + 1,
						lo1.get(i)[6] != null ? (lo1.get(i)[6].toString().equals(0) ? "20元话费" : "500M流量") : ""));

			}

			List<Object[]> lo2 = winningRecordService.getOUTData("2015-11-12", "qccjhd", 4);
			WritableSheet ws2 = wwb.createSheet("四等奖", 1); // 创建工作表
			ws2.addCell(new Label(0, 0, "序号"));
			ws2.addCell(new Label(1, 0, "流水号"));
			ws2.addCell(new Label(2, 0, "微信昵称"));
			ws2.addCell(new Label(3, 0, "手机号"));
			ws2.addCell(new Label(4, 0, "运营商"));
			ws2.addCell(new Label(5, 0, "时间"));
			ws2.addCell(new Label(6, 0, "奖项"));
			for (int i = 0; i < lo2.size(); i++) {
				ws2.addCell(new Label(0, i + 1, (i + 1) + ""));
				ws2.addCell(new Label(1, i + 1, lo2.get(i)[0].toString()));
				ws2.addCell(new Label(2, i + 1, lo2.get(i)[1].toString()));
				ws2.addCell(new Label(3, i + 1, lo2.get(i)[2] != null ? lo2.get(i)[2].toString() : ""));
				ws2.addCell(new Label(4, i + 1, lo2.get(i)[2] != null ? Util.getYYS(lo2.get(i)[2].toString()) : ""));
				ws2.addCell(new Label(5, i + 1, lo2.get(i)[3].toString()));
				ws2.addCell(new Label(6, i + 1, "10元话费"));
			}

			wwb.write();
			wwb.close();
			Util.makeFile_Zip(Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip",
					fileName);

			response.setContentType("text/html;charset=utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition",
					"attachment; filename=" + new String((now.getTime() + ".zip").getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length",
					String.valueOf(new File(
							Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip")
									.length()));
			bis = new BufferedInputStream(new FileInputStream(
					Util.getRootPath() + File.separator + "qccj" + File.separator + now.getTime() + ".zip"));
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
