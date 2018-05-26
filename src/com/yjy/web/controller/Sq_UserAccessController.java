package com.yjy.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Sq_UserAccessControl;
import com.yjy.service.Sq_UserAccessControlService;

@Controller
@RequestMapping(value="/accesscontrol")
public class Sq_UserAccessController {
	
	private static final String PAGE_SIZE="10";
	private static Map<String, Object> sortTypes=Maps.newLinkedHashMap();
	static{
		sortTypes.put("auto", "自动");
	}
	
	@Autowired
	Sq_UserAccessControlService controlService;
	
	@RequestMapping()
	public String list(HttpServletRequest request, Model model){
		
		return "useraccesscontrol/useraccrsslist";
				
	}
	/**
	 * 查询分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param request
	 * @return
	 */
	@RequestMapping(value="aclist")
	@ResponseBody
	public Page<Sq_UserAccessControl> getList(@RequestParam(value="page", defaultValue="1")int pageNumber,
			@RequestParam(value="size", defaultValue=PAGE_SIZE)int pageSize,
			@RequestParam(value="sortType", defaultValue="auto")String sortType,
			HttpServletRequest request){
		
		Map<String, Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
		
		if(searchParams.containsKey("LIKE_name")){
			
		}
		Page<Sq_UserAccessControl> accessControl=controlService.getList(searchParams, pageNumber, pageSize, sortType);
		return accessControl;
	}
	/**
	 * 保存
	 * @param accessControl
	 * @return
	 */
	@RequestMapping(value="create")
	public String save(@ModelAttribute Sq_UserAccessControl accessControl){
		
		controlService.save(accessControl);
		
		return "redirect:/accesscontrol";
	}
	/**
	 * 删除
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value="ids")String ids){
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		boolean su=controlService.delete(ids);
		if(su){
			map.put("result", true);
			map.put("msg", "删除成功");
		}else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}
	
}
