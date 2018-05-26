package com.yjy.wechat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yjy.entity.WXMerchant;
import com.yjy.entity.WeChatAccount;

public class WXCardManage {

	public static List<Object> COLORS = new ArrayList<Object>();
	public static List<String> MERSTATUS = Arrays.asList("CHECKING", "APPROVED", "REJECTED", "EXPIRED"); // 卡券子商户状态

	static {
		COLORS = WXUtil.parseJSON2List(
				"[{\"name\":\"Color010\",\"value\":\"#55bd47\"},  {\"name\":\"Color020\",\"value\":\"#10ad61\"},  {\"name\":\"Color030\",\"value\":\"#35a4de\"},  {\"name\":\"Color040\",\"value\":\"#3d78da\"},  {\"name\":\"Color050\",\"value\":\"#9058cb\"},  {\"name\":\"Color060\",\"value\":\"#de9c33\"},  {\"name\":\"Color070\",\"value\":\"#ebac16\"},  {\"name\":\"Color080\",\"value\":\"#f9861f\"},  {\"name\":\"Color081\",\"value\":\"#f08500\"},  {\"name\":\"Color090\",\"value\":\"#e75735\"},  {\"name\":\"Color100\",\"value\":\"#d54036\"}, {\"name\":\"Color101\",\"value\":\" #cf3e36\"}]");
	}

	/**
	 * 
	 * 获取卡券二维码
	 * 
	 * @author lyf
	 * @date 2015年7月1日 下午1:17:03
	 * @param wca
	 * @param cardid
	 *            卡券ID
	 * @return
	 */
	public static String getCardQrcode(WeChatAccount wca, String cardid) {
		return getCardQrcode(wca, cardid, null, null, null, null, null, null);
	}

	/**
	 * 
	 * 获取卡券二维码
	 * 
	 * @author lyf
	 * @date 2015年7月1日 下午1:17:32
	 * @param wca
	 * @param cardid
	 *            卡券ID
	 * @param code
	 *            指定卡券code 码，只能被领一次。use_custom_code 字 段为true 的卡券必须填写，非自定义code
	 *            不必填写。
	 * @param openid
	 *            指定领取者的openid，只有该用户能领取。bind_openid 字段为true 的卡券必须填写，非自定义openid
	 *            不必填写。
	 * @param expiretime
	 *            指定二维码的有效时间，范围是60 ~ 1800 秒。不填默认 为永久有效。
	 * @param isuniquecode
	 *            指定下发二维码，生成的二维码随机分配一个code，领取 后不可再次扫描。填写true 或false。默认false。
	 * @param balance
	 *            红包余额，以分为单位。红包类型必填（LUCKY_MONEY）， 其他卡券类型不填。
	 * @param outerid
	 *            领取场景值，用于领取渠道的数据统计，默认值为0，字 段类型为整型。用户领取卡券后触发的事件推送中会带上 此自定义场景值。
	 * @return
	 */
	public static String getCardQrcode(WeChatAccount wca, String cardid, String code, String openid, String expiretime,
			Boolean isuniquecode, Integer balance, Integer outerid) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> card = new HashMap<String, Object>();
		Map<String, Object> actioninfo = new HashMap<String, Object>();
		data.put("action_name", "QR_CARD");
		card.put("card_id", cardid);
		if (code != null) {
			card.put("code", code);
		}
		if (openid != null) {
			card.put("openid", openid);
		}
		if (expiretime != null) {
			card.put("expire_seconds", expiretime);
		}
		if (isuniquecode != null) {
			card.put("is_unique_code", isuniquecode);
		}
		if (balance != null) {
			card.put("balance", balance);
		}
		if (outerid != null) {
			card.put("outerid", outerid);
		}
		actioninfo.put("card", card);
		data.put("action_info", actioninfo);
		Map<String, Object> result = WXUtil.parseJSON2Map(
				WXUtil.sendPost("https://api.weixin.qq.com/card/qrcode/create?access_token=" + wca.getAccesstoken(),
						WXUtil.transMapToString(data)));
		if (!(result.get("errcode").toString().equals("0") && result.get("errmsg").toString().equals("ok"))) {
			System.out.println(result.get("errcode") + ":" + result.get("errmsg"));
			return null;
		}
		return "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + result.get("ticket").toString();
	}

	/**
	 * 
	 * 获取优惠卡列表
	 * 
	 * @author lyf
	 * @date 2015年7月1日 下午2:48:05
	 * @param wca
	 * @param offset
	 *            起始偏移量，从0 开始
	 * @param count
	 *            需要查询的卡片的数量（数量最大50）
	 * @return
	 */
	public static Map<String, Object> getCardIdList(WeChatAccount wca, int offset, int count) {
		Map<String, Object> resultlist = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("offset", offset);
		data.put("count", count);
		Map<String, Object> result = WXUtil.parseJSON2Map(
				WXUtil.sendPost("https://api.weixin.qq.com/card/batchget?access_token=" + wca.getAccesstoken(),
						WXUtil.transMapToString(data)));
		if (result.get("errcode").equals(0) && result.get("errmsg").equals("ok")) {
			resultlist.put("list", (List<String>) result.get("card_id_list"));
			resultlist.put("total", result.get("total_num"));
			return resultlist;
		}
		return null;
	}

	/**
	 * 
	 * 查询卡券具体信息
	 * 
	 * @author lyf
	 * @date 2015年7月1日 下午3:56:33
	 * @param wca
	 * @param cardid
	 * @return
	 */
	public static Map<String, Object> getCardInfo(String accesstoken, String cardid) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("card_id", cardid);
		return WXUtil.sendPostMap("https://api.weixin.qq.com/card/get?access_token=" + accesstoken,
				WXUtil.transMapToString(data));
	}

	/**
	 * 
	 * 根据用户CODE 查询 优惠券信息
	 * 
	 * @author lyf
	 * @date 2015年7月2日 上午10:20:01
	 * @param wca
	 * @param code
	 * @param cardid
	 * @return
	 */
	public static Map<String, Object> getCodeInfo(WeChatAccount wca, String code, String cardid) {
		Map data = new HashMap();
		data.put("code", code);
		if (cardid != null) {
			data.put("card_id", cardid);
		}
		return WXUtil.sendPostMap("https://api.weixin.qq.com/card/code/get?access_token=" + wca.getAccesstoken(),
				WXUtil.transMapToString(data));
	}

	/**
	 * 
	 * 消耗code卡券
	 * 
	 * @author lyf
	 * @date 2015年7月2日 上午10:33:15
	 * @param wca
	 * @param cardid
	 * @param code
	 * @return errcode 错误码，0：正常，40099：该code 已被核销
	 */
	public static Map<String, Object> useCard(WeChatAccount wca, String code, String cardid) {
		Map data = new HashMap();
		data.put("code", code);
		if (cardid != null) {
			data.put("card_id", cardid);
		}
		return WXUtil.sendPostMap("https://api.weixin.qq.com/card/code/consume?access_token=" + wca.getAccesstoken(),
				WXUtil.transMapToString(data));
	}

	// public static List<Map<String, Object>> getAllCard(WeChatAccount wca) {
	//
	// }

	/**
	 * 
	 * 获取所有卡券列表
	 * 
	 * @author luyf
	 * @date 2015年7月17日 上午11:02:16
	 * @param wca
	 * @param count
	 * @return
	 */
	public static List<String> getALLCardid(String accesstoken) {
		List<String> lm = new ArrayList<String>();
		int count = 10;// 微信API一次最多查50个
		int offset = 0;
		while (true) {
			Map<String, Object> data = getCard(accesstoken, offset, count);
			if (data != null && data.containsKey("errcode") && data.containsKey("errmsg")
					&& data.get("errcode").toString().equals("0") && data.get("errmsg").toString().equals("ok")) {
				List<String> cards = (List<String>) data.get("card_id_list");
				lm.addAll(cards);
				offset += count;
				if (cards.size() < count) {
					return lm;
				} else {
					continue;
				}
			} else {
				System.out.println("====获取卡券失败====");
				return null;
			}
		}
	}

	/**
	 * 
	 * 获取卡券ID列表
	 * 
	 * @author luyf
	 * @date 2015年7月17日 上午11:01:56
	 * @param wca
	 * @param start
	 * @param count
	 * @return
	 */
	public static Map<String, Object> getCard(String accesstoken, int start, int count) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("offset", start);
		data.put("count", count);
		return WXUtil.sendPostMap("https://api.weixin.qq.com/card/batchget?access_token=" + accesstoken,
				WXUtil.transMapToString(data));
	}

	/**
	 * 
	 * 根据OPENID发送卡券
	 * 
	 * @author luyf
	 * @date 2015年8月3日 下午3:31:27
	 * @param wca
	 * @param openids
	 *            最多10000个 最少2个
	 * @param cardid
	 * @return
	 */
	public static Map<String, Object> sendCardByOpenids(WeChatAccount wca, List<String> openids, String cardid) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("touser", openids);
		Map<String, String> card = new HashMap<String, String>();
		card.put("card_id", cardid);
		data.put("wxcard", card);
		data.put("msgtype", "wxcard");

		return WXUtil.sendPostMap(
				"https://api.weixin.qq.com/cgi-bin/message/mass/send?access_token=" + wca.getAccesstoken(),
				WXUtil.transMapToString(data));
	}

	/**
	 * 
	 * 生成卡券的基本信息
	 * 
	 * @author luyf
	 * @date 2015年8月6日 下午2:42:49
	 * @param logourl
	 *            卡券的商户logo，建议像素为300*300。
	 * @param codetype
	 *            Code展示类型，"CODE_TYPE_TEXT"，文本；"CODE_TYPE_BARCODE"，一维码
	 *            ；"CODE_TYPE_QRCODE"，二维码；"CODE_TYPE_ONLY_QRCODE",二维码无code显示；
	 *            "CODE_TYPE_ONLY_BARCODE",一维码无code显示；
	 * @param brandname
	 *            商户名字,字数上限为12个汉字。
	 * @param title
	 *            卡券名，字数上限为9个汉字。(建议涵盖卡券属性、服务及金额)。
	 * @param subtitle
	 *            副标题，字数上限为18个汉字。
	 * @param color
	 *            券颜色。按色彩规范标注填写Color010-Color100。
	 * @param notice
	 *            卡券使用提醒，字数上限为16个汉字。
	 * @param description
	 *            卡券使用说明，字数上限为1024个汉字。
	 * @param quantity
	 *            卡券库存的数量，不支持填写0，上限为100000000。
	 * @param type
	 *            使用时间的类型，仅支持填写1或2。1为固定日期区间，2为固定时长（自领取后按天算）。
	 * @param begintimestamp
	 *            type为1时专用，表示起用时间。从1970年1月1日00:00:00至起用时间的秒数，最终需转换为字符串形态传入。
	 * @param endtimestamp
	 *            type为1时专用，表示结束时间，建议设置为截止日期的23:59:59过期。
	 * @param fixedterm
	 *            type为2时专用，表示自领取后多少天内有效，领取后当天有效填写0。（单位为天）
	 * @param fixedbeginterm
	 *            type为2时专用，表示自领取后多少天开始生效。（单位为天）
	 * @param servicephone
	 *            (否) 客服电话。
	 * @param locationidlist
	 *            (否)门店位置ID。调用POI门店管理接口获取门店位置ID。
	 * @param customurlname
	 *            (否)自定义跳转外链的入口名字。
	 * @param customurl
	 *            (否)自定义跳转的URL。
	 * @param customurlsubtitle
	 *            (否)显示在入口右侧的提示语。
	 * @param promotionurlname
	 *            (否)营销场景的自定义入口名称。
	 * @param promotionurl
	 *            (否)入口跳转外链的地址链接。
	 * @param promotionurlsubtitle
	 *            (否)显示在营销入口右侧的提示语。
	 * @param getlimit
	 *            (否)每人可领券的数量限制。不填默认与quantity等值。
	 * @param canshare
	 *            (否)卡券领取页面是否可分享。
	 * @param cangivefriend
	 *            (否) 卡券是否可转赠
	 * @return
	 */
	public static Map<String, Object> getBaseInfo(String logourl, String codetype, String brandname, String title,
			String subtitle, String color, String notice, String description, int quantity, int type,
			String begintimestamp, String endtimestamp, Integer fixedterm, Integer fixedbeginterm, String servicephone,
			List<Integer> locationidlist, String customurlname, String customurl, String customurlsubtitle,
			String promotionurlname, String promotionurl, String promotionurlsubtitle, Integer getlimit,
			Boolean canshare, Boolean cangivefriend) {

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("logo_url", logourl);
		data.put("code_type", codetype);
		data.put("brand_name", brandname);
		data.put("title", title);
		data.put("sub_title", subtitle);
		data.put("color", color);
		data.put("notice", notice);
		data.put("description", description);

		Map<String, Object> sku = new HashMap<String, Object>();
		sku.put("quantity", quantity);
		data.put("sku", sku);

		Map<String, Object> date_info = new HashMap<String, Object>();
		if (type == 1) {
			date_info.put("type", "DATE_TYPE_FIX_TIME_RANGE");
			date_info.put("begin_timestamp", begintimestamp);
			date_info.put("end_timestamp", endtimestamp);
		} else if (type == 2) {
			date_info.put("type", "DATE_TYPE_FIX_TERM");
			date_info.put("fixed_term", fixedterm);
			date_info.put("fixed_begin_term", fixedbeginterm);
		}
		data.put("date_info", date_info);

		if (servicephone != null) {
			data.put("service_phone", servicephone);
		}
		if (locationidlist != null && locationidlist.size() > 0) {
			data.put("location_id_list", locationidlist);
		}
		if (customurlname != null) {
			data.put("custom_url_name", customurlname);
		}
		if (customurl != null) {
			data.put("custom_url", customurl);
		}
		if (customurlsubtitle != null) {
			data.put("custom_url_sub_title", customurlsubtitle);
		}

		if (promotionurlname != null) {
			data.put("promotion_url_name", promotionurlname);
		}
		if (promotionurl != null) {
			data.put("promotion_url", promotionurl);
		}
		if (promotionurlsubtitle != null) {
			data.put("promotion_url_sub_title", promotionurlsubtitle);
		}
		if (getlimit != null) {
			data.put("get_limit", getlimit);
		}
		if (canshare != null) {
			data.put("can_share", canshare);
		}
		if (cangivefriend != null) {
			data.put("can_give_friend", cangivefriend);
		}
		return data;
	}

	/**
	 * 
	 * 生成卡券的基本信息
	 * 
	 * @author luyf
	 * @date 2015年8月6日 下午2:42:49
	 * @param logourl
	 *            卡券的商户logo，建议像素为300*300。
	 * @param codetype
	 *            Code展示类型，"CODE_TYPE_TEXT"，文本；"CODE_TYPE_BARCODE"，一维码
	 *            ；"CODE_TYPE_QRCODE"，二维码；"CODE_TYPE_ONLY_QRCODE",二维码无code显示；
	 *            "CODE_TYPE_ONLY_BARCODE",一维码无code显示；
	 * @param brandname
	 *            商户名字,字数上限为12个汉字。
	 * @param title
	 *            卡券名，字数上限为9个汉字。(建议涵盖卡券属性、服务及金额)。
	 * @param subtitle
	 *            副标题，字数上限为18个汉字。
	 * @param color
	 *            券颜色。按色彩规范标注填写Color010-Color100。
	 * @param notice
	 *            卡券使用提醒，字数上限为16个汉字。
	 * @param description
	 *            卡券使用说明，字数上限为1024个汉字。
	 * @param quantity
	 *            卡券库存的数量，不支持填写0，上限为100000000。
	 * @param type
	 *            使用时间的类型，仅支持填写1或2。1为固定日期区间，2为固定时长（自领取后按天算）。
	 * @param begintimestamp
	 *            type为1时专用，表示起用时间。从1970年1月1日00:00:00至起用时间的秒数，最终需转换为字符串形态传入。
	 * @param endtimestamp
	 *            type为1时专用，表示结束时间，建议设置为截止日期的23:59:59过期。
	 * @param fixedterm
	 *            type为2时专用，表示自领取后多少天内有效，领取后当天有效填写0。（单位为天）
	 * @param fixedbeginterm
	 *            type为2时专用，表示自领取后多少天开始生效。（单位为天）
	 * @param servicephone
	 *            (否) 客服电话。
	 * @param locationidlist
	 *            (否)门店位置ID。调用POI门店管理接口获取门店位置ID。
	 * @param getlimit
	 *            (否)每人可领券的数量限制。不填默认与quantity等值。
	 * @param canshare
	 *            (否)卡券领取页面是否可分享。
	 * @param cangivefriend
	 *            (否) 卡券是否可转赠
	 * @return
	 */
	public static Map<String, Object> getBaseInfo(String logourl, String codetype, String brandname, String title,
			String subtitle, String color, String notice, String description, int quantity, int type,
			String begintimestamp, String endtimestamp, Integer fixedterm, Integer fixedbeginterm, String servicephone,
			List<Integer> locationidlist, Integer getlimit, Boolean canshare, Boolean cangivefriend) {
		return getBaseInfo(logourl, codetype, brandname, title, subtitle, color, notice, description, quantity, type,
				begintimestamp, endtimestamp, fixedterm, fixedbeginterm, servicephone, locationidlist, null, null, null,
				null, null, null, getlimit, canshare, cangivefriend);
	}

	/**
	 * 
	 * 创建卡券
	 * 
	 * @author luyf
	 * @date 2015年8月6日 下午1:56:45
	 * @param wca
	 * @param baseinfo
	 *            卡券基础数据
	 * @param type
	 *            卡券类型
	 * @param typedata
	 *            不同卡券不同的字段
	 * @return
	 */
	public static Map<String, Object> createCard(WeChatAccount wca, Map<String, Object> baseinfo, String type,
			Map<String, Object> typedata) {

		Map<String, Object> data = new HashMap<String, Object>();

		Map<String, Object> card = new HashMap<String, Object>();
		card.put("card_type", type);

		Map<String, Object> cardinfo = new HashMap<String, Object>();
		if (type.equals("GROUPON")) {
			cardinfo.put("deal_detail", typedata.get("deal_detail"));
		} else if (type.equals("CASH")) {
			cardinfo.put("least_cost", typedata.get("least_cost"));
			cardinfo.put("reduce_cost", typedata.get("reduce_cost"));
		} else if (type.equals("DISCOUNT")) {
			cardinfo.put("discount", typedata.get("discount"));
		} else if (type.equals("GIFT")) {
			cardinfo.put("gift", typedata.get("gift"));
		} else if (type.equals("GENERAL_COUPON")) {
			cardinfo.put("default_detail", typedata.get("default_detail"));
		}
		cardinfo.put("base_info", baseinfo);
		card.put(type.toLowerCase(), cardinfo);
		data.put("card", card);
		return WXUtil.sendPostMap("https://api.weixin.qq.com/card/create?access_token=" + wca.getAccesstoken(),
				WXUtil.transMapToString(data));
	}

	/**
	 * 
	 * 获取卡券子商户列表
	 * 
	 * @author lyf
	 * @date 2015年10月14日 上午11:29:26
	 * @param wca
	 * @param offset
	 *            子商户 id，一个母商户公众号下唯一。
	 * @param count
	 *            拉取的子商户的个数，最大值为 100
	 * @param state
	 *            子商户的审核状态
	 * @return
	 */
	public static Map<String, Object> getSubMerchantList(WeChatAccount wca, Long offset, int count, String state) {
		Map<String, Object> resultlist = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("begin_id", offset);
		data.put("limit", count);
		// data.put("status", (state == null || state.equals("")) ? "" : "");
		Map<String, Object> result = WXUtil.parseJSON2Map(WXUtil.sendPost(
				"https://api.weixin.qq.com/card/submerchant/batchget?access_token=" + wca.getAccesstoken(),
				WXUtil.transMapToString(data)));
		if (result.get("errcode").equals(0) && result.get("errmsg").equals("ok")) {
			resultlist.put("list", (List<Map<String, Object>>) result.get("info_list"));
			resultlist.put("nextid", result.get("next_begin_id"));
			return resultlist;
		}
		return null;
	}

	/**
	 * 
	 * 根据商户ID查询商户详情
	 * 
	 * @author lyf
	 * @date 2015年10月14日 下午7:20:04
	 * @param wca
	 * @param merid
	 * @return
	 */
	public static Map<String, Object> getSubMerchantInfo(String accesstoken, Long merid) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("merchant_id", merid);
		// data.put("status", (state == null || state.equals("")) ? "" : "");
		Map<String, Object> result = WXUtil.parseJSON2Map(
				WXUtil.sendPost("https://api.weixin.qq.com/card/submerchant/get?access_token=" + accesstoken,
						WXUtil.transMapToString(data)));
		if (result.get("errcode").equals(0) && result.get("errmsg").equals("ok")) {
			return (Map<String, Object>) result.get("info");
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		WeChatAccount w = new WeChatAccount();
		// w.setApikey("hillsun123456789yijiayi987654321");
		w.setAccesstoken(
				"XfNcahXZpI3pLNCZ1jF4mTLqxylwWP4KvHCdE2u3teB4UNaSu6Ec-twpr_bcAAruOd_HhCWiqBvcxeQvIJTnrer-AjkK_0hs1Cs6-oJSmncRHAfAGAMCV");
		// w.setAppid("wx4904cee5ef081be4");
		// w.setMcid("1248794701");
		// Map<String, Object> data = getCodeInfo(w, "350706475456", null);
		// System.out.println("ii");

		Map<String, Object> data = getCardInfo(
				"ETNop9bVxMT2PYRWHv0KIZA5YaOhR4lqrEMAtH6vFC5nuVEQk7HW_pC_-hiZXk4dOIAQzYaHYLzdv20H8xAbmlyOxAG1iFDaNRpPgmg22nz0kXXYAdGJwZ8m750yunt8VIYcAIAERH",
				"pRCW7wmoq7-Z5_qmf7UeiuZcIIaQ");
		System.out.println("aa");
	}
}
