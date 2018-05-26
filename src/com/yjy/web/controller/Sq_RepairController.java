package com.yjy.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Community;
import com.yjy.entity.Sq_Repair;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.Sq_RepairService;

@Controller
@RequestMapping(value = "/repair")
public class Sq_RepairController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	Sq_RepairService repairService;

	@Autowired
	CommunityService communityService;

	@RequestMapping()
	public String list(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		Community comm = user.getCommunity();
		if (comm == null) {
			model.addAttribute("iscomm", "0");
		} else {
			model.addAttribute("iscomm", "1");
		}

		List<Community> commlist = communityService.getCommunityList();
		model.addAttribute("communitys", commlist);
		return "wuye/repairlist";
	}

	/**
	 * 根据查询条件获取requir列表
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/replist")
	@ResponseBody
	private Page<Sq_Repair> repairList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "createtime") String sortType,
			HttpServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		User user = (User) request.getSession().getAttribute("user");
		Community comm = user.getCommunity();
		if (comm == null) {

		} else {
			searchParams.put("EQ_community.id", comm.getId() + "");
		}
		// 报修人
		if (searchParams.containsKey("LIKE_name")) {
			String realName = (String) searchParams.get("LIKE_name");
			if (realName == null || "".equals(realName.trim())) {
				searchParams.remove("LIKE_name");
			}
		}
		// 社区
		if (searchParams.containsKey("EQ_community.id")) {
			String commid = (String) searchParams.get("EQ_community.id");
			if (commid == null || "0".equals(commid.trim())) {
				searchParams.remove("EQ_community.id");
			}
		}
		// 状态
		if (searchParams.containsKey("EQ_state")) {
			String state = (String) searchParams.get("EQ_state");
			if (state == null || "0".equals(state.trim())) {
				searchParams.remove("EQ_state");
			}
		}
		// 创建时间1
		if (searchParams.containsKey("GTE_createtime")) {
			String starttime = (String) searchParams.get("GTE_createtime");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			try {
				Date startDate = sdf.parse(starttime);
				Calendar cal = Calendar.getInstance();
				cal.setTime(startDate);
				searchParams.put("GTE_createtime", cal.getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if (starttime == null || "".equals(starttime.trim())) {
				searchParams.remove("GTE_createtime");
			}
		}
		// 创建时间2
		if (searchParams.containsKey("LTE_createtime")) {// 按照捐献结束时间查找
			String endtime = (String) searchParams.get("LTE_createtime");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			try {
				Date endDate = sdf.parse(endtime);
				Calendar cal = Calendar.getInstance();
				cal.setTime(endDate);
				cal.add(Calendar.HOUR, +24);
				searchParams.put("LTE_createtime", cal.getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if (endtime == null || "".equals(endtime.trim())) {
				searchParams.remove("LTE_createtime");
			}
		}

		Page<Sq_Repair> repair = repairService.getRepairList(searchParams, pageNumber, pageSize, sortType);
		return repair;
	}

	@RequestMapping(value = "/showdetail/{sid}")
	@ResponseBody
	public Map<String, Object> showDetail(@PathVariable(value = "sid") Long sid) {
		Map<String, Object> map = new HashMap<String, Object>();

		Sq_Repair sr = repairService.get(sid);
		if (sr != null) {
			map.put("result", "1");
			map.put("data", sr);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/*
	 * @RequestMapping(value="showdetail/{sid}") public String
	 * showDetail(@PathVariable(value="sid") Long sid, Model model) {
	 * 
	 * Sq_Repair sr = repairService.get(sid); model.addAttribute("repair", sr);
	 * 
	 * return "wuye/repairdetail"; }
	 */

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = repairService.delete(ids);
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	@RequestMapping(value = "/inprogress", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> inProgress(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();

		StringBuilder sb1 = new StringBuilder(); // 未解决 state == 1
		StringBuilder sb2 = new StringBuilder(); // 处理中 state == 2
		StringBuilder sb3 = new StringBuilder(); // 暂不解决 state == 3
		StringBuilder sb4 = new StringBuilder(); // 已解决 state == 4

		StringBuilder sbnull = new StringBuilder(); // state为null的情况

		String[] id = ids.split("\\|");
		for (String i : id) {
			Sq_Repair rep = repairService.get(Long.valueOf(i));
			Integer state = rep.getState();
			if (state != null) {
				if (state == 1) {
					sb1.append("," + rep.getName());
				} else if (state == 2) {
					sb2.append("," + rep.getName());
				} else if (state == 3) {
					sb3.append("," + rep.getName());
				} else if (state == 4) {
					sb4.append("," + rep.getName());
				} else {

				}
			} else {
				sbnull.append("," + rep.getName());
			}
		}

		StringBuilder sbmsg = new StringBuilder();
		/*
		 * if(!"".equals(sb1.toString())) { sbmsg.append(sb1.substring(1) +
		 * sbnull.toString() +
		 * " 提交的报修的状态将由 <span style=\"color:red;\">未解决</span> 转变为  <span style=\"color:orange;\">处理中</span><br/>"
		 * ); }
		 */

		if (!"".equals(sb2.toString())) {
			sbmsg.append(sb2.substring(1) + " 提交的报修的状态已经是  <span style=\"color:orange;\">处理中</span><br/>");
		}

		/*
		 * if(!"".equals(sb3.toString())) { sbmsg.append(sb3.substring(1) +
		 * " 提交的报修的状态将由 <span style=\"color:grey;\">暂不解决</span> 转变为  <span style=\"color:orange;\">处理中</span><br/>"
		 * ); }
		 */

		if (!"".equals(sb4.toString())) {
			sbmsg.append(sb4.substring(1)
					+ " 提交的报修的状态为 <span style=\"color:green;\">已解决</span> 不能转变为  <span style=\"color:orange;\">处理中</span><br/>");
		}

		map.put("sbmsg", sbmsg.toString());

		return map;

	}

	@RequestMapping(value = "/sureinprogress", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sureInProgress(@RequestParam(value = "ids") String ids, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();

		StringBuilder sb1 = new StringBuilder(); // 未解决 state == 1
		StringBuilder sb2 = new StringBuilder(); // 处理中 state == 2
		StringBuilder sb3 = new StringBuilder(); // 暂不解决 state == 3
		StringBuilder sb4 = new StringBuilder(); // 已解决 state == 4

		StringBuilder sbnull = new StringBuilder(); // state为null的情况

		String[] id = ids.split("\\|");
		for (String i : id) {
			Sq_Repair rep = repairService.get(Long.valueOf(i));
			Integer state = rep.getState();
			if (state != null) {
				if (state == 1) {
					sb1.append("," + rep.getId());
					rep.setState(2);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 2) {
					sb2.append("," + rep.getId());
				} else if (state == 3) {
					sb3.append("," + rep.getId());
					rep.setState(2);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 4) {
					sb4.append("," + rep.getId());
				} else {

				}
			} else {
				sbnull.append("," + rep.getId());
				rep.setState(2);
				rep.setUser(user);
				repairService.save(rep);
			}
		}

		String changeids = "";

		if (!"".equals(sb1.toString())) {
			changeids += sb1.toString();
		}

		if (!"".equals(sb3.toString())) {
			changeids += sb3.toString();
		}

		if (!"".equals(sbnull.toString())) {
			changeids += sbnull.toString();
		}

		map.put("result", "1");
		if (!"".equals(changeids)) {
			map.put("changeids", changeids.substring(1));
		} else {
			map.put("changeids", "");
		}

		return map;

	}

	@RequestMapping(value = "/solved", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> solved(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();

		StringBuilder sb1 = new StringBuilder(); // 未解决 state == 1
		StringBuilder sb2 = new StringBuilder(); // 处理中 state == 2
		StringBuilder sb3 = new StringBuilder(); // 暂不解决 state == 3
		StringBuilder sb4 = new StringBuilder(); // 已解决 state == 4

		StringBuilder sbnull = new StringBuilder(); // state为null的情况

		String[] id = ids.split("\\|");
		for (String i : id) {
			Sq_Repair rep = repairService.get(Long.valueOf(i));
			Integer state = rep.getState();
			if (state != null) {
				if (state == 1) {
					sb1.append("," + rep.getName());
				} else if (state == 2) {
					sb2.append("," + rep.getName());
				} else if (state == 3) {
					sb3.append("," + rep.getName());
				} else if (state == 4) {
					sb4.append("," + rep.getName());
				} else {

				}
			} else {
				sbnull.append("," + rep.getName());
			}
		}

		StringBuilder sbmsg = new StringBuilder();
		/*
		 * if(!"".equals(sb1.toString())) { sbmsg.append(sb1.substring(1) +
		 * sbnull.toString() +
		 * " 提交的报修的状态将由 <span style=\"color:red;\">未解决</span> 转变为  <span style=\"color:orange;\">处理中</span><br/>"
		 * ); }
		 */

		/*
		 * if(!"".equals(sb2.toString())) { sbmsg.append(sb2.substring(1) +
		 * " 提交的报修的状态已经是  <span style=\"color:orange;\">处理中</span><br/>"); }
		 */

		/*
		 * if(!"".equals(sb3.toString())) { sbmsg.append(sb3.substring(1) +
		 * " 提交的报修的状态将由 <span style=\"color:grey;\">暂不解决</span> 转变为  <span style=\"color:orange;\">处理中</span><br/>"
		 * ); }
		 */

		if (!"".equals(sb4.toString())) {
			sbmsg.append(sb4.substring(1) + " 提交的报修的状态已经是  <span style=\"color:green;\">已解决</span><br/>");
		}

		map.put("sbmsg", sbmsg.toString());

		return map;

	}

	@RequestMapping(value = "/suresolved", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sureSolved(@RequestParam(value = "ids") String ids, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();

		StringBuilder sb1 = new StringBuilder(); // 未解决 state == 1
		StringBuilder sb2 = new StringBuilder(); // 处理中 state == 2
		StringBuilder sb3 = new StringBuilder(); // 暂不解决 state == 3
		StringBuilder sb4 = new StringBuilder(); // 已解决 state == 4

		StringBuilder sbnull = new StringBuilder(); // state为null的情况

		String[] id = ids.split("\\|");
		for (String i : id) {
			Sq_Repair rep = repairService.get(Long.valueOf(i));
			Integer state = rep.getState();
			if (state != null) {
				if (state == 1) {
					sb1.append("," + rep.getId());
					rep.setState(4);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 2) {
					sb2.append("," + rep.getId());
					rep.setState(4);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 3) {
					sb3.append("," + rep.getId());
					rep.setState(4);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 4) {
					sb4.append("," + rep.getId());
				} else {

				}
			} else {
				sbnull.append("," + rep.getId());
				rep.setState(4);
				rep.setUser(user);
				repairService.save(rep);
			}
		}

		String changeids = "";

		if (!"".equals(sb1.toString())) {
			changeids += sb1.toString();
		}

		if (!"".equals(sb2.toString())) {
			changeids += sb2.toString();
		}

		if (!"".equals(sb3.toString())) {
			changeids += sb3.toString();
		}

		if (!"".equals(sbnull.toString())) {
			changeids += sbnull.toString();
		}

		map.put("result", "1");
		if (!"".equals(changeids)) {
			map.put("changeids", changeids.substring(1));
		} else {
			map.put("changeids", "");
		}

		return map;

	}

	@RequestMapping(value = "/nosolved", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> nosolved(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();

		StringBuilder sb1 = new StringBuilder(); // 未解决 state == 1
		StringBuilder sb2 = new StringBuilder(); // 处理中 state == 2
		StringBuilder sb3 = new StringBuilder(); // 暂不解决 state == 3
		StringBuilder sb4 = new StringBuilder(); // 已解决 state == 4

		StringBuilder sbnull = new StringBuilder(); // state为null的情况

		String[] id = ids.split("\\|");
		for (String i : id) {
			Sq_Repair rep = repairService.get(Long.valueOf(i));
			Integer state = rep.getState();
			if (state != null) {
				if (state == 1) {
					sb1.append("," + rep.getName());
				} else if (state == 2) {
					sb2.append("," + rep.getName());
				} else if (state == 3) {
					sb3.append("," + rep.getName());
				} else if (state == 4) {
					sb4.append("," + rep.getName());
				} else {

				}
			} else {
				sbnull.append("," + rep.getName());
			}
		}

		StringBuilder sbmsg = new StringBuilder();
		/*
		 * if(!"".equals(sb1.toString())) { sbmsg.append(sb1.substring(1) +
		 * sbnull.toString() +
		 * " 提交的报修的状态将由 <span style=\"color:red;\">未解决</span> 转变为  <span style=\"color:orange;\">处理中</span><br/>"
		 * ); }
		 */

		/*
		 * if(!"".equals(sb2.toString())) { sbmsg.append(sb2.substring(1) +
		 * " 提交的报修的状态已经是  <span style=\"color:orange;\">处理中</span><br/>"); }
		 */

		if (!"".equals(sb3.toString())) {
			sbmsg.append(sb3.substring(1) + "  提交的报修的状态已经是  <span style=\"color:grey;\">暂不解决</span><br/>");
		}

		if (!"".equals(sb4.toString())) {
			sbmsg.append(sb4.substring(1)
					+ " 提交的报修的状态为 <span style=\"color:green;\">已解决</span> 不能转变为  <span style=\"color:grey;\">暂不解决</span><br/>");
		}

		map.put("sbmsg", sbmsg.toString());

		return map;

	}

	@RequestMapping(value = "/surenosolved", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sureNoSolved(@RequestParam(value = "ids") String ids, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();

		StringBuilder sb1 = new StringBuilder(); // 未解决 state == 1
		StringBuilder sb2 = new StringBuilder(); // 处理中 state == 2
		StringBuilder sb3 = new StringBuilder(); // 暂不解决 state == 3
		StringBuilder sb4 = new StringBuilder(); // 已解决 state == 4

		StringBuilder sbnull = new StringBuilder(); // state为null的情况

		String[] id = ids.split("\\|");
		for (String i : id) {
			Sq_Repair rep = repairService.get(Long.valueOf(i));
			Integer state = rep.getState();
			if (state != null) {
				if (state == 1) {
					sb1.append("," + rep.getId());
					rep.setState(3);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 2) {
					sb2.append("," + rep.getId());
					rep.setState(3);
					rep.setUser(user);
					repairService.save(rep);
				} else if (state == 3) {
					sb3.append("," + rep.getId());
				} else if (state == 4) {
					sb4.append("," + rep.getId());
				} else {

				}
			} else {
				sbnull.append("," + rep.getId());
				rep.setState(3);
				rep.setUser(user);
				repairService.save(rep);
			}
		}

		String changeids = "";

		if (!"".equals(sb1.toString())) {
			changeids += sb1.toString();
		}

		if (!"".equals(sb2.toString())) {
			changeids += sb2.toString();
		}

		if (!"".equals(sbnull.toString())) {
			changeids += sbnull.toString();
		}

		map.put("result", "1");
		if (!"".equals(changeids)) {
			map.put("changeids", changeids.substring(1));
		} else {
			map.put("changeids", "");
		}

		return map;

	}

}
