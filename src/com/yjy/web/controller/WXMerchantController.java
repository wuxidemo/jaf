package com.yjy.web.controller;

import java.util.HashMap;
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
import com.yjy.entity.Activity;
import com.yjy.entity.WXMerchant;
import com.yjy.service.WXMerchantService;

@Controller
@RequestMapping(value = "/wxmer")
public class WXMerchantController {
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	@Autowired
	WXMerchantService wXMerchantService;

	@RequestMapping()
	private String list(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {

		Map<String, Object> searchParams = new HashMap<String, Object>();
		Page<WXMerchant> wxmers = wXMerchantService.getList(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("mers", wxmers);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "/wxmerchant/list";
	}

	@RequestMapping(value = "/refresh")
	public String refreshList() {
		wXMerchantService.RefreshWXMER();
		return "redirect:/wxmer";
	}
}
