package com.yjy.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.yjy.entity.Community;
import com.yjy.entity.Sq_Donation_Good;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.Sq_Donation_GoodService;

@Controller
@RequestMapping("sq_donation_good")
public class Sq_Donation_GoodController {
	@Autowired
	private Sq_Donation_GoodService sq_Donation_GoodService;
	
	@Autowired
	private CommunityService communityService;
	
	private static final String PAGE_SIZE="10";
	private static Map<String,String> sortTypes=Maps.newLinkedHashMap();
	static{
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	@RequestMapping()
	private String getgoods(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			HttpServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(c!=null){
			Long comid=c.getId();
			searchParams.put("EQ_community.id", comid);
			model.addAttribute("comm", c);
		}else{
			List<Community> commlist=communityService.getCommunityList();
			model.addAttribute("commlist", commlist);
			if (searchParams.containsKey("EQ_community.id")) {//根据社区选择
	   			String EQ_community= (String) searchParams.get("EQ_community.id");
	   			model.addAttribute("EQ_community", EQ_community);
	   			if (EQ_community == "-1" || "-1".equals(EQ_community.trim())) {
	   				searchParams.remove("EQ_community.id");
	   			}
	   		   }
		}
		
		if (searchParams.containsKey("LIKE_name")) {//商品名称搜索
			String value = (String) searchParams.get("LIKE_name");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", value.trim());
				model.addAttribute("LIKE_name", value);
			}
		}
		if (searchParams.containsKey("EQ_state")) {//根据上架下选择
   			String EQ_state = (String) searchParams.get("EQ_state");
   			model.addAttribute("EQ_state", EQ_state);
   			if (EQ_state == "-1" || "-1".equals(EQ_state.trim())) {
   				searchParams.remove("EQ_state");
   			}
   		   }
		Page<Object[]> sq_Donation_Goods=sq_Donation_GoodService.getSq_Donation_Goods(searchParams, pageNumber, pageSize, sortType, c);
		model.addAttribute("donationgoods", sq_Donation_Goods);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "donation/sq_donation_goodList";
	}
	
	/**
	 * 更新跳转页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String update(@RequestParam(value = "id") Long id, Model model,HttpServletRequest request){
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(c!=null){
			model.addAttribute("comm", c);
		}
		List<Object[]> s=sq_Donation_GoodService.getSq_Donation_GoodById1(id);
			if(s.size()!=0){
				model.addAttribute("sqdonationgood", s.get(0));
				model.addAttribute("action", "update");
			}
		return "donation/sq_donation_goodForm";
	}
	/**
	 * 查看跳转页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") Long id, Model model,HttpServletRequest request){
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(c!=null){
			model.addAttribute("comm", c);
		}
		List<Object[]> s=sq_Donation_GoodService.getSq_Donation_GoodById1(id);
		if(s.size()!=0){
			model.addAttribute("sqdonationgood", s.get(0));
			model.addAttribute("action", "view");
		}
			model.addAttribute("view", "view");
		return "donation/sq_donation_goodForm";
	}
	/**
	 * 添加跳转页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String create(Model model){
			model.addAttribute("action", "create");
		return "donation/sq_donation_goodForm";
	}
	
	/**
	 * 编号不能重复
	 * @param id
	 * @param num
	 * @param request
	 * @return
	 */
	@RequestMapping(value="check")
	@ResponseBody
	public Map<String,Object> check(@RequestParam(value = "id", required = false) Long id, @RequestParam(value = "num") String num,HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_Donation_Good s=sq_Donation_GoodService.getSqDonatioGoodnByNum(num);
		if(id!=null){//更新
			if(s!=null&&s.getId()!=id){
				map.put("result", false);
				map.put("msg", "该编号物品已经存在,请重新填写编号！");
			}else{
				map.put("result", true);
			}
		}else if(id==null){//添加
			if(s!=null){
				map.put("result", false);
				map.put("msg", "该编号的物品已经存在,请重新填写编号！");
			}else{
				map.put("result", true);
			}
		}
		return map;
	}
	
	/**
     * 更新或添加方法
     * @param sqgiftrecord
     * @param request
     * @return
     */
	@RequestMapping(value = "createupdate", method = RequestMethod.POST)
	public String updateOrCreate(@Valid Sq_Donation_Good sdg,
			@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "state", required = false) Integer state,
             HttpServletRequest request,RedirectAttributes redirectAttributes) {
		
		 User u = (User) request.getSession().getAttribute("user"); 
		
		if (id != null) {// 更新数据
			Sq_Donation_Good s = sq_Donation_GoodService.getSq_Donation_GoodById(id);
			s.setNum(sdg.getNum());
			s.setName(sdg.getName());
			if(s.getPrice()!=sdg.getPrice()){
            s.setPrice(sdg.getPrice());
			}
            s.setFormat(sdg.getFormat());
            if(state!=null){
            	s.setState(state);//有问题
            }
            s.setUrl(sdg.getUrl());
			Sq_Donation_Good s1 = sq_Donation_GoodService.save(s);
			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "编辑成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "编辑失败!");
			}
		} else {// 新增数据
			sdg.setPrice(sdg.getPrice());
			sdg.setCreatetime(new Date());
			 if(u!=null){ 
				 Community comm=u.getCommunity();
				 sdg.setCommunity(comm);
			 }
			 if(state!=null){
				 sdg.setState(state);//有问题
	            }else{
	            sdg.setState(0);//默认下架
	            }
			Sq_Donation_Good s1 = sq_Donation_GoodService.save(sdg);
			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "添加成功!");
			} else{
				redirectAttributes.addFlashAttribute("message", "添加失败!");
			}
		}
		return "redirect:/sq_donation_good";
	}
	
	/**
	 * 删除
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Map<String,Object> delete(@RequestParam(value="ids")String ids){
		Map<String,Object> map=new HashMap<String,Object>();
		boolean result=sq_Donation_GoodService.delete(ids);
		if(result){
			map.put("result", true);
			map.put("msg","删除成功!");
		}else{
			map.put("result", false);
			map.put("msg","删除失败!");
		}
		return map;
	}
	/**
	 * 上下架
	 * @param id
	 * @param state
	 * @param model
	 * @return
	 */
	@RequestMapping(value="state")
	public String state(@RequestParam(value = "id") Long id, @RequestParam(value = "state") Long state,Model model,RedirectAttributes redirectAttributes){
			Sq_Donation_Good s=sq_Donation_GoodService.getSq_Donation_GoodById(id);
			System.out.println(id+state);
			if(state==0){
				s.setState(1);//上架
			}else if(state==1){
				s.setState(0);//下架
			}
			Sq_Donation_Good s1=sq_Donation_GoodService.save(s);
			if(s1!=null&&state==0){
				redirectAttributes.addFlashAttribute("message", "上架成功!");
			}else if(s1!=null&&state==1){
				redirectAttributes.addFlashAttribute("message", "下架成功!");
			}
		return "redirect:/sq_donation_good";
	}
}
