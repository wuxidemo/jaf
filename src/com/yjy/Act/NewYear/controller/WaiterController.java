package com.yjy.Act.NewYear.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Act.NewYear.entity.Vote;
import com.yjy.Act.NewYear.entity.Waiter;
import com.yjy.Act.NewYear.entity.WaiterRedbag;
import com.yjy.Act.NewYear.entity.Waiterth;
import com.yjy.Act.NewYear.entity.WaiterthRedbag;
import com.yjy.Act.NewYear.service.VoteService;
import com.yjy.Act.NewYear.service.WaiterRedbagService;
import com.yjy.Act.NewYear.service.WaiterService;
import com.yjy.Act.NewYear.service.WaiterthRedbagService;
import com.yjy.Act.NewYear.service.WaiterthService;
import com.yjy.Temporary.entity.tmphb;
import com.yjy.Temporary.service.tmphbService;
import com.yjy.entity.WXUser;
import com.yjy.entity.WeChatAccount;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.IpUtils;
import com.yjy.utils.Util;
import com.yjy.utils.wxytConfig;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

@Controller
@RequestMapping(value = "/waiter")
public class WaiterController {

	@Autowired
	WXUserService wXUserService;

	@Autowired
	WaiterService waiterService;

	@Autowired
	WaiterthService waiterthService;

	@Autowired
	WaiterRedbagService waiterRedbagService;

	@Autowired
	WaiterthRedbagService waiterthRedbagService;

	@Autowired
	VoteService voteService;
	@Autowired
	tmphbService tmphbService;
	@Autowired
	WeChatAccountService weChatAccountService;
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	public static int PROBABILITY = 20;

	@RequestMapping(method = RequestMethod.GET)
	public String main(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/waiter/"));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=waiter/";
		}

		int state = voteService.getWaiterStage();

		if (state == 1) {
			Waiter waiter = waiterService.findByOpenid(openid.toString());
			if (waiter == null) {
				model.addAttribute("state", 1);
			} else {
				model.addAttribute("state", 2);
			}
		} else if (state >= 2) {
			model.addAttribute("state", state + 1);
		}

		return "newyear/start";
	}

	/**
	 * 根据openid判断用户是否关注了金阿福e服务公众号
	 * 
	 * @author yigang
	 * @date 2015年12月18日 下午2:29:47
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "checkfocus")
	@ResponseBody
	public Map<String, Object> checkFocus(@RequestParam(value = "param", required = false) Long param,
			HttpServletRequest request) {

		System.out.println(param);

		Map<String, Object> map = new HashMap<String, Object>();

		String qrurl = null;

		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			qrurl = WXManage.getLimitQRCode(weChatAccountService.getAccesstoken(), Long.valueOf(param));
			System.out.println(qrurl);
			map.put("result", "-1");
			map.put("msg", "无法获取用户信息");
			map.put("qrurl", qrurl);
			return map;
		}

		WXUser wxuser = wXUserService.getOrNewWXUser(openid.toString());
		if (wxuser != null && wxuser.getState() == 1) {
			map.put("result", "1");
			map.put("msg", "已关注");
		} else {
			qrurl = WXManage.getLimitQRCode(weChatAccountService.getAccesstoken(), Long.valueOf(param));
			map.put("result", "0");
			map.put("msg", "未关注");
			map.put("qrurl", qrurl);
		}

		return map;

	}

	@RequestMapping("/listwaiter")
	public String listWaiter(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_wxname")) {
			String wxname = ((String) searchParams.get("LIKE_wxname")).trim();
			if ("".equals(wxname) || "null".equals(wxname)) {
				searchParams.remove("LIKE_wxname");
			} else {
				searchParams.put("LIKE_wxname", wxname);
				model.addAttribute("LIKE_wxname", wxname);
			}
		}

		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime")).trim();
			if ("null".equals(startDate) || "".equals(startDate)) {
				searchParams.remove("GTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				searchParams.put("GTE_createtime", calendar.getTime());
				model.addAttribute("GTE_createtime", startDate);
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime")).trim();
			if ("null".equals(endDate) || "".equals(endDate)) {
				searchParams.remove("LTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_createtime", calendar.getTime());
				model.addAttribute("LTE_createtime", endDate);
			}
		}

		if (searchParams.containsKey("EQ_state")) {
			String state = ((String) searchParams.get("EQ_state")).trim();
			if ("".equals(state) || "null".equals(state) || "-1".equals(state)) {
				searchParams.remove("EQ_state");
			} else {
				searchParams.put("EQ_state", state);
				model.addAttribute("EQ_state", state);
			}
		}

		if (searchParams.containsKey("LIKE_name")) {
			String name = ((String) searchParams.get("LIKE_name")).trim();
			if ("".equals(name) || "null".equals(name)) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", name);
				model.addAttribute("LIKE_name", name);
			}
		}

		if (searchParams.containsKey("LIKE_mername")) {
			String mername = ((String) searchParams.get("LIKE_mername")).trim();
			if ("".equals(mername) || "null".equals(mername) || "-1".equals(mername)) {
				searchParams.remove("LIKE_mername");
			} else {
				searchParams.put("LIKE_mername", mername);
				model.addAttribute("LIKE_mername", mername);
			}
		}
		Page<Object[]> waiterlist = waiterService.getWaiterList(searchParams, pageNumber, pageSize, sortType);

		int votestage = voteService.getWaiterStage();
		model.addAttribute("actstage", votestage);

		int allwaiternum = waiterService.getAllWaiterCount();
		model.addAttribute("allwaiternum", allwaiternum);

		int allwaiterthnum = waiterthService.findDiffWaiterthCount();
		model.addAttribute("allwaiterthnum", allwaiterthnum);

		model.addAttribute("waiterlist", waiterlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "newyear/waiterlist";
	}

	@RequestMapping("/listwaiterthredbag")
	public String listWaiterthRedbag(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_nickname")) {
			String wxname = ((String) searchParams.get("LIKE_nickname")).trim();
			if ("".equals(wxname) || "null".equals(wxname)) {
				searchParams.remove("LIKE_nickname");
			} else {
				searchParams.put("LIKE_nickname", wxname);
				model.addAttribute("LIKE_nickname", wxname);
			}
		}

		if (searchParams.containsKey("EQ_createtime")) {
			String startDate = ((String) searchParams.get("EQ_createtime")).trim();
			if ("null".equals(startDate) || "".equals(startDate)) {
				searchParams.remove("EQ_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				searchParams.put("EQ_createtime", date);
				model.addAttribute("EQ_createtime", startDate);
			}
		}

		Page<WaiterthRedbag> waiterthredbaglist = waiterthRedbagService.getList(searchParams, pageNumber, pageSize,
				sortType);

		model.addAttribute("redbags", waiterthredbaglist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "newyear/waiterthredbaglist";
	}

	@RequestMapping("/listwaiterredbag")
	public String listWaiterRedbag(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_nickname")) {
			String wxname = ((String) searchParams.get("LIKE_nickname")).trim();
			if ("".equals(wxname) || "null".equals(wxname)) {
				searchParams.remove("LIKE_nickname");
			} else {
				searchParams.put("LIKE_nickname", wxname);
				model.addAttribute("LIKE_nickname", wxname);
			}
		}

		if (searchParams.containsKey("LIKE_mername")) {
			String mername = ((String) searchParams.get("LIKE_mername")).trim();
			if ("".equals(mername) || "null".equals(mername)) {
				searchParams.remove("LIKE_mername");
			} else {
				searchParams.put("LIKE_mername", mername);
				model.addAttribute("LIKE_mername", mername);
			}
		}

		if (searchParams.containsKey("EQ_createtime")) {
			String startDate = ((String) searchParams.get("EQ_createtime")).trim();
			if ("null".equals(startDate) || "".equals(startDate)) {
				searchParams.remove("EQ_createtime");
			} else {
				searchParams.put("EQ_createtime", startDate);
				model.addAttribute("EQ_createtime", startDate);
			}
		}

		Page<Object[]> waiterredbag = waiterRedbagService.getWaiterRedbagList(searchParams, pageNumber, pageSize,
				sortType);

		int newfocus = 0;
		int totalfocus = 0;
		float newredyes = 0.0f;
		float newredno = 0.0f;
		float todayred = 0.0f;
		float totalred = 0.0f;
		if (waiterredbag != null && waiterredbag.getContent().size() > 0) {
			for (Object[] obj : waiterredbag) {
				newfocus += Integer.valueOf(obj[3].toString());
				totalfocus += Integer.valueOf(obj[4].toString());
				newredyes += Float.valueOf(Integer.valueOf(obj[5].toString()) * 0.5f);
				newredno += Float.valueOf(obj[6].toString());
			}
		}
		todayred = newfocus * 0.5f;
		totalred = totalfocus * 0.5f;

		model.addAttribute("newfocus", newfocus);
		model.addAttribute("totalfocus", totalfocus);
		model.addAttribute("newredyes", newredyes);
		model.addAttribute("newredno", newredno);
		model.addAttribute("todayred", todayred);
		model.addAttribute("totalred", totalred);

		model.addAttribute("redbags", waiterredbag);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "newyear/waiterredbaglist";
	}

	/**
	 * 数据过来保存
	 */
	@RequestMapping(value = "/cersave")
	@ResponseBody
	public Map<String, Object> getsave(@Valid Waiter wtr, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getWaiterStage();
		if (a == 1) {
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");
			} else {
				Waiter waiter = waiterService.findByOpenid(oid);
				if (waiter == null) {
					wtr.setOpenid(oid);
					WXUser wxuser = wXUserService.getOrNewWXUser(oid);
					wtr.setWxname(wxuser.getRealname());
					wtr.setCreatetime(new Date());
					waiterService.save1(wtr);
					map.put("result", "1");
					map.put("msg", "保存成功");
				} else {
					map.put("result", "2");
					map.put("msg", "请勿重复上传");
				}
			}
		} else {
			map.put("result", "2");
			map.put("msg", "当前活动状态不正确");
		}
		return map;
	}

	/* 数据的修改保存 */
	@RequestMapping(value = "/upsave")
	@ResponseBody
	public Map<String, Object> getupsave(@Valid Waiter wtr, HttpServletRequest request) {
		String oid = (String) request.getSession().getAttribute("openid");
		Map<String, Object> map = new HashMap<String, Object>();
		int a = voteService.getWaiterStage();
		if (a == 1) {
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");
			} else {
				Waiter waiter = waiterService.findByOpenid(oid);
				waiter.setName(wtr.getName());
				waiter.setTelephone(wtr.getTelephone());
				waiter.setMername(wtr.getMername());
				waiter.setContext(wtr.getContext());
				waiter.setUrl(wtr.getUrl());
				waiterService.save1(waiter);
				map.put("result", "1");
				map.put("msg", "修改成功");
			}
		} else {
			map.put("result", "2");
			map.put("msg", "当前活动状态不正确");
		}
		return map;
	}

	/***
	 * 点赞
	 */
	@RequestMapping(value = "/Thup")
	@ResponseBody
	public Map<String, Object> getbyth(@RequestParam(value = "waiterid") int waiterid,
			@RequestParam(value = "lat", required = false) Float lat,
			@RequestParam(value = "lon", required = false) Float lon, Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (lon == null || "".equals(lon.toString())) {
			map.put("result", "2");
			map.put("msg", "您没有提供您的位置信息，无法投票");
			return map;
		}

		String result = IpUtils.getLocation(lat, lon);
		String citystr = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String statusstr = jodata.getString("status");

			if ("OK".equals(statusstr)) {

				String weizhi = jodata.getString("result");

				JSONObject address = new JSONObject(weizhi);
				String addressstr = address.getString("addressComponent");
				String citycode = address.getString("cityCode");

				JSONObject city = new JSONObject(addressstr);
				citystr = city.getString("city");

				if ("317".equals(citycode) && citystr.indexOf("无锡") >= 0) {

				} else if (citystr.indexOf("江阴") >= 0) {

				} else if (citystr.indexOf("宜兴") >= 0) {

				} else {
					map.put("result", "2");
					map.put("msg", "您的位置不在无锡市，此活动仅限无锡地区用户");
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

		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getWaiterStage();
		Date d = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
		String date1 = dd.format(d);
		if (a == 3) {
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");
			} else {
				/* 判断当天的 */
				List<Waiterth> wtrlist = waiterthService.panduan(oid, waiterid, date1);

				/* 判断当天点击了多少次 */
				int daysum = waiterthService.findsum(oid, date1);

				/* 判断总共点击了多少次 */
				int datesum = waiterthService.findbyzon(oid);

				if (daysum == 0) {
					int oneint = (int) ((Math.random()) * PROBABILITY + 1);
					if (oneint == 8) {
						WXUser wxuser = wXUserService.getOrNewWXUser(oid);
						WaiterthRedbag redbag = new WaiterthRedbag();
						redbag.setNickname(wxuser.getRealname());
						redbag.setOpenid(oid);
						redbag.setCreatetime(new Date());
						redbag.setWaiter(waiterService.find((long) waiterid));

						int price = 100;
						Date now = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						String billno = WXManage.WCA.getMcid() + sdf.format(now)
								+ (now.getTime() + "").substring(2, 12);
						boolean sendresult = WXManage.sendPrize(WXManage.WCA, oid, price, "参与投票领取红包", "点击关注,获取更多活动信息",
								"金阿福e服务", "金阿福e服务", "最美服务员活动", billno);
						if (sendresult) {
							waiterthRedbagService.save(redbag);
						}
					}
				}

				if (datesum == 0) {
					System.out.println("这是第一次点赞###########################");
					WXUser newuser = wXUserService.getOrNewWXUser(oid);
					if (newuser != null) {
						String fromact = newuser.getFromact();
						if (fromact != null && fromact.startsWith("543000")) {
							Long wid = Long.valueOf(fromact.substring(6));
							System.out.println("你是第" + wid + "号服务员推荐的");
							Waiter wai = waiterService.find(wid);
							if (wai != null) {
								Map<String, Object> mapresult = waiterRedbagService.saveWaiterRedbag(wid, oid,
										newuser.getRealname(), lat.toString(), lon.toString(), citystr);

								if (mapresult.get("result").equals("1")) {
									System.out.println("成功推荐++++++++++++++++++++++++++++++++++++");
									WXManage.SendMessage(weChatAccountService.getAccesstoken(), wai.getOpenid(),
											"您的好友" + newuser.getRealname() + "通过扫描二维码关注了金阿福e服务平台并参与了活动");
								}
							}
						}
					}
				}

				if (wtrlist != null && wtrlist.size() > 0) {
					map.put("result", "2");
					map.put("msg", "您已为他投过票！请把票投给其他人吧~");
					return map;
				}
				if (daysum < 3) {
					System.out.println("第  " + daysum + " 次点赞！");
					Waiterth wath = new Waiterth();
					wath.setOpenid(oid);
					Waiter wtr = waiterService.find((long) waiterid);
					wath.setWaiter(wtr);
					wath.setCreatetime(new Date());
					waiterthService.save1(wath);
					map.put("daysum", daysum + 1);
					// map.put("datesum", datesum + 1);
					map.put("result", "1");
					map.put("msg", "保存成功");
				} else {
					map.put("result", "2");
					map.put("msg", "您今天的投票机会已用完,<br>请明天再来！<br>请关注金阿福的其他活动！");
				}
			}
		} else {
			map.put("result", "2");
			map.put("msg", "投票已经结束");
		}

		return map;
	}

	/* 更改个人的状态（入选） */
	@RequestMapping(value = "bechosen", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> beChoosen(@RequestParam(value = "waiterid") Long waiterid) {
		Map<String, Object> map = new HashMap<String, Object>();
		Waiter wtr = waiterService.find(waiterid);
		if (wtr != null) {
			wtr.setState(2);
			waiterService.save1(wtr);
			map.put("result", "1");
			map.put("msg", "入选成功");
		} else {
			map.put("result", "0");
			map.put("msg", "入选失败");
		}

		return map;
	}

	/* 更改个人的状态（入选） */
	@RequestMapping(value = "nobechosen", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noBeChoosen(@RequestParam(value = "waiterid") Long waiterid) {
		Map<String, Object> map = new HashMap<String, Object>();
		Waiter wtr = waiterService.find(waiterid);
		if (wtr != null) {
			wtr.setState(1);
			waiterService.save1(wtr);
			map.put("result", "1");
			map.put("msg", "取消复赛资格成功");
		} else {
			map.put("result", "0");
			map.put("msg", "取消复赛资格失败");
		}

		return map;
	}

	/****** 获取当前活动总体状态 ********/
	@RequestMapping(value = "getactstage", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getActStage() {
		Map<String, Object> map = new HashMap<String, Object>();

		int stage = voteService.getWaiterStage();

		map.put("result", "1");
		map.put("msg", "获取状态成功");
		map.put("actstage", stage);

		return map;
	}

	/* 点击进入复赛阶段 */
	@RequestMapping(value = "changestage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> changVoteStage(@RequestParam(value = "stage") int stage) {
		Map<String, Object> map = new HashMap<String, Object>();
		Vote vote = voteService.changeWaiterStage();
		if (vote == null) {
			map.put("result", "0");
			map.put("msg", "数据库中找不到要修改的对象数据");
			return map;
		}

		if (stage == 3) {
			Waiter waiter = null;
			List<Waiter> waiterlist = waiterService.findByState(2);

			if (waiterlist != null && waiterlist.size() > 0) {
				for (int i = 0; i < waiterlist.size(); i++) {
					waiter = waiterlist.get(i);
					waiter.setSenumber(i + 1);
					waiterService.save1(waiter);
				}
			}

		}

		if (stage == 4) {
			List<Object[]> winnerlist = waiterService.getWinnerList();

			if (winnerlist != null && winnerlist.size() > 0) {
				Waiter waiter = null;
				for (int i = 0; i < winnerlist.size(); i++) {
					waiter = waiterService.find(Long.valueOf(winnerlist.get(i)[0].toString()));
					if (i == 0) {
						waiter.setState(3);
					} else if (i >= 1 && i <= 3) {
						waiter.setState(4);
					} else if (i >= 4 && i <= 8) {
						waiter.setState(5);
					} else if (i >= 9 && i <= 49) {
						waiter.setState(6);
					}

					waiterService.save1(waiter);
				}
			}

		}

		vote.setStage(stage);
		voteService.save(vote);

		map.put("result", "1");
		if (stage == 1) {
			map.put("msg", "活动状态更新成功，活动进入个人资料上传阶段");
		} else if (stage == 2) {
			map.put("msg", "活动状态更新成功，活动进入审核阶段");
		} else if (stage == 3) {
			map.put("msg", "活动状态更新成功，活动进入投票阶段");
		} else if (stage == 4) {
			map.put("msg", "活动状态更新成功，活动进入中奖阶段");
		}
		return map;
	}

	@RequestMapping(value = "setrank", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> setRank(@RequestParam(value = "wid") Long wid,
			@RequestParam(value = "rank") Integer rank) {
		Map<String, Object> map = new HashMap<String, Object>();
		Waiter waiter = waiterService.find(wid);
		waiter.setState(rank);
		waiterService.save1(waiter);
		map.put("result", "1");
		if (rank == 3) {
			map.put("msg", "设置第一名成功");
		} else if (rank == 4) {
			map.put("msg", "设置第二名成功");
		} else if (rank == 5) {
			map.put("msg", "设置第三名成功");
		}
		return map;
	}

	@RequestMapping(value = "sendtodayredbag", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendTodayRedbag(@RequestParam(value = "datestr") String datestr) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> nosendlist = waiterRedbagService.getNoSendWaiterRedbagByDate(datestr);
		if (nosendlist != null && nosendlist.size() > 0) {
			for (Object[] obj : nosendlist) {
				String ids = obj[0].toString();
				String sendopenid = obj[5].toString();
				int totalcount = Integer.parseInt(obj[3].toString());
				float totalmoney = totalcount * 0.5f;

				int price = 100;
				if (totalcount < 2) {
					continue;
				} else if (totalcount >= 400) {
					continue;
				} else {
					price = (int) (totalmoney * 100);
				}

				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
				WeChatAccount w = new WeChatAccount();
				w.setApikey("hillsun123456789yijiayi987654321");
				w.setAccesstoken(
						"hzQOZ9v8gu9_srFmXGXzHBN4t0vgdIbtARkgBb1uL-agMY3YHgghMGufklWJvhe1O7-nD0-vmlFgplCk4Q3XfttOV7BtmjctX2Quc5S1kHcBVOjAIAEYR");
				w.setAppid("wxf5b9abfb1c7d734d");
				w.setMcid("1267639601");
				boolean sendresult = WXManage.sendPrize(w, sendopenid, price, "拉票红包奖励",
						datestr + "这天，您共拉了" + totalcount + "个粉丝，奖励" + totalmoney + "元", "金阿福e服务", "最美服务员活动", "最美服务员活动",
						billno);

				String[] idArr = ids.split(",");
				if (sendresult) {
					for (String oneid : idArr) {
						WaiterRedbag wrbag = waiterRedbagService.get(Long.valueOf(oneid));
						wrbag.setSendstate(1);
						wrbag.setSendresult(1);
						wrbag.setSendtime(new Date());
						waiterRedbagService.save(wrbag);
					}

					tmphb tt = new tmphb();
					tt.setBillno(billno);
					tt.setCreatetime(now);
					tt.setNickname(obj[1].toString());
					tt.setOpenid(obj[5].toString());
					tt.setPrice(price);
					tt.setI1(Integer.parseInt(obj[3].toString()));
					tt.setI2(obj[4].toString());
					tmphbService.save(tt);
				} else {
					for (String oneid : idArr) {
						WaiterRedbag wrbag = waiterRedbagService.get(Long.valueOf(oneid));
						wrbag.setSendstate(1);
						wrbag.setSendresult(0);
						wrbag.setSendtime(new Date());
						waiterRedbagService.save(wrbag);
					}
				}

			}
			map.put("result", "1");
			map.put("msg", "红包发送成功，到账可能会有延迟，请耐心等候");
		} else {
			map.put("result", "0");
			map.put("msg", "查不到此日数据");
		}

		return map;
	}

	@RequestMapping(value = "sendone")
	@ResponseBody
	public Map<String, Object> sendPrizeToOne(@RequestParam(value = "openid") String openid) {
		Map<String, Object> map = new HashMap<String, Object>();

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("touser", openid);
		data.put("msgtype", "text");
		Map<String, String> data1 = new HashMap<String, String>();
		data1.put("content", "感谢您参与金阿福e服务平台举办的\"最美服务员\"活动，昨天您的很多好友通过扫描您的二维码为您投了票，奖励的红包已经发放，请继续为自己吸粉！");
		data.put("text", data1);

		System.out.println(WXUtil.sendPost(
				"https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="
						+ "rPxeoTiYTwMT6qp4_SHhZTDKsQxW20Gezcd3k94slv4YpRY4WJ4nfemQ8yRHsvMGf00u7nZH0gWttTcf7DJMvNzUdI8R5VQ-9ytj9eb4FaMDNIaADAZJE",
				WXUtil.transMapToString(data)));

		return map;
	}

	/* 处理删除请求 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = waiterService.delete(ids);
		if (result) {
			map.put("result", true);

		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	/* 上传跳转 */
	@RequestMapping(value = "/jump")
	public String getjump(HttpServletRequest request, Model model) {
		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getWaiterStage();
		/* 判断openid是否为空 */
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=waiter/";
		} else {
			WXUser wxsuer = wXUserService.getOrNewWXUser(oid);
			int sta = wxsuer.getState();
			/* 判断是否关注 */
			if (sta == 1) {
				/* 判断当前活动状态 */
				if (a == 1) {
					Waiter waiter = waiterService.findbyopenid(oid);
					if (waiter == null) {
						model.addAttribute("config",
								WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/waiter/jump"));
						return "newyear/waiterinformation";
					} else {
						model.addAttribute("wait", waiter);

						return "newyear/waiterpreviewinformation";
					}
				} else {
					return "redirect:/wxurl/redirect?url=waiter/";
				}
			} else {
				return "redirect:/wxurl/redirect?url=waiter/";
			}
		}

	}

	@RequestMapping(value = "/waditsc")
	public String waditsc(HttpServletRequest request, Model model) {
		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getWaiterStage();
		/* 根据openid判断 */
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=waiter/";
		} else {
			WXUser wxsuer = wXUserService.getOrNewWXUser(oid);
			int sta = wxsuer.getState();
			/* 判断当前有没有关注 */
			if (sta == 1) {
				/* 判断当前的活动状态 */
				if (a == 1) {
					Waiter wtr = waiterService.findbyopenid(oid);
					if (wtr == null) {
						model.addAttribute("config",
								WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/waiter/waditsc"));
						return "newyear/waiterinformation";
					} else {
						model.addAttribute("wtr", wtr);
						model.addAttribute("config",
								WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/waiter/waditsc"));

						/* 跳转编辑服务员信息页面 */
						return "newyear/waitereditinformation";
					}
				} else {
					return "redirect:/wxurl/redirect?url=waiter/";
				}
			} else {

				return "redirect:/wxurl/redirect?url=waiter/";
			}
		}

	}

	/* 投票跳转 */
	@RequestMapping(value = "vote")
	public String totoupiao(HttpServletRequest request, Model model) {
		String oid = (String) request.getSession().getAttribute("openid");
		/* 判断openid */
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=waiter/";
		} else {
			int sta = wXUserService.getOrNewWXUser(oid).getState();
			/* 判断有没有关注过 */
			if (sta == 1) {
				/* 判断当前的活动状态 */
				if (voteService.getWaiterStage() == 3) {
					model.addAttribute("config",
							WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/waiter/vote"));
					model.addAttribute("baseurl", SysConfig.BASEURL);

					/* 跳转最美服务员投票页面 */

					return "newyear/fwytp";
				} else {
					return "redirect:/wxurl/redirect?url=waiter/";
				}

			} else {
				return "redirect:/wxurl/redirect?url=waiter/";
			}
		}

	}

	/* 跳转详情 */
	@RequestMapping(value = "getfwyurl")
	@ResponseBody
	public Map<String, Object> getFwyUrl(Model model, @RequestParam(value = "id") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();

		Waiter waiter = waiterService.find(id);
		if (waiter == null) {
			map.put("result", "0");
			map.put("msg", "参数错误");
		} else {
			String qrurl = WXManage.getLimitQRCode(weChatAccountService.getAccesstoken(),
					Long.valueOf("543000" + waiter.getId()));
			map.put("result", "1");
			map.put("fwyurl", qrurl);
		}
		return map;
	}

	@RequestMapping(value = "detail")
	public String xiangqing(Model model, @RequestParam(value = "id") Long id, HttpServletRequest request) {
		String oid = (String) request.getSession().getAttribute("openid");
		/* 判断openid是否存在 */
		if (oid == null || oid == "") {

			return "redirect:/wxurl/redirect?url=waiter/";
		} else {
			Waiter waiter = waiterService.find(id);
			/* 查找库是否含有 */
			if (waiter == null) {
				return "redirect:/wxurl/redirect?url=waiter/";
			} else {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				model.addAttribute("config",
						WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/waiter/detail?id=" + id));
				model.addAttribute("iscount",
						waiterthService.panduan(oid, id.intValue(), sdf.format(new Date())).size());
				model.addAttribute("allcount", waiterthService.findliketh(id.intValue()));
				model.addAttribute("baseurl", SysConfig.BASEURL);
				model.addAttribute("waiter", waiter);

				return "newyear/fwyxq";
			}
		}
	}

	/* 跳转获奖页面 */
	@RequestMapping(value = "winning")
	public String winresult(Model model) {

		return "newyear/award";
	}

	/*** 获奖复赛名单列表 ****/
	@RequestMapping(value = "gettplist")
	@ResponseBody
	public Map<String, Object> getTPList(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			map.put("result", "0");
			map.put("msg", "参数错误");
			return map;
		}

		Date date = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
		String today = dd.format(date);

		List<Object[]> objlist = waiterService.getChosenList(openid.toString(), today);
		if (objlist != null && objlist.size() > 0) {
			map.put("result", "1");
			map.put("msg", "获取数据成功");
			map.put("data", objlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/*** 获奖名单列表 ****/
	@RequestMapping(value = "getwinlist")
	@ResponseBody
	public Map<String, Object> getWinList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> objlist = waiterService.getTop50WinList();
		if (objlist != null && objlist.size() > 0) {
			map.put("result", "1");
			map.put("msg", "获取数据成功");
			map.put("data", objlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	@RequestMapping(value = "saveimg")
	@ResponseBody
	public String saveimg(@RequestParam(value = "sid") String sid) {
		String downurl = null;
		String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + WXManage.WCA.getAccesstoken()
				+ "&media_id=" + sid;
		String baespath = Util.getRootPath() + File.separator + "watmpimgforact" + File.separator;
		File f = new File(baespath);
		if (!f.exists()) {
			f.mkdirs();
		}
		String name = Util.downloadNet(url, baespath);
		try {
			downurl = wxytConfig.upload(baespath + name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return downurl;
	}

}
