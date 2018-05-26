package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.yjy.entity.Sq_PensionAct;
import com.yjy.entity.Sq_PensionApply;
import com.yjy.service.Sq_PensionActService;
import com.yjy.service.Sq_PensionApplyService;

/**
 * 类Sq_PensionActController.java的实现描述：活动报名
 * 
 * @author liping
 *
 */
@Controller
@RequestMapping(value = "/sqpensionact")
public class Sq_PensionActController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	private Sq_PensionActService sq_PensionActService;
	
	@Autowired
	private Sq_PensionApplyService sq_PensionApplyService;

	@RequestMapping()
	@ResponseBody
	private Page<Object[]> Sq_PensionActList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "createtime") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (searchParams.containsKey("LIKE_name")) {
			String value = (String) searchParams.get("LIKE_name");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", value.trim());
				model.addAttribute("LIKE_name", value);
			}
		}
		if (searchParams.containsKey("EQ_starttime")) {
			String value = (String) searchParams.get("EQ_starttime");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("EQ_starttime");
			} else {
				searchParams.put("EQ_starttime", value.trim());
				model.addAttribute("EQ_starttime", value);
			}
		}

		if (searchParams.containsKey("EQ_endtime")) {
			String value = (String) searchParams.get("EQ_endtime");
			String valuesdf = "";
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("EQ_endtime");
			} else {
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
					Date enddate = sdf.parse(value);
					Calendar cal = Calendar.getInstance();
					cal.setTime(enddate);
					cal.add(Calendar.HOUR, +24);
					valuesdf = sdf.format(cal.getTime());
				} catch (ParseException e) {
					e.printStackTrace();
				}
				searchParams.put("EQ_endtime", valuesdf.trim());
				model.addAttribute("EQ_endtime", value);
			}
		}
		Page<Object[]> sqpensionactlist = sq_PensionActService.getSqPensionActDateByParams(searchParams, pageNumber,
				pageSize, sortType);
		return sqpensionactlist;
	}

	/**
	 * 后台跳转到活动报名
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sqpenact")
	public String saveparam(Model model, HttpServletRequest request) {
		return "pension/sqpensionact";
	}

	/**
	 * 根据ids删除对象
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCommunity(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result=true;
		String[] id = ids.split("\\|");
		for (String i : id) {
			List<Sq_PensionApply> list=sq_PensionApplyService.getPenActListBySqactid(Long.parseLong(i));
			if(list.size()==0){
				sq_PensionActService.delete(Long.parseLong(i));
			}else{
				result=false;
			}
		}
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "已有参加活动者,暂不删除");
		}
		return map;
	}

	/**
	 * 根据id查询活动
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/checkbyid", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkbyid(@RequestParam(value = "id") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_PensionAct s = sq_PensionActService.getSq_PensionActById(id);
		Date starttime = s.getStarttime();
		Date endtime = s.getEndtime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startstr = sdf.format(starttime);
		String endstr = sdf.format(endtime);
		String[] startstrarr = startstr.split(" ");
		String[] endstrarr = endstr.split(" ");
		String startdate = startstrarr[0];
		String stime = startstrarr[1].substring(0, 5);
		String enddate = endstrarr[0];
		String etime = endstrarr[1].substring(0, 5);
		map.put("result", true);
		map.put("startdate", startdate);
		map.put("stime", stime);
		map.put("enddate", enddate);
		map.put("etime", etime);
		map.put("data", s);
		return map;
	}

	@RequestMapping(value = "saveorupdate", method = RequestMethod.POST)
	@ResponseBody
	public String quickBuy(@Valid Sq_PensionAct sqpensionact, @RequestParam(value = "id") Long id,
			@RequestParam(value = "startdate") String startdate, @RequestParam(value = "stime") String stime,
			@RequestParam(value = "enddate") String enddate, @RequestParam(value = "etime") String etime, Model model,
			RedirectAttributes redirectAttributes) {
		Date starttime = new Date();
		Date endtime = new Date();
		Date date=new Date();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			starttime = sdf.parse(startdate + " " + stime + ":00");
			endtime = sdf.parse(enddate + " " + etime + ":00");
			if (id == null) {// 保存
				sqpensionact.setStarttime(starttime);
				sqpensionact.setEndtime(endtime);
				sqpensionact.setNownum(Long.parseLong(0 + ""));
				sqpensionact.setCreatetime(new Date());
				if(date.getTime()>endtime.getTime()){
					sqpensionact.setState(2);// 已结束
				}else{
					sqpensionact.setState(0);// 默认新保存的为下线
				}
				sqpensionact.setCount(0L);// 默认新保存查看数量为零
				Sq_PensionAct s = sq_PensionActService.save(sqpensionact);
				if (s != null) {
					redirectAttributes.addFlashAttribute("message", "保存成功!");
				} else {
					redirectAttributes.addFlashAttribute("message", "保存失败!");
				}
			} else {// 更新
				Sq_PensionAct s1 = sq_PensionActService.getSq_PensionActById(id);
				s1.setName(sqpensionact.getName());
				s1.setStarttime(starttime);
				s1.setEndtime(endtime);
				s1.setMax(sqpensionact.getMax());
				s1.setContent(sqpensionact.getContent());
				s1.setPicurl(sqpensionact.getPicurl());
				if(date.getTime()>endtime.getTime()){
					s1.setState(2);// 已结束
				}
				Sq_PensionAct s = sq_PensionActService.save(s1);
				if (s != null) {
					redirectAttributes.addFlashAttribute("message", "编辑成功!");
				} else {
					redirectAttributes.addFlashAttribute("message", "编辑失败!");
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "1";
	}

	/**
	 * 上下线
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "isshow", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> isshow(@RequestParam(value = "id") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_PensionAct s = sq_PensionActService.getSq_PensionActById(id);
		Integer state = s.getState();
		Date starttime=s.getStarttime();
		Date date = new Date();
		if ((state == 0 || state == null)&&(date.getTime()>starttime.getTime())) {
			s.setState(1);
			sq_PensionActService.save(s);
			map.put("isshow", 1);
		} else if((state == 0 || state == null)&&(date.getTime()<starttime.getTime())){
			s.setState(3);
			sq_PensionActService.save(s);
			map.put("isshow", 3);
		}else {
			s.setState(0);
			sq_PensionActService.save(s);
			map.put("isshow", 0);
		}
		return map;
	}
}
