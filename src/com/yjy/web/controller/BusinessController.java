package com.yjy.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Business;
import com.yjy.entity.User;
import com.yjy.service.BusinessService;
import com.yjy.utils.Util;

/**
 * 类BusinessController.java的实现描述： 操作商圈
 * 
 * @author zhangmengmeng 2015-3-28 下午3:21:10
 */
@Controller
@RequestMapping(value = "/business")
public class BusinessController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}


	@Autowired
	private BusinessService businessService;

	/**
	 * 获取商圈列表
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:38:33
	 * @return
	 */
	@RequestMapping()
	private String getCategoryTypeList(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		// Long userId = getCurrentUserId();
		//searchParams = Util.changeEncoding(searchParams);
		if (searchParams.containsKey("LIKE_name")) {
			String realName = (String) searchParams.get("LIKE_name");
			if (realName == null || "".equals(realName.trim())) {
				searchParams.remove("LIKE_name");
			}else{
				searchParams.put("LIKE_name", realName.trim());
				model.addAttribute("LIKE_name", realName.trim());
			}
		}
		if (searchParams.containsKey("EQ_categoryValue.id")) {
			String district = (String) searchParams.get("EQ_categoryValue.id");
			if (district == "-1" || "-1".equals(district.trim())) {
				searchParams.remove("EQ_categoryValue.id");
			}
		}
		Page<Business> business = businessService.getBusinessList(searchParams, pageNumber, pageSize,
						sortType);

		model.addAttribute("business", business);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "business/list";
	}

	

	/**
	 * 新增商圈
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午3:27:26
	 * @param business
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String create(@Valid Business business,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		business.setCreatetime(new Date());
		User user = (User) request.getSession().getAttribute("user");
		business.setUser(user);
		businessService.SaveOrUpdate(business);
		redirectAttributes.addFlashAttribute("message", "更新成功");
		return "redirect:/business";

	}



	/**
	 * 判断商圈是否存在
	 * @author zhangmengmeng
	 * @date 2015-6-15 上午11:36:00
	 * @param id
	 * @param name
	 * @param cid
	 * @return
	 */
	@RequestMapping(value = "/checkname", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> CheckCategoryValue(
			@RequestParam(value = "id") Long id,
			@RequestParam(value = "name") String name,
			@RequestParam(value = "cid") Long cid) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Business> businesses = businessService.getBusinessByName(name,cid);
		if (businesses.size() == 0) {
			map.put("result", true);
		} else if (businesses.get(0).getId().equals(id)) {
			map.put("result", true);
		} else {
			map.put("result", false);
			map.put("msg", "商圈名称已存在");
		}
		return map;
	}

	/**
	 * 删除Business对象。
	 * @author zhangmengmeng
	 * @date 2015-6-15 上午11:35:53
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deletecategorytype(
			@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = businessService.delete(ids);
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}
	
	@RequestMapping(value = "/getbusinessbydisid", method = RequestMethod.POST)
	@ResponseBody
	public List<Business> getBusinessListByDistrictid(@RequestParam(value = "disid") Long disid) {
		
		List<Business> busilist = businessService.getBusinessListByDistrictid(disid);
				
		return busilist;
	}
	
	@RequestMapping(value = "getallbusinessgroup")
	@ResponseBody
	public Map<String, Object> getAllBusinessGroup() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Business> busilist = businessService.getList();
		
		if(busilist != null && busilist.size() > 0) {
			map.put("result", "1");
			map.put("data", busilist);
		}else{
			map.put("result", "0");
			map.put("data", "");
			
		}
				
		return map;
	}
	
}
