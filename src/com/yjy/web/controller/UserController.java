package com.yjy.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Role;
import com.yjy.entity.User;
import com.yjy.service.RoleService;
import com.yjy.service.UserService;

@Controller
@RequestMapping(value = "/system/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	private static String DEFAULTPASSWORD = "000000";

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("registertime", "注册时间");
	}

	/**
	 * 获取前端用于展示的所有User的数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:09:40
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping()
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		//searchParams = Util.changeEncoding(searchParams);

		if (searchParams.containsKey("EQ_role.id")) {
			String roleId = (String) searchParams.get("EQ_role.id");
			if (roleId.equals("0")) {
				searchParams.remove("EQ_role.id");
			} else {
				model.addAttribute("roleId", roleId);
				model.addAttribute("EQ_role_id", roleId);
			}
		}

		if (searchParams.containsKey("EQ_enabled")) {
			String enabled = (String) searchParams.get("EQ_enabled");
			if (enabled.equals("-1")) {
				searchParams.remove("EQ_enabled");
			} else {
				model.addAttribute("EQ_enabled", enabled);
			}
		}

		if (searchParams.containsKey("LIKE_name")) {
			String name = (String) searchParams.get("LIKE_name");
			if (name == null || name.trim().equals("") || name.equals("null")) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name",name.trim());
				model.addAttribute("LIKE_name", name);
			}
		}

		if (searchParams.containsKey("LIKE_realname")) {
			String realname = (String) searchParams.get("LIKE_realname");
			if (realname == null || realname.trim().equals("")
					|| realname.equals("null")) {
				searchParams.remove("LIKE_realname");
			} else {
				searchParams.put("LIKE_realname",realname.trim());
				model.addAttribute("LIKE_realname", realname);
			}
		}

		List<Role> roles = roleService.findAllRoles();

		Page<User> Users = userService.getUser(searchParams, pageNumber,
				pageSize, sortType);

		model.addAttribute("Users", Users);
		model.addAttribute("Roles", roles);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "account/userList";
	}

	/**
	 * 跳转到添加用户的页面，同时将所有的Role数据带到页面上去
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:22:16
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("user", new User());
		model.addAttribute("action", "create");
		List<Role> roles = roleService.findAllRolesForAdd();
		model.addAttribute("Roles", roles);
		return "account/userForm";
	}

	// 注册用户是密码需要加密保存
	/**
	 * 用来保存从添加页面传过来的数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:23:07
	 * @param user
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(@Valid User user,
			RedirectAttributes redirectAttributes) {
		user.setName(user.getTelephone());
		user.setPassword(DEFAULTPASSWORD);
		user.setRegistertime(new Date());
		user.setEnabled(1);
		user.setState(1);
		userService.saveorupdate(user);
		redirectAttributes.addFlashAttribute("message", "创建系统用户成功");
		return "redirect:/system/user/";
	}

	/**
	 * 跳转到修改用户信息的页面，并将所有的Role数据传递到页面上去
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:24:21
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id,
			@RequestParam(value = "page") String page, Model model) {
		User user = userService.get(id);

		model.addAttribute("user", user);
		model.addAttribute("action", "update");
		List<Role> roles = roleService.findAllRolesForAdd();
		model.addAttribute("Roles", roles);
		model.addAttribute("roleId", user.getRole().getId());
		model.addAttribute("page", page);
		return "account/userForm";
	}

	/**
	 * 保存修改之后的数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:24:59
	 * @param id
	 * @param name
	 * @param realname
	 * @param telephone
	 * @param roleId
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(
			@RequestParam(value = "id") Long id,
			@RequestParam(value = "realname") String realname,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "role.id", required = false) Long roleId,
			@RequestParam(value = "page") String page,
			RedirectAttributes redirectAttributes) {

		User user = userService.get(id);
		if (roleId != null && !"".equals(roleId) && !"null".equals(roleId)) {
			Role role = roleService.get(roleId);
			user.setRole(role);
		}

		user.setName(telephone);
		user.setRealname(realname);
		user.setTelephone(telephone);
		userService.update(user);
		redirectAttributes.addFlashAttribute("message", "更新用户成功");
		redirectAttributes.addAttribute("page", page);
		return "redirect:/system/user/";
	}

	/**
	 * 删除系统用户
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:26:56
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id,
			RedirectAttributes redirectAttributes) {
		userService.delete(id);
		redirectAttributes.addFlashAttribute("message", "删除用户成功");
		return "redirect:/system/user/";
	}

	/**
	 * 激活用户
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:27:17
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "activate/{id}")
	public String activate(@PathVariable("id") Long id,
			@RequestParam(value = "page") String page,
			RedirectAttributes redirectAttributes) {
		User user = userService.get(id);
		user.setEnabled(1);
		userService.update(user);
		redirectAttributes.addFlashAttribute("message", "激活用户成功");
		redirectAttributes.addAttribute("page", page);
		return "redirect:/system/user/";
	}

	/**
	 * 冻结用户，使其暂时无法登陆
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:27:35
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "disActivate/{id}")
	public String disActivate(@PathVariable("id") Long id,
			@RequestParam(value = "page") String page,
			RedirectAttributes redirectAttributes) {
		User user = userService.get(id);
		user.setEnabled(0);
		userService.update(user);
		redirectAttributes.addFlashAttribute("message", "冻结用户成功");
		redirectAttributes.addAttribute("page", page);
		return "redirect:/system/user/";
	}

	/**
	 * Ajax请求校验loginName是否唯一。
	 */
	/**
	 * 校验添加用户的时候，用户的名称是否已存在
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:28:06
	 * @param name
	 * @param uid
	 * @return
	 */
	@RequestMapping(value = "checkName")
	@ResponseBody
	public String checkLoginName(@RequestParam("name") String name,
			@RequestParam(value = "uid", required = false) Long uid) {
		if (uid == null) {
			if (userService.findByName(name) == null) {
				return "true";
			} else {
				return "false";
			}
		} else {
			if (userService.findByNameAndId(name, uid) == 0)
				return "true";
			else
				return "false";
		}
	}
	
	@RequestMapping(value = "checkTelephone")
	@ResponseBody
	public String checkTelephone(@RequestParam("telephone") String telephone,
			@RequestParam(value = "uid", required = false) Long uid) {
		if (uid == null) {
			if (userService.findByTelephone(telephone) == null) {
				return "true";
			} else {
				return "false";
			}
		} else {
			if (userService.findByTelephoneAndId(telephone, uid) == 0)
				return "true";
			else
				return "false";
		}
	}

	@RequestMapping(value = "/updatepassword", method = RequestMethod.GET)
	public String getuser(Model model, HttpServletRequest request) {
		model.addAttribute("action", "updatepassword");
		return "account/updatePassword";
	}

	@RequestMapping(value = "/checkoldpassword")
	@ResponseBody
	public Map<String, Object> check(
			@RequestParam(value = "oldpassword") String oldpassword,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) request.getSession().getAttribute("user");
		String oldpd = user.getPassword();
		String newpd = userService
				.entryptPasswordStr(user.getSalt(), oldpassword);
		if (oldpd.equals(newpd)) {
			map.put("result", true);
		} else {
			map.put("result", false);
			map.put("msg", "旧密码不正确");
		}
		return map;
	}

	@RequestMapping(value = "/updatepassword", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> newp1(@RequestParam(value = "newpassword1") String password,
			HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();

		try {
			User user = (User) session.getAttribute("user");
			user.setPassword(password);
			userService.saveorupdate(user);
			
			map.put("result", "1");
			map.put("msg", "密码修改成功,5秒后请重新登录");
			
			session.removeAttribute("user");
			session.removeAttribute("menuList");
			session.invalidate();
			Cookie ck = new Cookie("user", null);
			ck.setMaxAge(0);
			response.addCookie(ck);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "系统错误，密码修改失败，请稍后重试！");
		}
		
		return map;
	}

	/**
	 * 为系统用户重置密码，并保存重置后的结果
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:28:43
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping("rest/{uid}")
	public String restPassWord(@PathVariable("uid") Long id,
			RedirectAttributes redirectAttributes) {
		User su = userService.get(id);
		su.setPassword(DEFAULTPASSWORD);
		userService.saveorupdate(su);
		redirectAttributes.addFlashAttribute("message", "密码重置成功!默认密码："
				+ DEFAULTPASSWORD);
		return "redirect:/system/user/";
	}
	
	@RequestMapping(value="disableuser",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> disabledUser(@RequestParam("uid") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User su = userService.get(id);
			su.setEnabled(0);
			userService.update(su);
			map.put("result", "1");
			map.put("msg", "冻结账号成功");
			return map;
		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "冻结账号失败");
			return map;
		}
		
	}
	
	@RequestMapping(value="enableuser",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> enabledUser(@RequestParam("uid") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User su = userService.get(id);
			su.setEnabled(1);
			userService.update(su);
			map.put("result", "1");
			map.put("msg", "账号解冻成功");
			return map;
		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "账号解冻失败");
			return map;
		}
		
	}
	
	@RequestMapping(value="resetpass",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetPass(@RequestParam("uid") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User su = userService.get(id);
			su.setPassword(DEFAULTPASSWORD);
			userService.saveorupdate(su);
			map.put("result", "1");
			map.put("msg", "密码重置成功!默认密码：" + DEFAULTPASSWORD);
			return map;
		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "密码重置失败");
			return map;
		}
		
	}
	
}
