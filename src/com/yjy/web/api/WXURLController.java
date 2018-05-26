package com.yjy.web.api;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.Temporary.TmpActivityService;
import com.yjy.Temporary.entity.SumData;
import com.yjy.Temporary.service.SumDataService;
import com.yjy.entity.Order;
import com.yjy.entity.WXCardRecord;
import com.yjy.entity.WXUser;
import com.yjy.entity.WeChatAccount;
import com.yjy.service.OrderService;
import com.yjy.service.RebateRecordService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXCardService;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

@Controller
@RequestMapping(value = "/wxurl")
public class WXURLController {

	@Autowired
	WXUserService wxuserService;
	@Autowired
	WeChatAccountService weChatAccountService;
	@Autowired
	OrderService orderService;
	@Autowired
	RebateRecordService rebateRecordService;
	@Autowired
	WXCardService wXCardService;
	@Autowired
	WXCardRecordService wXCardRecordService;
	@Autowired
	TmpActivityService activityService;
	@Autowired
	SumDataService sumDataService;

	@RequestMapping()
	@ResponseBody
	public String main(@RequestParam(required = false, value = "signature") String signature,
			@RequestParam(required = false, value = "timestamp") String timestamp,
			@RequestParam(required = false, value = "nonce") String nonce,
			@RequestParam(required = false, value = "echostr") String echostr, HttpServletRequest request,
			HttpServletResponse response) {

		String returnStr = echostr;
		Map<String, String> result = new HashMap<String, String>();

		try {

			InputStream is = request.getInputStream();
			result = WXUtil.PushManageXml(is);
			if (result == null) {
				if (WXUtil.checkSignature(signature, timestamp, nonce)) {
					return echostr;
				} else {
					System.out.println("检查失败");
					return echostr;
				}
			}
			String type = result.get("MsgType");
			String toName = result.get("ToUserName");
			String fromName = result.get("FromUserName");

			if (type.equals("event")) {
				String event = result.get("Event");
				String ekey = result.get("EventKey");
				// System.out.println("事件的Key值为：" + ekey);

				if (event.equals("subscribe")) {
					WXUser user = wxuserService.getUserByOpenid(fromName);
					Map<String, String> userinfo = WXManage.getUserInfo(weChatAccountService.getAccesstoken(),
							fromName);
					boolean isfirst = false;
					if (user == null) {
						user = new WXUser();
						if (ekey != null && !ekey.equals("") && ekey.lastIndexOf("000") > 8) {
							ekey = ekey.substring(8, ekey.length());
							/*
							 * user.setFromact(ekey.substring(0,
							 * ekey.indexOf("000")));
							 */
							System.out.println("ekey::" + ekey);
							user.setFromact(ekey);
						}
						user.setFirstpay(0);
						if (userinfo == null) {
							return WXUtil.getBackXMLTypeText(toName, fromName, "获取用户信息失败");
						}
						isfirst = true;
					}
					user.setOpenid(fromName);
					user.setHeadimgurl(userinfo.get("headimgurl"));
					user.setRealname(userinfo.get("realname"));
					user.setSex(Integer.parseInt(userinfo.get("sex")));
					user.setState(1);
					user = wxuserService.save(user);
					if (isfirst) {
						// rebateRecordService.doACT(user);
					}
					return activityService.subscribeEventAct(result, WXUtil.getBackXMLTypeText(toName, fromName,
							"感谢您的关注！金阿福e服务竭诚为您提供更方便更时尚的智慧社区生活体验，欢迎您点击下方“社区”开启您的专属智慧社区生活！"), isfirst);

				} else if (event.equals("SCAN")) {

					WXUser user = wxuserService.getUserByOpenid(fromName);
					Map<String, String> userinfo = WXManage.getUserInfo(weChatAccountService.getAccesstoken(),
							fromName);
					if (user == null) {
						user = new WXUser();
						user.setFirstpay(0);
						if (userinfo == null) {
							return WXUtil.getBackXMLTypeText(toName, fromName, "获取用户信息失败");
						}
					}
					user.setOpenid(fromName);
					user.setHeadimgurl(userinfo.get("headimgurl"));
					user.setRealname(userinfo.get("realname"));
					user.setSex(Integer.parseInt(userinfo.get("sex")));
					user.setState(1);
					user = wxuserService.save(user);

					return activityService.scanEventAct(result, WXUtil.getBackXMLTypeText(toName, fromName,
							"感谢您的关注！金阿福e服务竭诚为您提供更方便更时尚的智慧社区生活体验，欢迎您点击下方“社区”开启您的专属智慧社区生活！"));

				} else if (event.equals("unsubscribe")) {

					WXUser user = wxuserService.getUserByOpenid(fromName);
					if (user != null) {
						user.setState(0);
						wxuserService.update(user);
					}

				} else if (event.equals("CLICK")) {

					if (ekey.equals("V1")) {
						returnStr = WXUtil.getBackXMLTypeText(toName, fromName, "点击了菜单1");
					} else if (ekey.equals("V2")) {
						returnStr = WXUtil.getBackXMLTypeText(toName, fromName, "点击了菜单2");
					}
				} else if (event.equals("card_pass_check")) {
					// 卡券通过审核事件
					// if (wXCardService.saveCard(result.get("CardId"), 1)) {
					// returnStr = "";
					// }
				} else if (event.equals("card_not_pass_check")) {
					// 卡券未通过审核事件
					// if (wXCardService.saveCard(result.get("CardId"), 0)) {
					// returnStr = "";
					// }
				} else if (event.equals("user_get_card")) {
					// 卡券被领取事件
					wXCardService.saveCardRecord(result.get("FromUserName"), result.get("FriendUserName"),
							result.get("IsGiveByFriend"), result.get("UserCardCode"), result.get("CardId"),
							result.get("OuterId"), result.get("OldUserCardCode"));
					return "";
				} else if (event.equals("user_del_card")) {
					// 卡券被删除事件
				} else if (event.equals("user_view_card")) {
					// 会员卡进入事件
				} else if (event.equals("user_consume_card")) {
					System.out.println("====卡券核销=====");
					System.out.println("code:" + result.get("UserCardCode"));
					// 卡券核销
				} else if (event.equals("VIEW")) {// 点击菜单

				}

			} else if (type.equals("text")) {

				returnStr = WXUtil.getBackXMLTypeText(toName, fromName,
						"感谢您的关注！金阿福e服务竭诚为您提供更方便更时尚的智慧社区生活体验，欢迎您点击下方“社区”开启您的专属智慧社区生活！");

			} else if (type.equals("image")) {

			} else if (type.equals("VIEW")) {

				System.out.println("点击菜单");

			} else {
				returnStr = WXUtil.getBackXMLTypeText(toName, fromName, "已接受/:,@-D");
			}

		} catch (IOException e) {
			e.printStackTrace();
			return echostr;
		}
		return returnStr;
	}

	/**
	 * 获取微信公众平台的AccessToken
	 * 
	 * @author yigang
	 * @date 2015年6月15日 下午7:55:08
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getak")
	@ResponseBody
	public String getak(HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		System.out.println("ak:" + WXManage.WCA.getAccesstoken());
		return WXManage.WCA.getAccesstoken();
	}

	/**
	 * 获取微信公众平台的jsapi_AccessToken
	 * 
	 * @author yigang
	 * @date 2015年6月15日 下午7:55:41
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getjsak")
	@ResponseBody
	public String getjsak(HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		return WXManage.WCA.getJsapiticket();
	}

	/**
	 * 
	 * 微信页面跳转,用户获取OPENID
	 * 
	 * @author lyf
	 * @date 2015年6月15日 下午1:53:52
	 * @param request
	 * @param url
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "redirect")
	public String usercentre(HttpServletRequest request, @RequestParam("url") String url, Model model) {
		// Object wxcode = request.getSession().getAttribute("wxcode");
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			request.getSession().setAttribute("url", url);
			// WXManage.getCodeUrl(url);
			return "redirect:" + WXManage.getCodeUrl(url);
		}
		return "redirect:/" + url;
	}

	@RequestMapping(value = "savecode")
	public String usercentre(HttpServletRequest request, Model model) {
		Object code = request.getParameter("code");
		Object url = request.getParameter("state");
		Map<String, String> m = WXManage.getPageAKAndOpenid(WXManage.WCA, code.toString());
		request.getSession().setAttribute("openid", m.get("openid"));
		return "redirect:/" + url;
	}

	@RequestMapping(value = "centre")
	@ResponseBody
	public String centre(Model model, HttpServletRequest request) {
		String openid = request.getSession().getAttribute("openid").toString();
		Map<String, String> data = WXManage.getUserInfo(weChatAccountService.getAccesstoken(), openid);
		if (data.get("subscribe").equals("1")) {
			return "已关注";
		} else {
			return "未关注";
		}
	}

	@RequestMapping(value = "getopenid")
	@ResponseBody
	public Map<String, String> getOpenid(HttpServletRequest request, Model model, @RequestParam("code") String code) {
		Map<String, String> data = new HashMap<String, String>();
		System.out.println("获取OPENID");
		Object url = request.getSession().getAttribute("url");
		if (url == null) {
			data.put("result", "0");
			return data;
		}
		data.put("url", url.toString());
		request.getSession().removeAttribute("url"); // 删除缓存中的跳转地址。
		Map<String, String> m = WXManage.getPageAKAndOpenid(WXManage.WCA, code);
		if (m != null) {
			request.getSession().setAttribute("openid", m.get("openid"));
			data.put("result", "1");

		} else {
			data.put("result", "0");
		}
		return data;
	}

	/**
	 * 
	 * 扫描二维码支付回调
	 * 
	 * @author lyf
	 * @date 2015年6月2日 上午10:12:52
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "back")
	@ResponseBody
	public String back(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("=========扫描二维码回调=========");
		String returnStr = "";
		Map<String, String> result = new HashMap<String, String>();
		try {
			result = WXUtil.PushManageXml(request.getInputStream());
			if (result == null) {
				return "";
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("return_code", "SUCCESS");
			map.put("appid", result.get("appid"));
			map.put("mch_id", result.get("mch_id"));
			map.put("nonce_str", result.get("nonce_str"));
			WeChatAccount wca = weChatAccountService.getByAppid(result.get("appid"));
			Order or = orderService.getByCode(result.get("product_id"));
			if (or.getState() != 1) {
				or.setState(0);
				String ccode = new Date().getTime() + Util.getRandomString(12);
				String pid = WXManage.getPrepay_id(wca, "账单", ccode, or.getNeedprice(), Util.getMyIp(),
						SysConfig.notify_url, "NATIVE", or.getCode(), "");
				or.setCwxcode(ccode);
				or.setWxcode(pid);
				map.put("prepay_id", pid);
				orderService.update(or);
				map.put("result_code", "SUCCESS");
				map.put("sign", WXUtil.getsign(map, wca.getApikey()));
				returnStr = WXUtil.getSendText(map);
			} else {
				map.put("result_code", "FAIL");
				map.put("err_code_des", "订单已处理");
				map.put("sign", WXUtil.getsign(map, wca.getApikey()));
				returnStr = WXUtil.getSendText(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}

	/**
	 * 
	 * 接收微信支付异步通知回调地址
	 * 
	 * @author lyf
	 * @date 2015年6月2日 上午10:13:10
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "payback")
	@ResponseBody
	public String payback(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("=========支付回调=========");
		String returnStr = "";
		Map<String, String> result = new HashMap<String, String>();
		try {
			result = WXUtil.PushManageXml(request.getInputStream());
			if (result == null) {
				Map<String, Object> data = new HashMap<String, Object>();
				data.put("return_code", "SUCCESS");
				return WXUtil.getSendText(data);
			} else {
				if (result.containsKey("return_code") && result.get("return_code").equals("SUCCESS")
						&& result.containsKey("result_code") && result.get("result_code").equals("SUCCESS")) {
					// TODO 返回信息较多 暂时只更新了下订单状态
					String ordercode = result.get("out_trade_no");
					// 活动订单
					if (ordercode.startsWith("tmp_")) {
						activityService.payCompleteEventAct(result);
						Map<String, Object> data = new HashMap<String, Object>();
						data.put("return_code", "SUCCESS");
						returnStr = WXUtil.getSendText(data);
					} else {
						Order o = orderService.getByCWXCode(ordercode);
						// 订单状态判断
						if (o != null && o.getState() == 0) {
							if (WXManage.CodeState.containsKey(o.getCode())) {
								WXManage.CodeState.put(o.getCode(), "1");
							}
							o.setPaytime(new Date());
							o.setState(1);
							o.setPayopenid(result.get("openid"));
							o.setPayname(wxuserService.getOrNewWXUser(result.get("openid")).getRealname());
							o.setBanktype(result.get("bank_type"));
							o.setPayprice(Integer.parseInt(result.get("cash_fee")));
							o.setWxcode(result.get("transaction_id"));
							orderService.update(o);
							if (o.getIsusecard() == 1) {
								for (WXCardRecord wr : wXCardRecordService.getWXCardRecordByOrderid(o.getId())) {
									WXCardManage.useCard(WXManage.WCA, wr.getCode(), null);
								}
								wXCardRecordService.updateState(2, new Date(), o.getId());
							}
							if (!activityService.payCompleteEventAct(result).equals("1")) {
								// 返利判断
								rebateRecordService.sendRebate(result.get("openid"), o.getCode(), o.getWxcode(),
										result.get("bank_type"), o.getPayprice(), o.getMerchantid(),
										o.getMerhchantname());
							}

							Map<String, Object> data = new HashMap<String, Object>();
							data.put("return_code", "SUCCESS");
							returnStr = WXUtil.getSendText(data);
						} else {
							System.out.println("订单状态异常");
							Map<String, Object> data = new HashMap<String, Object>();
							data.put("return_code", "SUCCESS");
							returnStr = WXUtil.getSendText(data);
						}
					}

				} else {
					System.out.println(result.get("return_msg"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}

	@RequestMapping(value = "orderlist")
	public String orderlist(Model model, HttpServletRequest request) {
		String openid = request.getSession().getAttribute("openid").toString();
		try {
			model.addAttribute("ods", orderService.getOrderByOpenid(openid));
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(openid);
		return "weixin/orderlist";
	}

	@RequestMapping(value = "tourl")
	public String tourl(@RequestParam(value = "url") String url) {
		return url;
	}

	@RequestMapping(value = "tourl1")
	public String tturl(@RequestParam(value = "url") String url, Model model) {
		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxurl/tourl1?url=" + url));
		return url;
	}

	@RequestMapping(value = "goodback")
	@ResponseBody
	public String goodback(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("=========h货物扫描二维码回调=========");
		String returnStr = "";
		Map<String, String> result = new HashMap<String, String>();
		try {
			result = WXUtil.PushManageXml(request.getInputStream());
			if (result == null) {
				return "";
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("return_code", "SUCCESS");
			map.put("appid", result.get("appid"));
			map.put("mch_id", result.get("mch_id"));
			map.put("nonce_str", result.get("nonce_str"));
			WeChatAccount wca = weChatAccountService.getByAppid(result.get("appid"));
			String goodid = result.get("product_id");
			// Order or = orderService.getByCode(result.get("product_id"));
			if (goodid.equals("1111")) {
				String ccode = new Date().getTime() + Util.getRandomString(12);
				String pid = WXManage.getPrepay_id(wca, "账单", ccode, 1, Util.getMyIp(), SysConfig.notify_url, "NATIVE",
						goodid, "");
				map.put("prepay_id", pid);
				map.put("result_code", "SUCCESS");
				map.put("sign", WXUtil.getsign(map, wca.getApikey()));
				returnStr = WXUtil.getSendText(map);
			} else {
				map.put("result_code", "FAIL");
				map.put("err_code_des", "订单已处理");
				map.put("sign", WXUtil.getsign(map, wca.getApikey()));
				returnStr = WXUtil.getSendText(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}
}
