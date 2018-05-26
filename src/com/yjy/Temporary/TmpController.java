package com.yjy.Temporary;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.service.MyService;
import com.yjy.utils.Util;

@Controller
@RequestMapping(value = "/tmp")
public class TmpController {

	@Autowired
	TmprecordService tmprecordService;
	@Autowired
	MyService myService;

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping(method = RequestMethod.GET, value = "/egg")
	private String getData(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		searchParams = Util.changeEncoding(searchParams);
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
				Date date = null;
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
		Page<Tmprecord> tmps = tmprecordService.getTmprecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("tmps", tmps);
		model.addAttribute("totalcount", myService.getTmpRecordCount(searchParams));
		model.addAttribute("maxprice", myService.getTmpRecordSumPrice(searchParams));
		model.addAttribute("maxrebateprice", myService.getTmpRecordSumRebatePrice(searchParams));

		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL

		return "temporary/egglist";
	}
}
