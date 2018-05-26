package com.yjy.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.yjy.entity.Community;
import com.yjy.entity.User;
import com.yjy.entity.Volunteer;
import com.yjy.service.CategoryTypeService;
import com.yjy.service.CategoryValueService;
import com.yjy.service.CommunityService;
import com.yjy.service.VolunteerService;

/**
 * 
 * @author liping
 *类VolunteerController.java的实现描述：操作我能行表
 */
@Controller
@RequestMapping(value="/volunteer")
public class VolunteerController {
	
	@Autowired
	private CategoryTypeService categoryTypeService;

	@Autowired
	private CategoryValueService categoryValueService;
	
	@Autowired
	private VolunteerService volunteerService;
	
	@Autowired
	private CommunityService communityService;
	
	private static  final String PAGE_SIZE="10";
	private static Map<String,String> sortTypes=Maps.newLinkedHashMap();
	static{
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	
	/**
	 *获取我能行列表
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param reques
	 * @return
	 */
	@RequestMapping()
	private String getVolunteerList(@RequestParam(value="page",defaultValue="1")int pageNumber,
 		   @RequestParam(value="page.size",defaultValue=PAGE_SIZE)int pageSize,
 		   @RequestParam(value="sortType",defaultValue="auto")String sortType,
 		   Model model,HttpServletRequest request){
		
		Map<String,Object> params=Servlets.getParametersStartingWith(request,"search_");
		
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(c!=null){
			Long comid=c.getId();
			params.put("EQ_communityid", comid);
			model.addAttribute("comm", c);
		}else{
			List<Community> commlist=communityService.getCommunityList();
			model.addAttribute("commlist", commlist);
			if (params.containsKey("EQ_community")) {//根据社区选择
	   			String EQ_community = (String) params.get("EQ_community");
	   			model.addAttribute("EQ_community", EQ_community);
	   			if (EQ_community == "-1" || "-1".equals(EQ_community.trim())) {
	   				params.remove("EQ_community");
	   			}
	   		   }
		}
		
		if(params.containsKey("LIKE_name")){//根据名字选择
 		   String realName=(String) params.get("LIKE_name");
 		   if(realName==null||"".equals(realName.trim())){
 			  params.remove("LIKE_name");
 		   }else{
 			  params.put("LIKE_name", realName.trim());
				   model.addAttribute("LIKE_name", realName.trim());
 		   }
 	   }
		  
		if (params.containsKey("EQ_paytype")) {//根据支付类型选择
   			String EQ_paytype = (String) params.get("EQ_paytype");
   			model.addAttribute("EQ_paytype", EQ_paytype);
   			if (EQ_paytype == "-1" || "-1".equals(EQ_paytype.trim())) {
   				params.remove("EQ_paytype");
   			}
   		   }
		if (params.containsKey("EQ_isshow")) {//根据上线下选择
   			String EQ_isshow = (String) params.get("EQ_isshow");
   			model.addAttribute("EQ_isshow", EQ_isshow);
   			if (EQ_isshow == "-1" || "-1".equals(EQ_isshow.trim())) {
   				params.remove("EQ_isshow");
   			}
   		   }
		CategoryType categoryTypeKeyword = null;
		List<CategoryValue> keywordlist = null;
		List<CategoryValue> keywordlist1 = new ArrayList<CategoryValue>();
		keywordlist1.clear();
		List<CategoryType> kwlist = categoryTypeService.getCategoryTypeByValue("才能类型");
		if(kwlist != null && kwlist.size() > 0) {
			categoryTypeKeyword = kwlist.get(0);
			keywordlist = categoryValueService.getCategoryValueListByCid(categoryTypeKeyword.getId(), 0);
			
			/*循环查询条件*/
			for(int i=0;i<keywordlist.size();i++){
				String id="LIKE_"+keywordlist.get(i).getId();
				if (params.containsKey(id)) {
		   			String LIKE_ability = (String) params.get(id);
		   			System.out.println(LIKE_ability+id);
		   			if (LIKE_ability == "" || "".equals(LIKE_ability)) {
		   				params.remove(id);
		   			}else{
		   				params.put(id,LIKE_ability.trim());
		   				model.addAttribute(id, LIKE_ability.trim());
		   				keywordlist1.add(keywordlist.get(i));
		   			}
		   		   }
			}
			
		}
		if(keywordlist1.size()!=0){
			model.addAttribute("list", keywordlist1);
		}
		model.addAttribute("keywordlist", keywordlist);
		Page<Object[]> volunteer=volunteerService.getVolunteerList(params, pageNumber, pageSize, sortType,keywordlist,c);
		model.addAttribute("volunteer", volunteer);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(params, "search_"));
		return "wnx/volunteerlist";
	}
	
	/**
	 * 删除
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Map<String,Object> deleteVolunteer(@RequestParam(value="ids")String ids){
		Map<String,Object> map=new HashMap<String,Object>();
		System.out.println(ids);
		boolean result=volunteerService.delete(ids);
		if(result){
			map.put("result", true);
			map.put("msg","删除成功");
		}else{
			map.put("result", false);
			map.put("msg","删除失败");
		}
		return map;
	}
	/**
	 * 详情中使用
	 * @param id
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="check")
	public String check(
			@RequestParam(value = "id") Long id,
			Model model,HttpServletRequest request,RedirectAttributes redirectAttributes){
		/*Volunteer volunteer=volunteerService.getVolunteerById(id);*/
		List<Object[]> list=volunteerService.getVolunteerDetail2(id);
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(list!=null&&list.size()!=0){
			Object[] volunteer=list.get(0);
			model.addAttribute("volunteer",volunteer);
			if(c==null){
				model.addAttribute("community",volunteer);
		    }else{
		    	model.addAttribute("community",null);
	    	}
		}
		return "wnx/volunteerform";
	}
	/**
	 * 拒绝，及拒绝理由的添加
	 * @param id
	 * @param failreason
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="refuse",method=RequestMethod.POST)
	public String refuse(
			@RequestParam(value = "id")Long id,@RequestParam(value = "failreason") String failreason,
			Model model,HttpServletRequest request,RedirectAttributes redirectAttributes){
		System.out.println(id+failreason);
		Volunteer volunteer=volunteerService.getVolunteerById(id);
		if(volunteer!=null){
			volunteer.setState(2);
			volunteer.setIsshow(null);
			volunteer.setFailreason(failreason);
			Volunteer v=volunteerService.save(volunteer);
			if(v!=null){
				redirectAttributes.addFlashAttribute("message",volunteer.getName()+"未通过审核！");
				model.addAttribute("v",v);
			}	
		}
		return "redirect:/volunteer";
	}
	
	@RequestMapping(value="via")
	public String via(
			@RequestParam(value = "id")Long id,Model model,HttpServletRequest request,RedirectAttributes redirectAttributes){
		Volunteer volunteer=volunteerService.getVolunteerById(id);
		if(volunteer!=null){
			volunteer.setState(1);
			volunteer.setIsshow(1);
			volunteer.setFailreason("");
			Volunteer v=volunteerService.save(volunteer);
			if(v!=null){
				redirectAttributes.addFlashAttribute("message",volunteer.getName()+"已通过审核！");
				model.addAttribute("v",v);
			}	
		}
		return "redirect:/volunteer";
	}
	
}
