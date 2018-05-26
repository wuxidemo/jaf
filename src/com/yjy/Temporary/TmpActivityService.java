package com.yjy.Temporary;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.Act.NewYear.service.WaiterRedbagService;
import com.yjy.Temporary.service.ActService;
import com.yjy.Temporary.service.AfuAxiService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.SumDataService;
import com.yjy.entity.Activity;
import com.yjy.entity.Merchant;
import com.yjy.entity.Sq_QuickBuy;
import com.yjy.entity.WXUser;
import com.yjy.service.ActivityService;
import com.yjy.service.MerchantService;
import com.yjy.service.SqQuickBuyService;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

/**
 * 活动业务
 * 
 * @author lyf
 * @date 2015年10月15日 下午4:42:07
 */
@Component
@Transactional
public class TmpActivityService {

	@Autowired
	TmprecordService tmprecordService;
	@Autowired
	ActivityService activityService;
	@Autowired
	WXUserService wXUserService;
	@Autowired
	PopularityService popularityService;
	@Autowired
	ActService actService;
	@Autowired
	MerchantService merchantService;
	@Autowired
	SumDataService sumDataService;
	@Autowired
	AfuAxiService afuAxiService;
	@Autowired
	WeChatAccountService weChatAccountService;
	@Autowired
	SqQuickBuyService sqQuickBuyService;

	/******************* 下面是双旦活动引入的Service ************************/

	@Autowired
	WaiterRedbagService waiterRedbagService;

	/*********************************************/

	// ======================调用方法===========================//
	/**
	 * 
	 * 关注
	 * 
	 * @author luyf
	 * @date 2015年7月30日 下午1:35:34
	 * @param data
	 * @return
	 */
	public String subscribeEventAct(Map<String, String> data, String returnstr, boolean isfirst) {
		String ekey = data.get("EventKey");
		System.out.println("####ekey" + ekey);
		if (ekey != null && !ekey.equals("")) {
			ekey = ekey.substring(8, data.get("EventKey").length());
			if (ekey.startsWith("111000")) { // 人气值活动
				return rqzhd(isfirst, ekey, data);
			} else if (ekey.startsWith("fxgz000")) { // 分享+关注活动
				return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "分享有红包",
						"分享就有机会获得红包，更可参与抽奖，还有更多活动等你来参加，优惠多多。", SysConfig.BASEURL + "/wxurl/redirect?url=wxact/share",
						SysConfig.BASEURL + "/static/11act/gzfx/fxgzsend.jpg");
			} else if (ekey.startsWith("shxxrk000")) {
				return getMerchantInfo(Long.parseLong(ekey.substring(6, ekey.length())), data);
			} else if (ekey.startsWith("afuaxi000")) {
				afuAxiService.add(data.get("FromUserName"));
			} else if (ekey.startsWith("yesican000")) {
				return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "用你的技能，造福邻里",
						"点击链接，先写个人能手信息，可以发布你的才能，用你的才能服务他人。", SysConfig.BASEURL + "/wxcommunity/",
						SysConfig.BASEURL + "/static/images/icantuwen.png");
			} else if (ekey.startsWith("518000")) {
				/*return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "用你的技能，造福邻里",
						"点击链接，先写个人能手信息，可以发布你的才能，用你的才能服务他人。", SysConfig.BASEURL + "/wxcommunity/",
						SysConfig.BASEURL + "/static/images/icantuwen.png");*/
				return getQgInfo(Long.parseLong(ekey.substring(6, ekey.length())), data);
			} /*
				 * else if (ekey.startsWith("jiangda000")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("taihu000")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("99")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("88")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("77")) { Long proid =
				 * Long.parseLong(ekey.substring(5, ekey.length())); return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/detail?id=" + proid,
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("55")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员", "最美服务员评选，快来参与吧!",
				 * SysConfig.BASEURL + "/wxurl/redirect?url=waiter/",
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); } else if
				 * (ekey.startsWith("44")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员", "最美服务员评选，快来参与吧!",
				 * SysConfig.BASEURL + "/wxurl/redirect?url=waiter/",
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); } else if
				 * (ekey.startsWith("33")) { Long waiterid =
				 * Long.parseLong(ekey.substring(5, ekey.length()));
				 * System.out.println("扫描的服务员id是：" + waiterid); return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员", "最美服务员评选，快来参与吧!",
				 * SysConfig.BASEURL + "/wxurl/redirect?url=waiter/detail?id=" +
				 * waiterid, SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); } else if
				 * (ekey.startsWith("543")) { return zmfwy(ekey, data); }
				 */ else {
				getDefaultTip(data);
			}

		} else {
			return returnstr;
		}
		return returnstr;
	}

	/**
	 * 
	 * 已关注扫描带参数二维码
	 * 
	 * @author luyf
	 * @date 2015年7月30日 下午1:30:52
	 * @return
	 */
	public String scanEventAct(Map<String, String> data, String returnstr) {
		String ekey = data.get("EventKey");
		System.out.println("####ekey" + ekey);
		if (ekey != null) {
			if (ekey.startsWith("111000")) {
				return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "双11拼人气，赢iPhone",
						"关注公众号，进入活动页面，分享到朋友圈，积累人气值赢iPhone,大奖等你来拿！",
						SysConfig.BASEURL + "/wxurl/redirect?url=wxact/poact",
						actService.isRQZ() ? SysConfig.BASEURL + "/static/11act/images/sendimage.jpg"
								: SysConfig.BASEURL + "/static/11act/images/sendimageover.jpg");
			} else if (ekey.startsWith("fxgz000")) { // 分享+关注活动
				return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "分享有红包",
						"分享就有机会获得红包，更可参与抽奖，还有更多活动等你来参加，优惠多多。", SysConfig.BASEURL + "/wxurl/redirect?url=wxact/share",
						SysConfig.BASEURL + "/static/11act/gzfx/fxgzsend.jpg");
			} else if (ekey.startsWith("shxxrk000")) {
				return getMerchantInfo(Long.parseLong(ekey.substring(6, ekey.length())), data);
			} else if (ekey.startsWith("afuaxi000")) {
				afuAxiService.add(data.get("FromUserName"));
			} else if (ekey.startsWith("yesican000")) {
				return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "用你的技能，造福邻里",
						"点击链接，先写个人能手信息，可以发布你的才能，用你的才能服务他人。", SysConfig.BASEURL + "/wxcommunity/",
						SysConfig.BASEURL + "/static/images/icantuwen.png");
			} else if (ekey.startsWith("518000")) {
				/*return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "用你的技能，造福邻里",
				"点击链接，先写个人能手信息，可以发布你的才能，用你的才能服务他人。", SysConfig.BASEURL + "/wxcommunity/",
				SysConfig.BASEURL + "/static/images/icantuwen.png");*/
				return getQgInfo(Long.parseLong(ekey.substring(6, ekey.length())), data);
			}/*
				 * else if (ekey.startsWith("jiangda000")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("taihu000")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("99")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("88")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/", SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("77")) { Long proid =
				 * Long.parseLong(ekey.substring(5, ekey.length())); return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美校园",
				 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=newyearact/detail?id=" + proid,
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/tuwen.jpg"); } else if
				 * (ekey.startsWith("55")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员", "最美服务员评选，快来参与吧!",
				 * SysConfig.BASEURL + "/wxurl/redirect?url=waiter/",
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); } else if
				 * (ekey.startsWith("44")) { return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员", "最美服务员评选，快来参与吧!",
				 * SysConfig.BASEURL + "/wxurl/redirect?url=waiter/",
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); } else if
				 * (ekey.startsWith("33")) { Long waiterid =
				 * Long.parseLong(ekey.substring(5, ekey.length())); return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员", "最美服务员评选，快来参与吧!",
				 * SysConfig.BASEURL + "/wxurl/redirect?url=waiter/detail?id=" +
				 * waiterid, SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); } else if
				 * (ekey.startsWith("543")) { Long waiterid =
				 * Long.parseLong(ekey.substring(6, ekey.length())); return
				 * WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
				 * data.get("FromUserName"), "最美服务员",
				 * "关注公众号，进入活动页面为喜欢的服务员投上一票吧！", SysConfig.BASEURL +
				 * "/wxurl/redirect?url=waiter/detail?id=" + waiterid,
				 * SysConfig.BASEURL +
				 * "/static/wxfile/newyear/image/fwysend.jpg"); }
				 */ else {
				getDefaultTip(data);
			}
		} else {
			return returnstr;
		}
		return returnstr;
	}

	/**
	 * 
	 * 人气值活动
	 * 
	 * @author lyf
	 * @date 2015年10月19日 上午9:08:56
	 * @param isfirst
	 * @param ekey
	 * @param data
	 * @return
	 */
	public String rqzhd(boolean isfirst, String ekey, Map<String, String> data) {
		boolean state = actService.isRQZ();
		if (state) {
			if (isfirst) {
				String fxr = wXUserService.get(Long.parseLong(ekey.substring(6, ekey.length()))).getOpenid();
				if (!fxr.equals(data.get("FromUserName"))) {
					if (popularityService.Judge(data.get("FromUserName"))) {
						WXUser wu = wXUserService.getOrNewWXUser(data.get("FromUserName"));
						if (popularityService.add1Score(fxr, data.get("FromUserName"))) {
							WXManage.SendMessage(weChatAccountService.getAccesstoken(), fxr,
									"您的好友" + wu.getRealname() + "已帮您增加了人气值10分");
						}
						String sendopenid = popularityService.add2Score(fxr, data.get("FromUserName"));
						if (sendopenid != null) {
							WXManage.SendMessage(weChatAccountService.getAccesstoken(), sendopenid,
									"您好友的朋友" + wu.getRealname() + "已帮您增加了人气值3分");
						}
						// popularityService.add1Score(data.get("FromUserName"),
						// data.get("FromUserName"));

						WXManage.SendMessage(weChatAccountService.getAccesstoken(), data.get("FromUserName"),
								"感谢参加活动人气值活动,并且您已成功帮好友增加了人气值");
					}
				}
			}
		}
		return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "双11拼人气，赢iPhone",
				"关注公众号，进入活动页面，积累人气值赢iPhone,大奖等你来拿！", SysConfig.BASEURL + "/wxurl/redirect?url=wxact/poact",
				state ? SysConfig.BASEURL + "/static/11act/images/sendimage.jpg"
						: SysConfig.BASEURL + "/static/11act/images/sendimageover.jpg");
	}

	/*********************** 下面是双旦活动，最美服务员消息推送 **********************/

	public String zmfwy(String ekey, Map<String, String> data) {
		Long waiterid = Long.parseLong(ekey.substring(6, ekey.length()));

		/*
		 * WXUser wu = wXUserService.getOrNewWXUser(data.get("FromUserName"));
		 * 
		 * Map<String, Object> map =
		 * waiterRedbagService.saveWaiterRedbag(waiterid,
		 * data.get("FromUserName"), wu.getRealname());
		 * 
		 * if(map.get("result").equals("1")) { String reopenid =
		 * map.get("reopenid").toString(); System.out.println(reopenid);
		 * WXManage.SendMessage(WXManage.WCA, reopenid, wu.getRealname() +
		 * "已通过您的二维码关注了公众号帮您积累了人气"); }
		 */

		return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "最美服务员",
				"关注公众号，进入活动页面为喜欢的服务员投上一票吧！", SysConfig.BASEURL + "/wxurl/redirect?url=waiter/detail?id=" + waiterid,
				SysConfig.BASEURL + "/static/wxfile/newyear/image/fwysend.jpg");
	}

	/***********************************************************/

	/**
	 * 
	 * 支付完成后调用
	 * 
	 * @author luyf
	 * @date 2015年7月30日 下午2:43:25
	 * @param data
	 * @return
	 */
	public String payCompleteEventAct(Map<String, String> data) {
		return eggact2(data);
	}

	// =====================================================//

	// ======================活动代码===========================//
	/**
	 * 
	 * 扫描买鸡蛋
	 * 
	 * @author luyf
	 * @date 2015年7月30日 下午1:37:09
	 * @return
	 */
	public String eggact1(Map<String, String> data, String returnstr, boolean iss) {
		if (data.containsKey("EventKey") && !data.get("EventKey").equals("")
				&& (data.get("EventKey").startsWith("tmp000") || data.get("EventKey").startsWith("qrscene_tmp000"))) {
			try {
				String key = null;
				if (iss) {
					key = data.get("EventKey").substring(12);
				} else {
					key = data.get("EventKey").substring(4);
				}
				System.out.println(key);
				// TODO 查询活动状态
				Activity a = activityService.get(Long.parseLong(key));
				if (a == null) {
					return returnstr;
				} else if (a.getState() == 0) {
					return WXUtil.getBackXMLTypeText(data.get("ToUserName"), data.get("FromUserName"), "活动还未开始,敬请期待!");
				} else if (a.getState() == 2) {
					return WXUtil.getBackXMLTypeText(data.get("ToUserName"), data.get("FromUserName"),
							"活动已结束,关注公众号参与下次活动!");
				}
				if (a.getType().equals("muban") && a.getSubtype() == 1) {
					returnstr = WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), a.getTitle(),
							a.getSubtitle(), a.getUrl(), SysConfig.BASEURL + "/" + a.getImgurl());
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return returnstr;
	}

	String qrcodefile = "tmpqrcode";

	/**
	 * 
	 * 鸡蛋活动 返回1 不需要再参与返利活动判断
	 * 
	 * @author luyf
	 * @date 2015年8月8日 下午1:39:27
	 * @param data
	 * @return
	 */
	public String eggact2(Map<String, String> data) {
		String ordercode = data.get("out_trade_no");
		Tmprecord t = tmprecordService.getByCode(ordercode);
		if (t != null) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String daystr = sdf.format(now);
			Activity a = activityService.get(t.getActid());
			if (a.getType().equals("muban") && a.getSubtype() == 1) {

				MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
				Map hints = new HashMap();
				hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
				hints.put(EncodeHintType.MARGIN, 0);
				BitMatrix bitMatrix;
				try {
					bitMatrix = multiFormatWriter.encode(t.getOpenid() + "," + t.getId(), BarcodeFormat.QR_CODE, 400,
							400, hints);
					File pf = new File(Util.getRootPath() + File.separator + qrcodefile + File.separator + daystr);
					if (!pf.exists()) {
						pf.mkdirs();
					}
					File f = new File(Util.getRootPath() + File.separator + qrcodefile + File.separator + daystr
							+ File.separator + now.getTime() + ".png");
					MatrixToImageWriter.writeToFile(bitMatrix, "png", f);

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				t.setState(1);
				t.setPaytime(now);
				t.setQrcode("/" + qrcodefile + "/" + daystr + "/" + now.getTime() + ".png");

				if (true) { // 是否是用农商行卡支付
							// data.get("bank_type").equals(WXManage.NSHCode)
					String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
					t.setRebatecode(billno);
					int rebateprice = a.getRebateprice();
					t.setRebateprice(rebateprice);
					// TODO 发红包
					if (WXManage.sendPrize(WXManage.WCA, data.get("openid"), rebateprice, a.getTitle(),
							"更多优惠关注金阿福e服务公众号", "金阿福e服务", "金阿福e服务", a.getTitle(), billno)) {
						t.setRebatestate(1);
					} else {
						t.setRebatestate(0);
					}
				} else {
					t.setRebateprice(0);
					t.setRebatestate(0);
				}
				tmprecordService.SaveOrUpdate(t);
				return "1";
			}

		}
		return "0";
	}

	// =================================================//

	public String getMerchantInfo(Long id, Map<String, String> data) {
		if (id == 61) {
			id = (long) 75;
		}
		Merchant mer = merchantService.get(id);
		return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), mer.getName() + "欢迎您", "",
				SysConfig.BASEURL + "/wxpage/merdetail?id=" + id + "&token=noshake",
				SysConfig.BASEURL + "/static/11act/djlj.jpg");
	}
	
	public String getQgInfo(Long id, Map<String, String> data) {
		System.out.println(id);
		Sq_QuickBuy sq = sqQuickBuyService.get(id);
		return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), sq.getTitle(), "",
				SysConfig.BASEURL + "/wxcommunity/qgdetail?id=" + id,
				sq.getImgurl());
	}

	public String getDefaultTip(Map<String, String> data) {
		/*
		 * return WXUtil.getBackXMLTypeImg(data.get("ToUserName"),
		 * data.get("FromUserName"), "最美校园",
		 * "用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春!", WXManage.BASEURL +
		 * "/wxurl/redirect?url=newyearact/", WXManage.BASEURL +
		 * "/static/wxfile/newyear/image/tuwen.jpg");
		 */

		/*
		 * List<String> titles = new ArrayList<String>(); titles.add("最美校园");
		 * titles.add("最美服务员"); List<String> contents = new ArrayList<String>();
		 * contents.add("用相机抓捕大学记忆中那些让你触动的人，让你沉醉的风景，以及永垂不朽的青春！");
		 * contents.add("你有没有因为某家店里的美女服务员而爱上一家店？快来评选出你心中那位最美的服务员吧！");
		 * List<String> urls = new ArrayList<String>();
		 * urls.add(SysConfig.BASEURL + "/wxurl/redirect?url=newyearact/");
		 * urls.add(SysConfig.BASEURL + "/wxurl/redirect?url=waiter/");
		 * List<String> pUrls = new ArrayList<String>();
		 * pUrls.add(SysConfig.BASEURL +
		 * "/static/wxfile/newyear/image/tuwen.jpg");
		 * pUrls.add(SysConfig.BASEURL +
		 * "/static/wxfile/newyear/image/fwysend.jpg"); return
		 * WXUtil.getBackXMLTypeImgS(data.get("ToUserName"),
		 * data.get("FromUserName"), titles, contents, urls, pUrls);
		 */

		return WXUtil.getBackXMLTypeImg(data.get("ToUserName"), data.get("FromUserName"), "用你的技能，造福邻里",
				"点击链接，先写个人能手信息，可以发布你的才能，用你的才能服务他人。", SysConfig.BASEURL + "/wxcommunity/",
				SysConfig.BASEURL + "/static/images/icantuwen.png");

	}
}
