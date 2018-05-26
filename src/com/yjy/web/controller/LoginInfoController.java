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
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.LoginInfo;
import com.yjy.service.LoginInfoService;
import com.yjy.utils.Util;

/**
 * 类LoginInfoController.java的实现描述：用来统计用户登录信息的Controller，包括记录登陆信息，像账号，ip等信息
 * @author yigang 2015年4月20日 下午1:26:43
 */
@Controller
@RequestMapping(value = "/logininfo")
public class LoginInfoController {
	
	@Autowired
	private LoginInfoService loginInfoService;
	
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
	}
	
	/** 
	 * 获取用户信息列表
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:08:00
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		
		for(String key : searchParams.keySet()) {
			String keyValue = (String) searchParams.get(key);
			if(keyValue != null && !keyValue.equals("")) {
				model.addAttribute(key.replace(".", "_"), Util.formatUTFString(keyValue));
			}
		}
		
		searchParams = Util.changeEncoding(searchParams);
		
		if (searchParams.containsKey("LIKE_name")) {
			String name = (String) searchParams.get("LIKE_name");
			String nameTrim = name.trim();
			if (nameTrim == null || "".equals(nameTrim.trim()) || "null".equals(nameTrim)) {
				searchParams.remove("LIKE_name");
			}else{
				searchParams.put("LIKE_name", nameTrim);
			}
		}
		
		Page<LoginInfo> loginInfoList = loginInfoService.getLoginInfo(searchParams,
				pageNumber, pageSize, sortType);
		model.addAttribute("loginInfos", loginInfoList);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "logininfo/logininfo";
	}
}
