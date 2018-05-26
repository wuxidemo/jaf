package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Business;
import com.yjy.entity.CategoryType;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.Classify;
import com.yjy.entity.Community;
import com.yjy.entity.Merchant;
import com.yjy.entity.MerchantDevice;
import com.yjy.entity.Role;
import com.yjy.entity.User;
import com.yjy.service.BusinessService;
import com.yjy.service.CategoryTypeService;
import com.yjy.service.CategoryValueService;
import com.yjy.service.ClassifyService;
import com.yjy.service.CommunityService;
import com.yjy.service.MerchantDeviceService;
import com.yjy.service.MerchantService;
import com.yjy.service.UserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.ImageUtil;
import com.yjy.utils.SocketUtil;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

@Controller
@RequestMapping(value = "/merchant")
public class MerchantController {

	@Autowired
	private MerchantService merchantService;

	@Autowired
	private CategoryTypeService categoryTypeService;

	@Autowired
	private CategoryValueService categoryValueService;

	@Autowired
	private ClassifyService classifyService;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private MerchantDeviceService merchantDeviceService;

	@Autowired
	private CommunityService communityService;

	@Autowired
	private UserService userService;
	@Autowired
	WeChatAccountService weChatAccountService;

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping()
	private String getmerlist(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			ServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_name")) {
			String name = (String) searchParams.get("LIKE_name");
			if (name == null || "".equals(name.trim())) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", name.trim());
				model.addAttribute("LIKE_name", name.trim());
			}
		}

		if (searchParams.containsKey("EQ_pclassify")) {
			String pclassify = (String) searchParams.get("EQ_pclassify");
			if ("-1".equals(pclassify.trim())) {
				searchParams.remove("EQ_pclassify");
			} else {
				searchParams.put("EQ_pclassify", pclassify.trim());
				model.addAttribute("EQ_pclassify", pclassify);
			}
		}

		if (searchParams.containsKey("EQ_classify")) {
			String classify = (String) searchParams.get("EQ_classify");
			if ("-1".equals(classify.trim())) {
				searchParams.remove("EQ_classify");
			} else {
				searchParams.put("EQ_classify", classify.trim());
				model.addAttribute("EQ_classify", classify);
			}
		}

		if (searchParams.containsKey("EQ_community")) {
			String community = (String) searchParams.get("EQ_community");
			if ("-1".equals(community.trim())) {
				searchParams.remove("EQ_community");
			} else if ("0".equals(community.trim())) {
				searchParams.remove("EQ_community");
				searchParams.put("GTE_community", 1);
				model.addAttribute("EQ_community", community);
			} else {
				searchParams.put("EQ_community", community.trim());
				model.addAttribute("EQ_community", community);
			}
		}

		searchParams.put("EQ_state", 1);
		Page<Merchant> merchants = merchantService.getMerchants(searchParams, pageNumber, pageSize, sortType);

		List<Classify> pclalist = classifyService.getList("");
		model.addAttribute("pclassifys", pclalist);

		List<Classify> subclass = classifyService.getAllSubClassify();
		model.addAttribute("subclass", subclass);

		List<Community> commlist = communityService.getCommunityList();
		model.addAttribute("communitys", commlist);

		model.addAttribute("merchants", merchants);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "merchant/merchantList";
	}

	@RequestMapping(value = "update/{merid}", method = RequestMethod.GET)
	public String updateForm(@PathVariable(value = "merid") Long id, Model model) {

		Merchant merchant = merchantService.get(id);

		List<Classify> classlist = classifyService.getList("");
		model.addAttribute("pclassify", classlist);

		CategoryType categoryTypeDistrict = null;
		List<CategoryValue> districtlist = null;
		List<CategoryType> ctlist = categoryTypeService.getCategoryTypeByValue("商圈区域");
		if (ctlist != null && ctlist.size() > 0) {
			categoryTypeDistrict = ctlist.get(0);
			districtlist = categoryValueService.getCategoryValueListByCid(categoryTypeDistrict.getId(), 0);
		}
		model.addAttribute("districtlist", districtlist);

		CategoryType categoryTypeKeyword = null;
		List<CategoryValue> keywordlist = null;
		List<CategoryType> kwlist = categoryTypeService.getCategoryTypeByValue("商家关键字");
		if (kwlist != null && kwlist.size() > 0) {
			categoryTypeKeyword = kwlist.get(0);
			keywordlist = categoryValueService.getCategoryValueListByCid(categoryTypeKeyword.getId(), 0);
		}
		model.addAttribute("keywordlist", keywordlist);

		List<Community> comlist = communityService.getCommunityList();
		model.addAttribute("communitys", comlist);

		Business busi = merchant.getBusiness();
		if (busi != null) {
			model.addAttribute("districtid", busi.getCategoryValue().getId());
		} else {
			model.addAttribute("districtid", null);
		}

		List<Business> businesslist = businessService.getList();
		model.addAttribute("businesslist", businesslist);

		model.addAttribute("merchant", merchant);
		model.addAttribute("merkeywords", "," + merchant.getKeywords() + ",");

		return "merchant/merchantForm";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(@ModelAttribute(value = "merchant") Merchant mer, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {

		Merchant merdb = merchantService.get(mer.getId());

		Integer comm = mer.getCommunity();
		if (comm == null || comm == -1) {
			merdb.setCommunity(null);
		} else {
			merdb.setCommunity(comm);
		}

		String busid = request.getParameter("business.id");
		if (busid == null || "-1".equals(busid)) {
			merdb.setBusiness(null);
		} else {
			merdb.setBusiness(mer.getBusiness());
		}

		merdb.setName(mer.getName());
		merdb.setOwnername(mer.getOwnername());
		merdb.setEmail(mer.getEmail());
		merdb.setTelephone(mer.getTelephone());
		merdb.setAddress(mer.getAddress());
		merdb.setBankaccount(mer.getBankaccount());
		merdb.setPclassify(mer.getPclassify());
		merdb.setClassify(mer.getClassify());
		merdb.setOnecost(mer.getOnecost());
		merdb.setKeywords(mer.getKeywords());
		merdb.setSpecialcourse(mer.getSpecialcourse());
		merdb.setThumbnailurl(mer.getThumbnailurl());
		merdb.setIntroduceurl(mer.getIntroduceurl());
		merdb.setDetailurl(mer.getDetailurl());
		merdb.setContent(mer.getContent());

		merchantService.save(merdb);

		redirectAttributes.addFlashAttribute("message", "修改商户成功！");
		return "redirect:/merchant/";
	}

	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public String delete(@RequestParam(value = "ids") String ids, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {

		String[] idArr = ids.split("\\|");
		for (String i : idArr) {
			Merchant mer = merchantService.get(Long.valueOf(i));
			List<User> userlist = userService.findByMerchantid(Long.valueOf(i));
			if (userlist != null && userlist.size() > 0) {
				for (User user : userlist) {
					user.setEnabled(0);
					user.setMerchant(null);
					userService.update(user);
				}
			}

			List<MerchantDevice> mdlist = merchantDeviceService.getMerchantDeviceListByMerchantid(Long.parseLong(i));
			if (mdlist != null && mdlist.size() > 0) {
				for (MerchantDevice md : mdlist) {
					merchantDeviceService.delete(md.getId());
				}
			}
			mer.setState(0);
			merchantService.save(mer);

			User user = (User) request.getSession().getAttribute("user");
			User usernew = userService.get(user.getId());
			request.getSession().setAttribute("user", usernew);

			/* merchantService.delete(Long.parseLong(i)); */
		}

		redirectAttributes.addFlashAttribute("message", "删除商户成功！");
		return "redirect:/merchant/";
	}

	@RequestMapping(value = "view/{merid}", method = RequestMethod.GET)
	public String viewForm(@PathVariable(value = "merid") Long id, Model model) {

		Merchant merchant = merchantService.get(id);

		List<Classify> classlist = classifyService.getList("");
		model.addAttribute("pclassify", classlist);

		CategoryType categoryTypeDistrict = null;
		List<CategoryValue> districtlist = null;
		List<CategoryType> ctlist = categoryTypeService.getCategoryTypeByValue("商圈区域");
		if (ctlist != null && ctlist.size() > 0) {
			categoryTypeDistrict = ctlist.get(0);
			districtlist = categoryValueService.getCategoryValueListByCid(categoryTypeDistrict.getId(), 0);
		}
		model.addAttribute("districtlist", districtlist);

		CategoryType categoryTypeKeyword = null;
		List<CategoryValue> keywordlist = null;
		List<CategoryType> kwlist = categoryTypeService.getCategoryTypeByValue("商家关键字");
		if (kwlist != null && kwlist.size() > 0) {
			categoryTypeKeyword = kwlist.get(0);
			keywordlist = categoryValueService.getCategoryValueListByCid(categoryTypeKeyword.getId(), 0);
		}
		model.addAttribute("keywordlist", keywordlist);

		List<Community> comlist = communityService.getCommunityList();
		model.addAttribute("communitys", comlist);

		Business busi = merchant.getBusiness();
		if (busi != null) {
			model.addAttribute("districtid", busi.getCategoryValue().getId());
		} else {
			model.addAttribute("districtid", null);
		}

		List<Business> businesslist = businessService.getList();
		model.addAttribute("businesslist", businesslist);

		model.addAttribute("merchant", merchant);
		model.addAttribute("merkeywords", "," + merchant.getKeywords() + ",");

		return "merchant/merchantViewForm";
	}

	@RequestMapping(value = "checkmerchant/{merid}", method = RequestMethod.GET)
	@ResponseBody
	public String checkMerchant(@PathVariable(value = "merid") Long merid, Model model) {
		Merchant mer = merchantService.get(merid);
		if (mer.getEmail() == null) {
			return "noupdate";
		} else {
			return "yesupdate";
		}
	}

	@RequestMapping(value = "bindaccount/{merid}", method = RequestMethod.GET)
	public String bindAccountForm(@PathVariable(value = "merid") Long id, Model model) {

		Merchant merchant = merchantService.get(id);

		List<User> userlist = userService.findUserByRoleAndMerchantid();
		List<User> bindedlist = userService.findByMerchantid(id);

		String idstr = "";
		if (bindedlist != null && bindedlist.size() > 0) {
			for (User user : bindedlist) {
				idstr += "," + user.getId();
			}
			model.addAttribute("useridstr", idstr.substring(1));
		} else {
			model.addAttribute("useridstr", idstr);
		}

		model.addAttribute("userlist", userlist);

		model.addAttribute("merchant", merchant);
		model.addAttribute("action", "bindaccount");

		return "merchant/bindAccount";
	}

	@RequestMapping(value = "bindaccount", method = RequestMethod.POST)
	public String bindAccount(@RequestParam(value = "merchantid") Long id,
			@RequestParam(value = "userids") String userids, RedirectAttributes redirectAttributes, Model model) {

		List<User> userlist = userService.findByMerchantid(id);

		if (userlist != null && userlist.size() > 0) {
			for (User user : userlist) {
				user.setMerchant(null);
				userService.update(user);
			}
		}

		Merchant merchant = merchantService.get(id);
		String[] useridArr = userids.split(",");

		for (String userid : useridArr) {
			User user = userService.get(Long.valueOf(userid));
			user.setMerchant(merchant);
			userService.update(user);
		}

		redirectAttributes.addFlashAttribute("message", "绑定账号成功！");

		return "redirect:/merchant/";
	}

	@RequestMapping(value = "openaccount", method = RequestMethod.POST)
	public String openAccount(@RequestParam(value = "merchantid") Long merchantid,
			@RequestParam(value = "phoneno") String phoneno, @RequestParam(value = "uname") String uname,
			RedirectAttributes redirectAttributes) {

		User user = new User();
		user.setName(phoneno);
		user.setRealname(uname);
		user.setTelephone(phoneno);
		user.setRegistertime(new Date());
		user.setEnabled(1);
		user.setState(1);

		Role role = new Role();
		role.setId(11L);
		user.setRole(role);

		Merchant mer = merchantService.get(merchantid);
		user.setMerchant(mer);
		user.setPassword("000000");

		try {
			userService.saveorupdate(user);

			mer.setBinduser(1);

			merchantService.save(mer);
			redirectAttributes.addFlashAttribute("message", "创建系统用户成功");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("message", "创建系统用户失败");

		}

		return "redirect:/merchant/";

	}

	@RequestMapping(value = "bindNum", method = RequestMethod.POST)
	public String bindNum(@RequestParam(value = "merchantid") Long merchantid,
			@RequestParam(value = "paytype") String paytype, @RequestParam(value = "countNum") String countNum,
			RedirectAttributes redirectAttributes) {
		Merchant mer = merchantService.get(merchantid);
		if ("wx".equals(paytype)) {
			mer.setWxpaynum(countNum);
		} else if ("ali".equals(paytype)) {
			mer.setAlipaynum(countNum);
		}
		merchantService.save(mer);
		return "redirect:/merchant/";
	}

	@RequestMapping(value = "merchantside", method = RequestMethod.GET)
	public String merchantSideUpdateForm(Model model, HttpServletRequest request, HttpServletResponse response) {

		User user = (User) request.getSession().getAttribute("user");

		if (user.getRole().getId() == 1) {
			model.addAttribute("msg", "你是管理员账户，你没有绑定具体的商户，不能进行此操作！");
			return "merchant/noBind";
		}

		Merchant mer = user.getMerchant();

		Merchant merchant = null;

		if (mer != null) {
			merchant = merchantService.get(mer.getId());
		} else {
			model.addAttribute("msg", "您的商户信息不完善，等待运营方为你完善信息，之后方可操作！");
			return "merchant/noBind";
		}

		if (merchant.getTelephone() == null) {
			model.addAttribute("msg", "您的商户信息不完善，等待运营方为你完善信息，之后方可操作！");
			return "merchant/noBind";
		}

		model.addAttribute("merchant", merchant);

		List<Classify> classlist = classifyService.getList("");
		model.addAttribute("pclassify", classlist);

		CategoryType categoryTypeDistrict = null;
		List<CategoryValue> districtlist = null;
		List<CategoryType> ctlist = categoryTypeService.getCategoryTypeByValue("商圈区域");
		if (ctlist != null && ctlist.size() > 0) {
			categoryTypeDistrict = ctlist.get(0);
			districtlist = categoryValueService.getCategoryValueListByCid(categoryTypeDistrict.getId(), 0);
		}
		model.addAttribute("districtlist", districtlist);

		CategoryType categoryTypeKeyword = null;
		List<CategoryValue> keywordlist = null;
		List<CategoryType> kwlist = categoryTypeService.getCategoryTypeByValue("商家关键字");
		if (kwlist != null && kwlist.size() > 0) {
			categoryTypeKeyword = kwlist.get(0);
			keywordlist = categoryValueService.getCategoryValueListByCid(categoryTypeKeyword.getId(), 0);
		}
		model.addAttribute("keywordlist", keywordlist);

		List<Community> comlist = communityService.getCommunityList();
		model.addAttribute("communitys", comlist);

		Business busi = merchant.getBusiness();
		if (busi != null) {
			model.addAttribute("districtid", busi.getCategoryValue().getId());
		} else {
			model.addAttribute("districtid", null);
		}

		List<Business> businesslist = businessService.getList();
		model.addAttribute("businesslist", businesslist);

		model.addAttribute("merchant", merchant);
		model.addAttribute("merkeywords", "," + merchant.getKeywords() + ",");

		return "merchant/merchantSideForm";
	}

	@RequestMapping(value = "mersideupdate", method = RequestMethod.POST)
	public String merchantSideUpdate(@ModelAttribute(value = "merchant") Merchant mer,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {

		Merchant merdb = merchantService.get(mer.getId());

		Integer comm = mer.getCommunity();
		if (comm == null || comm == -1) {
			merdb.setCommunity(null);
		} else {
			merdb.setCommunity(comm);
		}

		String busid = request.getParameter("business.id");
		if (busid == null || "-1".equals(busid)) {
			merdb.setBusiness(null);
		} else {
			merdb.setBusiness(mer.getBusiness());
		}

		merdb.setName(mer.getName());
		merdb.setOwnername(mer.getOwnername());
		merdb.setEmail(mer.getEmail());
		merdb.setTelephone(mer.getTelephone());
		merdb.setAddress(mer.getAddress());
		merdb.setBankaccount(mer.getBankaccount());
		merdb.setPclassify(mer.getPclassify());
		merdb.setClassify(mer.getClassify());
		merdb.setOnecost(mer.getOnecost());
		merdb.setKeywords(mer.getKeywords());
		merdb.setSpecialcourse(mer.getSpecialcourse());
		merdb.setThumbnailurl(mer.getThumbnailurl());
		merdb.setIntroduceurl(mer.getIntroduceurl());
		merdb.setDetailurl(mer.getDetailurl());
		merdb.setContent(mer.getContent());

		merchantService.save(merdb);

		redirectAttributes.addFlashAttribute("message", "保存成功！");

		return "redirect:/merchant/merchantside";
	}

	@RequestMapping(value = "upfile")
	@ResponseBody
	public String upfile(HttpServletRequest request, @RequestParam(value = "type") String type,
			@RequestParam(value = "fileToUploadthumb", required = false) MultipartFile thumbfile,
			@RequestParam(value = "fileToUploadintro", required = false) MultipartFile introfile,
			@RequestParam(value = "fileToUploaddetail", required = false) MultipartFile detailfile) {
		Date nowDate = new Date();
		int uuid = (int) (Math.random() * 10000);
		MultipartFile file = null;
		int width;
		int height;

		if (type.equals("thumb")) {
			width = 210;
			height = 130;
			file = thumbfile;
		} else if (type.equals("intro")) {
			width = 210;
			height = 130;
			file = introfile;
		} else if (type.equals("detail")) {
			width = 720;
			height = 252;
			file = detailfile;
		} else {
			width = 300;
			height = 300;
		}

		int filewidth, fileheight; // 文件实际宽高
		int kind;// 类型 1图片2视频

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String pbasepath = request.getSession().getServletContext().getRealPath("/");
		// uoload/picture/20140101
		String mybasepath = pbasepath + File.separator + "upload" + File.separator + "picture" + File.separator
				+ sdf.format(nowDate);
		// 原图
		File imgpath = new File(mybasepath + File.separator + "original");
		// 缩略图
		File thimgpath = new File(mybasepath + File.separator + "thumbnail");
		if (!imgpath.exists()) {
			imgpath.mkdirs();
		}
		if (!thimgpath.exists()) {
			thimgpath.mkdirs();
		}

		String fileoritype = ".jpg";

		try {

			String filename = file.getOriginalFilename();
			fileoritype = filename.substring(filename.lastIndexOf("."));
			String filetype = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
			// 图片文件
			if (filetype.equals("PNG") || filetype.equals("JPG")) {
				kind = 1;
				String newpath = imgpath.getPath() + File.separator + nowDate.getTime() + uuid + fileoritype;
				file.transferTo(new File(newpath));
				BufferedImage src = ImageIO.read(new File(newpath));
				ImageUtil.changeToSize(newpath,
						thimgpath.getPath() + File.separator + nowDate.getTime() + uuid + fileoritype, width, height,
						filetype);
				filewidth = src.getWidth();
				fileheight = src.getHeight();
			} else {
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return "{'path':'" + "upload/picture/" + sdf.format(nowDate) + "/original/" + nowDate.getTime() + uuid
				+ fileoritype + "','thumbnail':'" + "upload/picture/" + sdf.format(nowDate) + "/thumbnail/"
				+ nowDate.getTime() + uuid + fileoritype + "','result':'1','width':'" + filewidth + "','height':'"
				+ fileheight + "','kind':'" + kind + "','twidth':'" + width + "','theight':'" + height + "'}";
	}

	@RequestMapping(value = "wxmerlist")
	public String pageList(Model model) {

		// String ak = WXManage.WCA.getAccesstoken();

		String ak = SocketUtil.getak("http://huugu.com/wxurl/getak");

		String param = "{\"begin\":0,\"limit\":50}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=" + ak,
				param);

		String count = null;

		try {
			JSONObject jodata = new JSONObject(result);
			count = jodata.getString("total_count");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("count", count);

		return "merchant/wxmerlist";

	}

	@RequestMapping(value = "getmerlist")
	@ResponseBody
	public String getPageList(@RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
			@RequestParam(value = "pageIndex", defaultValue = "1") int pageIndex, Model model,
			HttpServletRequest request) {

		String ak = SocketUtil.getak("http://huugu.com/wxurl/getak");

		String param = "{\"begin\":" + (pageIndex - 1) * pageSize + ",\"limit\":" + pageSize + "}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=" + ak,
				param);

		String poidata = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("business_list");

			System.out.println(dataStr);

			if (dataStr != null && dataStr.length() > 2) {

				JSONArray jaArr = new JSONArray(dataStr);
				System.out.println(jaArr.length());
				for (int i = 0; i < jaArr.length(); i++) {
					System.out.println(jaArr.get(i));

					JSONObject jsonbaseinfo = new JSONObject(jaArr.get(i).toString());
					String jsonbaseinfodata = jsonbaseinfo.getString("base_info");

					JSONObject contentdata = new JSONObject(jsonbaseinfodata);

					String sid = contentdata.getString("sid");
					String business_name = contentdata.getString("business_name");
					String branch_name = contentdata.getString("branch_name");
					String address = contentdata.getString("address");
					String telephone = contentdata.getString("telephone");
					String categories = contentdata.getString("categories");
					String city = contentdata.getString("city");
					String province = contentdata.getString("province");
					String offset_type = contentdata.getString("offset_type");
					String longitude = contentdata.getString("longitude");
					String latitude = contentdata.getString("latitude");
					String photo_list = contentdata.getString("photo_list");
					String introduction = contentdata.getString("introduction");
					String recommend = contentdata.getString("recommend");
					String special = contentdata.getString("special");
					String open_time = contentdata.getString("open_time");
					String avg_price = contentdata.getString("avg_price");
					String poi_id = contentdata.getString("poi_id");
					String available_state = contentdata.getString("available_state");
					String district = contentdata.getString("district");
					String update_status = contentdata.getString("update_status");

					categories = categories.substring(1, categories.length() - 1);
					if (!categories.equals("")) {
						categories = categories.substring(1, categories.length() - 1);
					}
					System.out.println(categories);

					photo_list = photo_list.substring(1, photo_list.length() - 1);
					StringBuilder photourlstr = new StringBuilder();
					if (!photo_list.equals("")) {
						String[] photo_listArr = photo_list.split(",");
						for (String photourljson : photo_listArr) {
							JSONObject photojsonobj = new JSONObject(photourljson);
							String photourl = photojsonobj.getString("photo_url");
							photourlstr.append(photourl);
							photourlstr.append(",");
						}
					}

					if (photourlstr.length() > 0) {
						photo_list = photourlstr.substring(0, photourlstr.length() - 1);
					}

					Merchant wxmer = new Merchant();
					wxmer.setSid(sid);
					wxmer.setBusiness_name(business_name);
					wxmer.setBranch_name(branch_name);
					wxmer.setWxaddress(address);
					wxmer.setWxtelephone(telephone);
					wxmer.setWxcategories(categories);
					wxmer.setCity(city);
					wxmer.setProvince(province);
					wxmer.setOffset_type(Integer.parseInt(offset_type));
					wxmer.setLongitude(longitude);
					wxmer.setLatitude(latitude);
					wxmer.setPhoto_list(photo_list);
					wxmer.setIntroduction(introduction);
					wxmer.setWxrecommend(recommend);
					wxmer.setSpecial(special);
					wxmer.setOpen_time(open_time);
					wxmer.setAvg_price(Float.valueOf(avg_price));
					wxmer.setPoi_id(poi_id);
					wxmer.setAvailable_state(Integer.valueOf(available_state));
					wxmer.setDistrict(district);
					wxmer.setUpdate_status(Integer.valueOf(update_status));

					wxmer.setState(1);
					wxmer.setName(business_name);
					wxmer.setOwnername(business_name);
					wxmer.setEmail(null);
					wxmer.setCategory(null);
					wxmer.setDistrict(district);
					wxmer.setBusiness(null);
					wxmer.setTelephone(telephone);
					wxmer.setAddress(address);
					wxmer.setBankaccount(null);
					wxmer.setThumbnailurl(null);
					wxmer.setIntroduceurl(null);
					wxmer.setDetailurl(null);
					wxmer.setContent(null);
					wxmer.setCreatetime(new Date());
					wxmer.setUpdatetime(new Date());
					wxmer.setRecommend(0);

					User user = (User) request.getSession().getAttribute("user");
					wxmer.setUser(user);

					merchantService.save(wxmer);

				}
			}

			poidata = dataStr;

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return poidata;

	}

	@RequestMapping(value = "updatemertable")
	@ResponseBody
	public Map<String, Object> updateMerchantTable(HttpServletRequest request, Model model) {

		Map<String, Object> map = new HashMap<String, Object>();
		String ak = weChatAccountService.getAccesstoken();

		String param = "{\"begin\":0,\"limit\":50}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=" + ak,
				param);

		String count = null;

		try {
			JSONObject jodata = new JSONObject(result);
			count = jodata.getString("total_count");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int intCount = Integer.valueOf(count);

		int times = intCount / 50;

		int remain = intCount % 50;

		String alldatastr = "";

		String param1 = null;

		String result1 = null;

		for (int i = 1; i <= times; i++) {

			param1 = "{\"begin\":" + (i - 1) * 50 + ",\"limit\":50}";
			result1 = SocketUtil.sendPost("https://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=" + ak,
					param1);

			try {
				JSONObject jodata = new JSONObject(result1);
				String pieceStr = jodata.getString("business_list");

				alldatastr += pieceStr.substring(1, pieceStr.length() - 1) + ",";

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		param1 = "{\"begin\":" + times * 50 + ",\"limit\":" + remain + "}";
		result1 = SocketUtil.sendPost("https://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=" + ak, param1);

		try {
			JSONObject jodata = new JSONObject(result1);
			String pieceStr = jodata.getString("business_list");

			alldatastr += pieceStr.substring(1, pieceStr.length() - 1);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (alldatastr == null || alldatastr.length() == 0) {
			map.put("result", "1");
			map.put("msg", "数据更新成功");
			return map;
		}

		alldatastr = "[" + alldatastr + "]";

		System.out.println(alldatastr);

		StringBuilder poi_idstr = new StringBuilder();

		StringBuilder idbuilder = new StringBuilder();

		try {
			JSONArray jaArr = new JSONArray(alldatastr);
			System.out.println(jaArr.length());
			for (int i = 0; i < jaArr.length(); i++) {
				System.out.println(jaArr.get(i));

				JSONObject jsonbaseinfo = new JSONObject(jaArr.get(i).toString());
				String jsonbaseinfodata = jsonbaseinfo.getString("base_info");

				JSONObject contentdata = new JSONObject(jsonbaseinfodata);

				String sid = contentdata.getString("sid");
				String business_name = contentdata.getString("business_name");
				String branch_name = contentdata.getString("branch_name");
				String address = contentdata.getString("address");
				String telephone = contentdata.getString("telephone");
				String categories = contentdata.getString("categories");
				String city = contentdata.getString("city");
				String province = contentdata.getString("province");
				String offset_type = contentdata.getString("offset_type");
				String longitude = contentdata.getString("longitude");
				String latitude = contentdata.getString("latitude");
				String photo_list = contentdata.getString("photo_list");
				String introduction = contentdata.getString("introduction");
				String recommend = contentdata.getString("recommend");
				String special = contentdata.getString("special");
				String open_time = contentdata.getString("open_time");
				String avg_price = contentdata.getString("avg_price");
				String poi_id = contentdata.getString("poi_id");
				String available_state = contentdata.getString("available_state");
				String district = contentdata.getString("district");
				String update_status = contentdata.getString("update_status");

				if (!available_state.equals("3") || poi_id == null || poi_id.equals("")) {
					continue;
				}

				poi_idstr.append(poi_id + ",");

				Merchant wxmer = merchantService.getMerchantByPoi_id(poi_id);

				if (wxmer == null) {
					wxmer = new Merchant();
				}

				categories = categories.substring(1, categories.length() - 1);
				if (!"".equals(categories)) {
					categories = categories.substring(1, categories.length() - 1);
				}
				System.out.println(categories);

				photo_list = photo_list.substring(1, photo_list.length() - 1);
				StringBuilder photourlstr = new StringBuilder();
				if (!"".equals(photo_list)) {
					String[] photo_listArr = photo_list.split(",");
					for (String photourljson : photo_listArr) {
						JSONObject photojsonobj = new JSONObject(photourljson);
						String photourl = photojsonobj.getString("photo_url");
						photourlstr.append(photourl);
						photourlstr.append(",");
					}
				}

				if (photourlstr.length() > 0) {
					photo_list = photourlstr.substring(0, photourlstr.length() - 1);
				}

				wxmer.setSid(sid);
				wxmer.setBusiness_name(business_name);
				wxmer.setBranch_name(branch_name);
				wxmer.setWxaddress(address);
				wxmer.setWxtelephone(telephone);
				wxmer.setWxcategories(categories);
				wxmer.setCity(city);
				wxmer.setProvince(province);
				wxmer.setOffset_type(Integer.parseInt(offset_type));
				wxmer.setLongitude(longitude);
				wxmer.setLatitude(latitude);
				wxmer.setPhoto_list(photo_list);
				wxmer.setIntroduction(introduction);
				wxmer.setWxrecommend(recommend);
				wxmer.setSpecial(special);
				wxmer.setOpen_time(open_time);
				wxmer.setAvg_price(Float.valueOf(avg_price));
				wxmer.setPoi_id(poi_id);
				wxmer.setAvailable_state(Integer.valueOf(available_state));
				wxmer.setDistrict(district);
				wxmer.setUpdate_status(Integer.valueOf(update_status));

				if (wxmer.getId() == null) {

					wxmer.setName(business_name);
					wxmer.setOwnername(null);
					wxmer.setEmail(null);
					wxmer.setCategory(null);
					wxmer.setBusiness(null);
					wxmer.setTelephone(null);
					wxmer.setAddress(address);
					wxmer.setBankaccount(null);
					wxmer.setThumbnailurl(null);
					wxmer.setIntroduceurl(null);
					wxmer.setDetailurl(null);
					wxmer.setQrurl(null);
					wxmer.setContent(null);
					wxmer.setRecommend(0);
					wxmer.setBinduser(null);
					wxmer.setWxpaynum(null);
					wxmer.setAlipaynum(null);
					wxmer.setKeywords(null);
					wxmer.setOnecost(null);
					wxmer.setClassify(null);
					wxmer.setPclassify(null);
					wxmer.setCommunity(null);
					wxmer.setSpecialcourse(null);

					wxmer.setCreatetime(new Date());
					wxmer.setUpdatetime(new Date());
					wxmer.setState(1);

					wxmer.setWxlocationid(Long.valueOf(poi_id));

				} else {
					wxmer.setUpdatetime(new Date());
				}

				User user = (User) request.getSession().getAttribute("user");
				wxmer.setUser(user);

				Merchant mersaved = merchantService.save(wxmer);
				Long merid = mersaved.getId();

				idbuilder.append("," + merid);

				if (mersaved.getQrurl() != null && !mersaved.getQrurl().equals("")) {

				} else {

					String key = "shxxrk000" + merid;

					String qrurl = "";
					String qrparam = "{\"action_name\": \"QR_LIMIT_STR_SCENE\", \"action_info\": {\"scene\": {\"scene_str\": \""
							+ key + "\"}}}";
					String sendurl = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=";

					String qrresult = WXUtil.sendPost(sendurl + weChatAccountService.getAccesstoken(), qrparam);
					if (result.equals("")) {
						System.out.println("!!!!!!!获取ticket失败！！！！！！！！");
					} else {
						try {
							JSONObject jo = new JSONObject(qrresult);
							qrurl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo.getString("ticket");
						} catch (JSONException e) {
							System.out.println("!!!!!!!获取ticket失败！！！！！！！！");
							e.printStackTrace();
						}
					}

					System.out.println(qrurl);

					mersaved.setQrurl(qrurl);

					merchantService.save(mersaved);
				}

			}

			String idstrs = idbuilder.substring(1);

			merchantService.setState(idstrs);

			String poiids = poi_idstr.substring(0, poi_idstr.length() - 1);

			System.out.println(poiids);

			map.put("result", "1");
			map.put("msg", "数据更新成功");
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "1");
			map.put("msg", "数据更新失败");
			return map;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "1");
			map.put("msg", "数据更新失败");
			return map;
		}

		return map;

	}

	@RequestMapping(value = "downqr/{merid}")
	public String download(@PathVariable("merid") Long merid, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Merchant mer = merchantService.get(merid);
		String requesturl = mer.getQrurl();

		String filename = mer.getId() + ".jpg";

		InputStream inputStream = null;
		HttpURLConnection httpURLConnection = null;

		try {
			URL url = new URL(requesturl);
			httpURLConnection = (HttpURLConnection) url.openConnection();
			// 设置连接网络的超时时间
			httpURLConnection.setConnectTimeout(3000);
			httpURLConnection.setDoInput(true);
			httpURLConnection.setRequestMethod("GET");

			int responseCode = httpURLConnection.getResponseCode();
			if (responseCode == 200) {
				inputStream = httpURLConnection.getInputStream();

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-Disposition", "attachment;fileName=" + filename);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}

			// 关闭下载
			os.flush();
			os.close();
			inputStream.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

}
