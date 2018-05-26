package com.yjy.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
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
import com.yjy.entity.Resource;
import com.yjy.entity.ResourceRole;
import com.yjy.entity.Role;
import com.yjy.service.ResourceRoleService;
import com.yjy.service.ResourceService;
import com.yjy.service.RoleService;
import com.yjy.utils.Util;

/**
 * 类ResourceController.java的实现描述：用来操作资源的Controller 
 * @author yigang 2015年4月20日 下午2:03:13
 */
@Controller
@RequestMapping(value = "/system/resource")
public class ResourceController {

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("registertime", "注册时间");
	}

	@Autowired
	private ResourceService resourceService;

	@Autowired
	private ResourceRoleService resourceRoleService;

	@Autowired
	private RoleService roleService;

	/**
	 * 获取所有的Resource数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:30:20
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams = Util.changeEncoding(searchParams);

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

		if (searchParams.containsKey("EQ_resource.id")) {
			String subResId = (String) searchParams.get("EQ_resource.id");
			if ("0".equals(subResId)) {
				searchParams.remove("EQ_resource.id");
			} else {
				model.addAttribute("resourceId", subResId);
			}
		}

		List<Resource> subResoucesList = resourceService.findAllSupResources();

		Page<Resource> Resources = resourceService.getResources(searchParams,
				pageNumber, pageSize, sortType);

		model.addAttribute("Resources", Resources);
		model.addAttribute("subResoucesList", subResoucesList);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "resource/resourceList";
	}

	/**
	 * 添加新的页面资源
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:32:46
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		List<Resource> subResoucesList = resourceService.findAllSupResources();
		if (subResoucesList != null && subResoucesList.size() > 0) {
			model.addAttribute("SupMenus", subResoucesList);
		} else {
			model.addAttribute("dontshow", "dontshow");
		}
		model.addAttribute("resource", new Resource());
		model.addAttribute("action", "create");

		return "resource/resourceForm";
	}

	/**
	 * 保存新的资源信息
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:33:26
	 * @param resource
	 * @param selectLevel
	 * @param selectSupMenu
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(
			@Valid Resource resource,
			@RequestParam(value = "selectLevel") String selectLevel,
			@RequestParam(value = "selectSupMenu", required = false) Long selectSupMenu,
			RedirectAttributes redirectAttributes) {
		if (selectSupMenu != null && !"".equals(selectSupMenu)
				&& !"null".equals(selectSupMenu) && !"0".equals(selectSupMenu)) {
			Resource pres = resourceService.get(selectSupMenu);
			resource.setResource(pres);
		}
		resource.setCreatetime(new Date());
		resourceService.save(resource);
		redirectAttributes.addFlashAttribute("message", "创建资源成功！");
		return "redirect:/system/resource/";
	}

	/**
	 * 跳转到更新资源信息页面
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:33:51
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, Model model) {
		Resource res = resourceService.get(id);
		Resource pres = res.getResource();
		if (pres != null) {
			model.addAttribute("sub", "two");
			model.addAttribute("level", "2");
			model.addAttribute("supMenuId", pres.getId());
		} else {
			model.addAttribute("sub", "one");
			model.addAttribute("level", "1");
			model.addAttribute("supMenuId", "0");
		}
		List<Resource> subResoucesList = resourceService.findAllSupResources();
		if (subResoucesList != null && subResoucesList.size() > 0) {
			model.addAttribute("SupMenus", subResoucesList);
		}
		model.addAttribute("resource", resourceService.get(id));
		model.addAttribute("action", "update");
		return "resource/resourceForm";
	}

	/**
	 * 保存修改后的资源信息
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:34:15
	 * @param resId
	 * @param name
	 * @param selectLevel
	 * @param selectSupMenu
	 * @param url
	 * @param resdesc
	 * @param sorts
	 * @param logo
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(
			@RequestParam(value = "id") Long resId,
			@RequestParam(value = "name") String name,
			@RequestParam(value = "selectLevel", required = false) String selectLevel,
			@RequestParam(value = "selectSupMenu", required = false) Long selectSupMenu,
			@RequestParam(value = "url") String url,
			@RequestParam(value = "resdesc") String resdesc,
			@RequestParam(value = "sorts") Long sorts,
			@RequestParam(value = "logo") String logo,
			RedirectAttributes redirectAttributes) {

		Resource res = resourceService.get(resId);

		if (selectSupMenu != null && !"".equals(selectSupMenu)
				&& !"null".equals(selectSupMenu) && !"0".equals(selectSupMenu)) {
			Resource pres = resourceService.get(selectSupMenu);
			res.setResource(pres);
		}
		res.setName(name);
		res.setUrl(url);
		res.setResdesc(resdesc);
		res.setSorts(sorts);
		res.setLogo(logo);
		resourceService.update(res);
		redirectAttributes.addFlashAttribute("message", "更新资源成功");
		return "redirect:/system/resource/";
	}

	/**
	 * 树图结构时的跳转到添加资源页面
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:34:31
	 * @param pid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create2", method = RequestMethod.GET)
	public String createForm2(@RequestParam(value = "pid") String pid,
			Model model) {

		if (pid != null && !"".equals(pid) && !"null".equals(pid)) {
			if (pid.equals("main")) {
				model.addAttribute("showLogo", "yes");
				model.addAttribute("pname", "");
				model.addAttribute("presId", "level1");
			} else {
				Resource res = resourceService.get(Long.valueOf(pid));
				if (res != null) {
					Resource pres = res.getResource();
					if (pres != null) {
						model.addAttribute("pname", pres.getName());
						model.addAttribute("showLogo", "no");
						model.addAttribute("presId", pres.getId());
					} else {
						model.addAttribute("pname", res.getName());
						model.addAttribute("showLogo", "no");
						model.addAttribute("presId", res.getId());
					}
				}
			}
		}
		model.addAttribute("action", "create2");
		return "resource/resourceTreeForm";
	}

	/**
	 * 树图结构时保存添加的资源的信息
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:35:25
	 * @param presId
	 * @param resourceName
	 * @param resourceUrl
	 * @param resourceDesc
	 * @param resourceSorts
	 * @param resourceLogo
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "create2", method = RequestMethod.POST)
	public String create2(
			@RequestParam(value = "presId") String presId,
			@RequestParam(value = "resourceName") String resourceName,
			@RequestParam(value = "resourceUrl") String resourceUrl,
			@RequestParam(value = "resourceDesc") String resourceDesc,
			@RequestParam(value = "resourceSorts") String resourceSorts,
			@RequestParam(value = "resourceLogo", required = false) String resourceLogo,
			Model model,
			RedirectAttributes redirectAttributes) {

		Resource res = new Resource();
		res.setCreatetime(new Date());
		res.setName(resourceName);
		res.setUrl(resourceUrl);
		res.setResdesc(resourceDesc);
		res.setSorts(Long.valueOf(resourceSorts));

		if (presId.equals("level1")) {
			res.setLogo(resourceLogo);
			res.setResource(null);
		} else {
			res.setLogo(null);
			res.setResource(resourceService.get(Long.valueOf(presId)));
		}
		resourceService.save(res);
		model.addAttribute("msg", "创建菜单成功!");
		return "resource/resourceTree";
	}

	/**
	 * 树图结构时，跳转到修改资源信息的页面
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:35:50
	 * @param reid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update2", method = RequestMethod.GET)
	public String updateForm2(@RequestParam(value = "reid") String reid,
			Model model) {

		Resource res = resourceService.get(Long.valueOf(reid));

		model.addAttribute("resourceName", res.getName());
		model.addAttribute("resourceUrl", res.getUrl());
		model.addAttribute("resourceDesc", res.getResdesc());
		model.addAttribute("resourceSorts", res.getSorts());
		model.addAttribute("resId", reid);

		Resource pres = res.getResource();

		if (pres == null) {
			model.addAttribute("resourceLogo", res.getLogo());
			model.addAttribute("showLogo", "yes");
			model.addAttribute("pname", "");
		} else {
			model.addAttribute("showLogo", "no");
			model.addAttribute("pname", pres.getName());
		}

		model.addAttribute("action", "update2");
		return "resource/resourceTreeForm";
	}

	/**
	 * 树图结构时保存修改后的资源信息
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:36:15
	 * @param resId
	 * @param resourceName
	 * @param resourceUrl
	 * @param resourceDesc
	 * @param resourceSorts
	 * @param resourceLogo
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "update2", method = RequestMethod.POST)
	public String update2(
			@RequestParam(value = "resId") String resId,
			@RequestParam(value = "resourceName") String resourceName,
			@RequestParam(value = "resourceUrl") String resourceUrl,
			@RequestParam(value = "resourceDesc") String resourceDesc,
			@RequestParam(value = "resourceSorts") String resourceSorts,
			@RequestParam(value = "resourceLogo", required = false) String resourceLogo,
			Model model,
			RedirectAttributes redirectAttributes) {

		Resource res = resourceService.get(Long.valueOf(resId));

		res.setName(resourceName);
		res.setUrl(resourceUrl);
		res.setResdesc(resourceDesc);
		res.setSorts(Long.valueOf(resourceSorts));
		res.setLogo(resourceLogo);

		resourceService.update(res);
		model.addAttribute("msg", "修改菜单成功!");
		return "resource/resourceTree";
	}

	/**
	 * 删除资源信息
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:37:01
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id,
			RedirectAttributes redirectAttributes) {
		List<Long> rrIds = resourceService.findResourceRoleIdByResourceId(id);
		if (rrIds != null && rrIds.size() > 0) {
			for (Long oneId : rrIds) {
				resourceRoleService.delete(oneId);
			}
		}
		resourceService.delete(id);
		redirectAttributes.addFlashAttribute("message", "删除资源成功");
		return "redirect:/system/resource/";
	}

	/**
	 * 树图结构时，删除资源信息
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:37:29
	 * @param resId
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete2")
	@ResponseBody
	public Map<String, String> delete2(
			@RequestParam(value = "reId") String resId,
			RedirectAttributes redirectAttributes) {
		Map<String, String> map = new HashMap<String, String>();

		Resource res = resourceService.get(Long.valueOf(resId));

		Resource pres = res.getResource();

		if (pres != null) {
			List<Long> rrIds = resourceService
					.findResourceRoleIdByResourceId(Long.valueOf(resId));
			if (rrIds != null && rrIds.size() > 0) {
				for (Long oneId : rrIds) {
					resourceRoleService.delete(oneId);
				}
			}
			resourceService.delete(Long.valueOf(resId));
			map.put("result", "1");
			map.put("msg", "删除成功!");
			return map;
		} else {
			List<Resource> delResList = resourceService
					.findAllSortedSubResourcesByPid(Long.valueOf(resId));
			if (delResList != null && delResList.size() > 0) {
				map.put("result", "0");
				map.put("msg", "删除失败，该菜单下有子菜单，请将所有的子菜单删除之后，再删除该菜单!");
				return map;
			} else {
				List<Long> rrIds = resourceService
						.findResourceRoleIdByResourceId(Long.valueOf(resId));
				if (rrIds != null && rrIds.size() > 0) {
					for (Long oneId : rrIds) {
						resourceRoleService.delete(oneId);
					}
				}
				resourceService.delete(Long.valueOf(resId));
				map.put("result", "1");
				map.put("msg", "删除成功!");
				return map;
			}
		}
	}

	/**
	 * 移除摸个Role所具有的资源
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:37:49
	 * @param roleId
	 * @param resId
	 * @return
	 */
	@RequestMapping(value = "removeRes")
	@ResponseBody
	public Map<String, Object> removeRes(
			@RequestParam(value = "roleId") Long roleId,
			@RequestParam(value = "resId") Long resId) {
		Map<String, Object> map = new HashMap<String, Object>();
		resourceRoleService.deleteByRoleAndResource(roleId, resId);
		Resource res = resourceService.get(resId);
		if (res != null) {
			map.put("result", "1");
			map.put("res", res);

		} else {
			map.put("result", "0");
		}
		return map;
	}

	/**
	 * 为某个Role添加资源
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:38:09
	 * @param roleId
	 * @param resId
	 * @return
	 */
	@RequestMapping(value = "addRes")
	@ResponseBody
	public Map<String, Object> addRes(
			@RequestParam(value = "roleId") Long roleId,
			@RequestParam(value = "resId") Long resId) {
		Map<String, Object> map = new HashMap<String, Object>();
		ResourceRole rr = new ResourceRole();
		Resource res = resourceService.get(resId);
		Role role = roleService.get(roleId);
		if (res != null && role != null) {
			rr.setResource(res);
			rr.setRole(role);
			resourceRoleService.save(rr);
			map.put("result", "1");
			map.put("res", res);
		} else {
			map.put("result", "0");
		}
		return map;
	}

	/**
	 * 添加资源的时候，校验资源名称是否已存在
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:38:26
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
			if (resourceService.findByName(nameStr) == null) {
				return "true";
			} else {
				return "false";
			}
		} else {
			if (resourceService.findByNameAndId(nameStr, rid) == 0)
				return "true";
			else
				return "false";
		}
	}

	/**
	 * 获取资源树图
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:38:53
	 * @return
	 */
	@RequestMapping(value = "tree")
	public String getTree() {
		return "resource/resourceTree";
	}

	/**
	 * 获取生成资源树图所需要的json数据
	 * 
	 * @author yigang
	 * @date 2015年3月30日 下午4:39:04
	 * @return
	 */
	@RequestMapping(value = "getData")
	@ResponseBody
	public String getData() {
		String str = resourceService.getTree();
		return str;
	}
}
