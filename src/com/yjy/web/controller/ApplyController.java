package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Apply;
import com.yjy.service.ApplyService;
import com.yjy.utils.Util;

/**
 * 类ApplyController.java的实现描述：该类用来对Apply进行增删改查操作
 * 
 * @author wutao 2015年6月23日 下午1:36:24
 */
@Controller
@RequestMapping(value = "/system/apply")
public class ApplyController {
	@Autowired
	ApplyService applyService;

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		// sortTypes.put("state", "状态");
	}

	/**
	 * 获取所有的Apply记录，得到Apply的列表，提供前端展示。
	 * 
	 * @author wutao
	 * @date 2015年6月23日 下午1:37:32
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return 视图映射字符串，供视图解析器解析
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
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

		if (searchParams.containsKey("LIKE_name")) {
			String name = (String) searchParams.get("LIKE_name");
			String nameTrim = name.trim();
			if (name == null || "".equals(nameTrim) || "null".equals(nameTrim)) {
				searchParams.remove("LIKE_name");
			} else {
				model.addAttribute("name", name);
			}
		}

		if (searchParams.containsKey("LIKE_telephone")) {
			String telephone = (String) searchParams.get("LIKE_telephone");
			String telephoneTrim = telephone.trim();
			if (telephone == null || "".equals(telephoneTrim)
					|| "null".equals(telephoneTrim)
					|| telephoneTrim.equals("0")) {
				searchParams.remove("LIKE_telephone");
			} else {
				model.addAttribute("telephone", telephone);
			}
		}

		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime"))
					.trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_createtime");
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
				searchParams.put("GTE_createtime", calendar.getTime());
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime"))
					.trim();

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
				searchParams.put("LTE_createtime", calendar.getTime());
			}
		}
		if (searchParams.containsKey("EQ_state")) {
			String state = (String) searchParams.get("EQ_state");
			String stateTrim = state.trim();
			if (state == null || "".equals(stateTrim)
					|| stateTrim.equals("null") || stateTrim.equals("0")) {
				searchParams.remove("EQ_state");
			} else {
				model.addAttribute("state", state);
			}
		}
		Page<Apply> dvlist = applyService.getApply(searchParams, pageNumber,
				pageSize, sortType);
		model.addAttribute("dvs", dvlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "account/apply";
	}

	/**
	 * 保存从新增Apply页面传递过来的State更新之后的数据
	 * 
	 * @author wutao
	 * @date 2015年6月23日 下午1:39:29
	 * @param Apply
	 * @param State
	 * @return
	 */
	@RequestMapping(value = "updateState/{id}", method = RequestMethod.POST)
	public String update(@Valid Apply ap, RedirectAttributes redirectAttributes) {

		Apply apply = applyService.get(ap.getId());
		apply.setState(2);
		apply.setUpdatetime(new Date());
		applyService.update(apply);
		return "redirect:/system/apply/";
	}

	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id,
			RedirectAttributes redirectAttributes) {
		applyService.delete(id);
		// redirectAttributes.addFlashAttribute("message", "删除用户成功");
		return "redirect:/system/apply/";
	}

	// if (type.equals("yllb")) {
	// for (Long id : ids) {
	// int count = articleService.getCountByServerType(id);
	// if (count > 0) {
	// redirectAttributes.addFlashAttribute("message",
	// "绫诲埆宸茶寮曠敤鏃犳硶鍒犻櫎!");
	// return "redirect:/system/apply" + type;
	// }
	// }
	// }
	@RequestMapping(value = "delete1/{type}")
	public String delete(@PathVariable("type") String type,
			@RequestParam(value = "ids") List<Long> ids,
			RedirectAttributes redirectAttributes) {

		// redirectAttributes.addFlashAttribute("message", "删除用户成功");

		for (Long id : ids) {

			applyService.delete(id);
		}
		// redirectAttributes.addFlashAttribute("message", "鍒犻櫎鎴愬姛!");

		return "redirect:/system/apply/";
	}
}
