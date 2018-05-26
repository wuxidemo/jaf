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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Temporary.entity.Popularity;
import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.entity.ShareRedbagRecord;
import com.yjy.Temporary.entity.TicketRecord;
import com.yjy.Temporary.entity.WinningRecord;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.ShareRecordService;
import com.yjy.Temporary.service.ShareRedbagRecordService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.Temporary.service.WinningRecordService;
import com.yjy.entity.Activity;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/winningrecord")
public class WinningRecordController {
	@Autowired
	WinningRecordService winningRecordService;
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
		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}
		if (searchParams.containsKey("EQ_type")) {
			if (searchParams.get("EQ_type").toString().equals("0")) {
				searchParams.remove("EQ_type");
			}
		}
		if (searchParams.containsKey("EQ_winname")) {
			if (searchParams.get("EQ_winname").toString().equals("0")) {
				searchParams.remove("EQ_winname");
			}
		}
		if (searchParams.containsKey("GTE_wintime")) {
			String startDate = ((String) searchParams.get("GTE_wintime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_wintime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				searchParams.put("GTE_wintime", date);
			}
		}

		if (searchParams.containsKey("LTE_wintime")) {
			String endDate = ((String) searchParams.get("LTE_wintime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_wintime");
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
				calendar.add(Calendar.MINUTE, 59);
				searchParams.put("LTE_wintime", calendar.getTime());
			}
		}
		Page<WinningRecord> srs = winningRecordService.getWinningRecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("srs", srs);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "temporary/wrlist";
	}

	@RequestMapping(value = "deal/{id}")
	public String deal(@PathVariable(value = "id") Long id) {
		winningRecordService.updateState(id);
		return "redirect:/winningrecord";
	}
}
