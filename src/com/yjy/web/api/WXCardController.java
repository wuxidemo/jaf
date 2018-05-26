package com.yjy.web.api;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.yjy.Temporary.service.ActcardrecordService;
import com.yjy.entity.Advert;
import com.yjy.entity.Business;
import com.yjy.entity.Inuser;
import com.yjy.entity.Merchant;
import com.yjy.entity.Order;
import com.yjy.entity.User;
import com.yjy.entity.WXCard;
import com.yjy.entity.WXCardRecord;
import com.yjy.entity.WXMerchant;
import com.yjy.service.AdvertService;
import com.yjy.service.BusinessService;
import com.yjy.service.ImportuserService;
import com.yjy.service.MerchantService;
import com.yjy.service.MyService;
import com.yjy.service.OrderService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXCardService;
import com.yjy.service.WXMerchantService;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;
import com.yjy.wechat.WxCardSign;

@Controller
@RequestMapping(value = "/wxcard")
public class WXCardController {

	@Autowired
	WXCardRecordService wXCardRecordService;
	@Autowired
	WXCardService wXCardService;
	@Autowired
	OrderService orderService;
	@Autowired
	AdvertService advertService;
	@Autowired
	MyService myService;
	@Autowired
	ImportuserService importuserService;

	@Autowired
	ActcardrecordService actcardrecordService;

	@Autowired
	MerchantService merchantService;

	@Autowired
	WXMerchantService wxMerchantService;

	@Autowired
	BusinessService businessService;

	@RequestMapping(value = "card1")
	public String getCardQode1(Model model) {
		model.addAttribute("src", WXCardManage.getCardQrcode(WXManage.WCA, "pKEL4shD66yLSKgskTB3IqsEtNV0"));
		return "wechat/card/card1";
	}

	@RequestMapping(value = "card2")
	public String getCardQode3(Model model) {
		Map<String, Object> d = new HashMap<String, Object>();
		Map<String, Object> sd = new HashMap<String, Object>();
		String t = (new Date().getTime() / 1000) + "";
		d.put("timestamp", t);
		d.put("outer_id", "0");

		WxCardSign signer = new WxCardSign();
		signer.AddData(WXManage.WCA.getJsapiticketforcard());
		signer.AddData(t);
		signer.AddData("pKEL4sg3kBafiQdNtCgcVqYfxpFY");
		String s = signer.GetSignature();
		d.put("signature", s);
		System.out.println(s);
		model.addAttribute("cardid", "pKEL4sg3kBafiQdNtCgcVqYfxpFY");
		model.addAttribute("card_ext", WXUtil.transMapToString(d));
		return "wechat/card/card2";
	}

	/**
	 * 
	 * 所有可领用卡券列表
	 * 
	 * @author luyf
	 * @date 2015年7月20日 下午3:39:27
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "cardlist")
	public String getCardQode2(Model model) {

		List<WXCard> lwxc = wXCardService.getAllUserCard();
		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();

		List<String> exts = new ArrayList<String>();

		String t = (new Date().getTime() / 1000) + "";

		for (WXCard wc : lwxc) {
			Map<String, Object> d = new HashMap<String, Object>();
			Map<String, Object> result = new HashMap<String, Object>();
			d.put("timestamp", t);
			d.put("outer_id", "0");// 领取标志 暂无使用
			WxCardSign signer = new WxCardSign();
			signer.AddData(WXManage.WCA.getJsapiticketforcard());
			signer.AddData(t);
			signer.AddData(wc.getCardid());
			d.put("signature", signer.GetSignature());

			result.put("cardid", wc.getCardid());
			exts.add(WXUtil.transMapToString(d));
			result.put("card", wc);
			data.add(result);
		}
		List<Advert> la = advertService.getList("preferential");
		if (la.size() >= 1) {
			model.addAttribute("ad", la.get(0));
		} else {
			model.addAttribute("ad", null);
		}
		model.addAttribute("exts", exts);
		model.addAttribute("data", data);

		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data1 = new HashMap<String, Object>();
		data1.put("timestamp", ts);
		data1.put("noncestr", radomstr);
		data1.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data1.put("url", SysConfig.BASEURL + "/wxcard/cardlist");// baseurl
		model.addAttribute("signature", WXUtil.getJSsign(data1));

		return "wechat/card/cardlist";
	}

	/*
	 * @RequestMapping(value = "getcardlist", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public Map<String, Object> getCardList(Model model) {
	 * 
	 * Map<String, Object> map = new HashMap<String, Object>();
	 * 
	 * List<WXCard> lwxc = wXCardService.getAllUserCard();
	 * 
	 * if (lwxc == null || lwxc.size() == 0) { map.put("result", "0"); return
	 * map; }
	 * 
	 * List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
	 * 
	 * String t = (new Date().getTime() / 1000) + "";
	 * 
	 * for (WXCard wc : lwxc) {
	 * 
	 * Map<String, Object> d = new HashMap<String, Object>();
	 * 
	 * Map<String, Object> result = new HashMap<String, Object>();
	 * 
	 * d.put("timestamp", t); d.put("outer_id", "0");// 领取标志 暂无使用
	 * 
	 * WxCardSign signer = new WxCardSign();
	 * signer.AddData(WXManage.WCA.getJsapiticketforcard()); signer.AddData(t);
	 * signer.AddData(wc.getCardid()); d.put("signature",
	 * signer.GetSignature());
	 * 
	 * result.put("cardid", wc.getCardid()); result.put("card", wc);
	 * 
	 * data.add(result); }
	 * 
	 * map.put("result", "1"); map.put("data", data); return map;
	 * 
	 * }
	 */

	/**
	 * 
	 * 我的卡券
	 * 
	 * @author luyf
	 * @date 2015年7月20日 下午3:39:52
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "mycardlist")
	public String getMyCardList(Model model, HttpServletRequest request) {
		String openid = request.getSession().getAttribute("openid").toString();
		List<Object[]> data = wXCardRecordService.getDataByOpenid(openid);
		model.addAttribute("data", data);
		List<Object[]> useddata = wXCardRecordService.getUsedDataByOpenid(openid);
		model.addAttribute("useddata", useddata);
		model.addAttribute("datasize", data.size());
		model.addAttribute("useddatasize", useddata.size());
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data1 = new HashMap<String, Object>();
		data1.put("timestamp", ts);
		data1.put("noncestr", radomstr);
		data1.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data1.put("url", SysConfig.BASEURL + "/wxcard/mycardlist");// baseurl
		model.addAttribute("signature", WXUtil.getJSsign(data1));

		return "wechat/card/mycard";
	}

	@RequestMapping(value = "owc")
	public String orderwithcard(Model model) {
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("timestamp", ts);
		data.put("noncestr", radomstr);
		data.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data.put("url", SysConfig.BASEURL + "/wxcard/owc");// baseurl +
		model.addAttribute("signature", WXUtil.getJSsign(data));
		return "wechat/card/ShowOrder";
	}

	@RequestMapping(value = "mycard")
	public String mycard() {
		return "wechat/card/mycard";
	}

	@RequestMapping(value = "checkcard")
	@ResponseBody
	public Map<String, Object> checkcard(@RequestParam(value = "code") String code, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		User u = (User) request.getSession().getAttribute("wxuser");
		if (u == null) {
			result.put("result", "0");
			result.put("msg", "登录已过期,请重新登录");
		} else {
			if (u.getMerchant() == null) {
				result.put("result", "0");
				result.put("msg", "非商户登录,请联系我们");
			} else {
				if (u.getMerchant().getWxlocationid() == null) {
					result.put("result", "0");
					result.put("msg", "商户信息错误,请联系管理员");
				} else {
					result = wXCardService.checkCard(code, u.getMerchant().getWxlocationid().toString());
				}
			}
		}
		return result;
	}

	String oderqrurl = "oderqrurl";

	@RequestMapping(value = "getpaycode")
	@ResponseBody
	public Map<String, String> getPayCode(@RequestParam(value = "price") Float price,
			@RequestParam(value = "codes", required = false) List<String> codes, HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		User u = (User) request.getSession().getAttribute("wxuser");
		if (u == null) {
			result.put("result", "0");
			result.put("msg", "登录已过期,请重新登录");
			return result;
		}
		if (u.getMerchant() == null) {
			result.put("result", "0");
			result.put("msg", "非商户登录,请联系我们");
			return result;
		}
		if (u.getMerchant().getWxlocationid() == null) {
			result.put("result", "0");
			result.put("msg", "商户信息错误,请联系管理员");
			return result;
		}
		List<WXCard> lwxc = new ArrayList<WXCard>();
		List<WXCardRecord> lwcr = new ArrayList<WXCardRecord>();
		List<Map<String, Object>> lm = new ArrayList<Map<String, Object>>();
		if (codes != null) {
			for (String code : codes) {
				Map<String, Object> wxmap = new HashMap<String, Object>();
				Map<String, Object> data = wXCardService.checkCard(code, u.getMerchant().getWxlocationid().toString());
				if (data.get("result").toString().equals("0")) {
					result.put("result", "0");
					result.put("msg", data.get("msg").toString());
					return result;
				} else {
					wxmap.put("code", code);
					wxmap.put("data", data.get("data"));
					lm.add(wxmap);
					lwxc.add((WXCard) data.get("data"));
					lwcr.add((WXCardRecord) data.get("rdata"));
				}
			}
		}
		int payprice = wXCardService.calculatePrice((int) (price * 100), lwxc, lwcr);

		for (WXCardRecord wcr : lwcr) {
			wXCardRecordService.save(wcr);
		}
		Order or = new Order();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String daystr = sdf.format(now);
		if (codes == null || codes.size() == 0) {
			or.setIsusecard(0);
		} else {
			or.setIsusecard(1);
		}
		or.setNeedprice(payprice);
		or.setCreatetime(now);
		or.setPrice((int) (price * 100));
		or.setPayprice(0);
		or.setCode(now.getTime() + Util.getRandomString(10));
		or.setMerchantid(u.getMerchant().getId());
		or.setMerhchantname(u.getMerchant().getName());
		if (payprice == 0) { // 当支付金额为0时 不需要支付
			or.setState(1);
			or.setPaytime(new Date());
			or.setNeedprice(0);
			if (lwcr.size() > 0) {
				or.setPayopenid(lwcr.get(0).getOpenid());
				or.setPayname(lwcr.get(0).getOwnname());
			}
			for (String c : codes) {
				WXCardManage.useCard(WXManage.WCA, c, null);
			}

		} else {
			or.setState(0);
		}
		or = orderService.update(or);
		if (codes != null) {
			for (String code : codes) {
				wXCardRecordService.updateUseState(u.getMerchant().getId(), u.getMerchant().getName(), or.getId(),
						or.getCode(), code);
			}
		}
		request.getSession().setAttribute("mycode", or.getCode());
		if (payprice == 0) {
			wXCardRecordService.updateState(2, new Date(), or.getId());
		}
		WXManage.CodeState.put(or.getCode(), "0");

		if (payprice == 0) {
			result.put("result", "1");
		} else {
			String url = "";
			String baseurl = "http://" + request.getLocalAddr() + ":" + request.getLocalPort()
					+ request.getContextPath();
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
				File f = new File(Util.getRootPath() + File.separator + oderqrurl + File.separator + daystr
						+ File.separator + d.getTime() + ".png");
				MatrixToImageWriter.writeToFile(bitMatrix, "png", f);
				url = oderqrurl + "/" + daystr + "/" + d.getTime() + ".png";
				result.put("result", "1");
				result.put("url", SysConfig.BASEURL + "/" + url);
			} catch (Exception e) {
				result.put("result", "0");
				e.printStackTrace();
			}
		}
		return result;
	}

	@RequestMapping(value = "ff")
	@ResponseBody
	public String ff() {
		wXCardRecordService.refreshCardRrcord();
		return "1";
	}

	/**
	 * 
	 * 使用礼品券
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午3:53:04
	 * @param code
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "usegift")
	public String useGiftCard(@RequestParam(value = "code") String code, Model model, HttpServletRequest request) {
		System.out.println("开始核销" + code + "============");
		Map<String, Object> result = new HashMap<String, Object>();
		User u = (User) request.getSession().getAttribute("wxuser");
		try {
			if (u == null) {
				result.put("result", 0);
				result.put("msg", "登录已过期,请重新登录");
			} else {
				if (u.getMerchant() == null) {
					result.put("result", 0);
					result.put("msg", "非商户登录,请联系我们");
				} else {
					if (u.getMerchant().getWxlocationid() == null) {
						result.put("result", 0);
						result.put("msg", "商户信息错误,请联系管理员");
					} else {
						result = wXCardService.checkCard(code, u.getMerchant().getWxlocationid().toString());
						if (result.get("result").toString().equals("1")) {
							WXCard wx = (WXCard) result.get("data");
							// if (!wx.getType().equals("GIFT")) {
							// result.put("result", 0);
							// result.put("msg", "只支持核销礼品券");
							// } else {
							Map<String, Object> data = WXCardManage.useCard(WXManage.WCA, code, null);
							if (data != null && data.get("errcode").toString().equals("0")) {
								result.put("result", 1);
								WXCardRecord wxr = (WXCardRecord) result.get("rdata");
								Order mo = new Order();
								Date now = new Date();
								mo.setCode(now.getTime() + Util.getRandomString(10));
								mo.setCreateopenid(wxr.getOpenid());
								mo.setCreatetime(now);
								mo.setIsusecard(1);
								mo.setMerchantid(u.getMerchant().getId());
								mo.setMerhchantname(u.getMerchant().getName());
								mo.setNeedprice(0);
								mo.setPayname(wxr.getOwnname());
								mo.setPayopenid(wxr.getOpenid());
								mo.setPayprice(0);
								mo.setPaytime(now);
								mo.setPrice(wx.getPrice());
								mo.setState(1);
								mo = orderService.update(mo);
								wxr.setMerchantid(u.getMerchant().getId());
								wxr.setMerchantname(u.getMerchant().getName());
								wxr.setOrderid(mo.getId());
								wxr.setOrdercode(mo.getCode());
								wxr.setUsetime(now);
								wxr.setState(2);
								wxr.setBankprice(wx.getBankper());
								wxr.setShopprice(wx.getShopper());
								wXCardRecordService.save(wxr);
							} else if (data != null && data.get("errcode").toString().equals("40099")) {
								result.put("result", 0);
								result.put("msg", "卡券已被使用");
							} else {
								result.put("result", 0);
								result.put("msg", "核销失败!");
							}
							// }
						}
					}
				}
			}
			model.addAttribute("data", result);

			Long ts = new Date().getTime();
			String radomstr = Util.getRandomString(6);
			model.addAttribute("appId", WXManage.WCA.getAppid());
			model.addAttribute("timestamp", ts);
			model.addAttribute("nonceStr", radomstr);
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("timestamp", ts);
			data.put("noncestr", radomstr);
			data.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
			data.put("url", SysConfig.BASEURL + "/wxcard/usegift");// baseurl
																	// +
			model.addAttribute("signature", WXUtil.getJSsign(data));
		} catch (Exception e) {
			System.out.println("===============核销失败===============");
			e.printStackTrace();
		}
		System.out.println("核销结束" + code + "============");
		return "wechat/card/useresult";
	}

	/**
	 * 
	 * 使用礼品券
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午3:53:04
	 * @param code
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "usecard")
	@ResponseBody
	public Map<String, Object> useCard(@RequestParam(value = "code") String code, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		User u = (User) request.getSession().getAttribute("wxuser");
		try {
			if (u == null) {
				result.put("result", 0);
				result.put("msg", "登录已过期,请重新登录");
			} else {
				if (u.getMerchant() == null) {
					result.put("result", 0);
					result.put("msg", "非商户登录,请联系我们");
				} else {
					if (u.getMerchant().getWxlocationid() == null) {
						result.put("result", 0);
						result.put("msg", "商户信息错误,请联系管理员");
					} else {
						int kind = checkcodes(code);
						System.out.println(kind);
						if (kind == 0) {
							result = wXCardService.checkCard(code, u.getMerchant().getWxlocationid().toString());
							if (result.get("result").toString().equals("1")) {
								WXCard wx = (WXCard) result.get("data");
								// if (!wx.getType().equals("GIFT")) {
								// result.put("result", 0);
								// result.put("msg", "只支持核销礼品券");
								// } else {
								Map<String, Object> data = WXCardManage.useCard(WXManage.WCA, code, null);
								if (data != null && data.get("errcode").toString().equals("0")) {
									WXCardRecord wxr = (WXCardRecord) result.get("rdata");
									Date now = new Date();
									wxr.setMerchantid(u.getMerchant().getId());
									wxr.setMerchantname(u.getMerchant().getName());
									wxr.setUsetime(now);
									wxr.setState(2);
									wxr.setBankprice(wx.getBankper());
									wxr.setShopprice(wx.getShopper());
									wXCardRecordService.save(wxr);
									result.put("result", 1);
									result.put("msg", "'" + wxr.getCardname() + "'核销成功!");
								} else if (data != null && data.get("errcode").toString().equals("40099")) {
									result.put("result", 0);
									result.put("msg", "卡券已被使用");
								} else {
									result.put("result", 0);
									if (data == null) {
										result.put("msg", "核销失败!错误编号：-2");
									} else {
										result.put("msg", "核销失败!错误编号:" + data.get("errcode"));
									}

								}
								// }
							}
						} else if (kind == 1) { // 系统卡券
							result = actcardrecordService.useWECard(code, u.getMerchant());
						} else {
							result.put("result", "0");
							result.put("msg", "未找到该卡券信息");
						}
					}
				}
			}
		} catch (Exception e) {
			result.put("result", 0);
			result.put("msg", "核销错误!");
			System.out.println("===============核销失败===============");
			e.printStackTrace();
		}
		return result;
	}

	public int checkcodes(String code) {
		if (code.length() == 12) {
			return 0;
		} else if (code.length() == 22 && code.startsWith("we")) {
			return 1;
		} else {
			return -1;
		}
	}

	/**
	 * 
	 * 积分兑换列表
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午3:52:32
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "jflist")
	public String jflist(HttpServletRequest request, Model model) {
		List<WXCard> data = myService.getAllJFUserCard();
		model.addAttribute("data", data);
		model.addAttribute("datasize", data.size());
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> d = new HashMap<String, Object>();
		d.put("timestamp", ts);
		d.put("noncestr", radomstr);
		d.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		d.put("url", SysConfig.BASEURL + "/wxcard/jflist");
		model.addAttribute("signature", WXUtil.getJSsign(d));
		return "wechat/jflist";
	}

	/**
	 * 
	 * 获取可用银行卡
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午4:31:39
	 * @param cardid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "bankcard")
	@ResponseBody
	public Map<String, Object> getJFData(@RequestParam(value = "cardid") String cardid, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			result.put("result", "0");
			result.put("msg", "登录超时请重新打开页面");
			return result;
		}
		WXCard wc = wXCardService.getWXCardByCardid(cardid);
		if (wc == null) {
			result.put("result", "0");
			result.put("msg", "未找到此优惠券");
			return result;
		}
		if (wc.getMytype() != 2) {
			result.put("result", "0");
			result.put("msg", "优惠券类型错误");
			return result;
		}
		List<Inuser> liu = importuserService.getUseListByOpenid(openid.toString());
		List<String> exts = new ArrayList<String>();
		List<Map<String, String>> lm = new ArrayList<Map<String, String>>();
		String t = (new Date().getTime() / 1000) + "";
		for (Inuser iu : liu) {
			Map<String, Object> d = new HashMap<String, Object>();
			Map<String, String> r = new HashMap<String, String>();
			d.put("timestamp", t);
			d.put("outer_id", iu.getId());// 领取标志 暂无使用
			WxCardSign signer = new WxCardSign();
			signer.AddData(WXManage.WCA.getJsapiticketforcard());
			signer.AddData(t);
			signer.AddData(cardid);
			d.put("signature", signer.GetSignature());
			exts.add(WXUtil.transMapToString(d));
			try {
				r.put("cardnum", iu.getCardnum().substring(0, 4) + " **** **** "
						+ iu.getCardnum().substring(iu.getCardnum().length() - 4));
			} catch (Exception e) {
				System.out.println("银行卡格式错误");
				continue;
			}
			r.put("points", iu.getPoint() + "");
			r.put("can", (iu.getPoint() >= wc.getCount() ? "1" : "0"));
			lm.add(r);
		}
		result.put("result", "1");
		result.put("cards", lm);
		result.put("exts", exts);
		return result;
	}

	/*
	 * @RequestMapping(value = "mybankcard")
	 * 
	 * @ResponseBody public Map<String, Object>
	 * getMyBankCardList(HttpServletRequest request) {
	 * 
	 * Map<String, Object> map = new HashMap<String, Object>();
	 * 
	 * Object openid = request.getSession().getAttribute("openid"); if (openid
	 * == null) { map.put("result", "0"); map.put("message", "登录超时请重新打开页面");
	 * }else{ List<Inuser> inlist =
	 * importuserService.getUseListByOpenid(openid.toString()); if(inlist !=
	 * null && inlist.size() > 0) { for(Inuser in : inlist) { String cardnum =
	 * in.getCardnum(); try { in.setCardnum(cardnum.substring(0, 4) +
	 * " **** **** " + cardnum.substring(cardnum.length() - 4)); } catch
	 * (Exception e) { // TODO Auto-generated catch block
	 * System.out.println("银行卡格式错误"); continue; } importuserService.update(in);
	 * } map.put("result", "1"); map.put("data", inlist);
	 * 
	 * }else{ map.put("result", "0"); map.put("message", "没有绑定任何银行卡"); } }
	 * 
	 * return map; }
	 */

	@RequestMapping(value = "mybankcard")
	public String getMyBankCardList(Model model, HttpServletRequest request) {

		Object openid = request.getSession().getAttribute("openid");

		List<Inuser> inlist = importuserService.getUseListByOpenid(openid.toString());
		if (inlist != null && inlist.size() > 0) {
			for (Inuser in : inlist) {
				String cardnum = in.getCardnum();
				try {
					in.setCardnum(cardnum.substring(0, 4) + " **** **** " + cardnum.substring(cardnum.length() - 4));

					in.setPhone(cardnum);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					System.out.println("银行卡格式错误");
					continue;
				}
			}
		}

		model.addAttribute("cardlist", inlist);
		return "wechat/mybankcardlist";

	}

	/*-----------------------------------------------------------操作优惠券部分----------------------------------------------------------------*/

	/* 查找出全城所有的商圈 */
	@RequestMapping(value = "/business")
	@ResponseBody
	public Map<String, Object> getlistbusness(Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Business> buslist = businessService.getList();
		map.put("businsslist", buslist);
		return map;
	}

	/* 根据传过来的商圈id查找可用的卡券 */
	@RequestMapping(value = "/cardlist1")
	@ResponseBody
	public Map<String, Object> felllist(HttpServletRequest request, @RequestParam(value = "busid") Long busid) {
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * List<Map<String, Object>> date1 = new ArrayList<Map<String,
		 * Object>>();
		 */
		/* List<WXCard> listbus = new ArrayList<WXCard>(); */

		/* 对时间进行格式化 */
		Date d = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date2 = dd.format(d);

		int id = busid.intValue();
		// 根据传过来的商圈找到他的商家
		List<Object> listbuscar = merchantService.getcarlist(id, date2);
		/*
		 * for (int i = 0; i < list.size(); i++) { //根据商户id找到其自商户 WXMerchant
		 * wxer=wxMerchantService.getWXMOrNew(list.get(i).getId());
		 * if(wxer!=null){ 根据子商户的id找到卡券 List<WXCard>
		 * list2=wXCardService.getlist(wxer.getId(),date2); for (int j = 0; j
		 * <list2.size(); j++) { listbus.add(list2.get(j)); } } }
		 */

		/*
		 * String t = (new Date().getTime() / 1000) + ""; for(WXCard
		 * wc:listbus){ Map<String, Object> d=new HashMap<String,Object>();
		 * Map<String, Object> result=new HashMap<String,Object>();
		 * d.put("timestamp", t); d.put("outer_id", "0");// 领取标志 暂无使用 WxCardSign
		 * signer = new WxCardSign();
		 * signer.AddData(WXManage.WCA.getJsapiticketforcard());
		 * signer.AddData(t); signer.AddData(wc.getCardid()); d.put("signature",
		 * signer.GetSignature());
		 * 
		 * result.put("cardid", wc.getCardid());
		 * exts.add(WXUtil.transMapToString(d)); result.put("card", wc);
		 * date1.add(result); }
		 */
		map.put("data", listbuscar);
		return map;
	}

	/* 对卡券进行排序 */
	@RequestMapping(value = "/sort")
	@ResponseBody
	public Map<String, Object> getlist(Model model, HttpServletRequest request,
			@RequestParam(value = "type") String type, @RequestParam(value = "busid") Long busid) {
		Map<String, Object> map = new HashMap<String, Object>();

		int id = busid.intValue();
		/* 对时间进行格式化 */
		Date d = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date1 = /* dd.format(d); */"2015-11-12";
		/* 按领用经行排序 */
		if (type.equals("recipients")) {
			List<Object> list1 = wXCardService.getlistsum(date1, id);
			map.put("list", list1);
		}
		/* 按折扣最大经行排序 */
		if (type.equals("discount")) {
			List<Object> list2 = wXCardService.getprilist(date1);
			map.put("list", list2);
		}
		/* 按照上架时间经行排序 */
		if (type.equals("newdate")) {
			List<Object> list3 = wXCardService.getdatelist(date1, id);
			map.put("list", list3);
		}
		return map;
	}

}
