package com.yjy.web.api;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.yjy.Temporary.entity.Actcardrecord;
import com.yjy.Temporary.service.ActcardrecordService;
import com.yjy.entity.Merchant;
import com.yjy.entity.Payorder;
import com.yjy.entity.RefundOrder;
import com.yjy.entity.User;
import com.yjy.entity.WXCard;
import com.yjy.entity.WXCardRecord;
import com.yjy.entity.WXUser;
import com.yjy.service.MerchantService;
import com.yjy.service.PayorderService;
import com.yjy.service.RefundOrderService;
import com.yjy.service.UserService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXCardService;
import com.yjy.service.WXUserService;
import com.yjy.utils.SendMessage;
import com.yjy.utils.Util;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/appapi")
public class AppApiController {
	@Autowired
	UserService userService;
	@Autowired
	WXCardService wXCardService;
	@Autowired
	MerchantService merchantService;
	@Autowired
	WXCardRecordService wXCardRecordService;
	@Autowired
	ActcardrecordService actcardrecordService;
	@Autowired
	PayorderService payorderService;
	@Autowired
	RefundOrderService refundOrderService;
	@Autowired
	WXUserService wXUserService;

	@RequestMapping(value = "login")
	@ResponseBody
	public Map<String, Object> login(@RequestParam(value = "name") String name,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "issave", required = false) String issave, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = userService.findBytelephone(name);
		if (user != null) {
			boolean flag = userService.decryptPassword(user, password);
			Integer enabled = user.getEnabled();
			if (!flag) {
				result.put("result", "0");
				result.put("msg", "您输入的密码和手机号码不匹配,请重新输入!");
			} else if (enabled == 0) {
				result.put("result", "0");
				result.put("msg", "账号已被冻结!");
			} else if (user.getMerchant() == null) {
				result.put("result", "0");
				result.put("msg", "此账户不是商户用户");
			} else {
				result.put("result", "1");
				Map<String, String> loginuser = new HashMap<String, String>();
				loginuser.put("name", user.getName());
				loginuser.put("realname", user.getRealname());
				loginuser.put("telephone", user.getTelephone());
				result.put("user", loginuser);
				Map<String, String> mer = new HashMap<String, String>();
				mer.put("id", user.getMerchant().getId().toString());
				mer.put("wxpaynum", user.getMerchant().getWxpaynum());
				mer.put("alipaynum", user.getMerchant().getAlipaynum());
				mer.put("name", user.getMerchant().getName());
				mer.put("province", user.getMerchant().getProvince());
				mer.put("city", user.getMerchant().getCity());
				mer.put("district", user.getMerchant().getDistrict());
				mer.put("address", user.getMerchant().getAddress());
				result.put("mer", mer);

			}
		} else {
			result.put("result", "0");
			result.put("msg", "您输入的手机号码不存在,请重新输入!");
		}
		return result;
	}

	@RequestMapping(value = "usecard")
	@ResponseBody
	public Map<String, Object> useCard(@RequestParam(value = "code") String code,
			@RequestParam(value = "merid") String merid, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Merchant mer = merchantService.get(Long.parseLong(merid));
			if (mer == null) {
				result.put("result", "0");
				result.put("msg", "未找到对应商户");
			} else {
				int kind = checkcodes(code);
				if (kind == 0) {
					result = wXCardService.checkCard(code, mer.getWxlocationid().toString());
					if (result.get("result").toString().equals("1")) {
						WXCard wx = (WXCard) result.get("data");
						Map<String, Object> data = WXCardManage.useCard(WXManage.WCA, code, null);
						if (data != null && data.get("errcode").toString().equals("0")) {
							WXCardRecord wxr = (WXCardRecord) result.get("rdata");
							Date now = new Date();
							wxr.setMerchantid(mer.getId());
							wxr.setMerchantname(mer.getName());
							// wxr.setOrderid(mo.getId());
							// wxr.setOrdercode(mo.getCode());
							wxr.setUsetime(now);
							wxr.setState(2);
							wxr.setBankprice(wx.getBankper());
							wxr.setShopprice(wx.getShopper());
							wxr = wXCardRecordService.save(wxr);
							result.put("result", "1");
							result.put("msg", "'" + wxr.getCardname() + "'核销成功!");
							result.put("card", wxr);
						} else if (data != null && data.get("errcode").toString().equals("40099")) {
							result.put("result", "0");
							result.put("msg", "卡券已被使用");
						} else if (data != null && data.get("errcode").toString().equals("40079")) {
							result.put("result", "0");
							result.put("msg", "卡券不在有效时间内");
						} else {
							result.put("result", "0");
							result.put("msg", "核销失败!");
						}
						// }
					}
				} else if (kind == 1) { // 系统卡券
					result = actcardrecordService.useWECard(code, mer);
				} else {
					result.put("result", "0");
					result.put("msg", "未找到该卡券信息");
				}
			}
		} catch (Exception e) {
			result.put("result", "0");
			result.put("msg", "核销失败!");
			System.out.println("===============核销失败===============");
			e.printStackTrace();
		}
		return result;
	}

	/************************************************
	 * 以下是App端忘记密码，并找回密码的功能
	 *******************************************************/

	@RequestMapping(value = "getcode")
	@ResponseBody
	public Map<String, Object> getCode(@RequestParam("phone") String phone) {

		Map<String, Object> map = new HashMap<String, Object>();

		if (userService.findByTelephone(phone) == null) {
			map.put("result", "0");
			map.put("msg", "手机号码未注册，请确认");

			return map;
		} else {

			System.out.println(new Date().getTime());

			User user = userService.findByTelephone(phone);

			String captcha = Util.getCaptcha();
			user.setCaptcha(captcha);
			user.setStarttime(new Date());
			userService.saveCaptcha(user);
			SendMessage.sendYZMSMS(user.getTelephone(), captcha + "（金阿福e服务找回密码验证码，请完成验证），如非本人操作，请忽略本短信【金阿福e服务】", "");

			map.put("result", "1");
			map.put("msg", "验证码发送成功，请注意查收");

			return map;
		}

	}

	@RequestMapping(value = "checkcode")
	@ResponseBody
	public Map<String, Object> checkCode(@RequestParam(value = "phone") String phone,
			@RequestParam(value = "code") String code) {

		Map<String, Object> map = new HashMap<String, Object>();

		if (code == null || "".equals(code.trim()) || "null".equals(code.trim())) {
			map.put("result", "0");
			map.put("msg", "没有输入验证码");
			return map;
		} else {
			code = code.trim();
		}

		User user = userService.findByTelephone(phone);

		if (user == null) {
			map.put("result", "0");
			map.put("msg", "手机号码未注册");
			return map;
		} else {

			long nowdatelong = new Date().getTime();

			Date capcreatetime = user.getStarttime();

			if (capcreatetime == null) {
				map.put("result", "0");
				map.put("msg", "验证码错误或已失效，请重新获取验证码");
				return map;
			} else {
				long capcreatelong = capcreatetime.getTime();

				long cha = nowdatelong - capcreatelong;

				if (cha > 60000) {
					map.put("result", "0");
					map.put("msg", "验证码已失效，请重新获取验证码");
					return map;
				} else {

					if (code.equals(user.getCaptcha())) {

						map.put("result", "1");
						map.put("msg", "验证成功");
						return map;
					} else {
						map.put("result", "0");
						map.put("msg", "验证码错误");
						return map;
					}
				}
			}
		}
	}

	@RequestMapping(value = "setnewpass")
	@ResponseBody
	public Map<String, Object> setNewPass(@RequestParam(value = "phone") String phone,
			@RequestParam(value = "newpass") String newpass) {

		System.out.println("+++++++++" + phone);
		System.out.println("+++++++++" + newpass);

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User user = userService.findByTelephone(phone.trim());
			user.setPassword(newpass);
			userService.saveorupdate(user);

			map.put("result", "1");
			map.put("msg", "密码修改成功,请重新登录");
			return map;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "系统错误，密码修改失败，请稍后重试！");
			return map;
		}
	}

	/********************************************************************************************************************************/

	/**
	 * 
	 * 区分编号 （12位为微信卡券）
	 * 
	 * @author lyf
	 * @date 2015年11月5日 下午4:43:15
	 * @param code
	 * @return
	 */
	public int checkcodes(String code) {
		if (code.length() == 12) {
			return 0;
		} else if (code.length() == 22 && code.startsWith("we")) {
			return 1;
		} else {
			return -1;
		}
	}

	@RequestMapping(value = "crlist")
	@ResponseBody
	public Map<String, Object> getCardRecordList(@RequestParam(value = "time") String time,
			@RequestParam(value = "merid") String merid, @RequestParam(value = "type") String type,
			@RequestParam(value = "cardid", required = false) String cardid) {
		Map<String, Object> result = new HashMap<String, Object>();
		Merchant mer = merchantService.get(Long.parseLong(merid));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if (mer == null) {
			result.put("result", "0");
			result.put("msg", "未找到对应商户");
		} else {
			// 抵用券记录
			if (type.equals("2")) {
				List<Actcardrecord> la = actcardrecordService.getMerUsedRecord(time, Long.parseLong(merid));
				List<Map<String, String>> datas = new ArrayList<Map<String, String>>();
				for (Actcardrecord a : la) {
					Map<String, String> data = new HashMap<String, String>();
					data.put("cardname", a.getName());
					data.put("code", a.getCode());
					data.put("ownname", a.getNickname());
					data.put("usetime", sdf.format(a.getUsedate()));
					datas.add(data);
				}
				result.put("result", "1");
				result.put("data", datas);
			} else {
				List<Object[]> lwr = new ArrayList<Object[]>();
				if (cardid == null)
					lwr = wXCardRecordService.getMerUsedRecord(time, Long.parseLong(merid));
				else
					lwr = wXCardRecordService.getMerUsedRecordByCardid(time, Long.parseLong(merid), cardid);
				List<Map<String, String>> datas = new ArrayList<Map<String, String>>();
				for (Object[] wcr : lwr) {
					Map<String, String> data = new HashMap<String, String>();
					data.put("cardname", wcr[0] == null ? "" : wcr[0].toString());
					data.put("code", wcr[1] == null ? "" : wcr[1].toString());
					data.put("ownname", wcr[2] == null ? "" : wcr[2].toString());
					data.put("usetime", wcr[3] == null ? "" : sdf.format(wcr[3]));
					data.put("bank", wcr[4] == null ? "0" : wcr[4].toString());
					data.put("shop", wcr[5] == null ? "0" : wcr[5].toString());
					datas.add(data);
				}
				result.put("result", "1");
				result.put("data", datas);
			}

		}
		return result;
	}

	/**
	 * test notify_action_type /{type}/{id}
	 */
	Map<String, String> resultMap = null;

	@ResponseBody
	@RequestMapping("/alipaycallback/{orderNum}")
	public String alipaycallback(HttpServletRequest request, @PathVariable(value = "orderNum") String orderNum) {
		System.out.println("=====支付宝回调=====");
		String result = "";
		BufferedReader in;
		try {
			in = new BufferedReader(new InputStreamReader(request.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			System.out.println("回调返回结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		resultMap = new HashMap<>();
		resultMap.put(orderNum, result);
		return result;
	}

	@ResponseBody
	@RequestMapping("/alipay")
	public Map<String, String> alipay(HttpServletRequest request) {
		return resultMap;
	}

	@ResponseBody
	@RequestMapping("/cardnames")
	public List<Map<String, String>> getCardNames(@RequestParam(value = "time") String time,
			@RequestParam(value = "merid") String merid) {
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		for (Object[] o : wXCardRecordService.getCardNames(Long.parseLong(merid), time)) {
			Map<String, String> data = new HashMap<String, String>();
			data.put("name", o[1].toString());
			data.put("cardid", o[0].toString());
			result.add(data);
		}
		return result;
	}

	/**
	 * 支付订单存储
	 * 
	 * @param request
	 * @param total
	 *            付款金额
	 * @param merchantid
	 *            商户id
	 * @param ordernum
	 *            交易单号
	 * @param nickname
	 *            付款昵称
	 * @param translatenum
	 *            商户单号
	 * @param paytype
	 *            支付方式
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/savealipay")
	public Map<String, Object> savealipay(HttpServletRequest request, String total, Long merchantid, String ordernum,
			String nickname, String translatenum, String paytype,
			@RequestParam(value = "createtime", required = false) String createtime) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (payorderService.findByOrdernum(ordernum) != null) {
			result.put("result", "2");// 订单已存在
			return result;
		}
		Payorder payorder = new Payorder();
		payorder.setMerchantid(merchantid);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		if (createtime == null) {
			payorder.setCreatetime(new Date());
		} else {
			try {
				payorder.setCreatetime(sdf.parse(createtime));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if ("2".equals(paytype)) {
			payorder.setTotal(Integer.parseInt(total));
		} else {
			payorder.setTotal((int) (Float.parseFloat(total) * 100));
		}
		payorder.setOrdernum(ordernum);
		if ("2".equals(paytype)) {
			WXUser wu = wXUserService.getOrNewWXUser(nickname);
			payorder.setNickname(wu.getRealname());
			payorder.setOpenid(nickname);
		} else {
			payorder.setNickname(nickname);
		}

		payorder.setTranslatenum(translatenum);
		payorder.setPaytype(paytype);
		payorder.setState(1);
		if (payorderService.save(payorder) != null) {
			result.put("result", "1");
		} else {
			result.put("result", "0");
		}

		return result;
	}

	/**
	 * 根据参数返回支付订单列表
	 * 
	 * @param request
	 * @param createtime
	 *            付款日期 yyyyMMdd
	 * @param merchantid
	 *            商户id
	 * @param paytype
	 *            支付类型 0全部 1支付宝 2微信
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getPayorders")
	public Map<String, Object> getPayorders(HttpServletRequest request, String createtime, Long merchantid,
			String paytype) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> obj = null;
		List<Map<String, Object>> objs = new ArrayList<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		List<Payorder> payOrders = null;
		if ("0".equals(paytype)) {
			payOrders = payorderService.getAllPayorders(createtime, merchantid);
		} else {
			payOrders = payorderService.getPayorders(createtime, merchantid, paytype);
		}
		for (Payorder payorder : payOrders) {
			obj = new HashMap<>();
			obj.put("merchantid", payorder.getMerchantid());
			obj.put("createtime", sdf.format(payorder.getCreatetime()));
			obj.put("total", payorder.getTotal());
			obj.put("merchantid", payorder.getMerchantid());
			obj.put("ordernum", payorder.getOrdernum());
			obj.put("nickname", payorder.getNickname());
			obj.put("translatenum", payorder.getTranslatenum());
			obj.put("paytype", payorder.getPaytype());
			obj.put("state", payorder.getState());
			objs.add(obj);
		}
		if (objs.size() == 0) {
			result.put("msg", 0);
		} else {
			result.put("msg", 1);
			result.put("obj", objs);
		}
		return result;
	}

	// --------------app下载及更新功能------------------------------
	/**
	 * @param request
	 * @param versio
	 * @return 最新版本app地址
	 */
	@ResponseBody
	@RequestMapping("/getAppUrl")
	public String getAppUrl(HttpServletRequest request, String version) {
		String pbasepath = request.getSession().getServletContext().getRealPath("/");
		String mybasepath = pbasepath + File.separator + "static" + File.separator + "app";
		File file = new File(mybasepath);
		File[] tempList = file.listFiles();
		boolean mustUpdate = false;
		List<String> verList = new ArrayList<>();
		for (int i = 0; i < tempList.length; i++) {
			if (tempList[i].isDirectory()) {
				verList.add(tempList[i].getName());
				if (version.compareTo(tempList[i].getName()) < 0) {
					mustUpdate = true;
				}
			}
		}
		// 如果需要获取最新版本，对版本号排序，取出最大值
		if (mustUpdate) {
			String[] verArray = new String[verList.size()];
			for (int i = 0; i < verList.size(); i++) {
				verArray[i] = verList.get(i);
			}
			Arrays.sort(verArray);
			String newVer = verArray[verArray.length - 1];
			String path = "http://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath()
					+ "/";
			return path + "/static/" + "app/" + newVer + "/JinAFu.apk";
		}
		return null;
	}

	/**
	 * 
	 * 退款接口
	 * 
	 * @author lyf
	 * @date 2016年1月4日 上午9:53:14
	 * @param merchantid
	 * @param syscode
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "payrefund")
	@ResponseBody
	public Map<String, String> payRefund(@RequestParam(value = "merchantid") Long merchantid,
			@RequestParam(value = "ordernum") String ordernum, @RequestParam(value = "type") String type) {
		Map<String, String> data = new HashMap<String, String>();
		Merchant mer = merchantService.get(merchantid);
		if (mer == null) {
			data.put("result", "0");
			data.put("msg", "未找到对应商家");
			return data;
		}
		Payorder po = payorderService.getOrNew(ordernum, type, mer.getWxpaynum(), mer.getId());
		if (po == null) {
			data.put("result", "0");
			data.put("msg", "未查到相应订单");
		} else {
			if (!po.getPaytype().equals(type)) {
				data.put("result", "0");
				data.put("msg", "订单信息不符合");
			} else {
				Date now = new Date();
				RefundOrder ro = new RefundOrder();
				ro.setCreatetime(now);
				ro.setMerchantid(merchantid);
				ro.setOpenid(po.getOpenid());
				ro.setOrdernum(ordernum);
				ro.setRefundfee(po.getTotal());
				ro.setPayorderid(po.getId());
				// 支付宝
				if (type.equals("1")) {
					ro.setState(2);
					po.setState(3);
				} else if (type.equals("2")) { // 微信
					Map<String, String> result = WXManage.payRefundSub(WXManage.WCA, mer.getWxpaynum(), ordernum,
							po.getTotal(), po.getTotal());
					if (result.get("result").equals("1")) {
						ro.setRefundcode(result.get("tkcode"));
						po.setState(2);
						ro.setState(1);
					} else {
						data.put("result", "0");
						data.put("msg", "退款失败");
						return data;
					}
				}
				refundOrderService.save(ro);
				payorderService.save(po);
				data.put("result", "1");
			}
		}
		return data;
	}
}
