package com.yjy.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Sq_AreaManage;
import com.yjy.service.Sq_AreaManageService;

@Controller
@RequestMapping(value = "/areamanage")
public class Sq_AreaManageController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
	}
	
	@Autowired 
	Sq_AreaManageService areaManageService;
	
	@RequestMapping()
	public String list(Model model, HttpServletRequest request){
		
		return "finance/wanggelist";
	}
	/**
	 * 获取Sq_areaManage列表
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param request
	 * @return
	 */
	@RequestMapping(value="salist")
	@ResponseBody
	public Page<Sq_AreaManage> areaManageList(@RequestParam(value = "page", defaultValue = "1")int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE)int pageSize,
			@RequestParam(value = "sortType", defaultValue="auto")String sortType,
			HttpServletRequest request){
		
		Map<String, Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
		
		if(searchParams.containsKey("LIKE_name")){
			String realName=(String)searchParams.get("LIKE_name");
			if(realName == null ||"".equals(realName.trim())){
				searchParams.remove("LIKE_name");
			}
		}
		Page<Sq_AreaManage> areaManage=areaManageService.getAreaManageList(searchParams, pageNumber, pageSize, sortType);
		return areaManage;
		
	}
	/**
	 * 根据id查找对应的网格数据
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "showdetail/{aid}")
	@ResponseBody
	public Map<String, Object> detail(@PathVariable(value="aid")Long id){
		Map<String, Object> map=new HashMap<String, Object>();
		
		Sq_AreaManage sa=areaManageService.get(id);
		if(sa != null){
			map.put("result", "1");
			map.put("data", sa);
			map.put("action", "view");
		}else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;   
	}
	/**
	 * 跳转到修改页面
	 * @param id
	 * @return
	 */
/*	@RequestMapping(value = "tosave/{id}")
	public String tosave(@PathVariable(value="id")Long id,Model model){
		
		Sq_AreaManage sa=areaManageService.get(id);
		if(sa != null){
			model.addAttribute("areamanage", sa);
			model.addAttribute("action","save");
		}else {
			model.addAttribute("msg", "暂无数据");
		}
		return "finance/wanggeForm"; 
	}*/
	/**
	 * 修改保存
	 * @param id
	 * @param name
	 * @param telephone
	 * @param area
	 * @param logourl
	 * @return
	 */
	@RequestMapping(value="update/{id}")
	public String modify(@PathVariable(value="id")Long id,Sq_AreaManage areaManage){
		
		Sq_AreaManage sa=areaManageService.get(areaManage.getId());

		sa.setName(areaManage.getName());
		sa.setTelephone(areaManage.getTelephone());
		sa.setArea(areaManage.getArea());
		sa.setLogourl(areaManage.getLogourl());
		areaManageService.save(sa);
		
		return "redirect:/areamanage/";
	}
	
	@RequestMapping(value="save")
	public String save(@ModelAttribute Sq_AreaManage areaManage){

		areaManageService.save(areaManage);
		
		return "redirect:/areamanage/";
	}
	
	
	/**
	 * 删除操作（单个和批量）
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String, Object> deleteone(@RequestParam(value = "ids")String ids){
		Map<String, Object> map=new HashMap<String, Object>();
		
		boolean result = areaManageService.delete(ids);
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}
}
