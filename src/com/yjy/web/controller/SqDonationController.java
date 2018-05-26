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
import com.yjy.entity.Sq_Donation;
import com.yjy.entity.Sq_Donation_Item;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.Sq_DonationService;
import com.yjy.service.Sq_Donation_ItemService;

@Controller
@RequestMapping(value = "/sqdonation")
public class SqDonationController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	private Sq_DonationService sq_DonationService;

	@Autowired
	private CommunityService communityService;

	@Autowired
	private Sq_Donation_ItemService sq_Donation_ItemService;

	@RequestMapping()
	private String getSqDonation(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if (searchParams.containsKey("LIKE_name")) {// 按照个人捐献者姓名查找
			String name = (String) searchParams.get("LIKE_name");
			if (name == null || "".equals(name.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", name.trim());
				model.addAttribute("LIKE_name", name);
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

		User user = (User) request.getSession().getAttribute("user");
		Community comm = user.getCommunity();
		if (comm == null) {

		} else {
			searchParams.put("EQ_comid", comm.getId());
		}

		Page<Object[]> adverts = sq_DonationService.getGenRenDonations(searchParams, pageNumber, pageSize, sortType);

		// Page<Sq_Donation> adverts =
		// sq_DonationService.getSqDonations(searchParams, pageNumber, pageSize,
		// sortType);
		model.addAttribute("sqadverts", adverts);
		return "donation/sqdonationList";
	}

	/* 以下是企业捐赠 */
	/**
	 * 企业捐赠
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/companydonation")
	private String getcompany(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
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

		if (searchParams.containsKey("LIKE_company")) {// 企业名称搜索
			String LIKE_company = (String) searchParams.get("LIKE_company");
			if (LIKE_company == null || "".equals(LIKE_company.trim())) {
				searchParams.remove("LIKE_company");
			} else {
				searchParams.put("LIKE_company", LIKE_company.trim());
				model.addAttribute("LIKE_company", LIKE_company);
			}
		}
		if (searchParams.containsKey("EQ_contexttype")) {// 根据捐献类型搜索
			String EQ_contexttype = (String) searchParams.get("EQ_contexttype");
			model.addAttribute("EQ_contexttype", EQ_contexttype);
			if (EQ_contexttype == "-1" || "-1".equals(EQ_contexttype.trim())) {
				searchParams.remove("EQ_contexttype");
			}
		}
		if (searchParams.containsKey("EQ_starttime")) {// 按照开始时间查找
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
				try {
					Date endDate = sdf.parse(endtime);
					Calendar cal = Calendar.getInstance();
					cal.setTime(endDate);
					cal.add(Calendar.HOUR, +24);
					searchParams.put("EQ_endtime", sdf.format(cal.getTime()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				model.addAttribute("EQ_endtime", endtime);
			}
		}
		Page<Object[]> companydonation = sq_DonationService.getCompanyDonations(searchParams, pageNumber, pageSize,
				sortType, c);
		Integer pricenum = sq_DonationService.getPriceByParams(searchParams, c);
		Integer donationnum = sq_DonationService.getDonationCountByParams(searchParams, c);
		model.addAttribute("companydonation", companydonation);
		model.addAttribute("pricenum", pricenum);
		model.addAttribute("donationnum", donationnum);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "donation/companysqdonation";
	}

	@RequestMapping(value = "/del")
	public String del(@RequestParam(value = "delid") Long id, @RequestParam(value = "pageno") int pageno, Model model,
			RedirectAttributes redirectAttributes) {
		redirectAttributes.addAttribute("page", pageno);
		try {
			sq_DonationService.deleteDonationGoodsByDonationId(id);
			sq_DonationService.delete(id);
			redirectAttributes.addFlashAttribute("message", "删除成功");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("message", "删除失败");
		}

		return "redirect:/sqdonation/";

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
		boolean result = sq_DonationService.delete1(ids);

		String[] id = ids.split("\\|");// 删除捐赠记录中所有物品
		for (String i : id) {
			List<Sq_Donation_Item> donatimelist = sq_Donation_ItemService
					.getSq_Donation_ItemBydonation(Long.parseLong(i));
			if (donatimelist.size() > 0) {
				for (Sq_Donation_Item item : donatimelist) {// 循环清除捐赠记录中所有物品
					sq_Donation_ItemService.delete(item.getId());
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
	 * 企业更新跳转页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update(@RequestParam(value = "id") Long id, Model model) {
		Sq_Donation sq_Donation = sq_DonationService.get(id);
		List<Sq_Donation_Item> listdonation = sq_Donation_ItemService.getSq_Donation_ItemBydonation(id);
		if (sq_Donation != null) {
			model.addAttribute("sqdonation", sq_Donation);
			model.addAttribute("listdonation", listdonation);
			model.addAttribute("action", "update");
		}
		return "donation/companysqdonationForm";
	}

	/**
	 * 企业添加跳转页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create(Model model) {
		model.addAttribute("action", "create");
		return "donation/companysqdonationForm";
	}

	/**
	 * 企业更新或添加方法
	 * 
	 * @param sqgiftrecord
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "createupdate", method = RequestMethod.POST)
	public String updateOrCreate(@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "num", required = false) String num,
			@RequestParam(value = "company", required = false) String company,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "createtime", required = false) String createtime,
			@RequestParam(value = "contexttype", required = false) Integer contexttype,
			@RequestParam(value = "price", required = false) Integer price,
			@RequestParam(value = "context", required = false) String context, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		System.out.println(contexttype + context);
		User u = (User) request.getSession().getAttribute("user");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = sdf.parse(createtime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (id != null) {// 更新数据
			Sq_Donation s = sq_DonationService.get(id);
			List<Sq_Donation_Item> donatimelist = sq_Donation_ItemService.getSq_Donation_ItemBydonation(id);
			if (donatimelist.size() > 0) {
				for (Sq_Donation_Item item : donatimelist) {// 循环清除赠予记录中所有物品
					sq_Donation_ItemService.delete(item.getId());
				}
			}
			s.setNum(num.trim());
			s.setCompany(company.trim());
			s.setName(name.trim());
			s.setPhone(phone.trim());
			s.setCreatetime(date);
			s.setContexttype(contexttype);
			if (contexttype == 1) {// 1金钱
				s.setPrice(price * 100);
				s.setContext(null);
			} else {// 2物品
				s.setContext(context.trim());
				s.setPrice(null);

				String[] val = context.split(",");
				for (int i = 0; i < val.length; i++) {// 循环保存企业捐献的物品
					String[] val1 = val[i].split(" ");
					Sq_Donation_Item item = new Sq_Donation_Item();
					item.setName(val1[0]);
					item.setCount(Integer.parseInt(val1[1]));
					item.setDonationid(id);
					sq_Donation_ItemService.save(item);
				}
			}
			Sq_Donation s1 = sq_DonationService.save(s);
			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "编辑成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "编辑失败!");
			}
		} else {// 新增数据
			Sq_Donation s = new Sq_Donation();
			s.setNum(num.trim());
			s.setCompany(company.trim());
			s.setName(name.trim());
			s.setPhone(phone.trim());
			s.setCreatetime(date);
			s.setContexttype(contexttype);
			s.setType(3);// 新添加默认为企业
			if (u != null) {
				Community comm = u.getCommunity();
				s.setCommunity(comm);
			}
			Sq_Donation s1 = new Sq_Donation();
			if (contexttype == 1) {// 1金钱
				s.setPrice(price * 100);
				s1 = sq_DonationService.save(s);
			} else {// 2物品
				s.setContext(context.trim());
				s1 = sq_DonationService.save(s);

				String[] val = context.split(",");
				for (int i = 0; i < val.length; i++) {
					String[] val1 = val[i].split(" ");
					Sq_Donation_Item item = new Sq_Donation_Item();
					item.setName(val1[0]);
					item.setCount(Integer.parseInt(val1[1]));
					item.setDonationid(s1.getId());
					sq_Donation_ItemService.save(item);
				}
			}
			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "添加成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "添加失败!");
			}
		}
		return "redirect:/sqdonation/companydonation";
	}

	/**
	 * 编号不能重复
	 * 
	 * @param id
	 * @param num
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "checknum1")
	@ResponseBody
	public Map<String, Object> checknum(@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "num") String num, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_Donation s = sq_DonationService.getDonationByNum(num);
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

	/* 以下是物品捐赠 */
	/**
	 * 物品捐赠
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/goodsdonation")
	private String getgoods(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
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

		if (searchParams.containsKey("LIKE_name")) {// 捐献人
			String LIKE_name = (String) searchParams.get("LIKE_name");
			if (LIKE_name == null || "".equals(LIKE_name.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", LIKE_name.trim());
				model.addAttribute("LIKE_name", LIKE_name);
			}
		}
		if (searchParams.containsKey("LIKE_context")) {// 捐献物品
			String LIKE_context = (String) searchParams.get("LIKE_context");
			if (LIKE_context == null || "".equals(LIKE_context.trim())) {
				searchParams.remove("LIKE_context");
			} else {
				searchParams.put("LIKE_context", LIKE_context.trim());
				model.addAttribute("LIKE_context", LIKE_context);
			}
		}
		if (searchParams.containsKey("EQ_starttime")) {// 开始时间查找
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
		Page<Object[]> goodsdonation = sq_DonationService.getGoodsDonations(searchParams, pageNumber, pageSize,
				sortType, c);
		Integer goodsnum = sq_DonationService.getDonationGoodsCountByParams(searchParams, c);
		model.addAttribute("goodsdonation", goodsdonation);
		model.addAttribute("goodsnum", goodsnum);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "donation/goodsdonation";
	}

	/**
	 * 物品更新跳转页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "updategoods", method = RequestMethod.GET)
	public String updategoods(@RequestParam(value = "id") Long id, Model model) {
		Sq_Donation sq_Donation = sq_DonationService.get(id);
		List<Sq_Donation_Item> listdonation = sq_Donation_ItemService.getSq_Donation_ItemBydonation(id);
		if (sq_Donation != null && listdonation.size() > 0) {
			model.addAttribute("sqdonation", sq_Donation);
			model.addAttribute("listdonation", listdonation);
			model.addAttribute("action", "update");
		}
		return "donation/goodsdonationForm";
	}

	/**
	 * 物品添加跳转页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "creategoods", method = RequestMethod.GET)
	public String creategoods(Model model) {
		model.addAttribute("action", "create");
		return "donation/goodsdonationForm";
	}

	/**
	 * 物品更新或添加方法
	 * 
	 * @param sqgiftrecord
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "createupdategoods", method = RequestMethod.POST)
	public String updateOrCreateGoods(@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "num", required = false) String num,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "context", required = false) String context,
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
			Sq_Donation s = sq_DonationService.get(id);
			List<Sq_Donation_Item> donatimelist = sq_Donation_ItemService.getSq_Donation_ItemBydonation(id);

			s.setNum(num.trim());
			s.setName(name.trim());
			s.setPhone(phone.trim());
			s.setCreatetime(date);
			s.setContexttype(2);
			s.setType(2);
			s.setContext(context.trim());
			s.setPicurl(picurl);
			Sq_Donation s1 = sq_DonationService.save(s);// 保存捐赠记录
			for (Sq_Donation_Item item : donatimelist) {// 循环清除捐赠记录中所有物品
				sq_Donation_ItemService.delete(item.getId());
			}
			String[] val = context.split(",");
			for (int i = 0; i < val.length; i++) {
				String[] val1 = val[i].split(" ");
				Sq_Donation_Item item = new Sq_Donation_Item();
				item.setName(val1[0]);
				item.setCount(Integer.parseInt(val1[1]));
				item.setDonationid(id);
				sq_Donation_ItemService.save(item);
			}
			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "编辑成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "编辑失败!");
			}
		} else {// 新增数据
			Sq_Donation s = new Sq_Donation();
			s.setNum(num.trim());
			s.setName(name.trim());
			s.setPhone(phone.trim());
			s.setCreatetime(date);
			s.setContexttype(2);
			s.setType(2);// 新添加默认为线下
			s.setContext(context.trim());
			s.setPicurl(picurl);
			if (u != null) {
				Community comm = u.getCommunity();
				s.setCommunity(comm);
			}
			Sq_Donation s1 = sq_DonationService.save(s);

			String[] val = context.split(",");
			for (int i = 0; i < val.length; i++) {
				String[] val1 = val[i].split(" ");
				Sq_Donation_Item item = new Sq_Donation_Item();
				item.setName(val1[0]);
				item.setCount(Integer.parseInt(val1[1]));
				item.setDonationid(s1.getId());
				sq_Donation_ItemService.save(item);
			}

			if (s1 != null) {
				redirectAttributes.addFlashAttribute("message", "添加成功!");
			} else {
				redirectAttributes.addFlashAttribute("message", "添加失败!");
			}
		}
		return "redirect:/sqdonation/goodsdonation";
	}
}
