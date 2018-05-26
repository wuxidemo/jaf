package com.yjy.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
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
import com.yjy.entity.Role;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.UserService;

/**
 * 类CommunityController。java的实现描述：操作社区表
 * 
 * @author liping
 * 
 */
@Controller
@RequestMapping(value = "/community")
public class CommunityController {
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	@Autowired
	private CommunityService communityService;

	@Autowired
	private UserService userService;

	/**
	 * 获取社区列表
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping()
	private String getCommunityList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (searchParams.containsKey("LIKE_name")) {
			String realName = (String) searchParams.get("LIKE_name");
			if (realName == null || "".equals(realName.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", realName.trim());
				model.addAttribute("LIKE_name", realName.trim());
			}
		}
		if (searchParams.containsKey("EQ_categoryValue.id")) {
			String district = (String) searchParams.get("EQ_categoryValue.id");
			if (district == "-1" || "-1".equals(district.trim())) {
				searchParams.remove("EQ_categoryValue.id");
			}
		}
		Page<Community> community = communityService.getCommunityList(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("community", community);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "community/communitylist";
	}

	/**
	 * 根据ids删除community对象
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCommunity(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = communityService.delete(ids);
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	/**
	 * 新增社区
	 * 
	 * @author liping
	 * @param community
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String create(@Valid Community community, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		community.setCreatetime(new Date());
		User user = (User) request.getSession().getAttribute("user");
		community.setUser(user);
		communityService.SaveOrUpdate(community);
		redirectAttributes.addFlashAttribute("message", "更新成功");
		return "redirect:/community";

	}
	
	/**
	 * 新增社区
	 * 
	 * @author liping
	 * @param community
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/createmap", method = RequestMethod.POST)
	@ResponseBody
	public String createmap(@Valid Community community, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		community.setCreatetime(new Date());
		User user = (User) request.getSession().getAttribute("user");
		community.setUser(user);
		communityService.SaveOrUpdate(community);
		return "1";

	}

	/**
	 * 判断社区是否存在
	 * 
	 * @author liping
	 * @param id
	 * @param name
	 * @param cid
	 * @return
	 */
	@RequestMapping(value = "/checkname", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> CheckCommunityValue(@RequestParam(value = "id") Long id,
			@RequestParam(value = "name") String name, @RequestParam(value = "cid") Long cid) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Community> community = communityService.getCommunityByName(name, cid);
		if (community.size() == 0) {
			map.put("result", true);
		} else if (community.get(0).getId().equals(id)) {
			map.put("result", true);
		} else {
			map.put("result", false);
			map.put("msg", "商圈名称已存在");
		}
		return map;
	}

	@RequestMapping(value = "/addadmin", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addAdmin(@RequestParam(value = "communityid") Long id,
			@RequestParam(value = "phoneno") String phone, @RequestParam(value = "uname") String username) {
		Map<String, Object> map = new HashMap<String, Object>();

		try {

			Community comm = communityService.get(id);

			User user = new User();
			user.setName(phone);
			user.setRealname(username);

			Role role = new Role();
			role.setId(16L);
			user.setRole(role);

			user.setRegistertime(new Date());
			user.setStarttime(null);
			user.setEndtime(null);
			user.setState(1);
			user.setEnabled(1);
			user.setTelephone(phone);
			user.setCaptcha(null);
			user.setMerchant(null);
			user.setCommunity(comm);
			user.setPassword("000000");

			userService.saveorupdate(user);

			map.put("result", "1");
			map.put("msg", "创建社区管理员成功");
			return map;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			map.put("result", "0");
			map.put("msg", "创建社区管理员失败");
			return map;
		}
	}

	@RequestMapping(value = "getcommadmin", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCommAdmin(@RequestParam(value = "commid") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<User> ulist = userService.getUsersByCommunityid(id);
		if (ulist != null && ulist.size() > 0) {
			map.put("result", "1");
			map.put("data", ulist);
		} else {
			map.put("result", "0");
			map.put("data", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "commcontact", method = RequestMethod.GET)
	public String communityContact(HttpServletRequest request, Model model) {

		User user = (User) request.getSession().getAttribute("user");
		Community community = user.getCommunity();
		if (community == null) {
			return "community/noAccess";
		}

		model.addAttribute("community", community);
		return "donation/contact";
	}

	@RequestMapping(value = "updatecontact", method = RequestMethod.GET)
	public String updateContactForm(HttpServletRequest request, Model model) {

		User user = (User) request.getSession().getAttribute("user");
		Community community = user.getCommunity();
		if (community == null) {
			return "community/noAccess";
		}

		model.addAttribute("community", community);
		return "donation/contactForm";
	}

	@RequestMapping(value = "saveupdate", method = RequestMethod.POST)
	public String updateContact(@RequestParam(value = "firstname") String firstname,
			@RequestParam(value = "lastname") String lastname, @RequestParam(value = "contactsex") Integer contactsex,
			@RequestParam(value = "contactphone") String contactphone, HttpServletRequest request, Model model) {

		User user = (User) request.getSession().getAttribute("user");
		Community community = user.getCommunity();
		if (community == null) {
			return "community/noAccess";
		}

		community.setFirstname(firstname);
		community.setLastname(lastname);
		community.setContactphone(contactphone);
		community.setFullname(firstname + lastname);
		community.setContactsex(contactsex);
		communityService.SaveOrUpdate(community);

		model.addAttribute("community", community);
		return "donation/contact";
	}

	@RequestMapping(value = "viewcontact")
	private String viewContact(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (searchParams.containsKey("LIKE_fullname")) {
			String contactname = (String) searchParams.get("LIKE_fullname");
			if (contactname == null || "".equals(contactname.trim())) {
				searchParams.remove("LIKE_fullname");
			} else {
				searchParams.put("LIKE_fullname", contactname.trim());
				model.addAttribute("LIKE_fullname", contactname);
			}
		}
		if (searchParams.containsKey("EQ_community.id")) {
			String commid = (String) searchParams.get("EQ_community.id");
			if (commid == null || "-1".equals(commid.trim())) {

			} else {
				searchParams.put("EQ_id", commid);
				model.addAttribute("EQ_community_id", commid);
			}
			searchParams.remove("EQ_community.id");
		}

		List<Community> commlist = communityService.getCommunityList();
		model.addAttribute("communitys", commlist);

		Page<Community> community = communityService.getCommunityList(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("comms", community);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "donation/sqcontactlist";
	}

	@RequestMapping(value = "clearcontact", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> clearContact(@RequestParam(value = "commid") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			Community comm = communityService.get(id);
			comm.setFirstname(null);
			comm.setLastname(null);
			comm.setFullname(null);
			comm.setContactsex(null);
			comm.setContactphone(null);
			communityService.SaveOrUpdate(comm);
			map.put("result", "1");
			map.put("msg", "清除成功");
			return map;
		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "清除失败");
			return map;
		}

	}

	@RequestMapping(value = "comlist")
	@ResponseBody
	private Page<Community> CommunityList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "createtime") String sortType, Model model,
			ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (searchParams.containsKey("LIKE_name")) {
			String realName = (String) searchParams.get("LIKE_name");
			if (realName == null || "".equals(realName.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", realName.trim());
				model.addAttribute("LIKE_name", realName.trim());
			}
		}
		if (searchParams.containsKey("EQ_categoryValue.id")) {
			String district = (String) searchParams.get("EQ_categoryValue.id");
			if (district == "-1" || "-1".equals(district.trim())) {
				searchParams.remove("EQ_categoryValue.id");
			}
		}
		Page<Community> community = communityService.getCommunityList(searchParams, pageNumber, pageSize, sortType);
		return community;
	}

}
