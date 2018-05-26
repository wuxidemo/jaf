package com.yjy.Temporary;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.entity.ShareRedbagRecord;
import com.yjy.Temporary.entity.WinningRecord;
import com.yjy.Temporary.service.ActService;
import com.yjy.Temporary.service.ShareRecordService;
import com.yjy.Temporary.service.ShareRedbagRecordService;
import com.yjy.Temporary.service.WinningRecordService;
import com.yjy.service.WeChatAccountService;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/sharerecord")
public class ShareRecordController {
	@Autowired
	ShareRecordService shareRecordService;
	@Autowired
	ShareRedbagRecordService shareRedbagRecordService;
	@Autowired
	WinningRecordService winningRecordService;
	@Autowired
	ActService actService;
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

		Page<ShareRecord> srs = shareRecordService.getShareRecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("srs", srs);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("token", WXManage.WCA.getAccesstoken());

		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "temporary/srList";
	}

	@RequestMapping(value = "redbag")
	public String redbaglist(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {
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
		Page<ShareRedbagRecord> srs = shareRedbagRecordService.getShareRedbagRecord(searchParams, pageNumber, pageSize,
				sortType);
		model.addAttribute("srs", srs);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "temporary/redbagrecord";
	}

	@RequestMapping(value = "srcj")
	public String srcj() {
		return "temporary/srluckform";
	}

	@RequestMapping(value = "luckdata")
	@ResponseBody
	public Map<String, Object> getLuckData(@RequestParam(value = "time") String time,
			@RequestParam(value = "type") String type, @RequestParam(value = "count") int count,
			@RequestParam(value = "ids") String ids) {
		List<ShareRecord> ltr = shareRecordService.getwindata(time, count, ids);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data", ltr);
		if (ltr.size() == count) {
			result.put("result", "1");
		} else {
			result.put("result", "2");
		}
		return result;
	}

	@RequestMapping(value = "savewin")
	@ResponseBody
	public String savewin(@RequestParam(value = "ids") String ids, @RequestParam(value = "sort") int sort,
			@RequestParam(value = "time") String time) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		winningRecordService.delByData(time, "gzfxhd", sort);
		for (String id : ids.split(",")) {
			WinningRecord wr = new WinningRecord();
			ShareRecord tr = shareRecordService.get(Long.parseLong(id));
			wr.setCreatetime(now);
			wr.setName(tr.getName());
			wr.setOpenid(tr.getOpenid());
			wr.setState(1);
			wr.setType("gzfxhd");
			wr.setWinname(sort);
			wr.setTkid(tr.getId());
			try {
				wr.setWintime(sdf.parse(time));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			winningRecordService.save(wr);
			tr.setState(2);
			shareRecordService.save(tr);
			WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), tr.getOpenid(), "恭喜您中奖了", "中奖了",
					SysConfig.BASEURL + "/wxurl/redirect?url=wxact/sharewin",
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

	@RequestMapping(value = "stop")
	@ResponseBody
	public String stop() {
		actService.stopGZFX();
		return "1";
	}

	@RequestMapping(value = "refreshrb")
	public String refreshredbag() {
		shareRedbagRecordService.refreshredbag();
		return "redirect:/sharerecord/redbag";
	}
}
