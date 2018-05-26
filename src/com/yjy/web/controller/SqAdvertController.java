package com.yjy.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.yjy.entity.Community;
import com.yjy.entity.Sq_Advert;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.SqAdvertService;

@Controller
@RequestMapping(value = "/sqadvert")
public class SqAdvertController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	private SqAdvertService sqAdvertService;
	
	@Autowired
	private CommunityService communityService;

	@RequestMapping()
	private String getSqAdverts(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber, @RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize, @RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model, HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		
		if (searchParams.containsKey("EQ_community.id")) {
			String commid = (String) searchParams.get("EQ_community.id");
			if (commid == null || "-1".equals(commid.trim())) {
				searchParams.remove("EQ_community.id");
			} else {
				searchParams.put("EQ_community.id", commid.trim());
				model.addAttribute("EQ_community_id", commid.trim());
			}
		}
		
		User user = (User) request.getSession().getAttribute("user");
		Community comm = user.getCommunity();
		if(comm == null) {
			model.addAttribute("commuser", "0");
		}else{
			searchParams.put("EQ_community.id", comm.getId());
			model.addAttribute("commuser", "1");
		}
		
		List<Community> commlist = communityService.getCommunityList();
		model.addAttribute("communitys", commlist);
		
		Page<Sq_Advert> adverts = sqAdvertService.getSqAdverts(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("sqadverts", adverts);
		return "donation/sqadvert";
	}
	
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String createForm(HttpServletRequest request, Model model) {
		
		User user = (User)request.getSession().getAttribute("user");
		
		Community community = user.getCommunity();
		if(community == null) {
			return "community/noAccess";
		}
		
		return "donation/addsqadvert";
	}
	
	@RequestMapping(value="create", method = RequestMethod.POST)
	public String create(@Valid Sq_Advert sqadvert, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		
		User user = (User)request.getSession().getAttribute("user");
		
		Community community = user.getCommunity();
		if(community == null) {
			return "community/noAccess";
		}
		
		sqadvert.setCommunity(community);
		Integer type = sqadvert.getType();
		if(type == 1) {
			sqadvert.setUrl(null);
		}else{
			sqadvert.setContext(null);
		}
		
		sqAdvertService.save(sqadvert);
		
		redirectAttributes.addFlashAttribute("message", "新增广告轮播图成功");
		return "redirect:/sqadvert/";
	}
	
	@RequestMapping(value="update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable(value="id") Long id,Model model) {
		
		Sq_Advert sqadvert = sqAdvertService.get(id);
		model.addAttribute("sqadvert", sqadvert);
		Integer type = sqadvert.getType();
		if(type == 1) {
			return "donation/updatetuwen";
		}else{
			return "donation/updateurl";
		}
		
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String update(@Valid Sq_Advert sqadvert, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		
		Sq_Advert sq = sqAdvertService.get(sqadvert.getId());
		
		sq.setPicurl(sqadvert.getPicurl());
		sq.setTitle(sqadvert.getTitle());
		
		Integer type = sq.getType();
		if(type == 1) {
			sq.setUrl(null);
			sq.setContext(sqadvert.getContext());
		}else{
			sq.setContext(null);
			sq.setUrl(sqadvert.getUrl());
		}
		
		sqAdvertService.save(sq);
		
		redirectAttributes.addFlashAttribute("message", "修改广告轮播图成功");
		return "redirect:/sqadvert/";
	}
	
	@RequestMapping(value="view/{id}", method = RequestMethod.GET)
	public String viewForm(@PathVariable(value="id") Long id,Model model,HttpServletRequest request) {
		
		User user = (User) request.getSession().getAttribute("user");
		Community comm = user.getCommunity();
		if(comm == null) {
			model.addAttribute("commuser", "0");
		}else{
			model.addAttribute("commuser", "1");
		}
		
		Sq_Advert sqadvert = sqAdvertService.get(id);
		model.addAttribute("sqadvert", sqadvert);
		Integer type = sqadvert.getType();
		if(type == 1) {
			return "donation/viewtuwen";
		}else{
			return "donation/viewurl";
		}
		
	}
	
	@RequestMapping(value="delete", method = RequestMethod.POST)
	public String delete(@RequestParam(value="delids") String ids,RedirectAttributes redirectAttributes) {
		
		try {
			String[] idarr = ids.split("\\|");
			for(String id : idarr) {
				sqAdvertService.delete(Long.valueOf(id));
			}
			
			redirectAttributes.addFlashAttribute("message", "删除广告轮播图成功");
			
		} catch (Exception e) {
			
			redirectAttributes.addFlashAttribute("message", "删除广告轮播图失败");
		}
		
		return "redirect:/sqadvert/";
		
	}

}
