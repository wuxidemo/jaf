package com.yjy.web.controller;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Jsy;
import com.yjy.service.JsyService;
import com.yjy.utils.Util;

@Controller
@RequestMapping(value = "/jsy")
public class JsyController {
	
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	private JsyService jsyService;

	@RequestMapping(method = RequestMethod.GET)
	public String getIndex(
			@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType,
			Model model, ServletRequest request) {
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams = Util.changeEncoding(searchParams);
		
		if (searchParams.containsKey("LIKE_name")) {
			String name = (String) searchParams.get("LIKE_name");
			if (name == null || "".equals(name.trim())) {
				searchParams.remove("LIKE_name");
			}else{
				searchParams.put("LIKE_name", name.trim());
			}
		}
		
		Page<Jsy> jsyList = jsyService.getJsys(searchParams, pageNumber,
				pageSize, sortType);
		model.addAttribute("jsys", jsyList);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "jsy/jsyList";
	}
	
	@RequestMapping(value="contact", method = RequestMethod.GET)
	public String getIndex(@RequestParam(value = "jsyid") Long jsyid,
			Model model, ServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		Jsy jsy = jsyService.get(jsyid);
		jsy.setState(1);
		jsyService.save(jsy);
		
		redirectAttributes.addFlashAttribute("message", "数据更新成功！");
		return "redirect:/jsy/";
	}
}
