package com.yjy.wechat;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.yjy.entity.WeChatAccount;
import com.yjy.utils.Util;

/**
 * 微信平台开发封装方法
 * 
 * @author lyf
 *
 */
public class WXManage {

	public static WeChatAccount WCA;

	public static Map<String, String> CodeState = new HashMap<String, String>(); // 存放订单支付状态，给页面查询用

	public static String getCodeUrl(String state) {
		return "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WCA.getAppid() + "&redirect_uri="
				+ SysConfig.redirect_uri + "&response_type=code&scope=snsapi_base&state=" + state + "#wechat_redirect";
	}

	/**
	 * 
	 * 获取AccessToken
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午1:59:14
	 * @param wca
	 * @return
	 */
	public static String getAccessToken(WeChatAccount wca) {
		String at = null;
		String sendurl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=";
		String result = WXUtil.sendGet(sendurl + wca.getAppid() + "&secret=" + wca.getAppsecret(), "");
		if (result.equals("")) {
			System.out.println("!!!!!!!获取ACCESSTOKEN失败！！！！！！！！");
		} else {
			try {
				JSONObject jo = new JSONObject(result);
				at = jo.getString("access_token");
				System.out.println("ACCESS_TOKEN:" + at);
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取ACCESSTOKEN失败！！！！！！！！");
				e.printStackTrace();
			}
		}
		return at;
	}

	/**
	 * 
	 * 获取js sdk api_ticket
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:01:15
	 * @param wca
	 * @return
	 */
	public static String Getjsapi_ticket(String accesstoken) {
		String JSAPI_TICKET = null;
		String sendurl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=";
		String result = WXUtil.sendGet(sendurl + accesstoken + "&type=jsapi", "");
		if (result.equals("")) {
			System.out.println("!!!!!!!获取jsapi_ticket失败！！！！！！！！");
		} else {
			try {
				JSONObject jo = new JSONObject(result);
				JSAPI_TICKET = jo.getString("ticket");
				System.out.println("JSAPI_TICKET:" + JSAPI_TICKET);
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取JSAPI_TICKET失败！！！！！！！！");
				e.printStackTrace();
			}
		}
		return JSAPI_TICKET;
	}

	/**
	 * 
	 * 获取领取优惠券 api_ticket
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:01:15
	 * @param wca
	 * @return
	 */
	public static String Getjsapi_ticketForCard(String accesstoken) {
		String JSAPI_TICKET = null;
		String sendurl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=";
		String result = WXUtil.sendGet(sendurl + accesstoken + "&type=wx_card", "");
		if (result.equals("")) {
			System.out.println("!!!!!!!获取jsapi_ticket失败！！！！！！！！");
		} else {
			try {
				JSONObject jo = new JSONObject(result);
				JSAPI_TICKET = jo.getString("ticket");
				System.out.println("JSAPI_TICKET:" + JSAPI_TICKET);
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取JSAPI_TICKET失败！！！！！！！！");
				e.printStackTrace();
			}
		}
		return JSAPI_TICKET;
	}

	/**
	 * 
	 * 生成永久二维码
	 * 
	 * @author lyf
	 * @date 2015年10月23日 上午11:53:33
	 * @param wca
	 * @param kind
	 *            1整型 2字符串
	 * @param code
	 * @return
	 */
	public static String getForeverQRCode(String accesstoken, int kind, String code) {
		String url = "";
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> action_info = new HashMap<String, Object>();
		Map<String, Object> scene = new HashMap<String, Object>();
		data.put("expire_seconds", 3600);
		if (kind == 1) {
			data.put("action_name", "QR_LIMIT_SCENE");
			scene.put("scene_id", Long.parseLong(code));
		} else {
			data.put("action_name", "QR_LIMIT_STR_SCENE");
			scene.put("scene_str", code);
		}
		action_info.put("scene", scene);
		data.put("action_info", action_info);
		String result = WXUtil.sendPost("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + accesstoken,
				WXUtil.transMapToString(data));
		if (result.equals("")) {
			System.out.println("!!!!!!!获取ticket失败！！！！！！！！");
		} else {
			try {
				JSONObject jo = new JSONObject(result);
				url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo.getString("ticket");
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取ticket失败！！！！！！！！");
				e.printStackTrace();
			}
		}
		return url;
	}

	/**
	 * 
	 * 获取临时二维码
	 * 
	 * @author lyf
	 * @date 2015年10月23日 下午12:24:35
	 * @param wca
	 * @param code
	 * @return
	 */
	public static String getLimitQRCode(String accesstoken, Long code) {
		String url = "";
		Map data = new HashMap();
		Map action_info = new HashMap();
		Map scene = new HashMap();
		data.put("expire_seconds", Integer.valueOf(3600));
		data.put("action_name", "QR_SCENE");
		scene.put("scene_id", code);
		action_info.put("scene", scene);
		data.put("action_info", action_info);
		String result = WXUtil.sendPost("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + accesstoken,
				WXUtil.transMapToString(data));
		if (result.equals(""))
			System.out.println("!!!!!!!获取ticket失败！！！！！！！！");
		else {
			try {
				JSONObject jo = new JSONObject(result);
				url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo.getString("ticket");
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取ticket失败！！！！！！！！");
				System.out.println("错误输出:" + result);
				e.printStackTrace();
			}
		}
		return url;
	}

	/**
	 * 
	 * 获取用户基本信息
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:07:43
	 * @param wca
	 * @param openid
	 * @return
	 */
	public static Map<String, String> getUserInfo(String accesstoken, String openid) {
		String sendurl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=";
		String result = WXUtil.sendGet(sendurl + accesstoken + "&openid=" + openid + "&lang=zh_CN", "");
		if (result.equals("") || result == null) {
			System.out.println("!!!!!!!获取用户信息失败！！！！！！！！" + openid);
			return null;
		} else {
			Map<String, String> data = new HashMap<String, String>();
			try {
				JSONObject jo = new JSONObject(result);
				if (!jo.isNull("errcode")) {
					System.out.println("====获取用户信息错误====" + jo.getString("errmsg") + "++" + openid);
				}
				if (jo.getString("subscribe").equals("1")) {
					data.put("subscribe", "1");
					data.put("openid", jo.getString("openid"));
					String name = jo.getString("nickname");
					String realname = "";
					for (int i = 0; i < name.length(); i++) {
						if (!Util.isMessyCode(name.charAt(i) + ""))
							realname += name.charAt(i);
					}
					data.put("realname", realname.equals("") ? "微信用户" : realname);
					data.put("sex", jo.getString("sex"));
					data.put("state", jo.getString("subscribe"));
					data.put("headimgurl", jo.getString("headimgurl"));
					data.put("country", jo.getString("country"));
					data.put("province", jo.getString("province"));
					data.put("city", jo.getString("city"));

				} else {
					data.put("subscribe", "0");
					data.put("openid", jo.getString("openid"));
				}
				return data;
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取用户信息失败！！！！！！！！" + openid);
				e.printStackTrace();
				return null;
			}
		}
	}

	/**
	 * 
	 * 网页授权获取用户基本信息 获取 网页access_token(与后台获取的access_token不同)和openid
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:10:32
	 * @param wca
	 * @param code
	 * @return
	 */
	public static Map<String, String> getPageAKAndOpenid(WeChatAccount wca, String code) {
		String sendurl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=";
		String result = WXUtil.sendGet(sendurl + wca.getAppid() + "&secret=" + wca.getAppsecret() + "&code=" + code
				+ "&grant_type=authorization_code", "");
		if (result.equals("")) {
			System.out.println("!!!!!!!网页授权信息失败！！！！！！！！");
			return null;
		} else {
			Map<String, String> data = new HashMap<String, String>();
			try {
				JSONObject jo = new JSONObject(result);
				data.put("openid", jo.getString("openid"));
				data.put("accesstoken", jo.getString("access_token"));
				return data;
			} catch (JSONException e) {
				System.out.println("!!!!!!!网页授权信息失败！！！！！！！！");
				System.out.println(result);
				e.printStackTrace();
				return null;
			}
		}
	}

	/**
	 * 
	 * 获取全部用户 1000人以内
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:11:13
	 * @param wca
	 * @return
	 */
	public static JSONArray getAllOpenid(String accesstoken) {
		String sendurl = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=";
		String result = WXUtil.sendGet(sendurl + accesstoken + "&next_openid=", "");
		if (result.equals("")) {
			System.out.println("!!!!!!!获取全部用户息失败！！！！！！！！");
			return null;
		} else {
			try {
				JSONObject jo = new JSONObject(result);
				// int total = jo.getInt("total");
				// int count = jo.getInt("count");
				JSONObject jdata = jo.getJSONObject("data");
				JSONArray ja = jdata.getJSONArray("openid");

				return ja;
			} catch (JSONException e) {
				System.out.println("!!!!!!!获取全部用户信息失败！！！！！！！！");
				e.printStackTrace();
				return null;
			}
		}
	}

	/**
	 * 
	 * 对单个微信用户发红包
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:18:46
	 * @param wca
	 *            微信账号对象
	 * @param openid
	 * @param money
	 *            金额(单位分)
	 * @param wishString
	 *            祝福语 （展示）
	 * @param remark
	 *            备注 （无展示）
	 * @param nickname
	 *            提供方名称 （无展示）
	 * @param sendname
	 *            红包发送者名称 （展示）
	 * @param actname
	 *            活动名称 （无展示）
	 * @return
	 */
	public static Boolean sendPrize(WeChatAccount wca, String openid, int money, String wishString, String remark,
			String nickname, String sendname, String actname, String billno) {
		// TODO 未完全封装好
		// ofmf3tz1lzgHfANti4MLNm6eKTUk
		// Sk4KkLhWKUd-kwxX1Ub_MKJ971leBQA7bo6j_WemTgyQE5lOmN67ZrYT6fpgp83SW5M4P_FPBjaePmSDjihNxZgQQdXWX-ktFRGGER5Oqz4
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nonce_str", Util.getRandomString(10));
		map.put("mch_billno", billno);
		map.put("mch_id", wca.getMcid());
		map.put("wxappid", wca.getAppid());
		map.put("nick_name", nickname);
		map.put("send_name", sendname);
		map.put("re_openid", openid);
		map.put("total_amount", money);
		map.put("min_value", money);
		map.put("max_value", money);
		map.put("total_num", 1);
		map.put("wishing", wishString);
		map.put("client_ip", "192.168.1.1");
		map.put("act_name", actname);
		map.put("remark", remark);
		String sign = WXUtil.getsign(map, wca.getApikey());
		System.out.println(sign);
		map.put("sign", sign);
		String dada = WXUtil.getSendText(map);
		System.out.println("========" + dada);
		System.out.println(dada);
		Map<String, String> result = WXUtil.sendPostWithCA(
				"https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack", dada, wca.getMcid(),
				Util.getRootPath() + File.separator + wca.getCafilepath().replaceAll("/", "\\" + File.separator));
		// "C:\\Users\\lenovo\\Desktop\\apiclient_cert.p12"
		// Util.getRootPath() + File.separator +
		// wca.getCafilepath().replaceAll("/", "\\" + File.separator)
		if (result != null && result.containsKey("return_code")) {
			if (result.get("return_code").equals("SUCCESS")) {
				return true;
			} else {
				System.out.println("红包发送失败:" + result.get("return_msg"));
				return false;
			}

		} else {
			System.out.println("===========红包发送失败============");
			return false;
		}
	}

	/**
	 * 
	 * 获取微信订单号
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午4:13:35
	 * @param wca
	 *            微信平台信息
	 * @param goodname
	 *            商品描述
	 * @param ordercode
	 *            商户内部订单编号
	 * @param fee
	 *            价格
	 * @param clientip
	 *            APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。
	 * @param notifyurl
	 *            接收微信支付异步通知回调地址 (在WXMANAGE中配置)
	 * @param type
	 *            类型 NATIVE / JSAPI
	 * @param goodcode
	 *            商品编号
	 * @param openid
	 *            用户编号
	 * @return
	 */
	public static String getPrepay_id(WeChatAccount wca, String goodname, String ordercode, int fee, String clientip,
			String notifyurl, String type, String goodcode, String openid) {
		System.out.println("==========获取微信订单号=========");
		String pid = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", wca.getAppid());
		map.put("mch_id", wca.getMcid());
		map.put("nonce_str", Util.getRandomString(8));
		map.put("body", goodname);
		map.put("out_trade_no", ordercode);
		map.put("total_fee", fee);
		map.put("spbill_create_ip", clientip);
		map.put("notify_url", notifyurl);
		map.put("trade_type", type);
		if (type.equals("NATIVE")) {
			map.put("product_id", goodcode);
		} else if (type.equals("JSAPI")) {
			map.put("openid", openid);
		}
		map.put("sign", WXUtil.getsign(map, wca.getApikey()));
		String dada = WXUtil.getSendText(map);
		System.out.println("cac===" + dada);

		Map<String, String> result = WXUtil
				.pushManageXml(WXUtil.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", dada));
		if (result.containsKey("return_code") && result.containsKey("result_code")
				&& result.get("return_code").equals("SUCCESS") && result.get("result_code").equals("SUCCESS")) {
			pid = result.get("prepay_id");
		} else {
			System.out.println("==========获取微信订单号失败=========");
			System.out.println(result);
		}
		return pid;
	}

	/**
	 * 
	 * 生成二维码链接内容（native 支付时）
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午3:48:23
	 * @param wca
	 * @param goodsid
	 * @return
	 */
	public static String getPayQRCode(WeChatAccount wca, String code) {
		Map<String, Object> p = new HashMap<String, Object>();
		p.put("appid", wca.getAppid());
		Long ts = new Date().getTime();
		String rs = Util.getRandomString(8);
		p.put("time_stamp", ts);
		p.put("nonce_str", rs);
		p.put("product_id", code);
		p.put("mch_id", wca.getMcid());
		String sign = WXUtil.getsign(p, wca.getApikey());
		return "weixin://wxpay/bizpayurl?sign=" + sign + "&appid=" + wca.getAppid() + "&mch_id=" + wca.getMcid()
				+ "&product_id=" + code + "&time_stamp=" + ts + "&nonce_str=" + rs;
	}

	/**
	 * 
	 * 微信公众号转普通微信号
	 * 
	 * @author lyf
	 * @date 2015年6月8日 下午3:59:06
	 * @param wca
	 * @param openid
	 * @param oder
	 * @param amount
	 * @param desc
	 * @param ip
	 * @return
	 */
	public static Map<String, String> transfers(WeChatAccount wca, String openid, String oder, int amount, String desc,
			String ip) {
		Map<String, String> myresult = new HashMap<String, String>();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("mch_appid", wca.getAppid());
		data.put("mchid", wca.getMcid());
		data.put("nonce_str", Util.getRandomNumber(8));
		data.put("partner_trade_no", oder);
		data.put("openid", openid);
		data.put("check_name", "NO_CHECK");
		data.put("amount", amount);
		data.put("desc", desc);
		data.put("spbill_create_ip", ip);
		data.put("sign", WXUtil.getsign(data, wca.getApikey()));
		Map<String, String> result = WXUtil.sendPostWithCA(
				"https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers", WXUtil.getSendText(data),
				wca.getMcid(), "D:\\wp\\WeChat\\WebContent" + File.separator + "ca" + File.separator
						+ "\\yjydata\\apiclient_cert.p12");
		if (result.containsKey("return_code") && result.get("return_code").equals("SUCCESS")
				&& result.containsKey("result_code") && result.get("result_code").equals("SUCCESS")) {
			myresult.put("result", "1");
			myresult.put("myorder", result.get("partner_trade_no"));
			myresult.put("wxorder", result.get("payment_no"));
			myresult.put("paytime", result.get("payment_time"));
		} else {
			myresult.put("result", "0");
		}
		return myresult;
	}

	/**
	 * 
	 * 查询红包发送状态
	 * 
	 * @author lyf
	 * @date 2015年6月30日 下午4:14:34
	 * @param wca
	 * @param code
	 * @return
	 */
	public static Map<String, String> getRebaeState(WeChatAccount wca, String code) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("mch_billno", code);
		data.put("mch_id", wca.getMcid());
		data.put("appid", wca.getAppid());
		data.put("bill_type", "MCHT");
		data.put("nonce_str", Util.getRandomString(10));
		data.put("sign", WXUtil.getsign(data, wca.getApikey()));
		Map<String, String> result = WXUtil.sendPostWithCA("https://api.mch.weixin.qq.com/mmpaymkttransfers/gethbinfo",
				WXUtil.getSendText(data), wca.getMcid(),
				Util.getRootPath() + File.separator + wca.getCafilepath().replaceAll("/", "\\" + File.separator));
		if (result.containsKey("return_code") && result.containsKey("result_code")
				&& result.get("return_code").equals("SUCCESS") && result.get("result_code").equals("SUCCESS")) {
			result.put("result", "1");
		} else {
			System.out.println("======查询红包发送状态失败========");
			result.put("result", "0");
		}
		return result;
	}

	/**
	 * 
	 * 上传LOGO 接口
	 * 
	 * @author lyf
	 * @date 2015年6月30日 下午4:24:33
	 * @param wca
	 * @param file
	 * @return
	 */
	public String uploadImg(String accesstoken, String file) {
		String urlStr = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=" + accesstoken;
		Map<String, String> textMap = new HashMap<String, String>();
		Map<String, String> fileMap = new HashMap<String, String>();
		fileMap.put("userfile", file);
		String result = WXUtil.formUpload(urlStr, textMap, fileMap);
		if (result.equals("")) {
			System.out.println("上传logo失败");
			return null;
		} else {
			try {
				JSONObject jo = new JSONObject(result);
				return jo.getString("url");
			} catch (JSONException e) {
				System.out.println("!!!!!!!上传logo失败！！！！！！！！");
				System.out.println(result);
				e.printStackTrace();
				return null;
			}
		}
	}

	public void sendCouponStock() {

	}

	public static boolean SendMessage(String accesstoken, String openid, String text) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("touser", openid);
		data.put("msgtype", "text");
		Map<String, String> data1 = new HashMap<String, String>();
		data1.put("content", text);
		data.put("text", data1);
		WXUtil.sendPost("https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + accesstoken,
				WXUtil.transMapToString(data));
		return true;
	}

	public static Map<String, String> payRefund(WeChatAccount wca, String wxcode, String mycode, int totalprice,
			int refundprice) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", wca.getAppid());
		map.put("mch_id", wca.getMcid());
		map.put("nonce_str", Util.getRandomString(10));
		map.put("transaction_id", wxcode);
		map.put("out_trade_no", mycode);
		String tkcode = "tk" + (new Date().getTime() + "").substring(0, 10) + Util.getRandomString(4);
		map.put("out_refund_no", tkcode);
		map.put("total_fee", totalprice);
		map.put("refund_fee", refundprice);
		map.put("op_user_id", wca.getMcid());
		map.put("refund_fee_type", "CNY");
		String sign = WXUtil.getsign(map, wca.getApikey());
		System.out.println(sign);
		map.put("sign", sign);
		String dada = WXUtil.getSendText(map);
		System.out.println("========" + dada);
		System.out.println(dada);
		Map<String, String> result = WXUtil.sendPostWithCA("https://api.mch.weixin.qq.com/secapi/pay/refund", dada,
				wca.getMcid(),
				Util.getRootPath() + File.separator + wca.getCafilepath().replaceAll("/", "\\" + File.separator));
		// Util.getRootPath() + File.separator +
		// wca.getCafilepath().replaceAll("/", "\\" + File.separator);
		Map<String, String> data = new HashMap<String, String>();
		if (result != null && result.containsKey("return_code") && result.get("return_code").equals("SUCCESS")
				&& result.containsKey("result_code") && result.get("result_code").equals("SUCCESS")) {
			data.put("result", "1");
			data.put("tkcode", tkcode);
			data.put("prepayid", result.get("prepay_id"));
			data.put("codeurl", result.get("code_url"));
		} else {
			System.out.println("======退款失败=====");
			data.put("result", "0");
			// data.put("", value)
		}
		return data;
	}

	/**
	 * 
	 * 发送图文消息
	 * 
	 * @author lyf
	 * @date 2015年9月2日 下午4:32:53
	 * @param wca
	 * @param openid
	 * @param titles
	 * @param descriptions
	 * @param urls
	 * @param picurls
	 * @return
	 */
	public static Map<String, Object> SendPicMsg(String accesstoken, String openid, List<String> titles,
			List<String> descriptions, List<String> urls, List<String> picurls) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("touser", openid);
		data.put("msgtype", "news");
		Map<String, Object> news = new HashMap<String, Object>();
		List<Map<String, String>> articles = new ArrayList<Map<String, String>>();
		for (int i = 0; i < titles.size(); i++) {
			Map<String, String> art = new HashMap<String, String>();
			art.put("title", titles.get(i));
			art.put("description", descriptions.get(i));
			art.put("url", urls.get(i));
			art.put("picurl", picurls.get(i));
			articles.add(art);
		}
		news.put("articles", articles);
		data.put("news", news);
		return WXUtil.parseJSON2Map(
				WXUtil.sendPost("https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + accesstoken,
						WXUtil.transMapToString(data)));
	}

	/**
	 * 
	 * 发送一条图文
	 * 
	 * @author lyf
	 * @date 2015年9月2日 下午4:39:03
	 * @param wca
	 * @param openid
	 * @param title
	 * @param description
	 * @param url
	 * @param picurl
	 * @return
	 */
	public static Map<String, Object> SendOnePicMsg(String accesstoken, String openid, String title, String description,
			String url, String picurl) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("touser", openid);
		data.put("msgtype", "news");
		Map<String, Object> news = new HashMap<String, Object>();
		List<Map<String, String>> articles = new ArrayList<Map<String, String>>();
		Map<String, String> art = new HashMap<String, String>();
		art.put("title", title);
		art.put("description", description);
		art.put("url", url);
		art.put("picurl", picurl);
		articles.add(art);
		news.put("articles", articles);
		data.put("news", news);
		return WXUtil.parseJSON2Map(
				WXUtil.sendPost("https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + accesstoken,
						WXUtil.transMapToString(data)));
	}

	public static Map<String, Object> getConfig(String jsapiticket, String urls) {
		Map<String, Object> result = new HashMap<String, Object>();
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("timestamp", ts);
		data.put("noncestr", radomstr);
		data.put("jsapi_ticket", jsapiticket);
		data.put("url", SysConfig.BASEURL + urls);
		result.put("appId", WXManage.WCA.getAppid());
		result.put("timestamp", ts);
		result.put("nonceStr", radomstr);
		result.put("signature", WXUtil.getJSsign(data));
		return result;
	}

	public static Boolean sendGroupRedpack(WeChatAccount wca, String openid, int money, String wishString,
			String remark, String sendname, String actname, String billno, int totalnum) {
		// TODO 未完全封装好
		// ofmf3tz1lzgHfANti4MLNm6eKTUk
		// Sk4KkLhWKUd-kwxX1Ub_MKJ971leBQA7bo6j_WemTgyQE5lOmN67ZrYT6fpgp83SW5M4P_FPBjaePmSDjihNxZgQQdXWX-ktFRGGER5Oqz4
		System.out.println(wishString);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nonce_str", Util.getRandomString(10));
		map.put("mch_billno", billno);
		map.put("mch_id", wca.getMcid());
		map.put("wxappid", wca.getAppid());
		map.put("send_name", sendname);
		map.put("re_openid", openid);
		map.put("total_amount", money);
		map.put("total_num", totalnum);
		map.put("amt_type", "ALL_RAND");
		map.put("wishing", wishString);
		map.put("act_name", actname);
		map.put("remark", remark);
		String sign = WXUtil.getsign(map, wca.getApikey());
		System.out.println(sign);
		map.put("sign", sign);
		String dada = WXUtil.getSendText(map);
		System.out.println("========" + dada);
		System.out.println(dada);
		Map<String, String> result = WXUtil.sendPostWithCA(
				"https://api.mch.weixin.qq.com/mmpaymkttransfers/sendgroupredpack", dada, wca.getMcid(),
				Util.getRootPath() + File.separator + wca.getCafilepath().replaceAll("/", "\\" + File.separator));
		// "C:\\Users\\lenovo\\Desktop\\dwsq\\apiclient_cert.p12"
		// Util.getRootPath() + File.separator +
		// wca.getCafilepath().replaceAll("/", "\\" + File.separator)
		if (result != null && result.containsKey("return_code")) {
			if (result.get("return_code").equals("SUCCESS")) {
				return true;
			} else {
				System.out.println("红包发送失败:" + result.get("return_msg"));
				return false;
			}

		} else {
			System.out.println("===========红包发送失败============");
			return false;
		}
	}

	/**
	 * 子商户退款
	 * 
	 * @author lyf
	 * @date 2015年12月8日 下午1:22:40
	 * @param wca
	 * @param wxcode
	 * @param mycode
	 * @param totalprice
	 * @param refundprice
	 * @return
	 */
	public static Map<String, String> payRefundSub(WeChatAccount wca, String submchid, String mycode, int totalprice,
			int refundprice) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", wca.getAppid());
		map.put("mch_id", wca.getFwsmcid());
		map.put("sub_mch_id", submchid);
		map.put("nonce_str", Util.getRandomString(10));
		map.put("out_trade_no", mycode);
		String tkcode = "tk" + (new Date().getTime() + "").substring(0, 10) + Util.getRandomString(4);
		map.put("out_refund_no", tkcode);
		map.put("total_fee", totalprice);
		map.put("refund_fee", refundprice);
		map.put("op_user_id", wca.getMcid());
		map.put("refund_fee_type", "CNY");
		String sign = WXUtil.getsign(map, wca.getApikey());
		System.out.println(sign);
		map.put("sign", sign);
		String dada = WXUtil.getSendText(map);
		System.out.println("========" + dada);
		System.out.println(dada);
		Map<String, String> result = WXUtil.sendPostWithCA("https://api.mch.weixin.qq.com/secapi/pay/refund", dada,
				wca.getFwsmcid(),
				Util.getRootPath() + File.separator + wca.getFwscafilepath().replaceAll("/", "\\" + File.separator));
		// "D:\\wp\\nsh\\WebContent\\ca\\dwfws\\1275878301.p12"
		// Util.getRootPath() + File.separator +
		// wca.getCafilepath().replaceAll("/", "\\" + File.separator);
		Map<String, String> data = new HashMap<String, String>();
		if (result != null && result.containsKey("return_code") && result.get("return_code").equals("SUCCESS")
				&& result.containsKey("result_code") && result.get("result_code").equals("SUCCESS")) {
			data.put("result", "1");
			data.put("tkcode", tkcode);
		} else {
			System.out.println("======退款失败=====");
			data.put("result", "0");
			data.put("msg", result.get("return_msg"));
			// data.put("", value)
		}
		return data;
	}

	/**
	 * 
	 * 退款查询
	 * 
	 * @author lyf
	 * @date 2015年12月8日 下午4:26:05
	 * @param wca
	 * @param submchid
	 * @param refundid
	 * @return
	 */
	public static Map<String, String> refundquery(WeChatAccount wca, String submchid, String refundid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", wca.getAppid());
		map.put("mch_id", wca.getFwsmcid());
		map.put("sub_mch_id", submchid);
		map.put("nonce_str", Util.getRandomString(10));
		map.put("refund_id", refundid);
		String sign = WXUtil.getsign(map, wca.getApikey());
		map.put("sign", sign);
		String dada = WXUtil.getSendText(map);
		Map<String, String> result = WXUtil
				.pushManageXml(WXUtil.sendPost("https://api.mch.weixin.qq.com/pay/refundquery", dada));
		Map<String, String> data = new HashMap<String, String>();
		if (result != null && result.containsKey("return_code") && result.get("return_code").equals("SUCCESS")
				&& result.containsKey("result_code") && result.get("result_code").equals("SUCCESS")) {
			data.put("result", "1");
			data.put("state", result.get("refund_status_0"));
		} else {
			System.out.println("======退款查询失败=====");
			data.put("result", "0");
			data.put("msg", result.get("return_msg"));
		}
		return data;
	}

	/**
	 * 
	 * 获取订单详情
	 * 
	 * @author lyf
	 * @date 2016年1月4日 下午1:18:10
	 * @param wca
	 * @param mycode
	 * @param submchid
	 * @return
	 */
	public static Map<String, Object> getOrderInfo(WeChatAccount wca, String mycode, String submchid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", wca.getAppid());
		map.put("mch_id", wca.getFwsmcid());
		map.put("sub_mch_id", submchid);
		map.put("out_trade_no", mycode);
		map.put("nonce_str", Util.getRandomString(10));
		map.put("sign", WXUtil.getsign(map, wca.getApikey()));
		Map<String, String> result = WXUtil.pushManageXml(
				WXUtil.sendPost("https://api.mch.weixin.qq.com/pay/orderquery", WXUtil.getSendText(map)));
		Map<String, Object> data = new HashMap<String, Object>();
		if (result != null && result.containsKey("return_code") && result.get("return_code").equals("SUCCESS")
				&& result.containsKey("result_code") && result.get("result_code").equals("SUCCESS")) {
			data.put("result", "1");
			data.put("data", result);
		} else {
			System.out.println("======订单查询失败=====");
			data.put("result", "0");
			data.put("msg", result.get("return_msg"));
		}
		return data;
	}

	public static void main(String[] args) {

		WeChatAccount w = new WeChatAccount();
		w.setApikey("hillsun123456789yijiayi987654321");
		w.setAccesstoken(
				"hzQOZ9v8gu9_srFmXGXzHBN4t0vgdIbtARkgBb1uL-agMY3YHgghMGufklWJvhe1O7-nD0-vmlFgplCk4Q3XfttOV7BtmjctX2Quc5S1kHcBVOjAIAEYR");
		w.setAppid("wx4904cee5ef081be4");
		w.setMcid("1248794701");
	}
}
