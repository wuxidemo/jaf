package com.yjy.web.api;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.entity.Apply;
import com.yjy.entity.Order;
import com.yjy.entity.RebateRecord;
import com.yjy.entity.User;
import com.yjy.service.ApplyService;
import com.yjy.service.MercommentService;
import com.yjy.service.OrderService;
import com.yjy.service.RebateForFirstService;
import com.yjy.service.RebateRecordService;
import com.yjy.service.RebateService;
import com.yjy.service.UserService;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

/**
 * 订单微信端接口
 * 
 * @author lyf
 *
 */
@Controller
@RequestMapping(value = "/wxorder")
public class WXOrderController {

	@Autowired
	OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private RebateService rebateService;
	@Autowired
	private RebateForFirstService rebateForFirstService;
	@Autowired
	private ApplyService applyService;
	@Autowired
	private RebateRecordService rebateRecordService;
	@Autowired
	MercommentService mercommentService;
	String oderqrurl = "oderqrurl";

	@RequestMapping(value = "choise")
	public String choise(Model model, HttpServletRequest request) {
		User u = (User) request.getSession().getAttribute("wxuser");
		if (u == null) {
			return "redirect:/wxorder/login";
		}
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("timestamp", ts);
		data.put("noncestr", radomstr);
		data.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data.put("url", SysConfig.BASEURL + "/wxorder/choise");// baseurl
		model.addAttribute("signature", WXUtil.getJSsign(data));
		return "wechat/choise";
	}

	@RequestMapping(value = "showorder")
	public String showOrder(Model model, HttpServletRequest request) {
		// String openid =
		User u = (User) request.getSession().getAttribute("wxuser");
		if (u == null) {
			return "redirect:/wxorder/login";
		}
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("timestamp", ts);
		data.put("noncestr", radomstr);
		data.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data.put("url", SysConfig.BASEURL + "/wxorder/showorder");// baseurl
																	// +
		model.addAttribute("signature", WXUtil.getJSsign(data));
		model.addAttribute("mer", u.getMerchant());
		return "wechat/card/ShowOrder";
	}

	@RequestMapping(value = "wxlogin")
	public String wxlogin() {
		return "wechat/wxlogin";
	}

	@RequestMapping(value = "login")
	public String login(@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "issave", required = false) String issave, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		if (name == null || password == null) {
			Long uid = null;
			if (request.getCookies() == null) {
				return "wechat/wxlogin";
			}
			for (Cookie ck : request.getCookies()) {
				if (ck.getName().equals("wxuser")) {
					uid = Long.parseLong(ck.getValue());
				}
			}
			if (uid != null) {
				User u = userService.get(uid);
				if (u == null) {
					return "wechat/wxlogin";
				} else {
					if (u.getEnabled() == 0) {
						model.addAttribute("message", "账号已被冻结!");
						return "wechat/wxlogin";
					}
					if (u.getMerchant() == null) {
						model.addAttribute("message", "此账户不是商户用户");
						return "wechat/wxlogin";
					}
					System.out.println("自动登陆");
					request.getSession().setAttribute("wxuser", u);
				}
			} else
				return "wechat/wxlogin";
		} else {
			User user = userService.findBytelephone(name);
			if (user != null) {
				Integer enabled = user.getEnabled();
				if (enabled == 0) {
					model.addAttribute("message", "账号已被冻结!");
					return "wechat/wxlogin";
				}
				boolean flag = userService.decryptPassword(user, password);
				if (!flag) {
					model.addAttribute("message", "您输入的密码和手机号码不匹配,请重新输入!");
					return "wechat/wxlogin";
				}
				if (user.getMerchant() == null) {
					model.addAttribute("message", "此账户不是商户用户");
					return "wechat/wxlogin";
				}
			} else {
				model.addAttribute("message", "您输入的手机号码不存在,请重新输入!");
				return "wechat/wxlogin";
			}
			request.getSession().setAttribute("wxuser", user);
			if (issave != null) {
				Cookie ck = new Cookie("wxuser", user.getId().toString());
				ck.setMaxAge(999999999);
				response.addCookie(ck);
			}
		}
		return "redirect:/wxorder/choise";
	}

	/**
	 * 
	 * 根据价格生成二维码
	 * 
	 * @author lyf
	 * @date 2015年6月15日 下午1:51:15
	 * @param price
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getpaycode")
	@ResponseBody
	public Map<String, String> getPayCode(@RequestParam(value = "price") Float price, HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		User u = (User) request.getSession().getAttribute("wxuser");
		if (u == null) {
			result.put("result", "0");
			return result;
		}
		if (u.getMerchant() == null) {
			result.put("result", "0");
			return result;
		}
		Order or = new Order();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String daystr = sdf.format(now);
		or.setCreatetime(now);
		or.setState(0);
		or.setIsusecard(0);
		or.setPrice((int) (price * 100));
		or.setPayprice(0);
		or.setCode(now.getTime() + Util.getRandomString(10));
		or.setMerchantid(u.getMerchant().getId());
		or.setMerhchantname(u.getMerchant().getName());
		or.setNeedprice((int) (price * 100));
		orderService.update(or);
		request.getSession().setAttribute("mycode", or.getCode());
		WXManage.CodeState.put(or.getCode(), "0");
		String url = "";
		String baseurl = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
		String qrcode = WXManage.getPayQRCode(WXManage.WCA, or.getCode());
		try {
			MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
			Map hints = new HashMap();
			hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			BitMatrix bitMatrix = multiFormatWriter.encode(qrcode, BarcodeFormat.QR_CODE, 400, 400, hints);
			Date d = new Date();
			File pf = new File(Util.getRootPath() + File.separator + oderqrurl + File.separator + daystr);
			if (!pf.exists()) {
				pf.mkdirs();
			}
			File f = new File(Util.getRootPath() + File.separator + oderqrurl + File.separator + daystr + File.separator
					+ d.getTime() + ".png");
			MatrixToImageWriter.writeToFile(bitMatrix, "png", f);
			url = oderqrurl + "/" + daystr + "/" + d.getTime() + ".png";
			result.put("result", "1");
			result.put("url", baseurl + "/" + url);
		} catch (Exception e) {
			result.put("result", "0");
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "checkstate")
	@ResponseBody
	public Map<String, String> checkstate(HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		Object mycode = request.getSession().getAttribute("mycode");
		if (mycode != null) {
			if (WXManage.CodeState.containsKey(mycode.toString())) {
				for (int i = 0; i < 20; i++) {
					if (WXManage.CodeState.get(mycode.toString()).equals("1")) {
						result.put("result", "1");
						result.put("returndata", "1");
						return result;
					} else {
						try {
							Thread.sleep(1000);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
				}
				result.put("result", "0");
				result.put("returndata", "1");
			} else {
				result.put("returndata", "0");
			}
		} else {
			result.put("returndata", "0");
		}
		return result;
	}

	// @RequestMapping(value = "go")
	// public String test(@RequestParam(value = "url") String url, Model model)
	// {
	// Long ts = new Date().getTime();
	// String radomstr = Util.getRandomString(6);
	// model.addAttribute("appId", WXManage.WCA.getAppid());
	// model.addAttribute("timestamp", ts);
	// model.addAttribute("nonceStr", radomstr);
	// Map<String, Object> data = new HashMap<String, Object>();
	// data.put("timestamp", ts);
	// data.put("noncestr", radomstr);
	// data.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
	// model.addAttribute("signature", WXUtil.getJSsign(data));
	// return url;
	// }

	@RequestMapping(value = "rebatestate")
	@ResponseBody
	public Map<String, String> getRebateState() {
		Map<String, String> result = new HashMap<String, String>();
		result.put("r", rebateService.getUseRebate() + "");
		result.put("rf", rebateForFirstService.getRFFState() + "");
		return result;
	}

	@RequestMapping(value = "loginout")
	@ResponseBody
	public String loginout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().removeAttribute("wxuser");
		Cookie ck = new Cookie("wxuser", null);
		ck.setMaxAge(0);
		response.addCookie(ck);
		return "1";
	}

	@RequestMapping(value = "contactus")
	public String contactus(HttpServletRequest request, Model model) {
		Object openid = request.getSession().getAttribute("openid");
		model.addAttribute("app", applyService.getApplyByOpenid(openid.toString()));
		return "wechat/contactus";
	}

	@RequestMapping(value = "saveapply")
	public String saveApply(@Valid Apply app, HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		if (applyService.getApplyByOpenid(openid.toString()) != null) {
			return "redirect:/wxorder/contactus";
		}
		String realname = "";
		for (int i = 0; i < app.getName().length(); i++) {
			if (!Util.isMessyCode(app.getName().charAt(i) + ""))
				realname += app.getName().charAt(i);
		}
		app.setName(realname);
		String content = "";
		for (int i = 0; i < app.getMemo().length(); i++) {
			if (!Util.isMessyCode(app.getMemo().charAt(i) + ""))
				content += app.getMemo().charAt(i);
		}
		app.setMemo(content);
		app.setCreatetime(new Date());
		app.setOpenid(openid.toString());
		app.setState(1);
		applyService.update(app);
		return "redirect:/wxorder/contactus";
	}

	@RequestMapping(value = "myorderlist")
	@ResponseBody
	public List<Order> getOrderByOpenid(HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		return orderService.getOrderByOpenid(openid.toString());
	}

	@RequestMapping(value = "myrebaterecordlist")
	@ResponseBody
	public List<RebateRecord> getListByOpenid(HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		return rebateRecordService.getListByOpenid(openid.toString());
	}

	/**
	 * 我的订单 查询全部jude不传值，查询待评价jude传任意值
	 * 
	 * @param judge
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getmypayorderlist")
	@ResponseBody
	public Map<String, Object> getMyPayOrderByOpenid(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "judge", required = false) String judge, @RequestParam(value = "start") Integer start,
			@RequestParam(value = "size") Integer size, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if (openid != null) {
			searchParams.put("openid", openid);
		} else {
			searchParams.remove("openid");
		}
		if (judge != null) {
			searchParams.put("judge", judge);
		} else {
			searchParams.remove("judge");
		}
		List<Object[]> list = mercommentService.getMyPayOrderByOpenid(searchParams, start, size);
		if (list != null && list.size() > 0) {
			map.put("result", "1");
			map.put("data", list);// 0id 1时间 2付款金额 3商户id 4系统订单号（我们生成） 5付款昵称
									// 6微信或支付宝订单号 7支付方式 8是否退款 9微信编号 10失败原因
									// 11商户名称 12商户图片 13是否已评价(null为未评价，否则为已评价)
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

}
