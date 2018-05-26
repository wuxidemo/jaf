package com.yjy.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.yjy.entity.Sq_PensionAct;
import com.yjy.entity.Sq_PensionApply;
import com.yjy.service.Sq_PensionActService;
import com.yjy.service.Sq_PensionApplyService;

@Controller
@RequestMapping(value = "/pensionapply")
public class Sq_PensionApplyController {
	private static final String PAGE_SIZE = "10";
	private static Map<String, Object> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	@Autowired
	Sq_PensionApplyService pensionApplyService;
	/**
	 * 跳转到pensionapplylist页面
	 */
	@Autowired
	Sq_PensionActService pensionActService;

	@RequestMapping
	public String list(Model model, HttpServletRequest request) {

		List<Sq_PensionAct> pensionActs = pensionActService.getAllSqPensionAct();

		model.addAttribute("pensionacts", pensionActs);
		return "pension/pensionapplylist";
	}

	/**
	 * 分页查询
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/penlist")
	@ResponseBody
	public Page<Sq_PensionApply> getPensionApplyList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, HttpServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if (searchParams.containsKey("EQ_type")) {
			String type = (String) searchParams.get("EQ_type");
			if (type == null || "0".equals(type.trim())) {
				searchParams.remove("EQ_type");
			}
		}
		if (searchParams.containsKey("EQ_pensionAct.id")) {
			String sqactid = (String) searchParams.get("EQ_pensionAct.id");
			if (sqactid == null || "0".equals(sqactid.trim())) {
				searchParams.remove("EQ_pensionAct.id");
			}
		}
		Page<Sq_PensionApply> pension = pensionApplyService.getPensionApplyList(searchParams, pageNumber, pageSize,
				sortType);
		return pension;
	}

	/**
	 * 显示详情
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/showdetail/{id}")
	@ResponseBody
	public Map<String, Object> detail(@PathVariable(value = "id") Long id) {

		Map<String, Object> map = new HashMap<String, Object>();

		Sq_PensionApply sp = pensionApplyService.get(id);

		if (sp != null) {
			map.put("result", "1");
			map.put("data", sp);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}
}
