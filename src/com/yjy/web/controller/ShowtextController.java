package com.yjy.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Inuser;

import com.yjy.service.ImportuserService;
import com.yjy.utils.Util;

@Controller
@RequestMapping(value = "/sss")
public class ShowtextController {
	@Autowired
	private ImportuserService importuserService;

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getshow(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		searchParams = Util.changeEncoding(searchParams);
		Page<Inuser> nums = importuserService.getList(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("impos", nums);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "text/upfile1";
	}
}
