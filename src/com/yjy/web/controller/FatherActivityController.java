package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Activity;
import com.yjy.entity.FatherActivity;
import com.yjy.entity.FatherChildActivity;
import com.yjy.service.ActivityService;
import com.yjy.service.FatherActivityService;
import com.yjy.service.FatherChildActivityService;

@Controller
@RequestMapping(value = "/fatheractivity")
public class FatherActivityController {
	
	@Autowired
	private ActivityService activityService;
	
	@Autowired
	private FatherActivityService fatherActivityService;
	
	@Autowired
	private FatherChildActivityService fatherChildActivityService;
	
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	private String getFatherActivitys(
			@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType,
			Model model, ServletRequest request) {
		
		Map<String, Object> searchParams = new HashMap<String, Object>();
		Page<Object[]> fatheractivitys = fatherActivityService.getFatherActivitys(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("fatheractivitys", fatheractivitys);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		return "activity/fatheractivityList";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String createForm(Model model) {
		
		model.addAttribute("action", "create");
		
		return "activity/fatheractivityForm";
	}
	
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String urlCreate(@RequestParam(value="name") String name, 
			@RequestParam(value="actids",required=false) String actids, 
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		FatherActivity fa = new FatherActivity();
		fa.setName(name);
		fa.setCreatetime(new Date());
		fa.setUpdatetime(new Date());
		fa = fatherActivityService.save(fa);
		
		if(actids != null) {
			String[] actidArr = actids.split(",");
			for(String actid : actidArr) {
				FatherChildActivity fca = new FatherChildActivity();
				fca.setChildid(Long.valueOf(actid));
				fca.setFatherid(fa.getId());
				fatherChildActivityService.save(fca);
			}
		}else{
			FatherChildActivity fca = new FatherChildActivity();
			fca.setChildid(null);
			fca.setFatherid(fa.getId());
			fatherChildActivityService.save(fca);
		}
		
		
		
		redirectAttributes.addFlashAttribute("message", "创建父活动成功");
		
		return "redirect:/fatheractivity/";
	}
	
	@RequestMapping(value="update/{id}", method=RequestMethod.GET)
	public String updateForm(@PathVariable(value="id") Long id, Model model) {
		
		FatherActivity fa = fatherActivityService.get(id);
		
		model.addAttribute("fa", fa);
		model.addAttribute("action", "update");
		
		return "activity/fatheractivityForm";
		
	}
	
	@RequestMapping(value="getyesacts", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getYesAct(@RequestParam(value="faid") Long id) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<FatherChildActivity> fcalist = fatherChildActivityService.findByFatherid(id);
		
		if(fcalist != null && fcalist.size() > 0) {
			List<Activity> arrlist = new ArrayList<Activity>();
			List<Activity> alllist = new ArrayList<Activity>();
			List<Long> yesids = new ArrayList<Long>();
			List<Long> allids = new ArrayList<Long>();
			
			for(FatherChildActivity fca : fcalist) {
				if(fca.getChildid() != null) {
					Activity ac = activityService.get(Long.valueOf(fca.getChildid()));
					if(ac != null) {
						yesids.add(ac.getId());
						arrlist.add(ac);
					}
				}
			}
			
			map.put("result", "1");
			map.put("yesdata", arrlist);
			
			List<Activity> actlist = activityService.getAllActivity();
			if(actlist != null && actlist.size() > 0) {
				for(Activity act : actlist) {
					allids.add(act.getId());
				}
			}
			
			allids.removeAll(yesids);
			
			for(Long allid : allids) {
				alllist.add(activityService.get(allid));
			}
			
			map.put("nodata", alllist);
			
		}else{
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		
		return map;
		
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String urlCreate(
			@RequestParam(value="id") Long id, 
			@RequestParam(value="name") String name, 
			@RequestParam(value="actids", required=false) String actids, 
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		List<FatherChildActivity> fcalist = fatherChildActivityService.findByFatherid(id);
		for(FatherChildActivity fca : fcalist) {
			fatherChildActivityService.delete(Long.valueOf(fca.getId()));
		}
		
		FatherActivity fa = fatherActivityService.get(id);
		fa.setName(name);
		fa.setUpdatetime(new Date());
		fa = fatherActivityService.save(fa);
		
		if(actids != null) {
			String[] actidArr = actids.split(",");
			for(String actid : actidArr) {
				FatherChildActivity fca = new FatherChildActivity();
				fca.setChildid(Long.valueOf(actid));
				fca.setFatherid(fa.getId());
				fatherChildActivityService.save(fca);
			}
		}else{
			FatherChildActivity fca = new FatherChildActivity();
			fca.setChildid(null);
			fca.setFatherid(fa.getId());
			fatherChildActivityService.save(fca);
		}
		
		
		
		redirectAttributes.addFlashAttribute("message", "修改父活动成功");
		
		return "redirect:/fatheractivity/";
	}
	
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String delete(@RequestParam(value="delstr") String delstr,
			RedirectAttributes redirectAttributes) {
		
		String[] strarr = delstr.split(",");
		
		for(String str : strarr) {
			List<FatherChildActivity> fcalist = fatherChildActivityService.findByFatherid(Long.valueOf(str));
			if(fcalist != null && fcalist.size() > 0) {
				for(FatherChildActivity fca : fcalist) {
					fatherChildActivityService.delete(fca.getId());
				}
			}
			fatherActivityService.delete(Long.valueOf(str));
		}
		
		
		redirectAttributes.addFlashAttribute("message", "删除父活动成功");
		
		return "redirect:/fatheractivity/";
		
	}
	
}
