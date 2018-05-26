package com.yjy.web.controller;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.yjy.entity.Payorder;
import com.yjy.service.PayorderService;

@Controller
@RequestMapping(value = "/payorder")
public class PayorderController {
	@Autowired
	private PayorderService payorderService;
	
	private static final String PAGE_SIZE = "10";
	
	@RequestMapping()
	private String getmerlist(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");

		// searchParams = Util.changeEncoding(searchParams);
		if (searchParams.containsKey("LIKE_nickname")) {
			String nickname = (String) searchParams.get("LIKE_nickname");
			if (nickname == null || "".equals(nickname.trim())) {
				searchParams.remove("LIKE_nickname");
			} else {
				searchParams.put("LIKE_nickname", nickname.trim());
				model.addAttribute("LIKE_nickname", nickname.trim());
			}
		}
		searchParams.put("EQ_state", 1);
		Page<Payorder> payorderList = payorderService.getPayorder(searchParams,
				pageNumber, pageSize, sortType);
		model.addAttribute("payorderList", payorderList);
		
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "payorder/payorderList";
	}
}
