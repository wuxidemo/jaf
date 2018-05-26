package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.yjy.entity.Community;
import com.yjy.entity.SqGiftRecord;
import com.yjy.entity.Sq_Gift_Item;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.SqGiftRecordService;
import com.yjy.service.Sq_Gift_ItemService;

@Controller
@RequestMapping(value = "sqgiftrecord")
public class SqGiftRecordController {

	@Autowired
	private SqGiftRecordService sqGiftRecordService;

	@Autowired
	private Sq_Gift_ItemService sq_Gift_ItemService;

	@Autowired
	private CommunityService communityService;
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping()
	private String getIndex(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			HttpServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		User u = (User) request.getSession().getAttribute("user");// 根据用户进行社区选择
		Community c = u.getCommunity();
		if (c != null) {
			Long comid = c.getId();
			searchParams.put("EQ_communityid", comid);
			model.addAttribute("comm", c);
		} else {
			List<Community> commlist = communityService.getCommunityList();
			model.addAttribute("commlist", commlist);
			if (searchParams.containsKey("EQ_community")) {// 根据社区选择
				String EQ_community = (String) searchParams.get("EQ_community");
				model.addAttribute("EQ_community", EQ_community);
				if (EQ_community == "-1" || "-1".equals(EQ_community.trim())) {
					searchParams.remove("EQ_community");
				}
			}
		}

		if (searchParams.containsKey("LIKE_name")) {
			String value = (String) searchParams.get("LIKE_name");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", value.trim());
				model.addAttribute("LIKE_name", value);
			}
		}

		if (searchParams.containsKey("LIKE_doname")) {
			String value = (String) searchParams.get("LIKE_doname");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("LIKE_doname");
			} else {
				searchParams.put("LIKE_doname", value.trim());
				model.addAttribute("LIKE_doname", value);
			}
		}

		if (searchParams.containsKey("EQ_starttime")) {// 按照捐献开始时间查找
			String starttime = (String) searchParams.get("EQ_starttime");
			if (starttime == null || "".equals(starttime.trim())) {
				searchParams.remove("EQ_starttime");
			} else {
				searchParams.put("EQ_starttime", starttime.trim());
				model.addAttribute("EQ_starttime", starttime);
			}
		}

		if (searchParams.containsKey("EQ_endtime")) {// 按照捐献结束时间查找
			String endtime = (String) searchParams.get("EQ_endtime");

			if (endtime == null || "".equals(endtime.trim())) {
				searchParams.remove("EQ_endtime");
			} else {

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String newEndtime = endtime;

				try {
					Date endDate = sdf.parse(endtime);
					Calendar cal = Calendar.getInstance();
					cal.setTime(endDate);
					cal.add(Calendar.HOUR, +24);
					newEndtime = sdf.format(cal.getTime());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				searchParams.put("EQ_endtime", newEndtime.trim());
				model.addAttribute("EQ_endtime", endtime);
			}
		}
		Page<Object[]> sqgiftrecord = sqGiftRecordService.getSqGiftRecordList(searchParams, pageNumber, pageSize,
				sortType, c);
		Integer sqgiftcount = sqGiftRecordService.getGiftCountByParam(searchParams, c);
		model.addAttribute("sqgiftrecord", sqgiftrecord);
		model.addAttribute("sqgiftcount", sqgiftcount);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "donation/sqgiftrecordlist";
	}

	/**
	 * 删除
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = sqGiftRecordService.delete(ids);

		String[] id = ids.split("\\|");// 删除赠予记录中所有物品
		for (String i : id) {
			List<Sq_Gift_Item> gifttimelist = sq_Gift_ItemService.getSq_Gift_ItemByGift(Long.parseLong(i));
			if (gifttimelist.size() > 0) {
				for (Sq_Gift_Item item : gifttimelist) {// 循环清除赠予记录中所有物品
					sq_Gift_ItemService.delete(item.getId());
				}
			}
		}
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功!");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败!");
		}
		return map;
	}

	/**
	 * 更新跳转页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update(@RequestParam(value = "id") Long id, Model model) {
		SqGiftRecord sqGiftRecord = sqGiftRecordService.getSqGiftRecordById(id);
		List<Sq_Gift_Item> gifttimelist = sq_Gift_ItemService.getSq_Gift_ItemByGift(id);
		if (sqGiftRecord != null && gifttimelist.size() > 0) {
			model.addAttribute("sqgiftrecord", sqGiftRecord);
			model.addAttribute("gifttimelist", gifttimelist);
			model.addAttribute("action", "update");
		}
		return "donation/sqgiftrecordForm";
	}

	/**
	 * 添加跳转页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create(Model model) {
		model.addAttribute("action", "create");
		return "donation/sqgiftrecordForm";
	}

	/**
	 * 编号不能重复
	 * 
	 * @param id
	 * @param num
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "checknum")
	@ResponseBody
	public Map<String, Object> checknum(@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "num") String num, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		SqGiftRecord s = sqGiftRecordService.getSqGiftRecordByNum(num);
		if (id != null) {// 更新
			if (s != null && s.getId() != id) {
				map.put("result", false);
				map.put("msg", "该编号的捐赠记录已经存在,请重新填写编号！");
			} else {
				map.put("result", true);
			}
		} else if (id == null) {// 添加
			if (s != null) {
				map.put("result", false);
				map.put("msg", "该编号的捐赠记录已经存在,请重新填写编号！");
			} else {
				map.put("result", true);
			}
		}
		return map;
	}

	/**
	 * 更新或添加方法
	 * 
	 * @param sqgiftrecord
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "createupdate", method = RequestMethod.POST)
	public String updateOrCreate(@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "num", required = false) String num,
			@RequestParam(value = "firstname", required = false) String firstname,
			@RequestParam(value = "lastname", required = false) String lastname,
			@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "context", required = false) String context,
			@RequestParam(value = "doname", required = false) String doname,
			@RequestParam(value = "createtime", required = false) String createtime,
			@RequestParam(value = "picurl", required = false) String picurl, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		User u = (User) request.getSession().getAttribute("user");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = sdf.parse(createtime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (id != null) {// 更新数据
			SqGiftRecord s = sqGiftRecordService.getSqGiftRecordById(id);
			List<Sq_Gift_Item> gifttimelist = sq_Gift_ItemService.getSq_Gift_ItemByGift(id);

			s.setNum(num);
			s.setFirstname(firstname);
			s.setLastname(lastname);
			s.setPhone(phone);
			s.setContext(context);
			s.setDoname(doname);
			s.setCreatetime(date);
			s.setPicurl(picurl);
			SqGiftRecord s1 = sqGiftRecordService.save(s);

			for (Sq_Gift_Item item : gifttimelist) {// 循环清除赠予记录中所有物品
				sq_Gift_ItemService.delete(item.getId());
			}
			String[] val = context.split(",");
			for (int i = 0; i < val.length; i++) {
				String[] val1 = val[i].split(" ");
				Sq_Gift_Item item = new Sq_Gift_Item();
				item.setName(val1[0]);
				item.setCount(Integer.parseInt(val1[1]));
				item.setGiftid(id);
				sq_Gift_ItemService.save(item);
			}

			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "编辑成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "编辑失败!");
			}
		} else {// 添加数据

			SqGiftRecord s = new SqGiftRecord();
			s.setNum(num);
			s.setFirstname(firstname);
			s.setLastname(lastname);
			s.setPhone(phone);
			s.setContext(context);
			s.setDoname(doname);
			s.setCreatetime(date);
			s.setPicurl(picurl);
			if (u != null) {
				Community comm = u.getCommunity();
				s.setCommunity(comm);
			}
			SqGiftRecord s1 = sqGiftRecordService.save(s);

			String[] val = context.split(",");
			for (int i = 0; i < val.length; i++) {
				String[] val1 = val[i].split(" ");
				Sq_Gift_Item item = new Sq_Gift_Item();
				item.setName(val1[0]);
				item.setCount(Integer.parseInt(val1[1]));
				item.setGiftid(s1.getId());
				sq_Gift_ItemService.save(item);
			}

			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "添加成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "添加失败!");
			}
		}
		return "redirect:/sqgiftrecord";
	}
}
