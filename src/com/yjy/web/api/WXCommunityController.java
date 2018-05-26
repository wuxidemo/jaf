package com.yjy.web.api;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.h2.store.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.entity.Advert;
import com.yjy.entity.CategoryType;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.Community;
import com.yjy.entity.Mercomment;
import com.yjy.entity.SqTmpOrder;
import com.yjy.entity.Sq_Advert;
import com.yjy.entity.Sq_AreaManage;
import com.yjy.entity.Sq_Donation;
import com.yjy.entity.Sq_Donation_Good;
import com.yjy.entity.Sq_Donation_Item;
import com.yjy.entity.Sq_Gift_Item;
import com.yjy.entity.Sq_PensionAct;
import com.yjy.entity.Sq_PensionApply;
import com.yjy.entity.Sq_Propertyfee;
import com.yjy.entity.Sq_QGOrder;
import com.yjy.entity.Sq_QuickBuy;
import com.yjy.entity.Sq_Repair;
import com.yjy.entity.Sq_UserAccessControl;
import com.yjy.entity.Sq_Wy_Telephone;
import com.yjy.entity.User;
import com.yjy.entity.Volunteer;
import com.yjy.entity.WXCardRecord;
import com.yjy.entity.WXUser;
import com.yjy.entity.WXuserInfo;
import com.yjy.service.AdvertService;
import com.yjy.service.CategoryTypeService;
import com.yjy.service.CategoryValueService;
import com.yjy.service.CommunityService;
import com.yjy.service.MerchantService;
import com.yjy.service.MercommentService;
import com.yjy.service.MyService;
import com.yjy.service.SqAdvertService;
import com.yjy.service.SqGiftRecordService;
import com.yjy.service.SqQGOrderService;
import com.yjy.service.SqQuickBuyService;
import com.yjy.service.SqTmpOrderService;
import com.yjy.service.SqWyTelephoneService;
import com.yjy.service.Sq_AreaManageService;
import com.yjy.service.Sq_DonationService;
import com.yjy.service.Sq_Donation_GoodService;
import com.yjy.service.Sq_Donation_ItemService;
import com.yjy.service.Sq_Gift_ItemService;
import com.yjy.service.Sq_PensionActService;
import com.yjy.service.Sq_PensionApplyService;
import com.yjy.service.Sq_PropertyfeeService;
import com.yjy.service.Sq_RepairService;
import com.yjy.service.Sq_UserAccessControlService;
import com.yjy.service.TmpArtService;
import com.yjy.service.VolunteerService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXUserService;
import com.yjy.service.WXuserInfoService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.SendMessage;
import com.yjy.utils.Util;
import com.yjy.utils.wxytConfig;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;
import com.yjy.wechat.WxCardSign;

/**
 * 类WXCommunityController.java的实现描述：TODO 类实现描述
 * 
 * @author yigang 2016年3月16日 下午2:45:44
 */
@Controller
@RequestMapping(value = "wxcommunity")
public class WXCommunityController {

	@Autowired
	private WXUserService wXUserService;

	@Autowired
	private WeChatAccountService weChatAccountService;

	@Autowired
	private VolunteerService volunteerService;

	@Autowired
	private CategoryTypeService categoryTypeService;

	@Autowired
	private CategoryValueService categoryValueService;

	@Autowired
	private CommunityService communityService;

	@Autowired
	private SqAdvertService sqAdvertService;

	@Autowired
	private Sq_DonationService sq_DonationService;

	@Autowired
	private SqGiftRecordService sqGiftRecordService;

	@Autowired
	private MyService myService;

	@Autowired
	private WXuserInfoService wXuserInfoService;

	@Autowired
	Sq_Donation_GoodService sq_Donation_GoodService;
	@Autowired
	SqTmpOrderService sqTmpOrderService;

	@Autowired
	Sq_RepairService repairService;

	@Autowired
	MercommentService mercommentService;

	@Autowired
	private MerchantService merchantService;
	@Autowired
	TmpArtService tmpArtService;

	@Autowired
	Sq_AreaManageService areaManageService;

	@Autowired
	Sq_PensionActService sq_PensionActService;

	public static String notify_url = SysConfig.BASEURL + "/wxcommunity/payback"; // 捐赠回调
	public static String jfnotify_url = SysConfig.BASEURL + "/wxcommunity/jfpayback"; // 物业缴费回调
	public static String qgnotiry_url = SysConfig.BASEURL + "/wxcommunity/qgpayback"; // 抢购活动支付缴费回调

	@Autowired
	AdvertService advertService;

	@Autowired
	SqWyTelephoneService sqWyTelephoneService;

	@Autowired
	Sq_PropertyfeeService sq_PropertyfeeService;

	@Autowired
	Sq_Donation_ItemService sq_Donation_ItemService;

	@Autowired
	Sq_Gift_ItemService sq_Gift_ItemService;

	@Autowired
	SqQuickBuyService sqQuickBuyService;

	@Autowired
	Sq_UserAccessControlService sq_UserAccessControlService;

	@Autowired
	SqQGOrderService sqQGOrderService;

	@Autowired
	WXCardRecordService wXCardRecordService;

	@Autowired
	Sq_PensionApplyService sq_PensionApplyService;

	/**
	 * 判断用户是否关注过公众号，如果没有，则会生成一个临时的二维码让用户来长按关注
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午2:51:47
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

	/**
	 * 用户将本地图片上传到微信服务器，返回一个sid,根据这个sid将图片下载到服务器上去，然后再上传到腾讯云上面去
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午2:52:29
	 * @param sid
	 * @return
	 */
	@RequestMapping(value = "saveimg")
	@ResponseBody
	public String saveimg(@RequestParam(value = "sid") String sid) {
		String downurl = null;
		String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + WXManage.WCA.getAccesstoken()
				+ "&media_id=" + sid;
		String baespath = Util.getRootPath() + File.separator + "afucommunity" + File.separator;
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

	/**
	 * 我能行模块入口
	 * 
	 * @author yigang
	 * @date 2016年3月18日 下午4:03:29
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping()
	public String main(Model model, HttpServletRequest request, @RequestParam(value = "comid") Long comid) {
		model.addAttribute("comid", comid);
		model.addAttribute("comname", communityService.get(comid).getName());
		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/?comid=" + comid));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		return "wnx/serve";
	}

	/**
	 * 手机页面点击个人信息的时候，根据openid来判断当前用户是否填写过个人资料，如果没有则跳转到新增个人资料的页面，如果填写过，则跳转到查看页面
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午2:47:10
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "myinfo")
	public String myInfo(Model model, HttpServletRequest request, @RequestParam(value = "comid") Long comid) {

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/myinfo?comid=" + comid));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		model.addAttribute("comid", comid);
		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/myinfo?comid=" + comid;
		}

		WXUser wxuser = wXUserService.getOrNewWXUser(oid.toString());
		if (wxuser != null && wxuser.getState() == 1) {

		} else {
			return "wnx/ewm";
		}

		List<Volunteer> vols = volunteerService.getVolunteersByOpenid(oid.toString());

		CategoryType ct = null;
		List<CategoryValue> cvlist = null;
		List<CategoryType> ctlist = categoryTypeService.getCategoryTypeByValue("才能类型");
		if (ctlist != null && ctlist.size() > 0) {
			ct = ctlist.get(0);
			cvlist = categoryValueService.getCategoryValueListByCid(ct.getId(), 0);
		}
		model.addAttribute("ablelist", cvlist);
		model.addAttribute("openid", oid.toString());
		model.addAttribute("headimgurl", wxuser.getHeadimgurl());
		if (vols != null && vols.size() > 0) {

			List<Object[]> vollist = volunteerService.getVolunteerDetail(vols.get(0).getId());
			Object[] v = vollist.get(0);

			Object comobj = v[15];
			if (comobj != null) {
				Community comm = communityService.get(Long.valueOf(comobj.toString()));
				model.addAttribute("commname", comm.getName());
			} else {
				model.addAttribute("commname", "无所属社区");
			}

			Object nameobj = v[2];
			Object nicknameobj = v[3];
			Object sexobj = v[4];
			if (nameobj != null) {
				String name = nameobj.toString().substring(0, 1);
				if (sexobj != null) {
					if (sexobj.toString().equals("1")) {
						model.addAttribute("name", name + "先生");
					} else if (sexobj.toString().equals("2")) {
						model.addAttribute("name", name + "女士");
					} else {
						model.addAttribute("name", name);
					}
				} else {
					model.addAttribute("name", name);
				}
			} else {
				if (nicknameobj != null) {
					model.addAttribute("name", nicknameobj.toString());
				} else {
					model.addAttribute("name", "匿名用户");
				}
			}

			Object headobj = v[1];
			if (headobj == null) {
				model.addAttribute("headimgurl", wxuser.getHeadimgurl());
			} else {
				model.addAttribute("headimgurl", v[1].toString());
			}

			model.addAttribute("id", v[0]);
			// model.addAttribute("headimgurl",v[1]);
			// model.addAttribute("name",v[2]);
			model.addAttribute("nickname", v[3]);
			model.addAttribute("sex", v[4]);
			model.addAttribute("age", v[5]);
			model.addAttribute("servetime", v[6]);
			model.addAttribute("phone", v[7]);
			model.addAttribute("ability", v[8]);
			model.addAttribute("abilitydescrib", v[9]);
			model.addAttribute("paytype", v[10]);
			model.addAttribute("pay", v[11]);
			model.addAttribute("checkstate", v[12]);
			model.addAttribute("isshow", v[13]);
			model.addAttribute("createtime", v[14]);
			model.addAttribute("openid", v[16]);
			model.addAttribute("failreason", v[17]);

			return "wnx/chakangeren";

		} else {

			model.addAttribute("wu", wXuserInfoService.getInfoByOpenid(oid.toString()));
			return "wnx/tiangeren";
		}

	}

	@RequestMapping(value = "editmyinfo")
	public String editMyinfo(@RequestParam(value = "comid") Long comid, Model model, HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		model.addAttribute("comid", comid);
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/editmyinfo?comid=" + comid;
		}
		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/editmyinfo?openid=" + openid));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		Volunteer vol = null;
		List<Volunteer> vols = volunteerService.getVolunteersByOpenid(openid.toString());
		if (vols != null && vols.size() > 0) {
			vol = vols.get(0);
		}

		CategoryType ct = null;
		List<CategoryValue> cvlist = null;
		List<CategoryType> ctlist = categoryTypeService.getCategoryTypeByValue("才能类型");
		if (ctlist != null && ctlist.size() > 0) {
			ct = ctlist.get(0);
			cvlist = categoryValueService.getCategoryValueListByCid(ct.getId(), 0);
		}
		model.addAttribute("ablelist", cvlist);
		model.addAttribute("openid", openid);

		if (vol != null) {
			model.addAttribute("ablestr", "," + vol.getAbility() + ",");
			model.addAttribute("volunteer", vol);

			/*
			 * String headimgurl = vol.getHeadimgurl(); if (headimgurl == null
			 * || "".equals(headimgurl) || "null".equals(headimgurl)) { WXUser
			 * wxuser = wXUserService.getOrNewWXUser(openid);
			 * model.addAttribute("headimgurl", wxuser.getHeadimgurl()); } else
			 * { model.addAttribute("headimgurl", vol.getHeadimgurl()); }
			 */

			model.addAttribute("headimgurl", vol.getHeadimgurl());

			model.addAttribute("wu", wXuserInfoService.getInfoByOpenid(openid.toString()));

			return "wnx/xiugaigeren";
		} else {

			model.addAttribute("wu", wXuserInfoService.getInfoByOpenid(openid.toString()));
			return "wnx/tiangeren";
		}

	}

	/**
	 * 这个填写我能行个人资料的时候，发送短信验证码来验证填写的手机号码是否是本人的号码
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午2:45:48
	 * @param phone
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "sendsms", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendSMS(@RequestParam(value = "phone") String phone, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			String captcha = Util.getCaptcha();

			System.out.println("此次发送号码的手机：------ " + phone);
			System.out.println("此次发送的验证码：------ " + captcha);

			HttpSession session = request.getSession();
			SendMessage.sendYZMSMS(phone, "您好，您的验证码是:" + captcha + "。【金阿福e服务】", "");
			session.removeAttribute(phone.trim());
			session.setAttribute(phone.trim(), captcha);

			map.put("result", "1");
			map.put("msg", "短信发送成功");

		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "短信发送失败");
		}

		return map;

	}

	/**
	 * 用来测试ajax异步请求的接口是否正常
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午4:56:01
	 * @return
	 */
	@RequestMapping(value = "afu")
	public String afu() {
		return "afutest/afu";
	}

	/**
	 * 校验验证码是否正确
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午2:46:50
	 * @param phone
	 * @param code
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "verifycaptcha", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> verifyCode(@RequestParam(value = "phone") String phone,
			@RequestParam(value = "code") String code, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		String verifystr = (String) session.getAttribute(phone.trim());

		System.out.println("此次验证的手机号：------ " + phone);
		System.out.println("此次验证的验证码：------ " + code);

		if (verifystr == null) {
			map.put("result", "0");
			map.put("msg", "系统错误，请稍后重试");
			return map;
		}

		if (code.trim().equals(verifystr)) {
			map.put("result", "1");
			map.put("msg", "验证成功");
		} else {
			map.put("result", "0");
			map.put("msg", "验证码错误");
		}

		return map;

	}

	/**
	 * 获取所有的社区列表接口
	 * 
	 * @author yigang
	 * @date 2016年3月18日 上午9:48:39
	 * @return
	 */
	@RequestMapping(value = "getcommunities", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getCommunities() {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Community> commlist = communityService.getCommunityList();
		if (commlist != null && commlist.size() > 0) {
			map.put("result", "1");
			map.put("data", commlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/**
	 * 获取当前字典项中个人才能的种类
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午4:56:35
	 * @return
	 */
	@RequestMapping(value = "getkind", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getKind() {
		Map<String, Object> map = new HashMap<String, Object>();

		CategoryType ct = null;
		List<CategoryValue> cvlist = null;
		List<CategoryType> ctlist = categoryTypeService.getCategoryTypeByValue("才能类型");
		if (ctlist != null && ctlist.size() > 0) {
			ct = ctlist.get(0);
			cvlist = categoryValueService.getCategoryValueListByCid(ct.getId(), 0);
			map.put("result", "1");
			map.put("data", cvlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 根据不同的条件查询我能行中志愿者列表
	 * 
	 * @author yigang
	 * @date 2016年3月16日 下午4:57:06
	 * @param keyword
	 * @param kind
	 * @param pay
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListByParam(@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "commid", required = false) String commid,
			@RequestParam(value = "kind", required = false) String kind,
			@RequestParam(value = "pay", required = false) String pay, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size) {

		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();

		if (keyword != null && !"".equals(keyword.trim()) && !"null".equals(keyword.trim())) {
			searchParams.put("keyword", keyword.trim());
		}

		if (commid != null && !"0".equals(commid.trim()) && !"null".equals(commid.trim())) {
			searchParams.put("commid", commid.trim());
		}

		if (kind != null && !"0".equals(kind.trim()) && !"null".equals(kind.trim())) {
			searchParams.put("kind", kind.trim());
		}

		if (pay != null && !"-1".equals(pay.trim()) && !"null".equals(pay.trim())) {
			searchParams.put("pay", pay.trim());
		}

		List<Object[]> vlist = volunteerService.getVolunteerListDataByParam(searchParams, start, size);

		if (vlist != null && vlist.size() > 0) {
			for (Object[] obj : vlist) {
				Object nameobj = obj[1];
				Object sexobj = obj[2];
				if (nameobj != null) {
					String name = nameobj.toString().substring(0, 1);
					if (sexobj != null) {
						if (sexobj.toString().equals("1")) {
							obj[1] = name + "先生";
						} else if (sexobj.toString().equals("2")) {
							obj[1] = name + "女士";
						} else {
							obj[1] = nameobj;
						}
					} else {
						obj[1] = name + "先生/女士";
					}
				} else {
					obj[1] = "匿名用户";
				}
			}
			map.put("result", "1");
			map.put("data", vlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;

	}

	/**
	 * 上下线
	 * 
	 * @author liping
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "isshow", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> isshow(@RequestParam(value = "openid") String openid) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Volunteer> vols = volunteerService.getVolunteersByOpenid(openid);
		Volunteer vol = vols.get(0);
		Integer isshow = vol.getIsshow();
		if (isshow == null || isshow == 0) {
			vol.setIsshow(1);
			volunteerService.save(vol);
			map.put("isshow", 1);
			map.put("msg", vol.getName() + "上线成功！");
		} else {
			vol.setIsshow(0);
			volunteerService.save(vol);
			map.put("isshow", 0);
			map.put("msg", vol.getName() + "下线成功！");
		}

		return map;
	}

	/**
	 * 用来保存新增的志愿者个人资料
	 * 
	 * @author yigang
	 * @date 2016年3月21日 下午1:33:30
	 * @param vol
	 * @param openid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveVolunteer(@Valid Volunteer vol, @RequestParam(value = "openid") String openid,
			@RequestParam(value = "issave") Integer issave, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WXUser wxuser = wXUserService.getOrNewWXUser(openid);
		List<Volunteer> vols = volunteerService.getVolunteersByOpenid(openid);
		if (vols != null && vols.size() > 0) {

			WXuserInfo wu = wXuserInfoService.getInfoByOpenid(openid);
			if (wu == null) {
				wu = new WXuserInfo();
				wu.setName(vol.getName());
				wu.setOpenid(openid);
				wu.setPhone(vol.getPhone());
				wu.setSex(vol.getSex());
				wu.setAge(vol.getAge());
				wu.setHeadimgurl(wxuser.getHeadimgurl());
				wu.setCommunity(vol.getCommunity());
				wXuserInfoService.save(wu);
			} else {
				if (issave == 1) {
					wu.setOpenid(openid);
					wu.setName(vol.getName());
					wu.setPhone(vol.getPhone());
					wu.setSex(vol.getSex());
					wu.setAge(vol.getAge());
					wu.setHeadimgurl(wxuser.getHeadimgurl());
					wu.setCommunity(vol.getCommunity());
					wXuserInfoService.save(wu);
				}
			}

			map.put("result", "0");// 已存在
			map.put("data", vols.get(0));
			return map;
		} else {
			try {
				String headimgurl = vol.getHeadimgurl();
				if (headimgurl == null || "".equals(headimgurl) || "null".equals(headimgurl)) {
					vol.setHeadimgurl(wxuser.getHeadimgurl());
				}
				vol.setCreatetime(new Date());
				vol.setFailreason(null);
				vol.setIsshow(null);
				vol.setNickname(wxuser.getRealname());
				vol.setOpenid(openid);
				vol.setState(0);

				volunteerService.save(vol);

				WXuserInfo wu = wXuserInfoService.getInfoByOpenid(openid);
				if (wu == null) {
					wu = new WXuserInfo();
					wu.setName(vol.getName());
					wu.setOpenid(openid);
					wu.setPhone(vol.getPhone());
					wu.setSex(vol.getSex());
					wu.setAge(vol.getAge());
					wu.setHeadimgurl(wxuser.getHeadimgurl());
					wu.setCommunity(vol.getCommunity());
					wXuserInfoService.save(wu);
				} else {
					if (issave == 1) {
						wu.setOpenid(openid);
						wu.setName(vol.getName());
						wu.setPhone(vol.getPhone());
						wu.setSex(vol.getSex());
						wu.setAge(vol.getAge());
						wu.setHeadimgurl(wxuser.getHeadimgurl());
						wu.setCommunity(vol.getCommunity());
						wXuserInfoService.save(wu);
					}
				}

				map.put("result", "1");
				return map;
			} catch (Exception e) {
				volunteerService.save(vol);
				map.put("result", "2");
				return map;
			}
		}
	}

	/**
	 * 编辑个人信息
	 * 
	 * @author liping
	 * @param vol
	 * @param openid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "update")
	@ResponseBody
	public Map<String, Object> updateVolunteer(@Valid Volunteer vol, @RequestParam(value = "openid") String openid,
			@RequestParam(value = "issave", defaultValue = "0") Integer issave, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		WXUser wxuser = wXUserService.getOrNewWXUser(openid);
		List<Volunteer> vols = volunteerService.getVolunteersByOpenid(openid);
		if (vols != null && vols.size() > 0) {

			WXuserInfo wu = wXuserInfoService.getInfoByOpenid(openid);
			if (wu == null) {
				wu = new WXuserInfo();
				wu.setName(vol.getName());
				wu.setOpenid(openid);
				wu.setPhone(vol.getPhone());
				wu.setSex(vol.getSex());
				wu.setAge(vol.getAge());
				wu.setHeadimgurl(wxuser.getHeadimgurl());
				wXuserInfoService.save(wu);
			} else {
				if (issave == 1) {
					wu.setOpenid(openid);
					wu.setName(vol.getName());
					wu.setPhone(vol.getPhone());
					wu.setSex(vol.getSex());
					wu.setAge(vol.getAge());
					wu.setHeadimgurl(wxuser.getHeadimgurl());
					wXuserInfoService.save(wu);
				}
			}

			Volunteer volunteer = vols.get(0);

			String headimgurl = vol.getHeadimgurl();
			if (headimgurl == null || "".equals(headimgurl) || "null".equals(headimgurl)) {
				volunteer.setHeadimgurl(wxuser.getHeadimgurl());
			} else {
				volunteer.setHeadimgurl(headimgurl);
			}

			volunteer.setName(vol.getName());
			volunteer.setSex(vol.getSex());
			volunteer.setAge(vol.getAge());
			volunteer.setPhone(vol.getPhone());
			volunteer.setOpenid(openid);
			volunteer.setNickname(wxuser.getRealname());
			volunteer.setServertime(vol.getServertime());
			volunteer.setPay(vol.getPay());
			volunteer.setCommunity(vol.getCommunity());
			volunteer.setPaytype(vol.getPaytype());
			/* 如果修改了才能或者才能描述则重新审核，否则审核结果不变。创建时间不变 */
			String ability = volunteer.getAbility();
			String abilitydescrib = volunteer.getAbilitydescrib();
			int checkstate = volunteer.getState();

			System.out.println("+++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("数据库volunteer -- ID : " + volunteer.getId());
			System.out.println("数据库ability : " + ability);
			System.out.println("数据库abilitydescrib : " + abilitydescrib);
			System.out.println("数据库checkstate : " + checkstate);

			String pageability = vol.getAbility();
			String pageabilitydescrib = vol.getAbilitydescrib();

			System.out.println("页面修改ability : " + pageability);
			System.out.println("页面修改abilitydescrib : " + pageabilitydescrib);

			if (!pageability.equals(ability) || !pageabilitydescrib.equals(abilitydescrib) || checkstate == 2) {
				volunteer.setState(0);// 默认未审核 状态 0未审核 1审核通过 2审核失败
				volunteer.setIsshow(null);// 1展示0不展示 上下线
			}

			volunteer.setAbility(pageability);
			volunteer.setAbilitydescrib(pageabilitydescrib);

			Volunteer volunteer1 = volunteerService.save(volunteer);

			if (volunteer1 != null) {
				map.put("result", "1");// 保存成功
				map.put("msg", "保存成功");
				return map;
			} else {
				map.put("result", "2");// 保存失败
				map.put("msg", "保存失败");
				return map;
			}
		} else {
			map.put("result", "0");// 保存失败
			map.put("msg", "保存失败");
			return map;
		}

	}

	/**
	 * 获取志愿者个人详细信息
	 * 
	 * @author yigang
	 * @date 2016年3月21日 下午1:59:24
	 * @param id
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getvoldetail")
	public String getVolDetail(@RequestParam(value = "id") Long id, Model model, HttpServletRequest request) {

		List<Object[]> vollist = volunteerService.getVolunteerDetail(id);
		Object[] v = vollist.get(0);

		Object comobj = v[15];
		if (comobj != null) {
			Community comm = communityService.get(Long.valueOf(comobj.toString()));
			model.addAttribute("commname", comm.getName());
		} else {
			model.addAttribute("commname", "无所属社区");
		}

		Object nameobj = v[2];
		Object nicknameobj = v[3];
		Object sexobj = v[4];
		if (nameobj != null) {
			String name = nameobj.toString().substring(0, 1);
			if (sexobj != null) {
				if (sexobj.toString().equals("1")) {
					model.addAttribute("name", name + "先生");
				} else if (sexobj.toString().equals("2")) {
					model.addAttribute("name", name + "女士");
				} else {
					model.addAttribute("name", name);
				}
			} else {
				model.addAttribute("name", name);
			}
		} else {
			if (nicknameobj != null) {
				model.addAttribute("name", nicknameobj.toString());
			} else {
				model.addAttribute("name", "匿名用户");
			}
		}

		model.addAttribute("id", v[0]);
		model.addAttribute("headimgurl", v[1]);
		// model.addAttribute("name",v[2]);
		model.addAttribute("nickname", v[3]);
		model.addAttribute("sex", v[4]);
		model.addAttribute("age", v[5]);
		model.addAttribute("servetime", v[6]);
		model.addAttribute("phone", v[7]);
		model.addAttribute("ability", v[8]);
		model.addAttribute("abilitydescrib", v[9]);
		model.addAttribute("paytype", v[10]);
		model.addAttribute("pay", v[11]);
		model.addAttribute("checkstate", v[12]);
		model.addAttribute("isshow", v[13]);
		model.addAttribute("createtime", v[14]);
		model.addAttribute("openid", v[16]);
		model.addAttribute("failreason", v[17]);

		return "wnx/PersonalData";

	}

	@RequestMapping(value = "showfocusqr")
	public String showFocusQR() {
		return "wnx/ewm";
	}

	/************************************ 以下是义仓模块 *******************************************************/

	@RequestMapping(value = "donation")
	public String donation(@RequestParam(value = "comid") Long commid, Model model, HttpServletRequest request) {

		Community comm = communityService.get(commid);
		if (comm != null) {
			model.addAttribute("commname", comm.getName());
		}

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/donation?comid=" + commid));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		model.addAttribute("comid", commid);
		return "donation/ychomepage";
	}

	/**
	 * 获取社区捐赠联系人联系方式
	 * 
	 * @author yigang
	 * @date 2016年3月25日 下午3:28:12
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getcommcontact")
	@ResponseBody
	public Map<String, Object> getCommContact(Model model, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Community> commlist = communityService.getCommunityList();
		List<Map<String, String>> resultlist = new ArrayList<Map<String, String>>();
		if (commlist != null && commlist.size() > 0) {
			for (Community comm : commlist) {
				if (comm.getContactphone() == null) {
					continue;
				} else {
					Map<String, String> remap = new HashMap<String, String>();
					Integer consex = comm.getContactsex();
					if (consex == 1) {
						remap.put("commname", comm.getFirstname() + "先生");
					} else if (consex == 2) {
						remap.put("commname", comm.getFirstname() + "女士");
					} else {
						remap.put("commname", comm.getFullname());
					}
					remap.put("firstname", comm.getFirstname());
					remap.put("lastname", comm.getLastname());
					remap.put("contactphone", comm.getContactphone());
					resultlist.add(remap);
				}
			}

			if (resultlist.size() > 0) {
				map.put("result", "1");
				map.put("data", resultlist);
			} else {
				map.put("result", "0");
				map.put("msg", "暂无数据");
			}

		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 根据社区id获取本社区的轮播图
	 * 
	 * @author yigang
	 * @date 2016年3月25日 下午4:04:10
	 * @param comid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getcarousel")
	@ResponseBody
	public Map<String, Object> getCarousel(@RequestParam(value = "comid") Long comid, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		List<Sq_Advert> sqadvlist = sqAdvertService.getSqAdvertByComid(comid);
		if (sqadvlist != null && sqadvlist.size() > 0) {
			for (Sq_Advert sq : sqadvlist) {
				sq.setCommunity(null);
			}

			map.put("result", "1");
			map.put("data", sqadvlist);

		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 获取义仓首页最新的前20条捐献和赠与的记录，按照时间倒序排列
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:50:11
	 * @param comid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "gethomerecords")
	@ResponseBody
	public Map<String, Object> getHomeRecords(@RequestParam(value = "comid") Long comid, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> record = myService.getYiCangRecordsByComid(comid);

		for (Object[] obj : record) {
			List<String> itemlist = new ArrayList<String>();
			Object leibie = obj[0];
			Object id = obj[11];
			if (Integer.valueOf(leibie.toString()) == 1) {
				List<Sq_Donation_Item> sdis = sq_Donation_ItemService
						.getSq_Donation_ItemBydonation(Long.valueOf(id.toString()));
				if (sdis != null && sdis.size() > 0) {
					for (Sq_Donation_Item sd : sdis) {
						itemlist.add(sd.getName() + "##" + sd.getCount());
					}
				}
			} else {
				List<Sq_Gift_Item> sgis = sq_Gift_ItemService.getSq_Gift_ItemByGift(Long.valueOf(id.toString()));
				if (sgis != null && sgis.size() > 0) {
					for (Sq_Gift_Item sg : sgis) {
						itemlist.add(sg.getName() + "##" + sg.getCount());
					}
				}
			}
			obj[11] = itemlist;
		}

		if (record != null && record.size() > 0) {
			map.put("result", "1");
			map.put("data", record);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	@RequestMapping(value = "detailrecords")
	public String detailRecords(@RequestParam(value = "comid") Long comid, HttpServletRequest request, Model model) {

		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(),
				"/wxcommunity/detailrecords?comid=" + comid));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		model.addAttribute("comid", comid);
		return "donation/gbxq";
	}

	/**
	 * 获取公示详情里面的捐献和赠与的数据，分页，按照社区和类型来查找
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:50:50
	 * @param comid
	 * @param type
	 * @param start
	 * @param size
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getdetailrecords", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDetailRecords(@RequestParam(value = "comid", defaultValue = "0") Long comid,
			@RequestParam(value = "type") String type, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> record = myService.getYiCangRecordsByComidWithPage(comid, type, start, size);

		for (Object[] obj : record) {
			List<String> itemlist = new ArrayList<String>();
			Object leibie = obj[0];
			Object id = obj[11];
			if (Integer.valueOf(leibie.toString()) == 1) {
				List<Sq_Donation_Item> sdis = sq_Donation_ItemService
						.getSq_Donation_ItemBydonation(Long.valueOf(id.toString()));
				if (sdis != null && sdis.size() > 0) {
					for (Sq_Donation_Item sd : sdis) {
						itemlist.add(sd.getName() + "##" + sd.getCount());
					}
				}
			} else {
				List<Sq_Gift_Item> sgis = sq_Gift_ItemService.getSq_Gift_ItemByGift(Long.valueOf(id.toString()));
				if (sgis != null && sgis.size() > 0) {
					for (Sq_Gift_Item sg : sgis) {
						itemlist.add(sg.getName() + "##" + sg.getCount());
					}
				}
			}
			System.out.println(leibie + "-----" + obj[11] + "-----" + itemlist);
			obj[11] = itemlist;
		}

		if (record != null && record.size() > 0) {
			map.put("result", "1");
			map.put("data", record);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/**
	 * 查看我的捐献记录和被赠予的记录
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:51:30
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "myrecords", method = RequestMethod.GET)
	public String myRecords(HttpServletRequest request, Model model, @RequestParam(value = "comid") Long comid) {
		Object oid = request.getSession().getAttribute("openid");
		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/myrecords?comid=" + comid;
		}

		model.addAttribute("comid", comid);
		WXuserInfo wxuserinfo = wXuserInfoService.getInfoByOpenid(oid.toString());
		if (wxuserinfo == null) {
			return "donation/promptPage";
		}

		if (wxuserinfo.getPhone() == null) {
			model.addAttribute("wu", wxuserinfo);
			return "donation/gerenxinxi";
		}

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/myrecords?comid=" + comid));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		return "donation/Myrecord";
	}

	/**
	 * 填写个人资料页面
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:52:47
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "gerenxx", method = RequestMethod.GET)
	public String geRenxx(HttpServletRequest request, Model model) {
		Object oid = request.getSession().getAttribute("openid");
		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/gerenxx";
		}
		model.addAttribute("openid", oid.toString());
		model.addAttribute("wu", wXuserInfoService.getInfoByOpenid(oid.toString()));
		return "donation/gerenxinxi";

	}

	/**
	 * 我的捐献记录列表
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:53:02
	 * @param start
	 * @param size
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "idonate")
	@ResponseBody
	public Map<String, Object> iDonate(@RequestParam(value = "start") int start, @RequestParam(value = "size") int size,
			HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		Object oid = request.getSession().getAttribute("openid");

		// Object oid = "aa";

		WXuserInfo wxuserinfo = wXuserInfoService.getInfoByOpenid(oid.toString());

		if (wxuserinfo.getPhone() == null) {
			map.put("result", "0");
			map.put("msg", "无法获取用户的手机号码");
			return map;
		}

		List<Object[]> mydonations = myService.getMyDonationsByPhone(wxuserinfo.getPhone(), start, size);

		for (Object[] obj : mydonations) {
			List<String> itemlist = new ArrayList<String>();
			Object id = obj[11];
			List<Sq_Donation_Item> sdis = sq_Donation_ItemService
					.getSq_Donation_ItemBydonation(Long.valueOf(id.toString()));
			if (sdis != null && sdis.size() > 0) {
				for (Sq_Donation_Item sd : sdis) {
					itemlist.add(sd.getName() + "##" + sd.getCount());
				}
			}
			System.out.println(obj[11] + "-----" + itemlist);
			obj[11] = itemlist;
		}
		if (mydonations != null && mydonations.size() > 0) {
			map.put("result", "1");
			map.put("data", mydonations);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");

		}
		return map;

	}

	/**
	 * 我的被赠予记录列表
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:53:12
	 * @param start
	 * @param size
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "donatetome")
	@ResponseBody
	public Map<String, Object> donateToMe(@RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		Object oid = request.getSession().getAttribute("openid");

		WXuserInfo wxuserinfo = wXuserInfoService.getInfoByOpenid(oid.toString());

		if (wxuserinfo.getPhone() == null) {
			map.put("result", "0");
			map.put("msg", "无法获取用户的手机号码");
			return map;
		}

		List<Object[]> mygifts = myService.getMygiftsByPhone(wxuserinfo.getPhone(), start, size);

		for (Object[] obj : mygifts) {
			List<String> itemlist = new ArrayList<String>();
			Object id = obj[11];
			List<Sq_Gift_Item> sgis = sq_Gift_ItemService.getSq_Gift_ItemByGift(Long.valueOf(id.toString()));
			if (sgis != null && sgis.size() > 0) {
				for (Sq_Gift_Item sg : sgis) {
					itemlist.add(sg.getName() + "##" + sg.getCount());
				}
			}
			obj[11] = itemlist;
		}
		if (mygifts != null && mygifts.size() > 0) {
			map.put("result", "1");
			map.put("data", mygifts);

		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/**
	 * 获取义仓社区广告轮播图，按照社区id，去对应的社区的轮播图
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:53:27
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "advertdetail")
	public String getAdvertDetail(@RequestParam(value = "id") Long id, Model model) {

		Sq_Advert sqadv = sqAdvertService.get(id);
		model.addAttribute("sqadvert", sqadv);

		return "donation/advertdetail";
	}

	public String tomyinfo(Model model) {
		return "donation/grxx";
	}

	@RequestMapping(value = "savemyinfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveMyInfo(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "name") String name, @RequestParam(value = "sex") Integer sex,
			@RequestParam(value = "phone") String phone, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		WXUser wxuser = wXUserService.getOrNewWXUser(openid);

		WXuserInfo wxuserinfo = wXuserInfoService.getInfoByOpenid(openid);
		try {
			if (wxuserinfo != null) {
				wxuserinfo.setName(name);
				wxuserinfo.setPhone(phone);
				wxuserinfo.setSex(sex);
				wxuserinfo.setHeadimgurl(wxuser.getHeadimgurl());
				wXuserInfoService.save(wxuserinfo);
				map.put("result", "1");
				map.put("msg", "保存成功");
			} else {
				wxuserinfo = new WXuserInfo();
				wxuserinfo.setName(name);
				wxuserinfo.setPhone(phone);
				wxuserinfo.setSex(sex);
				wxuserinfo.setHeadimgurl(wxuser.getHeadimgurl());
				wxuserinfo.setOpenid(openid);
				wXuserInfoService.save(wxuserinfo);
				map.put("result", "1");
				map.put("msg", "保存成功");
			}
		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "保存失败");
			return map;
		}

		return map;
	}

	/**
	 * 我要捐献，个人捐献的跳转链接
	 * 
	 * @author yigang
	 * @date 2016年3月29日 下午5:54:16
	 * @param model
	 * @param request
	 * @param comid
	 * @return
	 */
	@RequestMapping(value = "persondonation")
	public String persondonation(Model model, HttpServletRequest request, @RequestParam(value = "comid") Long comid) {
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/persondonation";
		}
		model.addAttribute("openid", openid);
		model.addAttribute("comid", comid);
		return "donation/jxlb";
	}

	@RequestMapping(value = "savetmporder")
	@ResponseBody
	public Map<String, Object> savetmporder(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "comid") Long comid, @RequestParam(value = "allids") String ids,
			@RequestParam(value = "allcount") String counts) {
		Map<String, Object> result = new HashMap<String, Object>();
		SqTmpOrder sto = new SqTmpOrder();
		sto.setComid(comid);
		sto.setCounts(counts);
		sto.setGoodids(ids);
		sto.setOpenid(openid);
		String[] idss = ids.split(",");
		String[] countss = counts.split(",");
		int totalprice = 0;
		for (int i = 0; i < idss.length; i++) {
			Sq_Donation_Good sdg = sq_Donation_GoodService.getSq_Donation_GoodById(Long.parseLong(idss[i]));
			totalprice += sdg.getPrice() * Integer.parseInt(countss[i]);
		}
		sto.setPrice(totalprice);
		sto = sqTmpOrderService.save(sto);
		result.put("result", 1);
		result.put("tmpid", sto.getId());
		return result;
	}

	@RequestMapping(value = "updatetmporderform")
	public String updatetmporderform(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "tmpid") Long tmpid, Model model, @RequestParam(value = "comid") Long comid) {
		model.addAttribute("openid", openid);
		model.addAttribute("tmpid", tmpid);
		model.addAttribute("comid", comid);
		model.addAttribute("wu", wXuserInfoService.getInfoByOpenid(openid));
		return "donation/grxx";
	}

	@RequestMapping(value = "updatetmporder")
	@ResponseBody
	public Map<String, Object> updatetmporder(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "name") String name, @RequestParam(value = "sex") int sex,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "issave") int issave,
			@RequestParam(value = "tmpid") Long tmpid) {
		Map<String, Object> result = new HashMap<String, Object>();
		WXUser wxuser = wXUserService.getOrNewWXUser(openid);
		WXuserInfo wu = wXuserInfoService.getInfoByOpenid(openid);
		if (wu == null) {
			wu = new WXuserInfo();
			wu.setName(name);
			wu.setOpenid(openid);
			wu.setPhone(phone);
			wu.setHeadimgurl(wxuser.getHeadimgurl());
			wu.setSex(sex);
			wXuserInfoService.save(wu);
		} else {
			if (issave == 1) {
				wu.setName(name);
				wu.setPhone(phone);
				wu.setSex(sex);
				wu.setHeadimgurl(wxuser.getHeadimgurl());
				wXuserInfoService.save(wu);
			}
		}

		SqTmpOrder sto = sqTmpOrderService.get(tmpid);
		if (sto == null) {
			result.put("result", "0");
			result.put("msg", "未发现相应订单");
		} else {
			if (sto.getMycode() != null) {
				result.put("result", "0");
				result.put("msg", "订单已完成请勿重复提交。");
			} else {
				Date now = new Date();
				Long ts = now.getTime();
				String ordercode = now.getTime() + Util.getRandomNumber(5);
				String pid = WXManage.getPrepay_id(WXManage.WCA, "个人捐献", ordercode, sto.getPrice(), Util.getMyIp(),
						notify_url, "JSAPI", null, openid);
				Map<String, Object> data = new HashMap<String, Object>();
				data.put("appId", WXManage.WCA.getAppid());
				data.put("timeStamp", ts);
				data.put("nonceStr", Util.getRandomString(10));
				data.put("package", "prepay_id=" + pid);
				data.put("signType", "MD5");
				result.put("appId", WXManage.WCA.getAppid());
				result.put("timeStamp", ts);
				result.put("nonceStr", data.get("nonceStr"));
				result.put("package1", "prepay_id=" + pid);
				result.put("signType", "MD5");
				result.put("paySign", WXUtil.getsign(data, WXManage.WCA.getApikey()));
				result.put("result", "1");
				sto.setMycode(ordercode);
				sto.setName(name);
				sto.setPhone(phone);
				sto.setSex(sex);
				sqTmpOrderService.save(sto);
			}
		}

		return result;
	}

	@RequestMapping(value = "corporatedonation")
	public String Corporatedonation(@RequestParam(value = "comid") Long comid, Model model) {
		model.addAttribute("com", communityService.get(comid));
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(),
				"/wxcommunity/corporatedonation?comid=" + comid));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		return "donation/qyjx";
	}

	@RequestMapping(value = "getlistbycomid")
	@ResponseBody
	public List<Sq_Donation_Good> getListByComid(@RequestParam(value = "comid") Long comid) {
		return sq_Donation_GoodService.getListByComid(comid);
	}

	@RequestMapping(value = "payback")
	@ResponseBody
	public String payback(HttpServletRequest request) {
		System.out.println("=========捐款支付回调=========");
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
					SqTmpOrder sto = sqTmpOrderService.getByMycode(ordercode);
					Sq_Donation sd = sq_DonationService.getOnlineListBynum(ordercode);
					if (sto != null && sd == null) {
						sd = new Sq_Donation();
						Community com = new Community();
						com.setId(sto.getComid());
						sd.setCommunity(com);
						String[] idss = sto.getGoodids().split(",");
						String[] countss = sto.getCounts().split(",");
						String content = "";
						String picurl = "";
						for (int i = 0; i < idss.length; i++) {
							Sq_Donation_Good sdg = sq_Donation_GoodService
									.getSq_Donation_GoodById(Long.parseLong(idss[i]));
							content += sdg.getName() + "x" + countss[i] + ",";
							if (picurl.equals("")) {
								picurl = sdg.getUrl();
							}
						}
						if (content.endsWith(",")) {
							content = content.substring(0, content.length() - 1);
						}
						sd.setContext(content);
						sd.setContexttype(1);
						sd.setCreatetime(new Date());
						sd.setName(sto.getName());
						sd.setNum(ordercode);
						sd.setOpenid(sto.getOpenid());
						sd.setPhone(sto.getPhone());
						sd.setPrice(sto.getPrice());
						sd.setSex(sto.getSex());
						sd.setType(1);
						sd.setPicurl(picurl);
						sd.setWxnum(result.get("transaction_id"));
						Sq_Donation sdsaved = sq_DonationService.save(sd);

						for (int i = 0; i < idss.length; i++) {
							Sq_Donation_Good sdg = sq_Donation_GoodService
									.getSq_Donation_GoodById(Long.parseLong(idss[i]));

							Sq_Donation_Item sdi = new Sq_Donation_Item();
							sdi.setName(sdg.getName());
							sdi.setCount(Integer.valueOf(countss[i]));
							sdi.setDonationid(sdsaved.getId());
							sq_Donation_ItemService.save(sdi);
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

				} else {
					System.out.println(result.get("return_msg"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}

	/************************************ 下面是关于社区物业模块的相关接口 ******************************************************/

	/**
	 * 报修列表（查询）
	 * 
	 * @param commid
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "repair")
	public String repair(@RequestParam(value = "commid") Long commid, Model model, HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/repair?commid=" + commid;
		}

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/repair?commid=" + commid));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		WXuserInfo userInfo = wXuserInfoService.getInfoByOpenid(oid.toString());

		Community comm = communityService.get(commid);
		model.addAttribute("commid", commid);
		model.addAttribute("commname", comm.getName());

		if (userInfo == null) {
			userInfo = new WXuserInfo();
		} else {
			model.addAttribute("name", userInfo.getName());
			model.addAttribute("phone", userInfo.getPhone());
		}
		model.addAttribute("openid", oid.toString());
		return "wuye/realestate";
	}

	/**
	 * 保存用户填写的报修信息
	 * 
	 * @param repair
	 * @param openid
	 * @param commid
	 * @param yesorno
	 *            是否保存修改（1 保存2 不保存）
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "saverepair", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveRepair(@Valid Sq_Repair repair, @RequestParam(value = "commid") String commid,
			@RequestParam(value = "yesorno") String yesorno, HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");
		Map<String, Object> map = new HashMap<String, Object>();

		WXUser wxUser = wXUserService.getOrNewWXUser(oid.toString());
		WXuserInfo userInfo = wXuserInfoService.getInfoByOpenid(oid.toString());

		if ("1".equals(yesorno)) {
			if (userInfo == null) {

				userInfo = new WXuserInfo();

				userInfo.setName(repair.getName());
				userInfo.setPhone(repair.getTelephone());
				userInfo.setHeadimgurl(wxUser.getHeadimgurl());
				userInfo.setCommunity(communityService.get(Long.valueOf(commid)));

				wXuserInfoService.save(userInfo);

			} else {
				if (userInfo.getCommunity() == null) {
					userInfo.setCommunity(communityService.get(Long.valueOf(commid)));
				}
				userInfo = wXuserInfoService.modifyWXuserInfo(repair.getName(), repair.getTelephone(), commid,
						userInfo.getId());
			}
		}

		try {
			Community comm = communityService.get(Long.valueOf(commid));

			repair.setCommunity(comm);
			repair.setCreatetime(new Date());
			repair.setState(1);

			repairService.save(repair);

			map.put("result", "1");
			map.put("msg", "保存成功");
			map.put("userInfo", userInfo);

		} catch (NumberFormatException e) {
			map.put("result", "0");
			map.put("msg", "保存失败");
		}

		return map;
	}

	/*
	 * @RequestMapping(value="repairrecords")
	 * 
	 * @ResponseBody public Map<String, Object>
	 * repairRecords(@RequestParam(value="openid") String openid,
	 * 
	 * @RequestParam(value="start") int start,
	 * 
	 * @RequestParam(value="size") int size) { Map<String, Object> map = new
	 * HashMap<String, Object>();
	 * 
	 * List<Sq_Repair> srlist = repairService.getRepairsByOpenid(openid, start,
	 * size); if(srlist != null && srlist.size() > 0) { map.put("result", "1");
	 * map.put("data", srlist); }else{ map.put("result", "0"); map.put("data",
	 * "暂无数据"); }
	 * 
	 * return map; }
	 */
	/**
	 * 跳转到报修页面
	 * 
	 * @param commid
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "torepair")
	public String torepair(@RequestParam(value = "commid") Long commid, Model model, HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/torepair?commid=" + commid;
		}
		Community community = communityService.get(commid);
		model.addAttribute("openid", oid.toString());
		model.addAttribute("commid", commid);
		model.addAttribute("comname", community.getName());
		return "wuye/repairrsecord";
	}

	/**
	 * 根据查询条件获取requir列表
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "replist")
	@ResponseBody
	private Map<String, Object> repairList(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "state", defaultValue = "0") int state, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size) {

		Map<String, Object> map = new HashMap<String, Object>();
		List<Sq_Repair> reList = repairService.getRepairByState(openid, state, start, size);

		if (reList != null && reList.size() > 0) {
			map.put("result", "1");
			map.put("data", reList);
		} else {
			map.put("result", "0");
			map.put("data", "暂无数据");
		}

		return map;
	}

	/**
	 * 显示详情
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "redetail")
	public String showDetail(@RequestParam(value = "id") Long id, Model model) {
		Sq_Repair repair = repairService.get(id);

		if (repair != null) {
			Community community = communityService.get(repair.getCommunity().getId());
			model.addAttribute("rapair", repair);// 0id 1报修人名字 2电话 3地址 4内容 5保修时间
			model.addAttribute("commname", community.getName());
		} else {
			model.addAttribute("msg", "暂无信息");
		}

		return "wuye/realedetail";
	}

	/************************************ 下面是关于订单评论的相关接口 ******************************************************/

	/**
	 * 我的订单获取商户id，订单编号，微信编号，参数信息，页面跳转评价
	 * 
	 * @param merid
	 * @param orderid
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "mercommentparam")
	public String save(@RequestParam(value = "merid") Long merid, @RequestParam(value = "orderid") Long orderid,
			Model model, HttpServletRequest request, @RequestParam(value = "openid") String openid) {
		model.addAttribute("openid", openid);// ${openid}
		model.addAttribute("merid", merid);
		model.addAttribute("orderid", orderid);
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(),
				"/wxcommunity/mercommentparam?merid=" + merid + "&orderid=" + orderid + "&openid=" + openid));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		return "wuye/comment";
	}

	/**
	 * 保存订单评论
	 * 
	 * @param mercomment
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "savemercomment", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveMercomment(@Valid Mercomment mercomment, HttpServletRequest request) {
		Long orderid = mercomment.getOrderid();
		List<Mercomment> list = mercommentService.getMercommentByOrderid(orderid);
		Map<String, Object> map = new HashMap<String, Object>();
		if (list.size() == 0) {
			mercomment.setCreatetime(new Date());
			Mercomment m = mercommentService.save(mercomment);
			if (m != null) {
				map.put("result", "1");
				map.put("msg", "保存成功");
			} else {
				map.put("result", "0");
				map.put("msg", "保存失败");
			}
		} else {
			map.put("result", "0");
			map.put("msg", "已评价");
		}

		return map;
	}

	/**
	 * 跳转到另外一个页面得链接
	 * 
	 * @param merid
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "jumpallmer")
	public String jumpmer(@RequestParam(value = "merid") Long merid, Model model, HttpServletRequest request) {
		model.addAttribute("merid", merid);
		Float avgscore = mercommentService.getAvgScoreByMerid(merid);
		model.addAttribute("avgscore", avgscore);
		return "wechat/allmerdetail";
	}

	/**
	 * 商家全部评论
	 * 
	 * @param merid
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "allmercomment", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMercommentList(@RequestParam(value = "merid", required = false) Long merid,
			@RequestParam(value = "start") Integer start, @RequestParam(value = "size") Integer size) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if (merid != null) {
			searchParams.put("merid", merid);
		} else {
			searchParams.remove("merid");
		}
		List<Object[]> list = mercommentService.getMercommentListDataByParam(searchParams, start, size);// 0id
																										// 1微信编号
																										// 2评价内容
																										// 3merid
																										// 4分数
																										// 5时间
																										// 6订单编号
																										// 7图片
																										// 8昵称
																										// 9头像
		List<Object[]> list1 = mercommentService.getMercomment(merid);// 0商户名1总评分（0.0000）2评论次数
																		// 3评论人数
		if (list != null && list.size() > 0) {
			map.put("result", "1");
			map.put("data", list);// 0id 1微信编号 2评价内容 3merid 4分数 5时间 6订单编号 7图片
									// 8昵称 9头像
			map.put("merdata", list1.get(0));// 0商户名 1总评分（0.0000）2评论次数 3评论人数
												// 4平均消费
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/**
	 * 商家全部评论前三条 放在商家详情里面
	 * 
	 * @param merid
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "partmercomment", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPartMercomment(@RequestParam(value = "merid", required = false) Long merid) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if (merid != null) {
			searchParams.put("merid", merid);
		} else {
			searchParams.remove("merid");
		}
		List<Object[]> list = mercommentService.getPartMercommentList(searchParams);// 0id
																					// 1微信编号
																					// 2评价内容
																					// 3merid
																					// 4分数
																					// 5时间
																					// 6订单编号
																					// 7图片
																					// 8昵称
																					// 9头像
		if (list != null && list.size() > 0 && list.size() <= 3) {
			map.put("result", "2");// 当前仅有三条，或小于三条
			map.put("data", list);// 0id 1微信编号 2评价内容 3merid 4分数 5时间 6订单编号 7图片
									// 8昵称 9头像
		} else if (list != null && list.size() > 0 && list.size() > 3) {
			list.remove(3);
			map.put("result", "1");// 大于三条，取前三条
			map.put("data", list);// 0id 1微信编号 2评价内容 3merid 4分数 5时间 6订单编号 7图片
									// 8昵称 9头像
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/************************************ 下面是关于物业缴费接口 ******************************************************/

	@RequestMapping(value = "tmpshowview")
	public String tmpshowview(@RequestParam(value = "tmpid") Long tmpid, Model model) {
		model.addAttribute("art", tmpArtService.get(tmpid));
		return "wuye/tmpdetail";
	}

	/**
	 * 
	 * 根据openid来查找该手机号码所绑定的物业费缴纳信息
	 * 
	 * @param openid
	 * @return
	 */
	@RequestMapping(value = "getmyfee")
	@ResponseBody
	public Map<String, Object> getMyFee(@RequestParam(value = "openid") String openid,
			@RequestParam(value = "start") int start, @RequestParam(value = "size") int size) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Sq_Propertyfee> splist = myService.getMyFeeListByOpenid(openid, start, size);

		if (splist != null && splist.size() > 0) {
			map.put("result", "1");
			map.put("data", splist);
			return map;
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
			return map;
		}

	}

	/**
	 * 保存绑定物业缴费手机号码和openid的接口
	 * 
	 * @param phone
	 * @param openid
	 * @return
	 */
	@RequestMapping(value = "savebind")
	@ResponseBody
	public Map<String, Object> saveBind(@RequestParam(value = "phone") String phone,
			@RequestParam(value = "openid") String openid) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Sq_Wy_Telephone> swtlist = sqWyTelephoneService.getListByTelephone(phone);
		if (swtlist != null && swtlist.size() > 0) {
			map.put("result", "0");
			map.put("msg", "绑定失败，该手机号码已经通过校验，请换一个新的手机号码");
			return map;
		}

		try {
			Sq_Wy_Telephone swt = new Sq_Wy_Telephone();
			swt.setOpenid(openid);
			swt.setTelephone(phone);
			swt.setComid(null);
			sqWyTelephoneService.save(swt);

			map.put("result", "1");
			map.put("msg", "绑定成功");
			return map;

		} catch (Exception e) {
			map.put("result", "0");
			map.put("msg", "绑定失败");
			return map;
		}

	}

	/************************************ 下面是关于网格管理相关接口 ******************************************************/
	/**
	 * 分页查询网格列表
	 * 
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "seachwangge")
	@ResponseBody
	public Map<String, Object> wanggeList(@RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Sq_AreaManage> amList = areaManageService.pageList(start, size);

		if (amList != null && amList.size() > 0) {
			map.put("result", "1");
			map.put("data", amList);// 0id 1名字 2电话 3管理区域 4证件图片
		} else {
			map.put("result", "0");
			map.put("data", "暂无数据");
		}
		return map;
	}

	@RequestMapping(value = "discountdetail")
	public String DiscountDetail(@RequestParam(value = "id") Long id, Model model) {
		Advert ad = advertService.findOne(id.toString());
		model.addAttribute("title", ad.getTitle());
		model.addAttribute("content", ad.getContent());
		return "wuye/youhuidetail";
	}

	@RequestMapping(value = "feegetpay")
	@ResponseBody
	public Map<String, Object> getpay(@RequestParam(value = "ids") String ids,
			@RequestParam(value = "openid") String openid) {
		Map<String, Object> result = new HashMap<String, Object>();
		Date now = new Date();
		String[] idd = ids.split(",");
		int fee = 0;
		for (String id : idd) {
			Sq_Propertyfee sp = sq_PropertyfeeService.getById(Long.parseLong(id));
			if (sp.getState() == 1) {
				result.put("result", "2");
				result.put("msg", "选中的记录中，有已支付记录，请重新选择");
				return result;
			}
			fee += sp.getFee();
		}
		Long ts = now.getTime();
		String ordercode = now.getTime() + Util.getRandomNumber(5);
		SqTmpOrder sto = new SqTmpOrder();
		sto.setMycode(ordercode);
		sto.setGoodids(ids);
		sqTmpOrderService.save(sto);
		String pid = WXManage.getPrepay_id(WXManage.WCA, "物业缴费", ordercode, fee, Util.getMyIp(), jfnotify_url, "JSAPI",
				null, openid);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("appId", WXManage.WCA.getAppid());
		data.put("timeStamp", ts);
		data.put("nonceStr", Util.getRandomString(10));
		data.put("package", "prepay_id=" + pid);
		data.put("signType", "MD5");
		result.put("appId", WXManage.WCA.getAppid());
		result.put("timeStamp", ts);
		result.put("nonceStr", data.get("nonceStr"));
		result.put("package1", "prepay_id=" + pid);
		result.put("signType", "MD5");
		result.put("paySign", WXUtil.getsign(data, WXManage.WCA.getApikey()));
		result.put("result", "1");
		return result;
	}

	@RequestMapping(value = "jfpayback")
	@ResponseBody
	public String jfpayback(HttpServletRequest request) {
		System.out.println("=========缴费支付回调=========");
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
					SqTmpOrder sto = sqTmpOrderService.getByMycode(ordercode);
					if (sto != null) {
						String ids = sto.getGoodids();
						if (ids != null && !ids.equals("")) {
							for (String id : ids.split(",")) {
								sq_PropertyfeeService.updateStateById(Long.parseLong(id), 1);
							}
						} else {
							System.out.println("缴费订单无缴费ID");
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

				} else {
					System.out.println(result.get("return_msg"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}

	@RequestMapping(value = "bindphone")
	public String bindphone(Model model, HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/bindphone";
		}
		model.addAttribute("openid", openid);
		return "wuye/bindphone";
	}

	@RequestMapping(value = "bindac")
	public String bindAccessControl(HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/bindac";
		}
		if (sq_UserAccessControlService.getListByOpenid(openid.toString()).size() == 0) {
			Sq_UserAccessControl suac = new Sq_UserAccessControl();
			suac.setOpenid(openid.toString());
			suac.setAcid(1l);
			sq_UserAccessControlService.save(suac);
		}
		return "wuye/bindok";
	}

	@RequestMapping(value = "openac")
	public String openAccessControl(HttpServletRequest request, Model model) {
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/openac";
		}
		model.addAttribute("openid", openid);
		return "wuye/openac";
	}

	@RequestMapping(value = "doopen/{openid}")
	public String openac(@PathVariable(value = "openid") String openid, Model model) {
		if (sq_UserAccessControlService.getListByOpenid(openid).size() > 0) {
			String result = WXUtil.sendGet("http://ts.do-wi.cn:8010/csgJson.cgi?id=4049908&event_url=/talk/unlock",
					null);
			if (result.equals("{\"event_url\":\"/talk/unlock\",\"resultCode\":\"200\"}")) {

			} else {

			}
			return "wuye/openacok";
		} else {
			return "wuye/openacfail";
		}
	}

	@RequestMapping(value = "showwyjf")
	public String showwyjf(HttpServletRequest request, Model model) {
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/showwyjf";
		}
		model.addAttribute("openid", openid);
		return "wuye/propertyfee";
	}

	/************************************
	 * 下面是新版社区首页的相关接口 (2016-04-20)
	 ******************************************************/

	@RequestMapping(value = "getacts")
	@ResponseBody
	public Map<String, Object> getAct() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Advert> advlist = advertService.getAdListByType("commhuodong");
		if (advlist != null && advlist.size() > 0) {
			map.put("result", "1");
			map.put("data", advlist);// 0id 1名字 2电话 3管理区域 4证件图片
		} else {
			map.put("result", "0");
			map.put("data", "暂无数据");
		}
		return map;
	}

	@RequestMapping(value = "comactdetail")
	public String getActDetail(@RequestParam("id") String id, Model model, ServletRequest request) {
		Advert advert = advertService.findOne(id);
		model.addAttribute("fi", advert);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		model.addAttribute("time", sdf.format(advert.getCreatetime()));
		Integer count = advert.getCount();
		if (count == null) {
			count = 1;
		} else {
			count++;
		}
		advert.setCount(count);
		advertService.SaveOrUpdate(advert);

		return "wuye/hddetail";
	}

	@RequestMapping(value = "getquickbuyacts")
	@ResponseBody
	public Map<String, Object> getQuickBuyActs() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Sq_QuickBuy> sqlist = sqQuickBuyService.getOnlineQuickBuyList();
		List<Sq_QuickBuy> sortedlist = new ArrayList<Sq_QuickBuy>();
		if (sqlist != null && sqlist.size() > 0) {
			for (Sq_QuickBuy sq : sqlist) {
				if (sq.getState() == 2) {
					sortedlist.add(sq);
				}
			}

			for (Sq_QuickBuy sq : sqlist) {
				if (sq.getState() == 1) {
					sortedlist.add(sq);
				}
			}

			for (Sq_QuickBuy sq : sqlist) {
				if (sq.getState() == 3) {
					sortedlist.add(sq);
				}
			}

			for (Sq_QuickBuy sq : sqlist) {
				if (sq.getState() == 5) {
					sortedlist.add(sq);
				}
			}

			map.put("result", "1");
			map.put("data", sortedlist);// 0id 1名字 2电话 3管理区域 4证件图片
		} else {
			map.put("result", "0");
			map.put("data", "暂无数据");
		}
		return map;
	}

	@RequestMapping(value = "getoneqg")
	@ResponseBody
	public Sq_QuickBuy getOneQG(@RequestParam(value = "id") Long id) {
		Sq_QuickBuy sq = sqQuickBuyService.get(id);
		return sq;
	}

	@RequestMapping(value = "qgdetail")
	public String qiangGouDetail(@RequestParam(value = "id") Long id, HttpServletRequest request, Model model) {
		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/qgdetail?id=" + id;
		}

		Sq_QuickBuy sq = sqQuickBuyService.get(id);

		WXUser wxuser = wXUserService.getOrNewWXUser(oid.toString());
		if (!(wxuser != null && wxuser.getState() == 1)) {
			String qrurl = WXManage.getLimitQRCode(weChatAccountService.getAccesstoken(),
					Long.valueOf("518000" + sq.getId()));
			model.addAttribute("qrurl", qrurl);
			return "wuye/qrfocus";
		}

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxcommunity/qgdetail?id=" + id));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		int state = sq.getState();
		model.addAttribute("state", state);

		List<Sq_QGOrder> sorderlist = sqQGOrderService.getOrderListByOpenidAndActId(oid.toString(), sq.getId());
		if (sorderlist != null && sorderlist.size() > 0) {
			model.addAttribute("payed", 1);
			Sq_QGOrder sorder = sorderlist.get(0);
			int hascard = sorder.getHascard();
			if (hascard == 1) {
				model.addAttribute("hascard", 1);
			} else {
				model.addAttribute("hascard", 0);
				if (state == 2) {
					Map<String, Object> d = new HashMap<String, Object>();
					String t = (new Date().getTime() / 1000) + "";
					d.put("timestamp", t);
					d.put("outer_id", "0");

					WxCardSign signer = new WxCardSign();
					signer.AddData(WXManage.WCA.getJsapiticketforcard());
					signer.AddData(t);
					signer.AddData(sq.getCardnum());
					String s = signer.GetSignature();
					d.put("signature", s);
					System.out.println(s);
					model.addAttribute("cardid", sq.getCardnum());
					model.addAttribute("card_ext", WXUtil.transMapToString(d));
				}
			}
		} else {
			model.addAttribute("payed", 0);
			if (state == 2) {
				Map<String, Object> d = new HashMap<String, Object>();
				String t = (new Date().getTime() / 1000) + "";
				d.put("timestamp", t);
				d.put("outer_id", "0");

				WxCardSign signer = new WxCardSign();
				signer.AddData(WXManage.WCA.getJsapiticketforcard());
				signer.AddData(t);
				signer.AddData(sq.getCardnum());
				String s = signer.GetSignature();
				d.put("signature", s);
				System.out.println(s);
				model.addAttribute("cardid", sq.getCardnum());
				model.addAttribute("card_ext", WXUtil.transMapToString(d));
			}
		}

		int amount = sq.getAmount();
		int soldnum = sq.getSoldamount();

		model.addAttribute("openid", oid.toString());
		model.addAttribute("nowcount", amount - soldnum);

		System.out.println(sq.getTitle() + "--还剩余--" + (amount - soldnum) + "件");

		model.addAttribute("sq", sq);

		return "wuye/qgdetail";
	}

	@RequestMapping(value = "gobuy")
	@ResponseBody
	public Map<String, Object> goBuy(@RequestParam(value = "id") Long id,
			@RequestParam(value = "openid") String openid) {
		Map<String, Object> result = new HashMap<String, Object>();

		Sq_QuickBuy sq = sqQuickBuyService.get(id);
		int amount = sq.getAmount();
		int soldnum = sq.getSoldamount();
		if (amount <= soldnum) {
			result.put("result", "0");
			result.put("msg", "很抱歉，你来晚了，活动奖品已经被抢光了！");
			return result;
		}

		List<Sq_QGOrder> sorderlist = sqQGOrderService.getOrderListByOpenidAndActId(openid, sq.getId());
		if (sorderlist != null && sorderlist.size() > 0) {
			result.put("msg", "2");
			result.put("msg", "你已经支付过了，可以直接领取卡券");
			return result;
		}

		Date now = new Date();
		Long ts = now.getTime();
		String ordercode = now.getTime() + Util.getRandomNumber(5);
		SqTmpOrder sto = new SqTmpOrder();
		sto.setMycode(ordercode);
		sto.setGoodids(sq.getId().toString());
		sqTmpOrderService.save(sto);
		String pid = WXManage.getPrepay_id(WXManage.WCA, sq.getTitle(), ordercode, sq.getPaymoney(), Util.getMyIp(),
				qgnotiry_url, "JSAPI", null, openid);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("appId", WXManage.WCA.getAppid());
		data.put("timeStamp", ts);
		data.put("nonceStr", Util.getRandomString(10));
		data.put("package", "prepay_id=" + pid);
		data.put("signType", "MD5");
		result.put("appId", WXManage.WCA.getAppid());
		result.put("timeStamp", ts);
		result.put("nonceStr", data.get("nonceStr"));
		result.put("package1", "prepay_id=" + pid);
		result.put("signType", "MD5");
		result.put("paySign", WXUtil.getsign(data, WXManage.WCA.getApikey()));
		result.put("result", "1");
		return result;
	}

	@RequestMapping(value = "qgpayback")
	@ResponseBody
	public String qgpayback(HttpServletRequest request) {
		System.out.println("=========抢购活动缴费支付回调=========");
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
					String wxcode = result.get("transaction_id");
					String openid = result.get("openid");
					String paymoney = result.get("total_fee");
					WXUser wxuser = wXUserService.getOrNewWXUser(openid);
					SqTmpOrder sto = sqTmpOrderService.getByMycode(ordercode);
					if (sto != null) {
						String ids = sto.getGoodids();
						if (ids != null && !ids.equals("")) {

							Sq_QuickBuy sqb = sqQuickBuyService.get(Long.valueOf(ids));
							List<Sq_QGOrder> orderlist = sqQGOrderService.getOrderListByWXCode(wxcode);
							if (orderlist != null && orderlist.size() > 0) {

							} else {
								Sq_QGOrder sq = new Sq_QGOrder();
								sq.setSqquickbuy(sqb);
								sq.setMycode(ordercode);
								sq.setWxcode(wxcode);
								sq.setOpenid(openid);
								sq.setNickname(wxuser.getRealname());
								sq.setPaymoney(Integer.valueOf(paymoney));
								sq.setPaytime(new Date());
								sq.setHascard(0);
								sqQGOrderService.save(sq);

								Integer amount = sqb.getAmount();
								Integer soldnum = sqb.getSoldamount();
								if (soldnum == null) {
									sqb.setSoldamount(1);
								} else {
									sqb.setSoldamount(soldnum + 1);
								}

								if (sqb.getSoldamount() >= amount) {
									sqb.setState(3);
								}

								sqQuickBuyService.save(sqb);
							}

						} else {
							System.out.println("缴费订单无缴费ID");
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

				} else {
					System.out.println(result.get("return_msg"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}

	@RequestMapping(value = "updateqgcard")
	@ResponseBody
	public Map<String, Object> updateQGCard(@RequestParam(value = "id") Long id,
			@RequestParam(value = "openid") String openid) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Sq_QGOrder> sorderlist = sqQGOrderService.getOrderListByOpenidAndActId(openid, id);
		if (sorderlist != null && sorderlist.size() > 0) {
			Sq_QGOrder order = sorderlist.get(0);
			order.setHascard(1);
			sqQGOrderService.save(order);
			map.put("result", "1");
			map.put("msg", "更新订单状态成功");
			return map;
		} else {
			map.put("result", "0");
			map.put("msg", "更新订单状态失败，找不到对应的订单");
			return map;
		}

	}

	/************************************ 下面是关于养老服务活动相关接口 ******************************************************/
	/**
	 * 跳转到显示养老活动页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "showpension")
	public String tmpshowview(Model model) {
		return "pension/pensionservice";
	}

	/**
	 * 全部养老活动 加载分页
	 * 
	 * @param merid
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "allpensionservice", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMercommentList(@RequestParam(value = "start", required = false) int start,
			@RequestParam(value = "size", required = false) int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Sq_PensionAct> list = sq_PensionActService.getSq_PensionActList(start, size);
		if (list != null && list.size() > 0) {
			map.put("result", "1");
			map.put("data", list);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/**
	 * 活动详情
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "pensiondetail")
	public String pensiondetail(@RequestParam(value = "id", required = false) Long id, Model model,
			HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");
		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/pensiondetail?id=" + id;
		}
		Sq_PensionAct s = sq_PensionActService.getSq_PensionActById(id);
		List<Sq_PensionApply> apply = sq_PensionApplyService.getPenActListByOpenAndAct(id, oid.toString());
		if (s.getCount() == null) {
			s.setCount(1L);
		} else {
			s.setCount(s.getCount() + 1);
		}
		Sq_PensionAct s1 = sq_PensionActService.save(s);
		model.addAttribute("data", s1);
		if (s.getState() != 1) {
			model.addAttribute("state", "1");
			model.addAttribute("msg", "该活动已结束");
		} else {
			if (apply.size() > 0) {
				model.addAttribute("state", "2");
				model.addAttribute("msg", "已申请过！");
				model.addAttribute("data1", apply.get(0));
			} else {
				if ((s.getNownum() >= s.getMax())) {
					model.addAttribute("state", "3");
					model.addAttribute("msg", "已报满！");
				} else {
					model.addAttribute("state", "0");
					model.addAttribute("msg", "可以申请活动");
				}
			}
		}
		return "pension/huodongxiangq";
	}

	/**
	 * 跳转到我的申请
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "myapply")
	public String myapply(Model model, HttpServletRequest request) {
		Object oid = request.getSession().getAttribute("openid");
		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxcommunity/myapply";
		}
		model.addAttribute("openid", oid.toString());
		return "pension/wodeshenq";
	}

	/**
	 * 全部养老活动 加载分页
	 * 
	 * @param merid
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "mypensionapply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> myPensionApply(@RequestParam(value = "start", required = false) int start,
			@RequestParam(value = "size", required = false) int size,
			@RequestParam(value = "openid", required = false) String openid, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> list = sq_PensionActService.getMyPensionApplyByOpenid(openid, start, size);
		if (list != null && list.size() > 0) {
			map.put("result", "1");
			map.put("data", list);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/************************************ 下面是关于生活缴费接口 ******************************************************/
	@RequestMapping(value = "lifefee")
	public String lifeFee(@RequestParam(value = "comid") Long comid, Model model, HttpServletRequest request) {
		model.addAttribute("comid", comid);
		model.addAttribute("comname", communityService.get(comid).getName());
		return "wuye/costlife";
	}
}