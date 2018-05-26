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
import com.yjy.entity.CategoryType;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.User;
import com.yjy.service.CategoryTypeService;
import com.yjy.service.CategoryValueService;
import com.yjy.service.UserService;
import com.yjy.utils.Util;

/**
 * 类CategoryController.java的实现描述： 操作字典项
 * 
 * @author zhangmengmeng 2015-3-28 下午3:21:10
 */
@Controller
@RequestMapping(value = "/system")
public class CategoryController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	private CategoryTypeService categoryTypeService;

	@Autowired
	private CategoryValueService categoryValueService;
     
	@Autowired
	private UserService userService;
	/**
	 * 获取字典项列表
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:38:33
	 * @return
	 */
	@RequestMapping(value = "/categorytype")
	private String getCategoryTypeList(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		// Long userId = getCurrentUserId();
		//searchParams = Util.changeEncoding(searchParams);
		if (searchParams.containsKey("LIKE_value")) {
			String realName = (String) searchParams.get("LIKE_value");
			if (realName == null || "".equals(realName.trim())) {
				searchParams.remove("LIKE_value");
			}else{
				searchParams.put("LIKE_value", realName.trim());
				model.addAttribute("LIKE_value", realName.trim());
			}
		}
		searchParams.put("EQ_state", 0);
		Page<CategoryType> categorytypes = categoryTypeService
				.getCategoryTypeList(searchParams, pageNumber, pageSize,
						sortType);

		model.addAttribute("categorytypes", categorytypes);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "category/categorytype";
	}

	/**
	 * 获取字典项值
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午4:25:10
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/categoryvalue")
	private String getCategoryValueList(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		// Long userId = getCurrentUserId();
		//searchParams = Util.changeEncoding(searchParams);
		if (searchParams.containsKey("LIKE_value")) {
			String value = (String) searchParams.get("LIKE_value");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("LIKE_value");
			}else{
				searchParams.put("LIKE_value", value.trim());
				model.addAttribute("LIKE_value", value.trim());
			}
		}
		if (searchParams.containsKey("EQ_categoryType.id")) {
			String cid = (String) searchParams.get("EQ_categoryType.id");
			System.out.println("cid" + cid);
			if (cid == null || "-1".equals(cid.trim())) {
				searchParams.remove("EQ_categoryType.id");
			} else {
				searchParams.put("EQ_categoryType.id", Integer.parseInt(cid));
			}
		}
		searchParams.put("EQ_state", 0);
		Page<CategoryValue> categoryvalues = categoryValueService
				.getCategoryValueList(searchParams, pageNumber, pageSize,
						sortType);

		model.addAttribute("categoryvalues", categoryvalues);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "category/categoryvalue";
	}

	/**
	 * 查询字典项集合
	 * 
	 * @date 2015-3-30 上午11:20:56
	 * @return
	 */
	@RequestMapping(value = "/getcategorytype")
	@ResponseBody
	public Map<String, Object> getcategorytype() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CategoryType> list = categoryTypeService.getList();
		if (list.size() > 0) {
			map.put("result", true);
			map.put("obj", list);
		} else {
			map.put("result", false);
			map.put("msg", "数据异常");
		}
		return map;
	}

	/**
	 * 新增字典项
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-30 下午12:49:17
	 * @param categoryType
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/categorytype/create", method = RequestMethod.POST)
	public String create(@Valid CategoryType categoryType,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		categoryType.setCreatetime(new Date());
		categoryType.setState(0);
		User user = (User) request.getSession().getAttribute("user");
		categoryType.setUser(user);
		categoryTypeService.SaveOrUpdate(categoryType);
		redirectAttributes.addFlashAttribute("message", "更新成功");
		return "redirect:/system/categorytype";

	}

	/**
	 * 删除字典项
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-30 下午1:13:58
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/categorytype/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deletecategorytype(
			@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = categoryTypeService.delete(ids);
		boolean result1 = categoryValueService.deleteCid(ids);
		if (result && result1) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	/**
	 * 判断字典项是否存在
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-30 下午2:47:29
	 * @param id
	 * @param value
	 * @return
	 */
	@RequestMapping(value = "/categorytype/checkcategorytype", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkcategorytype(
			@RequestParam(value = "id") Long id,
			@RequestParam(value = "value") String value) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CategoryType> categoryType = categoryTypeService
				.getCategoryTypeByValue(value);
		if (categoryType.size() == 0) {
			map.put("result", true);
		} else if (categoryType.get(0).getId().equals(id)) {
			map.put("result", true);
		} else {
			map.put("result", false);
			map.put("msg", "字典项已存在");
		}
		return map;
	}

	/**
	 * 判断字典值是否存在
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-30 下午2:50:09
	 * @param id
	 * @param value
	 * @return
	 */
	@RequestMapping(value = "/categoryvalue/checkcategoryvalue", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> CheckCategoryValue(
			@RequestParam(value = "id") Long id,
			@RequestParam(value = "value") String value,
			@RequestParam(value = "cid") Long cid) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CategoryValue> categoryValue = categoryValueService
				.getCategoryValueByValue(value, cid);
		if (categoryValue.size() == 0) {
			map.put("result", true);
		} else if (categoryValue.get(0).getId().equals(id)) {
			map.put("result", true);
		} else {
			map.put("result", false);
			map.put("msg", "字典项已存在");
		}
		return map;
	}

	/**
	 * 新增字典项的值
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-30 下午3:24:55
	 * @param categoryValue
	 * @param categoryType
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/categoryvalue/create", method = RequestMethod.POST)
	public String createCategory(HttpServletRequest request,
			@Valid CategoryValue categoryValue,
			@RequestParam(value = "pid") String pid,
			@Valid CategoryType categoryType,
			RedirectAttributes redirectAttributes) {
		if (pid != null && !"".equals(pid)) {
			CategoryValue categoryValue1 = categoryValueService
					.getCategoryValue(Long.parseLong(pid));
			categoryValue.setCategoryValue(categoryValue1);
		}
		categoryValue.setCreatetime(new Date());
		categoryValue.setState(0);
		User user = (User) request.getSession().getAttribute("user");
		categoryValue.setUser(user);
		categoryValueService.SaveOrUpdate(categoryValue);
		redirectAttributes.addFlashAttribute("message", "更新成功");
		return "redirect:/system/categoryvalue";
	}

	/**
	 * 删除字典值
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-1 上午9:51:54
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/categorytypevalue/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deletecategoryvalue(
			@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = categoryValueService.delete(ids);
		boolean result1 = categoryValueService.deleteByPid(ids);
		if (result && result1) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	/**
	 * 查看子字典
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-1 下午1:52:40
	 * @param pid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/categoryvalue/getList")
	@ResponseBody
	public Map<String, Object> getList(@RequestParam(value = "pid") String pid,
			ServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CategoryValue> list = categoryValueService
				.getCategoryValueListByPid(Long.parseLong(pid), 0);
		if (list.size() > 0) {
			map.put("result", true);
			map.put("obj", list);
		} else {
			map.put("result", false);
			map.put("msg", "无记录");
		}
		return map;
	}

	/**
	 * 根据字典项的名称获取字典值
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:11:51
	 * @param cid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getcategoryvalue")
	@ResponseBody
	public Map<String, Object> getcategoryvalue(
			@RequestParam(value = "value") String value, ServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		CategoryType categoryType=categoryTypeService.getCategoryTypeByValue(value).get(0);
		List<CategoryValue> list = categoryValueService.getCategoryValueListByCid(categoryType.getId(), 0);
		if (list.size() > 0) {
			map.put("result", true);
			map.put("obj", list);
		} else {
			map.put("result", false);
			map.put("msg", "无记录");
		}
		return map;
	}
}
