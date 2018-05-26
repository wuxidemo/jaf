package com.yjy.Temporary;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Temporary.entity.SumData;
import com.yjy.Temporary.service.AfuAxiService;
import com.yjy.Temporary.service.SumDataService;
import com.yjy.service.WXUserService;

@Controller
@RequestMapping(value="/sumdata")
public class SumDataController {
	
	@Autowired
	private SumDataService sumDataService;
	@Autowired
	private WXUserService wXUserService;
	@Autowired
	private AfuAxiService afuAxiService;
	
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping
	public String getServey(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10", required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {
		
		/*Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		Page<SumData> sumdatas = sumDataService.getSumData(searchParams, pageNumber, pageSize, sortType);*/
		
		
		int adcount = wXUserService.getAdCount();
		
		int afaxcount = afuAxiService.getTotal();
		
		int jdcount = wXUserService.getJDCount();
		
		int thcount = wXUserService.getTHCount();
		
		model.addAttribute("adcount", new Integer(adcount));
		model.addAttribute("afaxcount",  new Integer(afaxcount));
		model.addAttribute("jdcount",  new Integer(jdcount));
		model.addAttribute("thcount",  new Integer(thcount));
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "sumdata/sumdata";
	}
}
