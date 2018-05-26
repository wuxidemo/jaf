package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import com.yjy.entity.Rebate;
import com.yjy.entity.RebateForFirst;
import com.yjy.entity.User;
import com.yjy.service.BusinessService;
import com.yjy.service.RebateForFirstService;
import com.yjy.service.RebateService;
import com.yjy.utils.Util;

/**
 * 返利红包
 * 
 * @author lyf
 *
 */
@Controller
@RequestMapping(value = "/rebate")
public class RebateController {

	@Autowired
	private RebateService rebateService;
	@Autowired
	private RebateForFirstService rebateForFirstService;

	@RequestMapping(value = "list")
	public String tolist(Model model,
			@RequestParam(value = "url", required = false) String url) {
		model.addAttribute("rcount", rebateService.getAllcount());
		model.addAttribute("rf", rebateForFirstService.getFirstRebate());
		model.addAttribute("url", url);
		return "rebate/list";
	}

	@RequestMapping(value = "create")
	public String create1(Model model) {
		return "rebate/addrebate";
	}

	@RequestMapping(value = "data")
	@ResponseBody
	public List<Rebate> getList(
			@RequestParam(value = "pageIndex") int pageIndex,
			@RequestParam(value = "pageSize") int pageSize) {
		return rebateService.getListPage(pageIndex, pageSize);
	}

	@RequestMapping(value = "updatestate")
	public String updatestate(@RequestParam(value = "id") Long id,
			@RequestParam(value = "state") int state) {
		rebateService.updatestate(id, state);
		rebateService.updateUnuse();
		return "redirect:/rebate/list";
	}

	@RequestMapping(value = "updatefstate")
	public String updatefstate(@RequestParam(value = "id") Long id,
			@RequestParam(value = "state") int state) {
		rebateService.updatefstate(id, state);
		return "redirect:/rebate/list?url=f";
	}

	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String save(@Valid Rebate rebate,
			@RequestParam(value = "mystarttime") String stime,
			@RequestParam(value = "myendtime") String etime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			rebate.setStarttime(sdf.parse(stime));
			rebate.setEndtime(sdf.parse(etime));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (rebate.getMustbank() == 1) {
			rebate.setMustbank(0);
		} else {
			rebate.setMustbank(1);
		}
		rebate.setWishstring("支付红包大吉大利");
		rebate.setNickname("金阿福e服务");
		rebate.setSendname("金阿福e服务");
		rebate.setActname(rebate.getName());
		rebate.setRemark("点击关注,获取更多优惠。");
		rebate.setState(0);
		rebate.setMaxprice(rebate.getMaxprice() == null ? 0 : rebate
				.getMaxprice() * 100);
		rebateService.save(rebate);
		rebateService.updateUnuse();
		return "redirect:/rebate/list";
	}

	@RequestMapping(value = "savef", method = RequestMethod.POST)
	public String savef(@Valid RebateForFirst rff) {
		if (rff.getMustbank() == 1) {
			rff.setMustbank(0);
		} else {
			rff.setMustbank(1);
		}
		rff.setPrice(rff.getPrice() * 100);
		rff.setWishstring("首次红包大吉大利");
		rff.setNickname("金阿福e服务");
		rff.setSendname("金阿福e服务");
		rff.setActname("首次支付返利");
		rff.setRemark("点击关注,获取更多优惠。");
		rff.setState(0);
		rebateForFirstService.save(rff);
		return "redirect:/rebate/list?url=f";
	}

	@RequestMapping(value = "updatef", method = RequestMethod.POST)
	public String updatef(@Valid RebateForFirst rff) {
		if (rff.getMustbank() == 1) {
			rff.setMustbank(0);
		} else {
			rff.setMustbank(1);
		}
		rff.setPrice(rff.getPrice() * 100);
		rebateForFirstService.save(rff);
		return "redirect:/rebate/list?url=f";
	}

	@RequestMapping(value = "createf")
	public String createf(Model model) {
		return "rebate/addfrebate";
	}

	@RequestMapping(value = "updatefform")
	public String updatefform(@RequestParam(value = "id") Long id, Model model) {
		model.addAttribute("rff", rebateForFirstService.get(id));
		model.addAttribute("action", "update");
		return "rebate/addfrebate";
	}

	@RequestMapping(value = "checktime")
	@ResponseBody
	public String checktime(@RequestParam(value = "stime") String stime,
			@RequestParam(value = "etime") String etime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int count = 0;
		try {
			count = rebateService.getTimeCount(sdf.parse(stime),
					sdf.parse(etime));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (count > 0) {
			return "0";
		} else {
			return "1";
		}
	}

}
