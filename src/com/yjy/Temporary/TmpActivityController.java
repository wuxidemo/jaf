package com.yjy.Temporary;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.entity.Activity;
import com.yjy.service.ActivityService;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

@Controller
@RequestMapping(value = "/tmpactivity")
public class TmpActivityController {

	@Autowired
	TmprecordService tmprecordService;
	@Autowired
	ActivityService activityService;
	@Autowired
	WXUserService wXUserService;
	@Autowired
	cjactService cjactService;
	@Autowired
	WeChatAccountService weChatAccountService;

	@RequestMapping(value = "eggs/{id}")
	public String eggact(@PathVariable(value = "id") Long id, HttpServletRequest request, Model model) {
		// TODO 查询活动状态
		Activity a = activityService.get(id);
		model.addAttribute("id", id);
		if (a == null) {
			model.addAttribute("actinfo", "0");
		} else if (a.getState() == 0) {
			model.addAttribute("actinfo", "2");
		} else if (a.getState() == 2) {
			model.addAttribute("actinfo", "3");
		} else {
			model.addAttribute("actinfo", "1");
			String openid = request.getSession().getAttribute("openid").toString();// "oKEL4sno2T4aOtRqod-4_wY3gzcU"
			List<Tmprecord> lt = tmprecordService.getTodayListByOpenid(openid, id);
			Tmprecord tmp = null;
			Date now = new Date();
			Long ts = now.getTime();
			if (lt.size() > 0) {
				tmp = lt.get(0);
			} else {
				tmp = new Tmprecord();
				tmp.setCode("tmp_" + now.getTime() + Util.getRandomString(6));
				tmp.setCreatetime(now);
				tmp.setOpenid(openid);
				tmp.setState(0);
				tmp.setName(wXUserService.getOrNewWXUser(openid).getRealname());
				tmp.setActid(id);
			}
			if (tmp.getState() == 0) {
				String pid = WXManage.getPrepay_id(WXManage.WCA, "鸡蛋一份", tmp.getCode(), a.getPayprice(), Util.getMyIp(),
						SysConfig.notify_url, "JSAPI", null, openid);
				tmp.setPrice(a.getPayprice());
				tmp.setWxcode(pid);
				tmprecordService.SaveOrUpdate(tmp);
				model.addAttribute("pid", pid);
				Map<String, Object> data = new HashMap<String, Object>();
				data.put("appId", WXManage.WCA.getAppid());
				data.put("timeStamp", ts);
				data.put("nonceStr", Util.getRandomString(10));
				data.put("package", "prepay_id=" + pid);
				data.put("signType", "MD5");

				model.addAttribute("appId", WXManage.WCA.getAppid());
				model.addAttribute("timeStamp", ts);
				model.addAttribute("nonceStr", data.get("nonceStr"));
				model.addAttribute("package1", "prepay_id=" + pid);
				model.addAttribute("signType", "MD5");
				model.addAttribute("paySign", WXUtil.getsign(data, WXManage.WCA.getApikey()));
			}
			model.addAttribute("tmp", tmp);
		}
		return "temporary/saleegg";
	}

	@RequestMapping(value = "checknum")
	@ResponseBody
	public String checknum(@RequestParam(value = "id") Long id) {
		Activity a = activityService.get(id);
		if (a != null) {
			if (a.getState() == 2) {
				return "活动还未开始,敬请期待";
			} else if (a.getState() == 3) {
				return "活动已结束";
			} else if (a.getState() == 0) {
				return "未找到此活动";
			} else {
				if (a.getTmpnum() != null && a.getTmpnum() != 0) {
					if (tmprecordService.getTodayPayCount(id) >= a.getTmpnum()) {
						return "今日活动已结束,明天请早哦";
					}
				}
				return "1";
			}
		} else {
			return "未找到此活动";
		}
	}

	/**
	 * 
	 * 支付完成获取 领蛋二维码
	 * 
	 * @author luyf
	 * @date 2015年7月31日 下午3:35:43
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "code")
	@ResponseBody
	public Map<String, String> getCODE(@RequestParam(value = "id") Long id) {

		Map<String, String> result = new HashMap<String, String>();

		// result.put(key, value)
		for (int i = 0; i < 10; i++) {
			Tmprecord t = tmprecordService.get(id);
			if (t != null) {
				if (t.getQrcode() != null && !t.getQrcode().equals("")) {
					result.put("result", "1");
					result.put("url", t.getQrcode());
					break;
				}
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} else {
				result.put("result", "-1");
				return result;
			}
		}

		return result;
	}

	/**
	 * 
	 * 获取活动永久二维码
	 * 
	 * @author luyf
	 * @date 2015年7月31日 下午3:42:14
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getqrcode")
	@ResponseBody
	public String getQRCode(@RequestParam(value = "id") Long id) {
		return WXManage.getForeverQRCode(weChatAccountService.getAccesstoken(), 2, "tmp000" + id);
	}

	@RequestMapping(value = "checkpage")
	public String checkpage(Model model) {
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("timestamp", ts);
		data.put("noncestr", radomstr);
		data.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data.put("url", SysConfig.BASEURL + "/tmpactivity/checkpage");
		model.addAttribute("signature", WXUtil.getJSsign(data));
		return "temporary/checkpage";
	}

	/**
	 * 
	 * 核销鸡蛋二维码
	 * 
	 * @author luyf
	 * @date 2015年8月3日 上午10:50:55
	 * @param str
	 * @return
	 */
	@RequestMapping(value = "checkcode")
	@ResponseBody
	public String checkQRCode(@RequestParam(value = "str") String str) {
		String[] data = str.split(",");
		Tmprecord t = tmprecordService.get(Long.parseLong(data[1]));
		if (t == null) {
			return "未发现该记录";
		}
		if (t.getOpenid().equals(data[0])) {
			if (t.getState() == 0) {
				return "未支付";
			} else if (t.getState() == 2) {
				return "已领取";
			}
			t.setState(2);
			tmprecordService.SaveOrUpdate(t);
			return "核销完成";
		} else {
			return "未发现该记录";
		}
	}

	@RequestMapping(value = "act1tj")
	public String act1tj(@RequestParam(value = "id") Long id, Model model) {
		Activity a = activityService.get(id);
		if (a != null) {
			model.addAttribute("id", id);
			model.addAttribute("num", a.getTmpnum());
			model.addAttribute("state1", tmprecordService.getTodayCountByState(id, 1));
			model.addAttribute("state2", tmprecordService.getTodayCountByState(id, 2));
			// List<Tmprecord> lt = tmprecordService.getTodayList(id);
		}
		return "temporary/act1tj";
	}

	@RequestMapping(value = "setnum")
	@ResponseBody
	public String setnum(@RequestParam(value = "id") Long id, @RequestParam(value = "num") Integer num) {
		Activity a = activityService.get(id);
		if (a != null) {
			a.setTmpnum(num);
			activityService.save(a);
			return "1";
		}
		return "0";
	}

	@RequestMapping(value = "jfrole")
	public String jfrole() {
		return "temporary/jfrole";
	}

	@RequestMapping(value = "cj")
	public String cj(HttpServletRequest request, Model model) {
		String openid = request.getSession().getAttribute("openid").toString();
		int allcount = cjactService.getAllcount();
		if (allcount <= 50) {
			int count = cjactService.getcount(openid);
			if (count == 0) {
				model.addAttribute("result", "1");
			} else {
				model.addAttribute("result", "0");
				model.addAttribute("msg", "您已领取过红包!");
			}

		} else {
			model.addAttribute("result", "0");
			model.addAttribute("msg", "红包已经被抢光啦!");
		}
		return "temporary/cj1";
	}

	@RequestMapping(value = "docj")
	@ResponseBody
	public Map<String, String> docj(HttpServletRequest request, Model model) {
		String openid = request.getSession().getAttribute("openid").toString();
		Map<String, String> data = new HashMap<String, String>();
		int allcount = cjactService.getAllcount();
		if (allcount <= 50) {
			int count = cjactService.getcount(openid);
			if (count == 0) {
				data.put("result", "1");
			} else {
				data.put("result", "0");
				data.put("msg", "您已领取过红包!");
			}

		} else {
			data.put("result", "-1");
			data.put("msg", "红包已经被抢光啦!");
		}
		Date now = new Date();
		cjact c = new cjact();
		c.setOpenid(openid);
		c.setCreatetime(now);
		cjactService.save(c);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
		WXManage.sendPrize(WXManage.WCA, openid, 188, "摇一摇抢红包", "摇一摇抢红包", "度维金数源", "度维金数源", "摇一摇抢红包", billno);
		return data;
	}

}
