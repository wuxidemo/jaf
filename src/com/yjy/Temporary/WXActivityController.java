package com.yjy.Temporary;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.Temporary.entity.Popularity;
import com.yjy.Temporary.entity.Servey;
import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.entity.ShareRedbagRecord;
import com.yjy.Temporary.entity.TicketRecord;
import com.yjy.Temporary.entity.WinningRecord;
import com.yjy.Temporary.service.ActService;
import com.yjy.Temporary.service.ActcardrecordService;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.ServeyService;
import com.yjy.Temporary.service.ShareRecordService;
import com.yjy.Temporary.service.ShareRedbagRecordService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.Temporary.service.WinningRecordService;
import com.yjy.entity.WXUser;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.IpUtils;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/wxact")
public class WXActivityController {

	@Autowired
	PopularityService popularityService;
	@Autowired
	WXUserService wXUserService;
	@Autowired
	TicketRecordService ticketRecordService;
	@Autowired
	WinningRecordService winningRecordService;
	@Autowired
	ShareRecordService shareRecordService;
	@Autowired
	ShareRedbagRecordService shareRedbagRecordService;
	@Autowired
	PopularityRecordService popularityRecordService;
	@Autowired
	ActService actService;
	@Autowired
	ServeyService serveyService;
	@Autowired
	ActcardrecordService actcardrecordService;
	@Autowired
	WeChatAccountService weChatAccountService;
	public static int COUNT = 2744;

	/**
	 * 
	 * 人气值活动入口
	 * 
	 * @author lyf
	 * @date 2015年10月17日 上午9:46:19
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/poact")
	public String popularityAct(Model model, HttpServletRequest request) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:sss");
		System.out.println(sdf.format(new Date()));
		Object openid = request.getSession().getAttribute("openid");
		model.addAttribute("actstate", actService.isRQZ() ? 1 : 0);
		if (openid != null) {
			List<WinningRecord> lw = winningRecordService.getByOpenidType(openid.toString(), "rqzhd");
			if (lw.size() > 0) {
				model.addAttribute("wr", lw.get(0));
				return "temporary/poactwin";
			}

			model.addAttribute("openid", openid.toString());
			model.addAttribute("url", SysConfig.BASEURL + "/wxact/showgzh/" + openid.toString());
			Popularity myp = popularityService.getByOpenid(openid.toString());
			int count = (myp == null ? 0 : myp.getTotalscore());
			model.addAttribute("count", count);
			if (count != 0) {
				model.addAttribute("rank", popularityService.getRankByOpenid(count, myp.getCreatetime()) + 1);
			}
			model.addAttribute("user", wXUserService.getUserByOpenid(openid.toString()));
		}
		model.addAttribute("top10", popularityService.getTop10By());
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/poact"));
		System.out.println(sdf.format(new Date()));
		return "temporary/poact";
	}

	/**
	 * 
	 * 人气值结果
	 * 
	 * @author lyf
	 * @date 2015年10月22日 下午4:01:36
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "poresult")
	public String PopularityActResult(Model model, HttpServletRequest request,
			@RequestParam(value = "kind", required = false) String kind) {
		if (kind != null) {
			List<Object[]> lw1 = winningRecordService.getByTypeWinname("rqzhd", 1);
			List<Object[]> lw2 = winningRecordService.getByTypeWinname("rqzhd", 2);
			List<Object[]> lw3 = winningRecordService.getByTypeWinnameTop90("rqzhd", 3);
			List<Object[]> lw4 = winningRecordService.getByTypeWinnameTop90("rqzhd", 4);
			model.addAttribute("lw1count", lw1.size());
			if (lw1.size() > 0)
				model.addAttribute("lw1", lw1.get(0));
			model.addAttribute("lw2count", lw2.size());
			if (lw2.size() > 0)
				model.addAttribute("lw2", lw2.get(0));
			model.addAttribute("lw3count", lw3.size());
			if (lw3.size() > 0)
				model.addAttribute("lw3", lw3);
			model.addAttribute("lw4count", lw4.size());
			if (lw4.size() > 0)
				model.addAttribute("lw4", lw4);
			return "temporary/poactresult";
		}
		List<WinningRecord> lw = winningRecordService
				.getByOpenidType(request.getSession().getAttribute("openid").toString(), "rqzhd");
		if (lw.size() == 0) {
			List<Object[]> lw1 = winningRecordService.getByTypeWinname("rqzhd", 1);
			List<Object[]> lw2 = winningRecordService.getByTypeWinname("rqzhd", 2);
			List<Object[]> lw3 = winningRecordService.getByTypeWinnameTop90("rqzhd", 3);
			List<Object[]> lw4 = winningRecordService.getByTypeWinnameTop90("rqzhd", 4);
			model.addAttribute("lw1count", lw1.size());
			model.addAttribute("lw1", lw1);
			model.addAttribute("lw2count", lw2.size());
			model.addAttribute("lw2", lw2);
			model.addAttribute("lw3count", lw3.size());
			model.addAttribute("lw3", lw3);
			model.addAttribute("lw4count", lw4.size());
			model.addAttribute("lw4", lw4);
			return "temporary/poactresult";
		} else {
			model.addAttribute("wr", lw.get(0));
			return "temporary/poactwin";
		}
	}

	@RequestMapping(value = "poshare/{openid}")
	@ResponseBody
	public String poshare(@PathVariable(value = "openid") String openid) {
		if (actService.isRQZ()) {
			if (popularityRecordService.getCountByOpenid(openid) == 0) {
				popularityService.add1Score(openid, openid);
				WXManage.SendMessage(weChatAccountService.getAccesstoken(), openid, "感谢您参加人气值活动,已获得人气值10分");
			}
		}
		return "1";
	}

	@RequestMapping(value = "savenum/{id}")
	public String savephonenum(@PathVariable(value = "id") Long id, @RequestParam(value = "num") String num,
			@RequestParam(value = "sub", required = false) Integer sub) {
		WinningRecord lw = winningRecordService.get(id);
		if (lw != null) {
			lw.setPhone(num);
			lw.setSubname(sub);
			winningRecordService.save(lw);
		}
		return "redirect:/wxact/poresult?kind=1";
	}

	/**
	 * 
	 * 人气值活动 带个人信息的关注二维码的页面
	 * 
	 * @author lyf
	 * @date 2015年10月17日 上午9:49:38
	 * @param openid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/showgzh/{id}")
	public String test2(@PathVariable(value = "id") String openid, Model model) {
		model.addAttribute("pic", WXManage.getLimitQRCode(weChatAccountService.getAccesstoken(),
				Long.parseLong("111000" + wXUserService.getOrNewWXUser(openid).getId())));
		return "temporary/showgzh";
	}

	// ------------------------------全城抽奖----------------------
	/**
	 * 
	 * 全城抽奖页面
	 * 
	 * @author lyf
	 * @date 2015年10月19日 上午9:28:30
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "luck")
	public String AllLuck(Model model, HttpServletRequest requset) {
		Object openid = requset.getSession().getAttribute("openid");
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/luck"));
		model.addAttribute("actstate", actService.isQCCJ() ? 1 : 0);
		String openidstr = openid.toString();
		if (openid != null) {
			List<WinningRecord> lw = winningRecordService.getByOpenidType(openid.toString(), "qccjhd");
			if (lw.size() > 0) {
				for (WinningRecord wr : lw) {
					int count = actcardrecordService.getCountByTrid(wr.getId());
					if (count < 0) {
						if (wr.getPhone() == null || wr.getPhone().equals("")) {
							model.addAttribute("wr", wr);
							return "temporary/drawcity2";
						} else {
							return "redirect:/wxact/luck";
						}
					} else {
						if ((wr.getWinname() == 1 || wr.getWinname() == 2 || wr.getWinname() == 3)) {
							model.addAttribute("wr", wr);
							// model.addAttribute("url",
							// actcardrecordService.getUrl(openid, "qccjhd",
							// wr.getId()));
							return "redirect:/wxact/myqccjcard";
						}
						if (wr.getPhone() == null || wr.getPhone().equals("")) {
							model.addAttribute("wr", wr);
							return "temporary/drawcity2";
						}
					}

					// if (wr.getWinname() == 1 || wr.getWinname() == 2 ||
					// wr.getWinname() == 3) {
					// model.addAttribute("wr", wr);
					// model.addAttribute("url",
					// actcardrecordService.getUrl(openidstr, "qccjhd",
					// wr.getId()));
					// return "temporary/drawcity";
					// }
					// if (wr.getPhone() == null || wr.getPhone().equals("")) {
					// model.addAttribute("wr", wr);
					// return "temporary/drawcity2";
					// }
				}
			}
		}
		// model.addAttribute("iswin",
		// winningRecordService.getCountByOpenidType(openid, "allluck") != 0);
		// // 是否已中奖
		int count = ticketRecordService.getCountByopenid(openid.toString());
		if (count == 3) {
			model.addAttribute("is3", true);
		} else {
			model.addAttribute("is3", false);
			model.addAttribute("count", 3 - count);
		}
		return "temporary/luck";
	}

	@RequestMapping(value = "listluck")
	public String listluck(Model model, HttpServletRequest requset) {
		Object openid = requset.getSession().getAttribute("openid");
		int count = ticketRecordService.getCountByopenid(openid.toString());
		if (count == 3) {
			model.addAttribute("is3", true);
		} else {
			model.addAttribute("is3", false);
			model.addAttribute("count", 3 - count);
		}
		if (openid != null) {
			List<WinningRecord> lw = winningRecordService.getByOpenidType(openid.toString(), "qccjhd");
			if (lw.size() > 0) {
				for (WinningRecord wr : lw) {
					if ((wr.getWinname() == 4 || wr.getWinname() == 5)
							&& (wr.getPhone() == null || wr.getPhone().equals(""))) {
						model.addAttribute("wr", wr);
						return "temporary/drawcity2";
					}
				}
			}
		}
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/listluck"));
		model.addAttribute("actstate", actService.isQCCJ() ? 1 : 0);
		return "temporary/luck";
	}

	@RequestMapping(value = "luckresult")
	public String luckresult(Model model) {
		String times = "";
		for (String str : winningRecordService.getTimes("qccjhd")) {
			times += str + ",";
		}
		if (times.endsWith(",")) {
			times = times.substring(0, times.length() - 1);
		}
		if (times.equals("")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			times = sdf.format(new Date());
		}
		model.addAttribute("times", times);
		return "temporary/luckresult";
	}

	@RequestMapping(value = "luckdata")
	@ResponseBody
	public Map<String, Object> getluckData(@RequestParam(value = "time") String time, HttpServletRequest request) {
		String openid = request.getSession().getAttribute("openid").toString();
		Map<String, Object> data = new HashMap<String, Object>();
		List<TicketRecord> lsr = ticketRecordService.getByTimeOpenid(time, openid);
		data.put("mys", lsr);
		data.put("jp1", winningRecordService.getListByData(time, "qccjhd", 1));
		data.put("jp2", winningRecordService.getListByData(time, "qccjhd", 2));
		data.put("jp3", winningRecordService.getListByData(time, "qccjhd", 3));
		data.put("jp4", winningRecordService.getListByData(time, "qccjhd", 4));
		data.put("jp5", winningRecordService.getListByData(time, "qccjhd", 5));
		List<WinningRecord> lwr = winningRecordService.getByTimeOpenidType(openid, "qccjhd", time);
		if (lwr.size() > 0) {
			data.put("myjp", lwr.get(0));
		} else {
			data.put("myjp", null);
		}
		return data;
	}

	/**
	 * 
	 * 添加抽奖记录
	 * 
	 * @author lyf
	 * @date 2015年10月19日 上午9:28:52
	 * @param request
	 * @param mid
	 * @return
	 */
	@RequestMapping(value = "saverecord")
	@ResponseBody
	public Map<String, String> saverecord(HttpServletRequest request, @RequestParam(value = "mid") String mid) {
		Object openid = request.getSession().getAttribute("openid");
		Map<String, String> result = new HashMap<String, String>();
		if (!actService.isQCCJ()) {
			result.put("result", "0");
			result.put("msg", "活动已结束");
			return result;
		}
		if (openid == null) {
			result.put("result", "-1");
			return result;
		}
		// if (winningRecordService.getCountByOpenidType(openid.toString(),
		// "allluck") != 0) {
		// result.put("result", "0");
		// result.put("msg", "您已中奖,把机会留给别人吧");
		// return result;
		// }
		int count = ticketRecordService.getCountByopenid(openid.toString());
		if (count == 3) {
			result.put("result", "0");
			result.put("msg", "上传机会已用完");
			return result;
		}
		Date now = new Date();
		TicketRecord tr = new TicketRecord();
		tr.setCreatetime(now);
		tr.setOpenid(openid.toString());
		tr.setName(wXUserService.getOrNewWXUser(openid.toString()).getRealname());
		tr.setState(1);
		tr.setUrl(mid);
		tr.setCode((now.getTime() + "").substring((now.getTime() + "").length() - 6) + Util.getRandomNumber(4));
		tr = ticketRecordService.save(tr);
		result.put("result", "1");
		result.put("luckid", tr.getCode());
		result.put("msg", "您已上传" + (count + 1) + "次" + (count == 2 ? "" : "，还有" + (3 - count - 1) + "次机会。"));
		return result;
	}

	/**
	 * 
	 * 分享活动获奖
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:23:48
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "luckwin")
	public String luckwin(HttpServletRequest request, Model model) {
		String openid = request.getSession().getAttribute("openid").toString();
		List<WinningRecord> lw = winningRecordService.getByOpenidType(openid, "qccjhd");
		if (lw.size() > 0) {
			for (WinningRecord wr : lw) {
				// 先判断，1，2，3等奖直接跳到领取页面
				int count = actcardrecordService.getCountByTrid(wr.getId());
				if (count <= 0) {
					if (wr.getPhone() == null || wr.getPhone().equals("")) {
						model.addAttribute("wr", wr);
						return "temporary/drawcity2";
					}
				}

			}
		}
		return "redirect:/wxact/listluck";
	}

	/**
	 * 
	 * 分享活动保存号码
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:37:05
	 * @param id
	 * @param num
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "lucksavenum")
	public String lucksavephonenum(@RequestParam(value = "id") Long id, @RequestParam(value = "num") String num,
			Model model) {
		WinningRecord lw = winningRecordService.get(id);
		if (lw != null) {
			lw.setPhone(num);
			winningRecordService.save(lw);
		}
		List<WinningRecord> lwr = winningRecordService.getByOpenidType(lw.getOpenid(), "qccjhd");
		if (lwr.size() > 0) {
			for (WinningRecord wr : lwr) {
				int count = actcardrecordService.getCountByTrid(wr.getId());
				if (count <= 0) {
					if (wr.getPhone() == null || wr.getPhone().equals("")) {
						model.addAttribute("wr", wr);
						return "temporary/drawcity2";
					}
				}
			}
		}
		return "redirect:/wxact/listluck";
	}
	// ----------------------------------------------------
	// ---------------分享活动---------------------

	/**
	 * 
	 * 分享入口
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:36:16
	 * @param model
	 * @param request
	 * @return
	 */
	// @RequestMapping(value = "share")
	// public String share(Model model, HttpServletRequest request) {
	// Object openid = request.getSession().getAttribute("openid");
	// model.addAttribute("state", actService.isGZFX());
	// if (openid != null)
	// model.addAttribute("openid", openid.toString());
	// model.addAttribute("config", WXManage.getConfig("/wxact/share"));
	// model.addAttribute("url", WXManage.BASEURL + "/wxact/sharecontent");
	// return "temporary/shareinfo";
	// }

	/**
	 * 
	 * 分享后业务
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:36:39
	 * @param openid
	 * @return
	 */
	// @RequestMapping(value = "shared/{openid}")
	// @ResponseBody
	// public Map<String, String> shared(@PathVariable(value = "openid") String
	// openid) {
	// boolean a =true;
	// Map<String, String> result = new HashMap<String, String>();
	// if (actService.isGZFX()) {
	// // 是否分享过
	// boolean isluck = shareRecordService.JudgeLuck(openid);
	// WXUser wu = wXUserService.getOrNewWXUser(openid);
	// if (isluck) {
	// ShareRecord sr = new ShareRecord();
	// sr.setCreatetime(new Date());
	// sr.setName(wu.getRealname());
	// sr.setOpenid(openid);
	// sr.setState(1);
	// sr = shareRecordService.save(sr);
	// result.put("luck", sr.getId().toString());
	// }
	//
	// // boolean isredbag = shareRecordService.JudgeRedbag(openid);
	// boolean isMycount = shareRecordService.getIsCountByOpenid(openid);
	// boolean isAllcount = shareRecordService.getIsCountBytime();
	// if (isMycount && isAllcount) {
	// Date now = new Date();
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	// String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime()
	// + "").substring(2, 12);
	// ShareRedbagRecord srr = new ShareRedbagRecord();
	// if (a/*WXManage.sendPrize(WXManage.WCA, openid, 100, "请关注其他活动", "备注",
	// "金阿福", "金阿福e服务", "关注分享红包", billno)*/) {
	// srr.setState(1);
	// result.put("redbag", "1");
	// } else {
	// srr.setState(2);
	// result.put("redbag", "2");
	// }
	// srr.setBillno(billno);
	// srr.setCreatetime(new Date());
	// srr.setOpenid(openid);
	// srr.setName(wu.getRealname());
	// srr.setPrice(100);
	//
	// shareRedbagRecordService.save(srr);
	//
	// } else if (!isMycount) {
	// result.put("ismycount", "1");
	// } else if (!isAllcount) {
	// result.put("isAllcount", "1");
	// }
	// } else {
	// result.put("over", "1");
	// }
	// return result;
	// }

	/**
	 * 
	 * 分享活动获奖
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:23:48
	 * @param request
	 * @param model
	 * @return
	 */
	// @RequestMapping(value = "sharewin")
	// public String sharewin(HttpServletRequest request, Model model) {
	// String openid = request.getSession().getAttribute("openid").toString();
	// List<WinningRecord> lw = winningRecordService.getByOpenidType(openid,
	// "gzfxhd");
	// if (lw.size() > 0) {
	// for (WinningRecord wr : lw) {
	// if (wr.getPhone() == null || wr.getPhone().equals("")) {
	// model.addAttribute("wr", wr);
	// return "temporary/attshare";
	// }
	// }
	// }
	// return "redirect:/wxact/share";
	// }

	/**
	 * 
	 * 分享活动保存号码
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:37:05
	 * @param id
	 * @param num
	 * @param model
	 * @return
	 */
	// @RequestMapping(value = "sharesavenum")
	// public String sharesavephonenum(@RequestParam(value = "id") Long id,
	// @RequestParam(value = "num") String num,
	// Model model) {
	// WinningRecord lw = winningRecordService.get(id);
	// if (lw != null) {
	// lw.setPhone(num);
	// winningRecordService.save(lw);
	// }
	// List<WinningRecord> lwr =
	// winningRecordService.getByOpenidType(lw.getOpenid(), "gzfxhd");
	// if (lwr.size() > 0) {
	// for (WinningRecord wr : lwr) {
	// if (wr.getPhone() == null || wr.getPhone().equals("")) {
	// model.addAttribute("wr", wr);
	// return "temporary/attshare";
	// }
	// }
	// }
	// return "redirect:/wxact/share";
	// }

	/**
	 * 
	 * 分享出来的内容
	 * 
	 * @author lyf
	 * @date 2015年10月27日 下午1:37:34
	 * @param model
	 * @param request
	 * @return
	 */
	// @RequestMapping(value = "sharecontent")
	// public String shareContent(Model model, HttpServletRequest request) {
	// Map<String, String[]> map = request.getParameterMap();
	// String keys = "";
	// for (String key : map.keySet()) {
	// keys += key + "=" + map.get(key)[0] + "&";
	// }
	// if (keys.endsWith("&")) {
	// keys = keys.substring(0, keys.length() - 1);
	// }
	// // System.out.println(keys);
	// model.addAttribute("config", WXManage.getConfig("/wxact/sharecontent" +
	// (keys.equals("") ? "" : ("?" + keys))));
	// return "temporary/sharecontent";
	// }

	// @RequestMapping(value = "shareresult")
	// public String shareresult(Model model) {
	// String times = "";
	// for (String str : winningRecordService.getTimes("gzfxhd")) {
	// times += str + ",";
	// }
	// if (times.endsWith(",")) {
	// times = times.substring(0, times.length() - 1);
	// }
	// if (times.equals("")) {
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// times = sdf.format(new Date());
	// }
	// model.addAttribute("times", times);
	// return "temporary/shareresult";
	// }

	// @RequestMapping(value = "sharedata")
	// @ResponseBody
	// public Map<String, Object> getShareData(@RequestParam(value = "time")
	// String time, HttpServletRequest request) {
	// String openid = request.getSession().getAttribute("openid").toString();
	// Map<String, Object> data = new HashMap<String, Object>();
	// List<ShareRecord> lsr = shareRecordService.getByTimeOpenid(time, openid);
	// if (lsr.size() > 0) {
	// data.put("mys", lsr.get(0));
	// } else {
	// data.put("mys", null);
	// }
	// data.put("jp1", winningRecordService.getListByData(time, "gzfxhd", 1));
	// data.put("jp2", winningRecordService.getListByData(time, "gzfxhd", 2));
	// data.put("jp3", winningRecordService.getListByData(time, "gzfxhd", 3));
	// List<WinningRecord> lwr =
	// winningRecordService.getByTimeOpenidType(openid, "gzfxhd", time);
	// if (lwr.size() > 0) {
	// data.put("myjp", lwr.get(0));
	// } else {
	// data.put("myjp", null);
	// }
	// return data;
	// }

	// -----------------------------------------

	/***************************************** 调查问卷 **************************************************/

	@RequestMapping(value = "servey")
	public String servey(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/servey"));
		Object openid = request.getSession().getAttribute("openid");
		Servey servey = serveyService.findByOpenid(openid.toString());

		int wuxicount = serveyService.countTotalWuxi();
		System.out.println(wuxicount);
		System.out.println(COUNT);

		if (servey != null) {
			if (servey.getPhone() == null) {
				return "temporary/datifail";
			} else {
				if (servey.getWuxi() == 1) {
					model.addAttribute("servey", servey);
					return "temporary/datidonenew";
				} else {
					return "temporary/datifail";
				}
			}

		} else {
			return "temporary/datifail";
		}

		/*
		 * if(wuxicount >= COUNT) { if(wuxicount == COUNT) { if(servey != null)
		 * { if(servey.getPhone() == null) { return "temporary/datiphonenew";
		 * }else{ if (servey.getWuxi() == 1) { model.addAttribute("servey",
		 * servey); return "temporary/datidonenew"; } else { return
		 * "temporary/datimainnew2"; } }
		 * 
		 * }else{ return "temporary/datimainnew"; } }else{ return
		 * "temporary/datifail"; }
		 * 
		 * }else{
		 * 
		 * if(servey != null) { if(servey.getPhone() == null) { return
		 * "temporary/datiphonenew"; }else{ if (servey.getWuxi() == 1) {
		 * model.addAttribute("servey", servey); return "temporary/datidonenew";
		 * } else { return "temporary/datimainnew2"; } }
		 * 
		 * }else{ return "temporary/datimainnew"; }
		 * 
		 * 
		 * }
		 */

		/*
		 * if (servey != null) {
		 * 
		 * int dbcount = serveyService.idLessCount(servey.getId()); String
		 * serphone = servey.getPhone(); if (serphone != null) { int wuxi =
		 * servey.getWuxi(); if (wuxi == 1) { model.addAttribute("servey",
		 * servey); return "temporary/datidonenew"; } else { return
		 * "temporary/datimainnew2"; }
		 * 
		 * } else { if (dbcount < COUNT) { return "temporary/datiphonenew"; }
		 * else { return "temporary/datifail"; } }
		 * 
		 * 
		 * 
		 * } else { return "temporary/datimainnew"; }
		 */
	}

	@RequestMapping(value = "saveopenid")
	@ResponseBody
	public Map<String, Object> saveOpenid(Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		Object openid = request.getSession().getAttribute("openid");

		int wuxicount = serveyService.countTotalWuxi();
		int total = serveyService.getTotalCount();

		WXUser wxuser = wXUserService.getUserByOpenid(openid.toString());
		Servey servey = serveyService.findByOpenid(openid.toString());

		if (wuxicount >= COUNT) {
			map.put("result", "0");
			map.put("url", "wxact/datifail");
			return map;
		} else {

			if (servey != null) {
				if (servey.getPhone() == null) {
					map.put("result", "0");
					map.put("url", "wxact/givephone");
					return map;
				} else {
					if (servey.getWuxi() == 1) {
						map.put("result", "0");
						map.put("url", "wxact/servey");
						return map;
					} else {
						map.put("result", "0");
						map.put("url", "wxact/datimainnew2");
						return map;
					}
				}
			} else {
				servey = new Servey();
				servey.setNickname(wxuser.getRealname());
				servey.setOpenid(openid.toString());
				servey.setPhone(null);
				servey.setSend(0);
				servey.setActtime(null);
				servey.setWuxi(0);
				servey.setRank(total + 1);
				servey.setRemark(null);
				serveyService.save(servey);

				map.put("result", "1");
				map.put("msg", "提交成功");
				boolean flag = wuxicount < COUNT;
				map.put("flag", flag);
				return map;
			}

		}

		/*
		 * if (servey != null) { int dbcount =
		 * serveyService.idLessCount(servey.getId()); if (servey.getPhone() ==
		 * null) { if (dbcount < COUNT) { map.put("result", "0"); map.put("url",
		 * "wxact/givephone"); return map; } else { map.put("result", "0");
		 * map.put("url", "wxact/datifail"); return map; } } else {
		 * map.put("result", "0"); map.put("url", "wxact/servey"); return map; }
		 * } servey = new Servey(); servey.setNickname(wxuser.getRealname());
		 * servey.setOpenid(openid.toString()); servey.setPhone(null);
		 * servey.setSend(0); servey.setActtime(null); servey.setWuxi(0);
		 * servey.setRank(total + 1); servey.setRemark(null);
		 * serveyService.save(servey);
		 * 
		 * map.put("result", "1"); map.put("msg", "提交成功"); boolean flag = total
		 * < COUNT; map.put("flag", flag); return map;
		 */
	}

	@RequestMapping(value = "datifail")
	public String datiFail(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/datifail"));
		return "temporary/datifail";
	}

	@RequestMapping(value = "seemy")
	public String seeMy(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/seemy"));
		return "temporary/datimynew";
	}

	@RequestMapping(value = "startanswer")
	public String startAnswer(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/startanswer"));
		return "temporary/datinew";
	}

	@RequestMapping(value = "checkcount")
	@ResponseBody
	public Map<String, Object> checkPhone() {
		Map<String, Object> map = new HashMap<String, Object>();
		int wuxicount = serveyService.countTotalWuxi();
		if (wuxicount >= COUNT) {
			map.put("result", "0");
			map.put("msg", "亲，来晚了哦，话费已被抢完了");
		} else {
			map.put("result", "1");
		}
		return map;
	}

	@RequestMapping(value = "givephone")
	public String givePhone(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/givephone"));
		return "temporary/datiphonenew";
	}

	@RequestMapping(value = "checkphone")
	@ResponseBody
	public Map<String, Object> checkPhone(@RequestParam(value = "phone") String phone, Model model,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		Servey servey = serveyService.findByPhone(phone);
		if (servey != null) {
			map.put("result", "0");
			map.put("msg", "该手机号码已参与过活动，不能重复参加");
		} else {
			map.put("result", "1");
		}
		return map;
	}

	@RequestMapping(value = "subphone")
	@ResponseBody
	public Map<String, Object> subPhone(@RequestParam(value = "phone") String phone, Model model,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		Object openid = request.getSession().getAttribute("openid");
		Servey check = serveyService.findByOpenid(openid.toString());

		String result = Util.getYYS(phone);
		if (result != null && !result.trim().equals("")) {
			if (result.indexOf("无锡") >= 0) {

				check.setActtime(new Date());
				check.setPhone(phone);
				check.setWuxi(1);
				serveyService.save(check);
				map.put("result", "1");
				map.put("msg", "保存成功");

				return map;

			} else {

				check.setActtime(new Date());
				check.setPhone(phone);
				check.setWuxi(0);
				serveyService.save(check);

				map.put("result", "2");
				map.put("msg", "只支持无锡地区的手机号码");
				return map;
			}
		} else {
			map.put("result", "0");
			map.put("data", "系统错误，请重试");
			return map;
		}

	}

	@RequestMapping(value = "thankyou")
	public String givePhone(@RequestParam(value = "phone") String phone, Model model, HttpServletRequest request) {
		model.addAttribute("phone", phone);
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/thankyou"));
		return "temporary/datithanknew";
	}

	@RequestMapping(value = "checkdone")
	@ResponseBody
	public Map<String, Object> checkDone(Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		Object openid = request.getSession().getAttribute("openid");
		Servey servey = serveyService.findByOpenid(openid.toString());
		if (servey != null) {
			if (servey.getPhone() != null) {
				map.put("result", "0");
			} else {
				map.put("result", "1");
			}
		} else {
			map.put("result", "1");
		}
		return map;
	}

	@RequestMapping(value = "getph")
	public String getPh() {
		return "wxmerchant/phonelocation";
	}

	@RequestMapping(value = "phlocation")
	@ResponseBody
	public Map<String, Object> phLocation(@RequestParam(value = "phone") String phone) {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = Util.getYYS(phone);
		if (result != null && !result.trim().equals("")) {
			if (result.indexOf("无锡") >= 0) {
				map.put("result", "1");
				map.put("msg", "定位地点在无锡");
			} else {
				map.put("result", "2");
				map.put("msg", "不是无锡的号码");
			}
		} else {
			map.put("result", "0");
			map.put("data", "位置未知");
		}
		return map;
	}

	/*********************************************************************************************************/

	/*******************************
	 * 抢钱，约吗
	 ********************************************************/

	@RequestMapping(value = "robmoney")
	public String robMoney() {
		return "temporary/robmoney";
	}

	/*********************************************************************************************************/

	@RequestMapping(value = "yhh")
	public String aaa(Model model) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxact/yhh"));
		return "wxmerchant/youhui";
	}

	@RequestMapping(value = "getarea")
	@ResponseBody
	public Map<String, Object> getArea(@RequestParam(value = "lat") Float lat, @RequestParam(value = "lon") Float lon) {

		Map<String, Object> map = new HashMap<String, Object>();
		String result = IpUtils.getLocation(lat, lon);

		try {
			JSONObject jodata = new JSONObject(result);
			String statusstr = jodata.getString("status");

			if ("OK".equals(statusstr)) {

				String weizhi = jodata.getString("result");

				JSONObject address = new JSONObject(weizhi);
				String addressstr = address.getString("addressComponent");
				String citycode = address.getString("cityCode");

				JSONObject city = new JSONObject(addressstr);
				String citystr = city.getString("city");

				if ("317".equals(citycode) && citystr.indexOf("无锡") >= 0) {
					map.put("result", "1");
					map.put("msg", "定位成功");
					return map;
				} else if (citystr.indexOf("江阴") >= 0) {
					map.put("result", "1");
					map.put("msg", "定位成功");
					return map;
				} else if (citystr.indexOf("宜兴") >= 0) {
					map.put("result", "1");
					map.put("msg", "定位成功");
					return map;
				} else {
					map.put("result", "2");
					map.put("msg", "您的位置不在无锡市");
					return map;
				}
			} else {
				map.put("result", "0");
				map.put("msg", "获取位置信息失败");
				return map;
			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "获取位置信息失败");
			return map;
		}

	}

	@RequestMapping(value = "myqccjcard")
	public String myQCCJCard(Model model, HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");

		// 获取微信头像 和微信名称
		WXUser wxuser = wXUserService.getOrNewWXUser(openid.toString());
		model.addAttribute("url", wxuser.getHeadimgurl());
		model.addAttribute("name", wxuser.getRealname());

		/*
		 * model.addAttribute("cards",
		 * actcardrecordService.getListByOpenidAct(openid.toString(),
		 * "qccjhd"));
		 */

		model.addAttribute("cards", actcardrecordService.getListByOpenidAct2(openid.toString(), "qccjhd"));

		return "temporary/myrecord";
	}
}
