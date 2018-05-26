package com.yjy.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Resource;
import com.yjy.entity.ResourceRole;
import com.yjy.entity.Role;
import com.yjy.entity.User;
import com.yjy.service.ResourceRoleService;
import com.yjy.service.ResourceService;
import com.yjy.service.RoleService;
import com.yjy.service.UserService;
import com.yjy.utils.Util;

/**
 * 类RoleController.java的实现描述：该类用来对Role进行增删改查操作
 * 
 * @author yigang 2015年3月30日 下午3:53:24
 */
@Controller
@RequestMapping(value = "/system/role")
public class RoleController {

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("name", "注册时间");
	}

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private ResourceService resourceService;

	@Autowired
	private ResourceRoleService resourceRoleService;

	/**
	 * 获取所有的Role记录，得到Role的列表，提供前端展示。
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午3:53:32
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return 视图映射字符串，供视图解析器解析
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

		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = ((String) searchParams.get(key)).trim();
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value);
					model.addAttribute(key.replace(".", "_"), value);
				} else {
					searchParams.remove(key);
				}
			}
		}

		Page<Role> Roles = roleService.getRoles(searchParams, pageNumber,
				pageSize, sortType);

		model.addAttribute("Roles", Roles);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "role/roleList";
	}

	/**
	 * 用来跳转到新增Role的页面
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午3:57:19
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("role", new Role());
		model.addAttribute("action", "create");
		return "role/roleForm";
	}

	/**
	 * 用来保存新增Role的页面转递过来的数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午3:58:36
	 * @param role
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(@Valid Role role, RedirectAttributes redirectAttributes) {
		role.setEnabled(1);
		roleService.save(role);
		redirectAttributes.addFlashAttribute("message", "创建角色成功！");
		return "redirect:/system/role";
	}

	/**
	 * 跳转到更新Role记录的页面
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午3:59:12
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, 
			@RequestParam(value="page") String page,Model model) {
		model.addAttribute("role", roleService.get(id));
		model.addAttribute("action", "update");
		model.addAttribute("page", page);
		return "role/roleForm";
	}

	/**
	 * 保存从新增Role页面传递过来的更新之后的数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午3:59:29
	 * @param role
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(@Valid @ModelAttribute("role") Role role,
			@RequestParam(value="page") String page,
			RedirectAttributes redirectAttributes) {
		roleService.update(role);
		redirectAttributes.addFlashAttribute("message", "更新角色成功");
		redirectAttributes.addAttribute("page", page);
		return "redirect:/system/role";
	}

	/**
	 * 删除选定的Role记录
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:00:22
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id,
			@RequestParam(value="page") String page,
			RedirectAttributes redirectAttributes) {
		List<User> userList = userService.findByRole(id);
		if (userList != null && userList.size() > 0) {
			redirectAttributes.addFlashAttribute("message", "该角色当前被使用中，无法删除！");
			redirectAttributes.addAttribute("page", page);
			return "redirect:/system/role";
		}
		List<Long> rrIds = resourceRoleService.findResourceRoleIdByRoleId(id);
		if (rrIds != null && rrIds.size() > 0) {
			for (Long rrid : rrIds) {
				resourceRoleService.delete(rrid);
			}
		}
		roleService.delete(id);
		redirectAttributes.addFlashAttribute("message", "删除角色成功");
		redirectAttributes.addAttribute("page", page);
		return "redirect:/system/role";
	}

	/**
	 * 修改特定的角色可以访问的资源##该方法已经被废弃，但为了兼容之前的程序，暂时保留
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:03:52
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "updateResources/{id}")
	public String updateResources(@PathVariable(value = "id") Long roleId,
			Model model) {
		List<Resource> hasList = resourceService.findByRoleId(roleId);
		List<Resource> hasnotList = resourceService.findOtherResources(roleId);
		if (hasList != null && hasList.size() > 0) {
			model.addAttribute("hasList", hasList);
		}
		if (hasnotList != null && hasnotList.size() > 0) {
			model.addAttribute("hasnotList", hasnotList);
		}
		model.addAttribute("roleId", roleId);
		return "role/connection";
	}

	/**
	 * Ajax请求校验loginName是否唯一。
	 */
	/**
	 * 用来校验新增或者修改页面上Role的名称是否已经存在
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:04:28
	 * @param name
	 * @param rid
	 * @return
	 */
	@RequestMapping(value = "checkName")
	@ResponseBody
	public String checkLoginName(@RequestParam("name") String name,
			@RequestParam(value = "rid", required = false) Long rid) {
		String nameStr = Util.formatUTFString(name);
		if (rid == null) {
			if (roleService.findByName(nameStr) == 1) {
				return "true";
			} else {
				return "false";
			}
		} else {
			if (roleService.findByNameAndId(nameStr, rid) == 0)
				return "true";
			else
				return "false";
		}
	}

	/**
	 * 以树状图的形式展示特定Role所能够访问的资源，跳转到展示页面
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:06:42
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "treeview/{roleId}")
	public String treeView(@PathVariable("roleId") Long roleId, 
			@RequestParam(value="page") String page,Model model) {
		model.addAttribute("roleId", roleId);
		model.addAttribute("page", page);
		return "role/treeView";
	}

	/**
	 * 提供给前端用来获取生成树状图所需要的json格式的字符串数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:07:54
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "getData")
	@ResponseBody
	public String getData(@RequestParam("roleId") Long roleId, Model model) {
		String str = roleService.getTree(roleId);
		return str;
	}

	/**
	 * 当Role能够拥有的资源被修改的时候，保存修改后的内容
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:08:39
	 * @param ids
	 * @param roleId
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "saveRoleRes")
	public String saveRoleRes(@RequestParam("ids") String ids,
			@RequestParam("roleId") Long roleId, 
			@RequestParam(value="page") String page,Model model,
			RedirectAttributes redirectAttributes) {
		// Map<String, String> map = new HashMap<String, String>();
		resourceRoleService.deleteByRoleId(roleId);
		List<Long> supList = new ArrayList<Long>();
		List<Long> pieceList = new ArrayList<Long>();

		if (ids != null && ids.trim().length() > 0) {

			if (ids.indexOf("main") != -1) {
				List<Resource> supResList = resourceService
						.findAllSupResources();
				if (supResList != null && supResList.size() > 0) {
					for (Resource supRes : supResList) {
						supList.add(supRes.getId());
					}
				}
			} else {
				String[] idArr = ids.split("#");
				for (String idstr : idArr) {
					Resource res = resourceService.get(Long.valueOf(idstr));
					Resource pres = res.getResource();
					if (pres == null) {
						supList.add(Long.valueOf(idstr));
					} else {
						pieceList.add(Long.valueOf(idstr));
					}
				}
			}

			if (supList.size() > 0) {
				List<Long> fromSup = new ArrayList<Long>();
				for (Long supId : supList) {
					List<Resource> chdList = resourceService
							.findAllSortedSubResourcesByPid(supId);
					if (chdList != null && chdList.size() > 0) {
						for (Resource res : chdList) {
							fromSup.add(res.getId());
						}
					} else {
						fromSup.add(supId);
					}
				}

				if (pieceList.size() > 0) {
					for (int i = 0; i < pieceList.size(); i++) {
						if (fromSup.contains(pieceList.get(i))) {
							continue;
						} else {
							fromSup.add(pieceList.get(i));
						}
					}

					for (Long fromSupId : fromSup) {
						ResourceRole rr = new ResourceRole();
						rr.setResource(resourceService.get(fromSupId));
						rr.setRole(roleService.get(roleId));
						resourceRoleService.save(rr);
					}
				} else {
					for (Long fromSupId : fromSup) {
						ResourceRole rr = new ResourceRole();
						rr.setResource(resourceService.get(fromSupId));
						rr.setRole(roleService.get(roleId));
						resourceRoleService.save(rr);
					}
				}
			} else {
				for (Long pieceId : pieceList) {
					ResourceRole rr = new ResourceRole();
					rr.setResource(resourceService.get(pieceId));
					rr.setRole(roleService.get(roleId));
					resourceRoleService.save(rr);
				}
			}
		}

		redirectAttributes.addFlashAttribute("message", "更新权限成功！");
		redirectAttributes.addAttribute("page", page);
		return "redirect:/system/role";
	}
}
