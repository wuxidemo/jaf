package com.yjy.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.WXCard;
import com.yjy.service.WXCardService;
import com.yjy.utils.Util;

@Controller
@RequestMapping(value = "/card")
public class CardController {
	@Autowired
	WXCardService wxcardService;

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		// sortTypes.put("state", "状态");
	}

	@RequestMapping()
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "createtime") String sortType, Model model,
			ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
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
		if (searchParams.containsKey("EQ_mytype")) {
			String state = (String) searchParams.get("EQ_mytype");
			String stateTrim = state.trim();
			if (state == null || "".equals(stateTrim) || stateTrim.equals("null") || stateTrim.equals("-1")) {
				searchParams.remove("EQ_mytype");
			} else {
				model.addAttribute("mytype", state);
			}
		}
		if (searchParams.containsKey("EQ_type")) {
			String state = (String) searchParams.get("EQ_type");
			String stateTrim = state.trim();
			if (state == null || "".equals(stateTrim) || stateTrim.equals("null") || stateTrim.equals("0")) {
				searchParams.remove("EQ_type");
			} else {
				model.addAttribute("type", state);
			}
		}
		Page<WXCard> dvlist = wxcardService.getWXCard(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("dvs", dvlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "wxcard/wxcardlist";
	}

	/**
	 * 
	 * 刷新优惠券
	 * 
	 * @author luyf
	 * @date 2015年7月17日 下午1:57:44
	 * @return
	 */
	@RequestMapping(value = "updatecards")
	public String updateCards() {
		wxcardService.refreshCard();
		return "redirect:/card";
	}

	/**
	 * 
	 * 更下优惠券类型
	 * 
	 * @author luyf
	 * @date 2015年7月17日 下午2:02:48
	 * @param state
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "setcard")
	public String setcard(@RequestParam(value = "state") Integer state, @RequestParam(value = "ids") List<Long> ids) {
		for (Long id : ids) {
			WXCard wc = wxcardService.get(id);
			wc.setMytype(state);
			wxcardService.save(wc);
		}
		return "redirect:/card";
	}

	@RequestMapping(value = "per")
	public String per(@RequestParam(value = "id") Long id, @RequestParam(value = "bankper") float bankper,
			@RequestParam(value = "shopper") float shopper, @RequestParam(value = "price") float price) {
		WXCard wc = wxcardService.get(id);
		if (wc.getType().equals("DISCOUNT")) {
			wc.setShopper((int) shopper);
			wc.setBankper((int) bankper);
		} else if (wc.getType().equals("CASH")) {
			wc.setShopper((int) (shopper * 100));
			wc.setBankper((int) (bankper * 100));
		} else {
			wc.setShopper((int) (shopper * 100));
			wc.setBankper((int) (bankper * 100));
			wc.setPrice((int) (price * 100));
		}
		wxcardService.save(wc);
		return "redirect:/card";
	}

	@RequestMapping(value = "setcount")
	public String setcount(@RequestParam(value = "id") Long id, @RequestParam(value = "count") int count) {
		WXCard wc = wxcardService.get(id);
		wc.setCount(count);
		wxcardService.save(wc);
		return "redirect:/card";
	}

	@RequestMapping(value = "setbank/{id}")
	public String setbank(@PathVariable(value = "id") Long id) {
		WXCard wc = wxcardService.get(id);
		wc.setIsbank(1);
		wxcardService.save(wc);
		return "redirect:/card";
	}

	@RequestMapping(value = "cancelbank/{id}")
	public String cancelbank(@PathVariable(value = "id") Long id) {
		WXCard wc = wxcardService.get(id);
		wc.setIsbank(0);
		wxcardService.save(wc);
		return "redirect:/card";
	}
}