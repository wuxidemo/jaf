package com.yjy.web.api;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.persistence.Id;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.poi.hssf.record.PageBreakRecord.Break;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.Temporary.service.ServeyService;
import com.yjy.entity.Activity;
import com.yjy.entity.Advert;
import com.yjy.entity.Article;
import com.yjy.entity.Business;
import com.yjy.entity.CategoryType;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.Classify;
import com.yjy.entity.Community;
import com.yjy.entity.FatherActivity;
import com.yjy.entity.FatherChildActivity;
import com.yjy.entity.FinanceInfo;
import com.yjy.entity.IntegralRecord;
import com.yjy.entity.Inuser;
import com.yjy.entity.Jsy;
import com.yjy.entity.Merchant;
import com.yjy.entity.Sq_PensionAct;
import com.yjy.entity.Sq_PensionApply;
import com.yjy.entity.User;
import com.yjy.entity.Volunteer;
import com.yjy.entity.WXCard;
import com.yjy.entity.WXUser;
import com.yjy.entity.WXUserRecord;
import com.yjy.entity.WXuserInfo;
import com.yjy.service.ActivityService;
import com.yjy.service.AdvertService;
import com.yjy.service.ArticleService;
import com.yjy.service.BusinessService;
import com.yjy.service.CategoryTypeService;
import com.yjy.service.CategoryValueService;
import com.yjy.service.ClassifyService;
import com.yjy.service.CommunityService;
import com.yjy.service.FatherActivityService;
import com.yjy.service.FatherChildActivityService;
import com.yjy.service.FinanceInfoService;
import com.yjy.service.FinanceThreadSave;
import com.yjy.service.ImportuserService;
import com.yjy.service.IntegralRecordService;
import com.yjy.service.JsyService;
import com.yjy.service.MerchantService;
import com.yjy.service.MercommentService;
import com.yjy.service.MyService;
import com.yjy.service.Sq_PensionActService;
import com.yjy.service.Sq_PensionApplyService;
import com.yjy.service.ThreadSave;
import com.yjy.service.UserService;
import com.yjy.service.VolunteerService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXCardService;
import com.yjy.service.WXUserRecordService;
import com.yjy.service.WXUserService;
import com.yjy.service.WXuserInfoService;
import com.yjy.service.WeChatAccountService;
import com.yjy.service.impl.SqQGOrderServiceImpl;
import com.yjy.utils.SendMessage;
import com.yjy.utils.Util;
import com.yjy.utils.wxytConfig;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;
import com.yjy.wechat.WxCardSign;

@Controller
@RequestMapping(value = "/wxpage")
public class WXPagesController {
	@Autowired
	private WXUserService wXUserService;

	@Autowired
	private MerchantService merchantService;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private AdvertService advertService;

	@Autowired
	private CategoryTypeService categoryTypeService;

	@Autowired
	private CategoryValueService categoryValueService;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private JsyService jsyService;

	@Autowired
	private WXCardService wXCardService;

	@Autowired
	private UserService userService;

	@Autowired
	private ImportuserService importuserService;

	@Autowired
	private IntegralRecordService integralRecordService;

	@Autowired
	private ActivityService activityService;

	@Autowired
	private ServeyService serveyService;

	@Autowired
	private ClassifyService classifyService;

	@Autowired
	private CommunityService communityService;

	@Autowired
	private FinanceInfoService financeInfoService;

	@Autowired
	private FatherActivityService fatherActivityService;

	@Autowired
	private FatherChildActivityService fatherChildActivityService;

	@Autowired
	private WXCardRecordService wxCardRecordService;

	@Autowired
	MyService myService;

	@Autowired
	private WXUserRecordService wxUserRecordService;
	@Autowired
	WeChatAccountService weChatAccountService;

	@Autowired
	MercommentService mercommentService;

	@Autowired
	WXuserInfoService wxUserInfoService;

	@Autowired
	WXUserService wxUserService;

	@Autowired
	VolunteerService volunteerService;

	@Autowired
	Sq_PensionApplyService pensionApplyService;

	@Autowired
	Sq_PensionActService pensionActService;
	
	@RequestMapping(value = "merlist")
	public String merList(Model model) {

		CategoryType categoryType = categoryTypeService.getCategoryTypeByValue("商家标签").get(0);
		List<CategoryValue> list = categoryValueService.getCategoryValueListByCid(categoryType.getId(), 0);

		if (list != null && list.size() > 0) {
			StringBuilder sb = new StringBuilder();
			sb.append("[");
			for (CategoryValue cv : list) {
				String cvstr = "{\"id\":" + cv.getId() + "," + "\"value\":\"" + cv.getValue() + "\"},";
				sb.append(cvstr);
			}

			String jsonstr = sb.substring(0, sb.length() - 1) + "]";

			model.addAttribute("cvjsonstr", jsonstr);
		} else {
			model.addAttribute("cvjsonstr", "");
		}

		List<Business> groupList = businessService.getList();
		model.addAttribute("group", groupList);

		return "wechat/merlist";

	}

	@RequestMapping(value = "getmerlist")
	@ResponseBody
	public Map<String, Object> getMerList(@RequestParam(value = "groupid", required = false) String groupid,
			@RequestParam(value = "mername", required = false) String mername, Model model) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Merchant> merList = merchantService.getMerchantByNameOrGroupid(mername, groupid);
		model.addAttribute("merlist", merList);

		if (merList != null && merList.size() > 0) {
			map.put("data", merList);
			map.put("result", "1");
		}

		return map;
	}

	@RequestMapping(value = "merdetail", method = RequestMethod.GET)
	public String getMerDetail(@RequestParam(value = "id") Long id,
			@RequestParam(value = "token", required = false) String token, Model model, HttpServletRequest request,
			@RequestParam(value = "from", required = false) String from) {

		Merchant merchant = merchantService.get(id);
		Float avgscore = mercommentService.getAvgScoreByMerid(id);

		if (merchant != null) {

			/* 记录点击的操作 */
			String oid = (String) request.getSession().getAttribute("openid");
			if (oid != null) {
				ThreadSave ts = new ThreadSave(wXUserRecordService, "merchant", oid, id.toString(), merchant.getName(),
						"");
				ts.run();
			} else {
				ThreadSave ts = new ThreadSave(wXUserRecordService, "merchant", "", id.toString(), merchant.getName(),
						"");
				ts.run();
			}

			if (from != null) {
				if (from.equals("tj")) {
					ThreadSave ts = new ThreadSave(wXUserRecordService, "hotmer", "", id.toString(), merchant.getName(),
							"");
					ts.run();
				} else if (from.equals("list")) {
					ThreadSave ts = new ThreadSave(wXUserRecordService, "merchant", "", id.toString(),
							merchant.getName(), "");
					ts.run();
				}
			}
			model.addAttribute("merchant", merchant);
			model.addAttribute("avgscore", avgscore);
			model.addAttribute("merid", id);

			List<WXCard> lwxc = wXCardService.getCardByLocation(merchant.getWxlocationid().toString()); // 根据门店的poi_id来获取该门店下的所有的卡券

			List<Map<String, Object>> data = new ArrayList<Map<String, Object>>(); // 定义一个元素类型是Map的List

			List<String> exts = new ArrayList<String>();

			String t = (new Date().getTime() / 1000) + ""; // 生成时间戳

			for (WXCard wc : lwxc) {

				Map<String, Object> result = new HashMap<String, Object>();

				Map<String, Object> d = new HashMap<String, Object>();

				d.put("timestamp", t);
				d.put("outer_id", "0");// 领取标志 暂无使用

				WxCardSign signer = new WxCardSign();
				signer.AddData(WXManage.WCA.getJsapiticketforcard());
				signer.AddData(t);
				signer.AddData(wc.getCardid());
				d.put("signature", signer.GetSignature());

				exts.add(WXUtil.transMapToString(d));

				result.put("cardid", wc.getCardid());
				result.put("card", wc);

				data.add(result);
			}
			model.addAttribute("exts", exts);
			/* model.addAttribute("data", data); */

			Long ts = new Date().getTime();
			String radomstr = Util.getRandomString(6);

			model.addAttribute("appId", WXManage.WCA.getAppid());
			model.addAttribute("timestamp", ts);
			model.addAttribute("nonceStr", radomstr);

			Map<String, Object> data1 = new HashMap<String, Object>();
			data1.put("timestamp", ts);
			data1.put("noncestr", radomstr);
			data1.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
			data1.put("url", SysConfig.BASEURL + "/wxpage/merdetail?id=" + id
					+ (token != null && !"".equals(token) ? "&token=" + token : ""));// baseurl
			model.addAttribute("signature", WXUtil.getJSsign(data1));

		}

		CategoryType categoryType = categoryTypeService.getCategoryTypeByValue("商家标签").get(0);
		List<CategoryValue> list = categoryValueService.getCategoryValueListByCid(categoryType.getId(), 0);

		model.addAttribute("labellist", list);

		if (token != null && !"".equals(token)) {
			return "wechat/merdetailnoshake";
		}

		return "wechat/merdetailpage";
	}

	@RequestMapping(value = "getcardlist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCardList(@RequestParam(value = "id") Long id, Model model,
			HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		Merchant merchant = merchantService.get(id);
		if (merchant != null) {

			List<WXCard> lwxc = wXCardService.getCardByLocation(merchant.getWxlocationid().toString());

			if (lwxc == null || lwxc.size() == 0) {
				map.put("result", "0");
				return map;
			}

			List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();

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
				result.put("card", wc);

				data.add(result);
			}

			map.put("result", "1");
			map.put("data", data);
			return map;

		} else {
			map.put("result", "0");
			return map;
		}

	}

	@RequestMapping(value = "actpage/{id}", method = RequestMethod.GET)
	public String getActivityPageDetail(@PathVariable(value = "id") Long id, HttpServletRequest request, Model model) {

		Article art = articleService.find(id);
		Merchant mer = null;
		if (art != null) {
			mer = art.getUser().getMerchant();
			model.addAttribute("article", art);
		}

		if (mer != null) {
			model.addAttribute("merchant", mer);
			List<WXCard> lwxc = wXCardService.getCardByLocation(mer.getWxlocationid().toString());
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
			model.addAttribute("exts", exts);
			/* model.addAttribute("data", data); */

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

		}

		CategoryType categoryType = categoryTypeService.getCategoryTypeByValue("商家标签").get(0);
		List<CategoryValue> list = categoryValueService.getCategoryValueListByCid(categoryType.getId(), 0);

		model.addAttribute("labellist", list);

		return "wechat/activitypagedetail";
	}

	@RequestMapping(value = "/red")
	public String getcreate1(Model model) {
		return "wechat/redenvelope1";
	}

	@RequestMapping(value = "/ord")
	public String getcreate(Model model, HttpServletRequest request) {
		Object openid = request.getSession().getAttribute("openid");
		if (openid == null) {
			return "redirect:/wxurl/redirect?url=wxpage/ord";
		}
		model.addAttribute("openid", openid.toString());
		return "wechat/dindan";
	}

	@RequestMapping(value = "/bankcard")
	public String getBankCardList(Model model) {
		return "wechat/bankcard";
	}

	@RequestMapping(value = "/detail")
	public String getbydetail(Model model, @RequestParam(value = "cardnum") String cardnum) {
		List<IntegralRecord> lists = integralRecordService.getListByCardnum(cardnum);
		Inuser inuser = importuserService.findbyname(cardnum);
		model.addAttribute("lists", lists);
		model.addAttribute("inuser", inuser);
		return "wechat/mydetail";
	}

	@RequestMapping(value = "/my", method = RequestMethod.GET)
	public String getcreate2(Model model, HttpServletRequest request) {
		try {
			String oid = (String) request.getSession().getAttribute("openid");
			WXUser wxuser = wXUserService.getOrNewWXUser(oid);
			model.addAttribute("mgs", importuserService.isBindCard(oid));
			model.addAttribute("url", wxuser.getHeadimgurl());
			model.addAttribute("name", wxuser.getRealname());
			model.addAttribute("type", 4);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "wechat1601/mine";
	}

	/**
	 * 获取推荐商家
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-26 下午3:27:02
	 * @return
	 */
	@RequestMapping(value = "/getmerchant", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMerchant() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Merchant> list = merchantService.getRecommend();
		if (list.size() > 0) {
			map.put("data", list);
			map.put("result", true);
		} else {
			map.put("result", false);
			map.put("msg", "暂无推荐");
		}
		return map;
	}

	public int[] getRandom(int size) {
		int[] intRet = new int[3];
		int intRd = 0; // 存放随机数
		int count = 0; // 记录生成的随机数个数
		int flag = 0; // 是否已经生成过标志
		while (count < 3) {
			Random rdm = new Random();
			intRd = rdm.nextInt(size);
			for (int i = 0; i < count; i++) {
				if (intRet[i] == intRd) {
					flag = 1;
					break;
				} else {
					flag = 0;
				}
			}
			if (flag == 0) {
				intRet[count] = intRd;
				count++;
			}
		}
		return intRet;
	}

	@RequestMapping(value = "/forgetpass")
	public String forgetPass() {

		return "wechat/forgetpassone";
	}

	@RequestMapping(value = "checktelephone")
	@ResponseBody
	public boolean checkTelephone(@RequestParam("telephone") String telephone) {

		if (userService.findByTelephone(telephone) == null) {
			return false;
		} else {
			return true;
		}

	}

	@RequestMapping(value = "/getcaptcha")
	@ResponseBody
	public boolean getCaptcha(@RequestParam("telephone") String telephone) {

		System.out.println(new Date().getTime());

		User user = userService.findByTelephone(telephone);

		String captcha = Util.getCaptcha();
		user.setCaptcha(captcha);
		user.setStarttime(new Date());
		userService.saveCaptcha(user);
		for (int i = 0; i < 1; i++) {
			SendMessage.sendYZMSMS(user.getTelephone(), captcha + "【金阿福e服务】", "");
		}

		return true;
	}

	@RequestMapping(value = "/checkcaptcha")
	@ResponseBody
	public Map<String, Object> checkCaptcha(@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "captcha") String captcha) {
		User user = userService.findByTelephone(telephone);

		Map<String, Object> map = new HashMap<String, Object>();
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

					if (!captcha.equals(user.getCaptcha())) {
						map.put("result", "0");
						map.put("msg", "验证码错误");
						return map;
					} else {
						map.put("result", "1");
						map.put("msg", "验证成功");
						return map;
					}
				}
			}
		}
	}

	@RequestMapping(value = "/gonext")
	public String goNext(@RequestParam(value = "tel") String tel, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		if (tel == null || tel.equals("")) {
			response.setStatus(403);
			return null;
		}
		model.addAttribute("tel", tel);

		System.out.println(tel);
		return "wechat/forgetpasstwo";
	}

	@RequestMapping(value = "/password/changenewpassword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> changeNewPassword(@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "newpassword") String newpassword) {

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			User user = userService.findByTelephone(telephone);
			user.setPassword(newpassword);
			userService.saveorupdate(user);

			map.put("result", "1");
			map.put("msg", "密码修改成功,请重新登录");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "系统错误，密码修改失败，请稍后重试！");
		}

		return map;
	}

	@RequestMapping(value = "changepass", method = RequestMethod.GET)
	public String changePassword(HttpServletRequest request) {
		User u = (User) request.getSession().getAttribute("wxuser");
		if (u == null) {
			return "redirect:/wxorder/login";
		}
		return "wechat/changepass";
	}

	@RequestMapping(value = "checkoldpass", method = RequestMethod.POST)
	@ResponseBody
	public boolean checkOldPassword(@RequestParam(value = "oldpass") String oldpass, HttpServletRequest request) {

		User u = (User) request.getSession().getAttribute("wxuser");
		String salt = u.getSalt();
		String oldpassencrypted = u.getPassword();
		String inputoldpassencrypted = userService.entryptPasswordStr(salt, oldpass);

		if (oldpassencrypted.equals(inputoldpassencrypted)) {
			return true;
		}
		return false;
	}

	@RequestMapping(value = "changeoldpass", method = RequestMethod.POST)
	@ResponseBody
	public boolean changeOldPassword(@RequestParam(value = "pass") String pass, HttpServletRequest request,
			HttpServletResponse response) {

		User u = (User) request.getSession().getAttribute("wxuser");
		u.setPassword(pass);

		try {
			userService.saveorupdate(u);

			request.getSession().removeAttribute("wxuser");
			Cookie ck = new Cookie("wxuser", null);
			ck.setMaxAge(0);
			response.addCookie(ck);

			return true;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping(value = "bindbankcard", method = RequestMethod.GET)
	public String bindBankCardForm() {
		return "wechat/bindbankcard";
	}

	@RequestMapping(value = "getvalidcode", method = RequestMethod.GET)
	public void getValidCode(@RequestParam(value = "rand") String rand, HttpServletRequest request,
			HttpServletResponse response) {

		response.setContentType("image/jpeg");
		response.setHeader("pragma", "no-cache");
		response.setHeader("cache-control", "no-cache");
		response.setHeader("expires", "0");

		int length = 4;
		String basestr = "345678abcdefhjkmnpqrstuvwxy";
		String valcode = "";

		Random rd = new Random();
		for (int i = 0; i < length; i++)
			valcode += basestr.charAt(rd.nextInt(27));

		// 把产生的验证码存入到Session中
		HttpSession session = request.getSession();
		session.setAttribute("valcode", valcode);

		// 产生图片
		int width = 80;
		int height = 25;
		BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

		// 获取一个Graphics
		Graphics g = img.getGraphics();

		// 填充背景色
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, width, height);

		// 填充干扰线50
		/*
		 * for(int i=0; i<50; i++){ g.setColor(new
		 * Color(rd.nextInt(100)+155,rd.nextInt(100)+155,rd.nextInt(100)+155));
		 * g.drawLine(rd.nextInt(width), rd.nextInt(height),rd.nextInt(width),
		 * rd.nextInt(height)); }
		 */

		/*
		 * g.setColor(Color.GRAY); g.drawRect(0, 0, width-1, height-1);
		 */

		// 绘制验证码
		/*
		 * Font[] fonts = {new Font("隶书",Font.BOLD,18),new
		 * Font("楷体",Font.BOLD,18),new Font("宋体",Font.BOLD,18),new
		 * Font("幼圆",Font.BOLD,18)};
		 */
		for (int i = 0; i < length; i++) {
			/*
			 * g.setColor(new
			 * Color(rd.nextInt(150),rd.nextInt(150),rd.nextInt(150)));
			 */
			g.setColor(new Color(100, 100, 100));
			/* g.setFont(fonts[rd.nextInt(fonts.length)]); */
			g.setFont(new Font("Arial Bold", Font.ITALIC, 18));
			g.drawString(valcode.charAt(i) + "", width / valcode.length() * i + 2, 18);
		}

		// 输出图像
		g.dispose();

		try {
			ImageIO.write(img, "jpeg", response.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "checkvalcode", method = RequestMethod.POST)
	@ResponseBody
	public boolean checkValidCode(@RequestParam(value = "valcode") String valcode, HttpServletRequest request) {
		if (valcode == null || "".equals(valcode)) {
			return false;
		}
		String code = (String) request.getSession().getAttribute("valcode");
		if (valcode.equals(code)) {
			return true;
		} else {
			return false;
		}
	}

	@RequestMapping(value = "savebankcard", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveBindBankCard(@RequestParam(value = "name") String name,
			@RequestParam(value = "bankcard") String bankcard, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		String openid = (String) request.getSession().getAttribute("openid");

		List<Inuser> inuserlist = importuserService.findByNameAndCardNumber(name, bankcard);

		if (inuserlist != null && inuserlist.size() > 0) {
			Inuser inuser = inuserlist.get(0);
			String openiddb = inuser.getOpenid();

			if (openiddb == null || "".equals(openiddb.trim())) {
				inuser.setOpenid(openid);
				inuser.setUpdatetime(new Date());
				importuserService.update(inuser);

				map.put("result", "1");
				map.put("message", "绑定成功");

			} else {
				map.put("result", "0");
				map.put("message", "此卡已被绑定，请绑定其他卡，有疑问请联系客服");
			}
		} else {
			map.put("result", "0");
			map.put("message", "查无记录，请填写正确的姓名和卡号");
		}
		return map;

	}

	@RequestMapping(value = "actlist", method = RequestMethod.GET)
	public String getActivityList(Model model) {

		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/actlist"));

		List<Activity> actlist = activityService.getActivityByState(1);
		model.addAttribute("actlist", actlist);

		return "wechat/activitylist";
	}

	@RequestMapping(value = "actdetail", method = RequestMethod.GET)
	public String getActivityDetail(@RequestParam(value = "id") Long id, Model model) {

		Activity act = activityService.get(id);

		model.addAttribute("activity", act);

		return "wechat/activitydetail";
	}

	/***************************************************** 一下是jsy的功能方法 ***********************************************************************/

	@RequestMapping(value = "productintro")
	public String productIntro(Model model, HttpServletRequest request) {

		return "wechat/productintro";
	}

	@RequestMapping(value = "jsycontactus")
	public String contactUs(Model model, HttpServletRequest request) {

		return "wechat/jsycontactus";
	}

	@RequestMapping(value = "jsyjoinus")
	public String joinUs(Model model, HttpServletRequest request) {

		return "wechat/joinJsyForm";

	}

	@RequestMapping(value = "savejsyjoininfo", method = RequestMethod.POST)
	public String saveJoinUs(@RequestParam(value = "name") String name,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "referee", required = false) String referee,
			@RequestParam(value = "refereephone", required = false) String refereephone, Model model,
			HttpServletRequest request) {

		List<Jsy> jsylist = jsyService.getJsyByTelephone(telephone);
		if (jsylist != null && jsylist.size() > 0) {
			return "wechat/showprogress";
		}

		Jsy jsy = new Jsy();
		jsy.setName(name);
		jsy.setTelephone(telephone);
		jsy.setReferee(referee);
		jsy.setRefereephone(refereephone);
		jsy.setCreatetime(new Date());
		jsy.setState(0);
		jsyService.save(jsy);

		return "wechat/showprogress";

	}

	@RequestMapping(value = "jsymarketing")
	public String marketing(Model model, HttpServletRequest request) {

		return "wechat/jsymarketing";

	}

	/****************************************************************************************************************************/

	@RequestMapping(value = "tttt")
	public String tttt(Model model) {
		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);

		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);

		Map<String, Object> data1 = new HashMap<String, Object>();
		data1.put("timestamp", ts);
		data1.put("noncestr", radomstr);
		data1.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data1.put("url", SysConfig.BASEURL + "/wxpage/tttt");// baseurl
		model.addAttribute("signature", WXUtil.getJSsign(data1));
		return "wechat/tt";
	}

	@Autowired
	WXUserRecordService wXUserRecordService;

	/* 微信首页 */
	@RequestMapping(value = "index")
	public String index(Model model, HttpServletRequest request,
			@RequestParam(value = "tmp", required = false) Long time) {
		String oid = (String) request.getSession().getAttribute("openid");
		model.addAttribute("type", "1");
		if (oid != null) {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", oid, "1", "特惠商户", "");
			ts.run();
		} else {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", "", "1", "特惠商户", "");
			ts.run();
		}
		model.addAttribute("date", new Date().getTime());
		List<Advert> adverts = advertService.getList("carousel");
		model.addAttribute("adverts", adverts);
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(),
				time == null ? "/wxpage/index" : "/wxpage/index?tmp=" + time));
		return "wechat1601/homepage";
	}

	/* 微信中的社区 */
	@RequestMapping(value = "community")
	public String community(Model model, HttpServletRequest request,
			@RequestParam(value = "tmp", required = false) Long time) {
		String oid = (String) request.getSession().getAttribute("openid");
		model.addAttribute("type", "2");
		if (oid != null) {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", oid, "2", "社区", "");
			ts.run();
		} else {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", "", "2", "社区", "");
			ts.run();
		}
		/*
		 * ThreadSave ts = new ThreadSave(wXUserRecordService, "view", "", "2",
		 * "社区", ""); ts.run();
		 */
		model.addAttribute("date", new Date().getTime());

		List<Advert> adverts = advertService.getList("commlunbo");
		model.addAttribute("adverts", adverts);

		return "wechat1601/community";
	}

	/* 微信中的优惠劵 */
	@RequestMapping(value = "coupon")
	public String coupon(Model model, HttpServletRequest request,
			@RequestParam(value = "tmp", required = false) Long time) {
		String oid = (String) request.getSession().getAttribute("openid");
		model.addAttribute("type", "3");
		if (oid != null) {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", oid, "3", "优惠", "");
			ts.run();
		} else {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", "", "3", "优惠", "");
			ts.run();
		}
		List<Advert> la = advertService.getList("preferential");
		if (la.size() >= 1) {
			model.addAttribute("ad", la.get(0));
		} else {
			model.addAttribute("ad", null);
		}

		Long ts = new Date().getTime();
		String radomstr = Util.getRandomString(6);
		model.addAttribute("appId", WXManage.WCA.getAppid());
		model.addAttribute("timestamp", ts);
		model.addAttribute("nonceStr", radomstr);
		Map<String, Object> data1 = new HashMap<String, Object>();
		data1.put("timestamp", ts);
		data1.put("noncestr", radomstr);
		data1.put("jsapi_ticket", WXManage.WCA.getJsapiticket());
		data1.put("url", SysConfig.BASEURL + (time == null ? "/wxpage/coupon" : "/wxpage/coupon?tmp=" + time));// baseurl
		model.addAttribute("signature", WXUtil.getJSsign(data1));
		model.addAttribute("date", new Date().getTime());
		return "wechat1601/preferential";
	}

	/* 微信中的我的 */
	@RequestMapping(value = "/mypage")
	public String mypage(Model model, HttpServletRequest request) {
		String oid = (String) request.getSession().getAttribute("openid");
		model.addAttribute("type", 4);
		if (oid != null) {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", oid, "4", "我的", "");
			ts.run();
		} else {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "view", "", "4", "我的", "");
			ts.run();
		}
		model.addAttribute("date", new Date().getTime());
		WXUser wxuser = wXUserService.getOrNewWXUser(oid);
		model.addAttribute("url", wxuser.getHeadimgurl());
		model.addAttribute("name", wxuser.getRealname());
		return "wechat1601/mypage";
	}

	/**
	 * 获取首页热门商户的api
	 * 
	 * @author yigang
	 * @date 2016年1月14日 下午4:40:00
	 * @return
	 */
	/*
	 * @RequestMapping(value = "gethotmerchant")
	 * 
	 * @ResponseBody public Map<String, Object> getHotMerchant() {
	 * 
	 * Map<String, Object> map = new HashMap<String, Object>(); List<Map<String,
	 * Object>> resultlist = new ArrayList<Map<String, Object>>();
	 * 
	 * List<Merchant> hotList = merchantService.getRecommend(); List<Merchant>
	 * defmerlist = merchantService.getAllMerchant(); List<Merchant> returnlist
	 * = new ArrayList<Merchant>();
	 * 
	 * if(hotList != null && hotList.size() > 0) { if(hotList.size() <= 3) {
	 * returnlist = hotList; }else{ for(int i=0; i<3; i++) {
	 * returnlist.add(hotList.get(i)); } }
	 * 
	 * }else{ if(defmerlist != null && defmerlist.size() > 0) {
	 * if(defmerlist.size()<=3) { returnlist = defmerlist; }else{ for(int i=0;
	 * i<3; i++) { returnlist.add(defmerlist.get(i)); } } } }
	 * 
	 * if(returnlist.size() > 0) { for(int i=0; i<returnlist.size(); i++) {
	 * Map<String, Object> newmap = new HashMap<String, Object>();
	 * newmap.put("id", returnlist.get(i).getId()); newmap.put("url",
	 * returnlist.get(i).getThumbnailurl()); newmap.put("name",
	 * returnlist.get(i).getName()); resultlist.add(newmap); }
	 * 
	 * map.put("result", "1"); map.put("data", resultlist);
	 * 
	 * }else{ map.put("result", "0"); map.put("msg", "暂无数据"); }
	 * 
	 * return map; }
	 */

	/**
	 * 获取热门商户的api
	 * 
	 * @author yigang
	 * @date 2016年1月15日 上午11:04:24
	 * @return
	 */
	@RequestMapping(value = "gethotmerchant")
	@ResponseBody
	public Map<String, Object> getHotMerchant() {

		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> resultlist = new ArrayList<Map<String, Object>>();

		List<Advert> advlist = advertService.getList("nominate");

		if (advlist != null && advlist.size() > 0) {
			for (int i = 0; i < advlist.size(); i++) {
				Advert adv = advlist.get(i);
				String content = adv.getContent();
				if (content == null || "".equals(content)) {
					continue;
				} else {
					Map<String, Object> newmap = new HashMap<String, Object>();
					newmap.put("jumpurl", adv.getContent());
					newmap.put("imgurl", adv.getImg());
					newmap.put("name", adv.getTitle());
					resultlist.add(newmap);
				}
			}

			map.put("result", "1");
			map.put("data", resultlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "nshtest")
	public String nshTest() {
		return "wechat/nshtest";
	}

	@RequestMapping(value = "getnearbymerchant", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNearByMerchant(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> listobj = myService.getNearByMerchant(lat, lon, start, size);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {
				obj[8] = obj[8] + "";
				if (obj[4] == null || "".equals(obj[4].toString())) {
					obj[4] = "未分类";
				} else {
					Long cateid = Long.valueOf(obj[4].toString());
					Classify cla = classifyService.get(cateid);
					if (cla != null) {
						obj[4] = cla.getName();
					} else {
						obj[4] = "未分类";
					}

				}

				if (obj[5] == null || "".equals(obj[5].toString())) {
					obj[5] = "无锡商圈";
				} else {
					Long businessid = Long.valueOf(obj[5].toString());
					Business bus = businessService.get(businessid);
					if (bus != null) {
						obj[5] = bus.getName();
					} else {
						obj[5] = "无锡商圈";
					}

				}

			}
			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "getparentclassify")
	@ResponseBody
	public Map<String, Object> getParentClassify() {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Classify> classlist = classifyService.getList("");
		if (classlist != null && classlist.size() > 0) {
			map.put("result", "1");
			map.put("data", classlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "getchildclassifybypid")
	@ResponseBody
	public Map<String, Object> getChildClassifyByPid(@RequestParam(value = "pid") Long pid) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Classify> subclass = classifyService.getClassifyListByPid(pid);
		if (subclass != null && subclass.size() > 0) {
			map.put("result", "1");
			map.put("data", subclass);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}

	/**
	 * 获取所有的商圈列表
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:18:31
	 * @return
	 */
	@RequestMapping(value = "getbusinessgroup")
	@ResponseBody
	public Map<String, Object> getBusinessGroup() {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Business> buslist = businessService.getList();
		if (buslist != null && buslist.size() > 0) {
			map.put("result", "1");
			map.put("data", buslist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 根据所在的经纬度，父分类和子分类来查找商户
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:19:15
	 * @param lat
	 * @param lon
	 * @param start
	 * @param size
	 * @param pclassid
	 * @param classid
	 * @return
	 */
	@RequestMapping(value = "getmerbyclassify", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMerchantByClassify(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "pid") String pclassid,
			@RequestParam(value = "id") String classid) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> listobj = myService.getMerchantByClassify(lat, lon, start, size, pclassid, classid);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {
				if (obj[5] == null || "".equals(obj[5].toString())) {
					obj[5] = "未分类";
				} else {
					Long cateid = Long.valueOf(obj[5].toString());
					Classify cla = classifyService.get(cateid);
					if (cla != null) {
						obj[5] = cla.getName();
					} else {
						obj[5] = "未分类";
					}
				}

				if (obj[6] == null || "".equals(obj[6].toString())) {
					obj[6] = "无锡商圈";
				} else {
					Long businessid = Long.valueOf(obj[6].toString());
					Business bus = businessService.get(businessid);
					if (bus != null) {
						obj[6] = bus.getName();
					} else {
						obj[6] = "无锡商圈";
					}
				}

			}
			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 按照商圈来查找商户列表
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:20:04
	 * @param lat
	 * @param lon
	 * @param start
	 * @param size
	 * @param bid
	 * @return
	 */
	@RequestMapping(value = "getmerbybusiness", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMerchantByBusiness(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "bid") String bid) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> listobj = myService.getMerchantByBusiness(lat, lon, start, size, bid);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {
				if (obj[4] == null || "".equals(obj[4].toString())) {
					obj[4] = "未分类";
				} else {
					Long cateid = Long.valueOf(obj[4].toString());
					Classify cla = classifyService.get(cateid);
					if (cla != null) {
						obj[4] = cla.getName();
					} else {
						obj[4] = "未分类";
					}
				}

				if (obj[5] == null || "".equals(obj[5].toString())) {
					obj[5] = "无锡商圈";
				} else {
					Long businessid = Long.valueOf(obj[5].toString());
					Business bus = businessService.get(businessid);
					if (bus != null) {
						obj[5] = bus.getName();
					} else {
						obj[5] = "无锡商圈";
					}
				}

			}
			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "getmerbyoption", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMerchantByOption(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "pid") String pclassid,
			@RequestParam(value = "cid") String classid, @RequestParam(value = "bid") String bid) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> listobj = myService.getMerchantsByOption(lat, lon, start, size, pclassid, classid, bid);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {
				if (obj[5] == null || "".equals(obj[5].toString())) {
					obj[5] = "未分类";
				} else {
					Long cateid = Long.valueOf(obj[5].toString());
					Classify cla = classifyService.get(cateid);
					if (cla != null) {
						obj[5] = cla.getName();
					} else {
						obj[5] = "未分类";
					}
				}

				if (obj[6] == null || "".equals(obj[6].toString())) {
					obj[6] = "无锡商圈";
				} else {
					Long businessid = Long.valueOf(obj[6].toString());
					Business bus = businessService.get(businessid);
					if (bus != null) {
						obj[6] = bus.getName();
					} else {
						obj[6] = "无锡商圈";
					}
				}

			}
			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 根据关键字来查找商户列表
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:20:24
	 * @param lat
	 * @param lon
	 * @param start
	 * @param size
	 * @param keyword
	 * @return
	 */
	@RequestMapping(value = "getmerbykeyword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMerchantByKeyword(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "keyword", required = false) String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> listobj = myService.getMerchantByKeywords(lat, lon, start, size, keyword);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {
				if (obj[4] == null || "".equals(obj[4].toString())) {
					obj[4] = "未分类";
				} else {
					Long cateid = Long.valueOf(obj[4].toString());
					Classify cla = classifyService.get(cateid);
					if (cla != null) {
						obj[4] = cla.getName();
					} else {
						obj[4] = "未分类";
					}

				}

				if (obj[5] == null || "".equals(obj[5].toString())) {
					obj[5] = "无锡商圈";
				} else {
					Long businessid = Long.valueOf(obj[5].toString());
					Business bus = businessService.get(businessid);
					if (bus != null) {
						obj[5] = bus.getName();
					} else {
						obj[5] = "无锡商圈";
					}

				}

			}
			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 获取所有的社区列表
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:20:51
	 * @return
	 */
	@RequestMapping(value = "getcommunities")
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
	 * 根据社区的id来查找该社区下的所有商户列表
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:21:12
	 * @param lat
	 * @param lon
	 * @param start
	 * @param size
	 * @param commid
	 * @return
	 */
	@RequestMapping(value = "getmerbycommunity", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMerchantByCommunity(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon, @RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "commid", required = false) String commid) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> listobj = myService.getMerchantByCommunity(lat, lon, start, size, commid);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {
				if (obj[4] == null || "".equals(obj[4].toString())) {
					obj[4] = "未分类";
				} else {
					Long cateid = Long.valueOf(obj[4].toString());
					Classify cla = classifyService.get(cateid);
					if (cla != null) {
						obj[4] = cla.getName();
					} else {
						obj[4] = "未分类";
					}
				}

				if (obj[5] == null || "".equals(obj[5].toString())) {
					obj[5] = "无锡社区";
				} else {
					Long comid = Long.valueOf(obj[5].toString());
					Community comm = communityService.get(comid);
					if (comm != null) {
						obj[5] = comm.getName();
					} else {
						obj[5] = "无锡社区";
					}

				}

			}
			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/**
	 * 按照商圈的id来查找该商圈下的所有的卡券
	 * 
	 * @author yigang
	 * @date 2016年1月22日 上午10:21:44
	 * @param start
	 * @param size
	 * @param businessid
	 * @return
	 */
	@RequestMapping(value = "getcardbybusiness", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCardByBusiness(@RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "id", required = false) String businessid) {

		Map<String, Object> map = new HashMap<String, Object>();

		String t = (new Date().getTime() / 1000) + "";

		List<Object[]> listobj = myService.getWXCardByBusiness(businessid, start, size);
		if (listobj != null && listobj.size() > 0) {
			for (Object[] obj : listobj) {

				if (obj[6] == null || Integer.parseInt(obj[6].toString()) == 0) {
					obj[1] = "多商家";
					obj[2] = "static/images/wxlog.png";
				} else {

				}

				Map<String, Object> d = new HashMap<String, Object>();

				d.put("timestamp", t);
				d.put("outer_id", "0");// 领取标志 暂无使用
				WxCardSign signer = new WxCardSign();
				signer.AddData(WXManage.WCA.getJsapiticketforcard());
				signer.AddData(t);
				signer.AddData(obj[4].toString().trim());
				d.put("signature", signer.GetSignature());
				obj[5] = WXUtil.transMapToString(d);
				System.out.println(obj[5]);
			}

			map.put("result", "1");
			map.put("data", listobj);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "getcardbyoption", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCardByOption(@RequestParam(value = "start") int start,
			@RequestParam(value = "size") int size, @RequestParam(value = "id", required = false) String businessid,
			@RequestParam(value = "type") String sort) {

		Map<String, Object> map = new HashMap<String, Object>();

		String t = (new Date().getTime() / 1000) + "";

		/*
		 * List<Object[]> listobj =
		 * myService.getCardByOption(start,size,businessid,sort); if (listobj !=
		 * null && listobj.size() > 0) { for (Object[] obj : listobj) {
		 * 
		 * if(obj[6] == null || Integer.parseInt(obj[6].toString()) == 0) {
		 * obj[1] = "多商家"; obj[2] = "static/images/wxlog.png"; }else{
		 * 
		 * }
		 * 
		 * Map<String, Object> d = new HashMap<String, Object>();
		 * 
		 * d.put("timestamp", t); d.put("outer_id", "0");// 领取标志 暂无使用 WxCardSign
		 * signer = new WxCardSign();
		 * signer.AddData(WXManage.WCA.getJsapiticketforcard());
		 * signer.AddData(t); signer.AddData(obj[4].toString().trim());
		 * d.put("signature", signer.GetSignature()); obj[5] =
		 * WXUtil.transMapToString(d); }
		 * 
		 * map.put("result", "1"); map.put("data", listobj); } else {
		 * map.put("result", "0"); map.put("msg", "暂无数据"); }
		 */

		List<Object[]> listobj = myService.getCardByOption(start, size, businessid, sort);
		for (Object[] obj : listobj) {

			if (obj[6] == null || Integer.parseInt(obj[6].toString()) == 0) {
				obj[1] = "多商家";
				obj[2] = "static/images/wxlog.png";
			} else {

			}

			Map<String, Object> d = new HashMap<String, Object>();

			d.put("timestamp", t);
			d.put("outer_id", "0");// 领取标志 暂无使用
			WxCardSign signer = new WxCardSign();
			signer.AddData(WXManage.WCA.getJsapiticketforcard());
			signer.AddData(t);
			signer.AddData(obj[4].toString().trim());
			d.put("signature", signer.GetSignature());
			obj[5] = WXUtil.transMapToString(d);
		}

		map.put("result", "1");
		map.put("data", listobj);

		return map;
	}

	@RequestMapping(value = "getfinanceinfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getFinanceInfo(@RequestParam(value = "commid", required = false) Long commid,
			@RequestParam(value = "start") int start, @RequestParam(value = "size") int size) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<Object[]> filist = myService.getPublishedFinanceInfo(commid, start, size);
		if (filist != null && filist.size() > 0) {
			map.put("result", "1");
			map.put("data", filist);

		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "getonefinanceinfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOneFinanceInfo(@RequestParam(value = "id") Long financeid) {

		Map<String, Object> map = new HashMap<String, Object>();

		FinanceInfo fi = financeInfoService.get(financeid);
		if (fi != null) {
			map.put("result", "1");
			map.put("data", fi);

		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	@RequestMapping(value = "getsubactbypid")
	public String getChildActByFatherid(@RequestParam(value = "pid", required = false) Long fatherid, Model model) {

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/getsubactbypid"));

		if (fatherid == null || "".equals(fatherid) || "null".equals(fatherid)) {
			/*
			 * List<Activity> actlist = activityService.getActivityByState(1);
			 */
			List<Activity> actlist = activityService.getAllActivity();
			model.addAttribute("acts", actlist);
			model.addAttribute("pactname", "");
			return "wechat/activitylist";
		}

		List<Activity> actlist = new ArrayList<Activity>();

		FatherActivity fa = fatherActivityService.get(fatherid);
		if (fa == null) {
			model.addAttribute("acts", actlist);
			model.addAttribute("pactname", "");
			return "wechat/activitylist";
		}

		List<FatherChildActivity> fcalist = fatherChildActivityService.findByFatherid(fatherid);
		if (fcalist != null && fcalist.size() > 0) {
			for (FatherChildActivity fca : fcalist) {
				if (fca.getChildid() == null) {

				} else {
					Activity act = activityService.get(fca.getChildid());
					/*
					 * if (act != null && act.getState() == 1) {
					 * actlist.add(act); }
					 */
					actlist.add(act);
				}
			}
			model.addAttribute("pactname", fa.getName());
			model.addAttribute("acts", actlist);
		} else {
			model.addAttribute("pactname", fa.getName());
			model.addAttribute("acts", actlist);
		}

		return "wechat/activitylist";
	}

	/*
	 * ============================================对统计页面
	 * 的处理========================================================
	 */

	/* ==========四个菜单============= */

	@RequestMapping(value = "text1")
	public String getjhajajaj() {
		return "wechat1601/fourmenupage";
	}

	/* 查询菜单中当天的数据 */
	@RequestMapping(value = "getday")
	@ResponseBody
	public Map<String, Object> getday(@RequestParam(value = "key") String key) {
		Map<String, Object> map = new HashMap<String, Object>();

		/* 总的记录 */
		List<WXUserRecord> list = wxUserRecordService.getallrecord(key);
		/* 当天的记录 */
		List<WXUserRecord> list1 = wxUserRecordService.getallrecordday(key);

		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("zon", list);
			map.put("listday", list1);
		} else {
			map.put("result", "0");
			map.put("zon", list);
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询菜单中最近7天的数据 */
	@RequestMapping(value = "getsevenday")
	@ResponseBody
	public Map<String, Object> getsevenday(@RequestParam(value = "key") String key) {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 总的记录 */
		List<WXUserRecord> list = wxUserRecordService.getallrecord(key);
		/* 最近7天的记录 */
		List<WXUserRecord> list1 = wxUserRecordService.getallsevenday(key);
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("zon", list);
			map.put("listsevenday", list1);
		} else {
			map.put("result", "0");
			map.put("zon", list);
			map.put("mag", "暂无数据");
		}
		return map;
	}

	/* 查询最近30天的数据 */
	@RequestMapping(value = "getthirtylist")
	@ResponseBody
	public Map<String, Object> getthirtylist(@RequestParam(value = "key") String key) {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 总的记录 */
		List<WXUserRecord> list = wxUserRecordService.getallrecord(key);
		/* 最近30天的记录 */
		List<WXUserRecord> list1 = wxUserRecordService.getallthirtylist(key);
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("zon", list);
			map.put("listthirtyday", list1);
		} else {
			map.put("result", "0");
			map.put("zon", list);
			map.put("mag", "暂无数据");
		}
		return map;
	}

	/* 根据开始的时间和结束的时间查询数据 */
	@RequestMapping(value = "/gettimelist")
	@ResponseBody
	public Map<String, Object> gettimelist(@RequestParam(value = "start") String start,
			@RequestParam(value = "end") String end, @RequestParam(value = "key") String key) {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 总的记录 */
		List<WXUserRecord> list = wxUserRecordService.getallrecord(key);

		Date a = null;
		Date b = null;
		try {
			SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
			a = d.parse(start);
			b = d.parse(end);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/* 根据开始结束时间查询数据 */
		List<WXUserRecord> list1 = wxUserRecordService.gettimelist(a, b, key);
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("zon", list);
			map.put("listthirtyday", list1);
		} else {
			map.put("result", "0");
			map.put("zon", list);
			map.put("mag", "暂无数据");
		}
		return map;
	}

	/*
	 * ================商家点击统计=============================
	 */
	@RequestMapping(value = "/merchants")
	public String getmerchants() {
		return "wechat1601/merchantstj";
	}

	/* 查询商家的当天点击数 */
	/* 查询当天的数据 */
	@RequestMapping(value = "getmerchantday")
	@ResponseBody
	public Map<String, Object> getmerchantday() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 当天的记录 */
		List<Object> list1 = wxUserRecordService.getmerchantlist();

		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询近7天的记录 */
	@RequestMapping(value = "/getsevenmerchant")
	@ResponseBody
	public Map<String, Object> getsevenmerchant() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 7天的记录 */
		List<Object> list1 = wxUserRecordService.getmerchantlist2();

		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listsevenday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询近30天的记录 */
	@RequestMapping(value = "/getthirtymerchant")
	@ResponseBody
	public Map<String, Object> getthirtymerchant() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 30天的记录 */
		List<Object> list1 = wxUserRecordService.getmerchantlist3();

		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listthirtyday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询商户所有的记录 */
	@RequestMapping(value = "/getsummerchant")
	@ResponseBody
	public Map<String, Object> getsummerchant() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 所有的记录 */
		List<Object> list1 = wxUserRecordService.getmerchantlist4();

		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listsumday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 根据开始和结束进行组合查询 */
	@RequestMapping(value = "/zhuhe")
	@ResponseBody
	public Map<String, Object> getzhuhe(@RequestParam(value = "start") String start,
			@RequestParam(value = "end") String end, @RequestParam(value = "name") String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (start == "") {
			/* 更据商家名称查找记录 */
			List<Object> list1 = wxUserRecordService.getmerchantlist6(name);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsumday", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		} else if (name == "") {

			Date a = null;
			Date b = null;
			try {
				SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
				a = d.parse(start);
				b = d.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			/* 根据时间查找 */
			List<Object> list1 = wxUserRecordService.getmerchantlist5(a, b);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsumday", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		} else if (!start.equals("") && !name.equals("")) {
			Date a = null;
			Date b = null;
			try {
				SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
				a = d.parse(start);
				b = d.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/* 更据时间和店名进行组合查询 */

			List<Object> list1 = wxUserRecordService.getmerchantlist7(a, b, name);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsumday", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		}

		return map;
	}

	/* =========对优惠劵的统计查询================ */
	@RequestMapping(value = "/coupon1")
	public String getcoupon(Model model) {

		/* 查找所有的商家 */
		List<Merchant> list = merchantService.getAllMerchant();
		model.addAttribute("list", list);

		return "wechat1601/coupon1";
	}

	/* 查询卡卷当天的发行使用记录 */
	@RequestMapping(value = "/getcoupon1day")
	@ResponseBody
	public Map<String, Object> getcoupon1day() {
		Map<String, Object> map = new HashMap<String, Object>();

		/* 优惠劵当天的发行和使用 */
		List<Object> list1 = wxCardRecordService.getcoupon1();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listcoupon1day", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询卡卷最近7天的发行使用记录 */
	@RequestMapping(value = "/getsevencoupon")
	@ResponseBody
	public Map<String, Object> getsevencoupon() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 最近7天的发行和使用记录 */
		List<Object> list1 = wxCardRecordService.getcoupon2();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listsevenday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询卡卷最近30天的发行使用记录 */
	@RequestMapping(value = "/getthirtycoupon")
	@ResponseBody
	public Map<String, Object> getthirtycoupon() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 卡卷最近30天的发行使用记录 */
		List<Object> list1 = wxCardRecordService.getcoupon3();

		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listthirtyday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}
		return map;
	}

	/* 查询所有的卡卷发行使用记录 */
	@RequestMapping(value = "getsumcoupon")
	@ResponseBody
	public Map<String, Object> getsumcoupon() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 查询所有卡券的发放使用记录使用记录 */
		List<Object> list1 = wxCardRecordService.getsumcoupon();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listsumcoupon", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 根据开始和结束时间与所属商家进行组合查询 */
	@RequestMapping(value = "getzhuhe")
	@ResponseBody
	public Map<String, Object> getcozhuhe(@RequestParam(value = "start") String start,
			@RequestParam(value = "end") String end, @RequestParam(value = "category") int category) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (start == "") {
			/* 更据所属商家查找记录 */
			List<Object> list1 = wxCardRecordService.getcoupon4(category);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsumday", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		} else if (category == -1) {

			Date a = null;
			Date b = null;
			try {
				SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
				a = d.parse(start);
				b = d.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			/* 根据时间查找 */
			List<Object> list1 = wxCardRecordService.getcoupon5(a, b);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsumday", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		} else if (!start.equals("") && category != -1) {
			Date a = null;
			Date b = null;
			try {
				SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
				a = d.parse(start);
				b = d.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Object> list1 = wxCardRecordService.getcoupon6(a, b, category);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsumday", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}

		}

		return map;

	}

	/*
	 * /=============对活动的统计======================
	 */
	/* 跳转活动统计页面 */
	@RequestMapping(value = "/activitypage")
	public String actpage(Model model) {

		return "wechat1601/activity";
	}

	/* 获取当天的点击活动记录 */
	@RequestMapping(value = "/getactivity")
	@ResponseBody
	public Map<String, Object> getactivity() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 获取当天的活动点击记录 */
		List<Object> list1 = wxUserRecordService.getactivitylist();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listactivityday", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;

	}

	/* 获取最近七天的活动点击记录 */
	@RequestMapping(value = "/getsevenactivity")
	@ResponseBody
	public Map<String, Object> getsevenactivity() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 获取最近七天的点击记录 */
		List<Object> list1 = wxUserRecordService.getactivitylist1();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listactivityseven", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;

	}

	/* 获取最近30天的活动点击记录 */
	@RequestMapping(value = "/getthirtyactivity")
	@ResponseBody
	public Map<String, Object> getthirtyactivity() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 获取最近30天的点击记录 */
		List<Object> list1 = wxUserRecordService.getactivitylist2();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listactivitythirty", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}

		return map;
	}

	/* 查询所有的活动点击记录 */
	@RequestMapping(value = "/getactivitysum")
	@ResponseBody
	public Map<String, Object> getactivitysum() {
		Map<String, Object> map = new HashMap<String, Object>();
		/* 获取所有的活动点击记录 */
		List<Object> list1 = wxUserRecordService.getactivitylist3();
		if (list1.size() != 0) {
			map.put("result", "1");
			map.put("listactivitysum", list1);
		} else {
			map.put("result", "0");
			map.put("mag", "暂无数据");
		}
		return map;
	}

	/* 根据开始和结束时间与活动名称进行组合查询 */
	@RequestMapping(value = "getactivityzhuhe")
	@ResponseBody
	public Map<String, Object> getactivityzhuhe(@RequestParam(value = "start") String start,
			@RequestParam(value = "end") String end, @RequestParam(value = "name") String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (start == "") {
			/* 更据活动名称查找记录 */
			List<Object> list1 = wxUserRecordService.getactivitylist4(name);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsum", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		} else if (name == "") {

			Date a = null;
			Date b = null;
			try {
				SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
				a = d.parse(start);
				b = d.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			/* 根据时间查找 */
			List<Object> list1 = wxUserRecordService.getactivitylist5(a, b);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsum", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		} else if (!start.equals("") && !name.equals("")) {
			Date a = null;
			Date b = null;
			try {
				SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
				a = d.parse(start);
				b = d.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/* 更据时间和店名进行组合查询 */

			List<Object> list1 = wxUserRecordService.getactivitylist6(a, b, name);
			if (list1.size() != 0) {
				map.put("result", "1");
				map.put("listsum", list1);
			} else {
				map.put("result", "0");
				map.put("mag", "暂无数据");
			}
		}

		return map;

	}

	/*
	 * ===================================对活动的处理================================
	 * ===================
	 */

	/* 保存点击活动记录 */
	@RequestMapping(value = "/activity")
	public void mypage1(Model model, HttpServletRequest request, @RequestParam(value = "id") Long id,
			@RequestParam(value = "name") String name) {
		String oid = (String) request.getSession().getAttribute("openid");
		String id1 = id.toString();
		if (oid != null) {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "activity", oid, id1, name, "");
			ts.run();
		} else {
			ThreadSave ts = new ThreadSave(wXUserRecordService, "activity", "", id1, name, "");
			ts.run();
		}
	}

	@RequestMapping(value = "commer")
	public String CommunityMer(Model model, @RequestParam(value = "comid", required = false) Long comid,
			@RequestParam(value = "comname", required = false) String comname) {
		model.addAttribute("comid", comid);
		try {
			if (comname != null) {
				model.addAttribute("comname", URLDecoder.decode(comname, "utf-8"));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "wechat1601/sh";
	}

	@RequestMapping(value = "mergroup")
	public String mersByGroup(Model model) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/mergroup"));
		return "wechat1601/ms";
	}

	@RequestMapping(value = "mersearch")
	public String merSearch(Model model) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/mersearch"));
		return "wechat1601/sjss";
	}

	@RequestMapping(value = "jrlist")
	public String jrlist(@RequestParam(value = "comid") Long comid, Model model) {
		Community com = communityService.get(comid);
		if (com != null) {
			model.addAttribute("comid", comid);
			model.addAttribute("comname", com.getName());
		}
		return "wechat1601/finance";
	}

	@RequestMapping(value = "jrdetail")
	public String jrdetail(@RequestParam(value = "id") Long id, Model model) {
		FinanceInfo fi = financeInfoService.get(id);
		model.addAttribute("fi", fi);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		model.addAttribute("time", sdf.format(fi.getUpdatetime()));
		FinanceThreadSave fts = new FinanceThreadSave(financeInfoService, id);
		fts.run();
		return "wechat1601/jrdetail";
	}

	/*
	 * ===================================对微信用户信息的处理============================
	 * ==== ===================
	 */
	/**
	 * 跳转到我的信息
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "towxuserinfo")
	public String toUserInfo(Model model, HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxpage/towxuserinfo";
		}
		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/towxuserinfo"));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		WXUser user = wxUserService.getOrNewWXUser(oid.toString());
		WXuserInfo userInfo = wxUserInfoService.getInfoByOpenid(oid.toString());
		Volunteer volunteer = volunteerService.getVolunteerByOpenid(oid.toString());

		if (userInfo == null) {
			userInfo = new WXuserInfo();
			userInfo.setHeadimgurl(user.getHeadimgurl());
			model.addAttribute("userinfo", userInfo);
			model.addAttribute("xzorxg", "1");
			model.addAttribute("openid", oid);
			return "wuye/chapelmeg";
		} else {
			if (volunteer != null) {
				model.addAttribute("volunteer", volunteer);
			}
			userInfo.setHeadimgurl(user.getHeadimgurl());
			userInfo.setSex(user.getSex());
			wxUserInfoService.save(userInfo);
			model.addAttribute("openid", oid);
			model.addAttribute("userinfo", userInfo);

			return "wuye/peoplemeg";
		}

	}

	/**
	 * 跳转到修改页面
	 * 
	 * @param openid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "tochuserinfo")
	public String toupdate(Model model, HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxpage/tochuserinfo";
		}

		WXuserInfo userInfo = wxUserInfoService.getInfoByOpenid(oid.toString());

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/tochuserinfo"));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		model.addAttribute("openid", oid);
		model.addAttribute("xzorxg", "0");
		model.addAttribute("userinfo", userInfo);

		return "wuye/chapelmeg";
	}

	/**
	 * 保存
	 * 
	 * @param wXuserInfo
	 * @param xzorxg
	 *            判断新增还是修改 1新增 其他为修改
	 * @return
	 */
	@RequestMapping(value = "saveuserinfo")
	@ResponseBody
	public Map<String, Object> save(@ModelAttribute WXuserInfo userInfo, @RequestParam(value = "openid") String openid,
			@RequestParam(value = "xzorxg") String xzorxg, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		if ("1".equals(xzorxg)) {
			try {
				wxUserInfoService.save(userInfo);
				map.put("result", "1");
				map.put("mag", "保存个人信息成功！");

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				map.put("result", "0");
				map.put("msg", "系统错误，保存信息失败，请稍后重试！");
			}
		} else {
			try {
				WXuserInfo wXuserInfo = wxUserInfoService.getInfoByOpenid(openid);

				wXuserInfo.setAge(userInfo.getAge());
				wXuserInfo.setCommunity(userInfo.getCommunity());
				wXuserInfo.setHeadimgurl(userInfo.getHeadimgurl());
				wXuserInfo.setName(userInfo.getName());
				wXuserInfo.setPhone(userInfo.getPhone());
				wXuserInfo.setSex(userInfo.getSex());

				wxUserInfoService.save(wXuserInfo);

				map.put("result", "1");
				map.put("msg", "修改个人信息成功");

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				map.put("result", "0");
				map.put("msg", "系统错误，修改个人信息失败，请稍后重试");
			}
		}
		return map;
	}

	/*
	 * ===================================对养老的处理============================
	 * ==== ===================
	 */
	/**
	 * 跳转到申请页面
	 * 
	 * @param type
	 *            类型 1活动 2直接
	 * @param sqactid活动id
	 * @param model
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("toaddinfo")
	public String toaddinfo(@RequestParam(value = "type") String type,
			@RequestParam(value = "sqactid", required = false) Long sqactid, Model model, HttpServletRequest request) {

		String oid = (String) request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxpage/toaddinfo?type=" + type + "&sqactid" + sqactid;
		}

		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(),
				"/wxpage/toaddinfo?type=" + type + "&sqactid" + sqactid));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		if ("1".equals(type)) {
			model.addAttribute("type", "1");
			model.addAttribute("sqactid", sqactid);
			model.addAttribute("openid", oid);

		} else if ("2".equals(type)) {
			model.addAttribute("openid", oid);
			model.addAttribute("type", "2");
		}
		return "pension/wtoreq";
	}

	/**
	 * 保存活动申请
	 * 
	 * @param pensionApply
	 * @return
	 */
	@RequestMapping(value = "savepension")
	@ResponseBody
	public Map<String, Object> save(@Valid Sq_PensionApply pensionApply) {

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			pensionApply.setCreatetime(new Date());

			Sq_PensionAct sa0 = pensionApply.getPensionAct();
			Sq_PensionAct sa = new Sq_PensionAct();

			if (sa0 == null) {
				pensionApply.setPensionAct(null);
			} else if (sa0 != null && sa0.getId() == null) {
				pensionApply.setPensionAct(null);
			} else {
				sa = pensionActService.getSq_PensionActById(sa0.getId());
				// 判断状态
				if (sa.getState() == 0) {
					map.put("result", "0");
					map.put("msg", "活动已下线,申请失败");
					return map;
				}

				if (sa.getState() == 2) {
					map.put("result", "0");
					map.put("msg", "活动已结束，申请失败");
					return map;
				}
				// 判断人数
				if (sa.getNownum() >= sa.getMax()) {
					map.put("result", "0");
					map.put("msg", "人数已达上限，申请失败");
					return map;
				} else {
					sa.setNownum(sa.getNownum() != null ? sa.getNownum() + 1 : 1);
				}

			}
			pensionActService.save(sa);
			pensionApplyService.save(pensionApply);
			WXUtil.sendGet("http://ts.do-wi.cn:8180/dwsocket/push?msg=aaaaaaa",null);
			Long spid = pensionApply.getId();	
			map.put("result", "1");
			map.put("msg", "修改信息成功");
			map.put("applyid", spid);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "系统错误，修改信息失败，请稍后重试");
		}
		return map;
	}

	/**
	 * 查看详情
	 * 
	 * @param id
	 *            申请id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "showdetail")
	public String showDetail(@RequestParam(value = "id") Long id, Model model, HttpServletRequest request) {

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/showdetai?id=" + id));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		Sq_PensionApply sp = pensionApplyService.get(id);

		if (sp != null) {
			model.addAttribute("result", "1");
			model.addAttribute("penapply", sp);
		} else {
			model.addAttribute("result", "0");
			model.addAttribute("msg", "暂无数据");
		}
		return "pension/reqforinf";
	}

	/**
	 * 修改
	 * 
	 * @param id
	 *            申请id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "updatepen")
	public String update(@RequestParam(value = "id") Long id, Model model, HttpServletRequest request) {

		Object oid = request.getSession().getAttribute("openid");

		if (oid == null) {
			return "redirect:/wxurl/redirect?url=wxpage/updatepen?id=" + id;
		}

		Sq_PensionApply sp = pensionApplyService.get(id);

		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/wxpage/updatepen?id=" + id));
		model.addAttribute("baseurl", SysConfig.BASEURL);

		if (sp != null) {
			model.addAttribute("result", "1");
			model.addAttribute("penapply", sp);
			model.addAttribute("openid", oid);
		} else {

			model.addAttribute("result", "0");
			model.addAttribute("msg", "暂无数据");

		}
		return "pension/chareq";
	}

	/**
	 * 保存修改
	 * 
	 * @param pensionApply
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "saveupdate")
	@ResponseBody
	public Map<String, Object> saveUpdate(@ModelAttribute Sq_PensionApply pensionApply, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();

		Sq_PensionApply pension = pensionApplyService.get(pensionApply.getId());

		try {
			if (pensionApply != null) {

				pension.setName(pensionApply.getName());
				pension.setTelephone(pensionApply.getTelephone());

				pension.setCreatetime(new Date());

				if (pensionApply.getPensionAct() != null && pensionApply.getPensionAct().getId() == null) {
					pensionApply.setPensionAct(null);
				}

				pension.setPensionAct(pensionApply.getPensionAct());
				pension.setAge(pensionApply.getAge());
				pension.setAddress(pensionApply.getAddress());
				pension.setSex(pensionApply.getSex());
				pension.setType(pensionApply.getType());

				if (pension.getType() == 2) {
					pension.setContent(pensionApply.getContent());
				}

				pensionApplyService.save(pension);

				map.put("result", "1");
				map.put("msg", "保存成功");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "系统错误，修改信息失败，请稍后重试");
		}
		return map;
	}

}
