package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
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
import com.yjy.entity.Rebate;
import com.yjy.entity.RebateRecord;
import com.yjy.service.MyService;
import com.yjy.service.RebateRecordService;
import com.yjy.service.RebateService;
import com.yjy.utils.Util;

/**
 * 类RebateRecordController.java的实现描述：红包发放查询
 * 
 * @author wutao 2015-6-23 下午3:50:10
 */
@Controller
@RequestMapping(value = "/rrecord")
public class RebateRecordController {

	@Autowired
	private RebateRecordService rebateRecordService;
	@Autowired
	private RebateService rebateService;
	@Autowired
	private MyService myService;
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		// sortTypes.put("state", "状态");
	}

	/**
	 * 获取所有的RebateRecord记录，得到RebateRecord的列表，提供前端展示。
	 * 
	 * @author wutao
	 * @date 2015年6月23日 下午4:50:32
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return 视图映射字符串，供视图解析器解析
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
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

		if (searchParams.containsKey("LIKE_mycode")) {
			String mycode = (String) searchParams.get("LIKE_mycode");
			String mycodeTrim = mycode.trim();
			if (mycode == null || "".equals(mycodeTrim) || "null".equals(mycodeTrim)) {
				searchParams.remove("LIKE_mycode");

			} else {
				model.addAttribute("mycode", mycode);
			}
		}

		if (searchParams.containsKey("LIKE_receivename")) {
			String receivename = (String) searchParams.get("LIKE_receivename");
			String receivenameTrim = receivename.trim();
			if (receivename == null || "".equals(receivenameTrim) || "null".equals(receivenameTrim)
					|| receivenameTrim.equals("0")) {
				searchParams.remove("LIKE_receivename");
			} else {
				model.addAttribute("receivename", receivename);
			}
		}
		if (searchParams.containsKey("EQ_rebatename")) {
			String rebatename = (String) searchParams.get("EQ_rebatename");
			String rebatenameTrim = rebatename.trim();
			if (rebatename == null || "".equals(rebatenameTrim) || "null".equals(rebatenameTrim)
					|| rebatenameTrim.equals("0")) {
				searchParams.remove("EQ_rebatename");
			} else {
				model.addAttribute("rebatename", rebatename);
			}
		}

		if (searchParams.containsKey("GTE_createdate")) {
			String startDate = ((String) searchParams.get("GTE_createdate")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_createdate");
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
				searchParams.put("GTE_createdate", calendar.getTime());
			}
		}

		if (searchParams.containsKey("LTE_createdate")) {
			String endDate = ((String) searchParams.get("LTE_createdate")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_createdate");
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
				searchParams.put("LTE_createdate", calendar.getTime());
			}
		}
		if (searchParams.containsKey("EQ_state")) {
			String state = (String) searchParams.get("EQ_state");
			String stateTrim = state.trim();
			if (state == null || "".equals(stateTrim) || stateTrim.equals("null") || stateTrim.equals("0")) {
				searchParams.remove("EQ_state");
			} else {
				model.addAttribute("state", state);
			}
		}
		if (searchParams.containsKey("EQ_rebateid")) {
			String state = (String) searchParams.get("EQ_rebateid");
			String stateTrim = state.trim();
			if (state == null || "".equals(stateTrim) || stateTrim.equals("null") || stateTrim.equals("0")) {
				searchParams.remove("EQ_rebateid");
			} else {
				model.addAttribute("rebateid", state);
			}
		}

		List<Rebate> rebate = rebateService.findAllRebates();
		Page<RebateRecord> dvlist = rebateRecordService.getRebateRecord(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("totalcount", myService.getRebateRecordCountByParam(searchParams));
		model.addAttribute("maxprice", myService.getRebateRecordSumByParam(searchParams) / 100.0);
		if (searchParams.containsKey("GTE_paytime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_paytime", sdf.format(searchParams.get("GTE_paytime")));
		}
		if (searchParams.containsKey("LTE_paytime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("LTE_paytime", sdf.format(searchParams.get("LTE_paytime")));
		}
		model.addAttribute("dvs", dvlist);
		model.addAttribute("rebatename", rebate);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "rebate/rebaterecord";
	}
}
