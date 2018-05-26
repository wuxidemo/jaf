package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.yjy.entity.Advert;
import com.yjy.entity.CategoryType;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.Sq_QuickBuy;
import com.yjy.entity.User;
import com.yjy.entity.WXCard;
import com.yjy.service.AdvertService;
import com.yjy.service.CategoryTypeService;
import com.yjy.service.CategoryValueService;
import com.yjy.service.SqQuickBuyService;
import com.yjy.service.WXCardService;

/**
 * 类AdvertController.java的实现描述： 操作广告
 * 
 * @author zhangmengmeng 2015-3-28 下午3:21:10
 */
@Controller
@RequestMapping(value = "/advert")
public class AdvertController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@Autowired
	private AdvertService advertService;
	
	@Autowired
	private CategoryTypeService categoryTypeService;
	
	@Autowired
	private CategoryValueService categoryValueService;
	
	@Autowired
	private WXCardService wXCardService;
	
	@Autowired
	private SqQuickBuyService sqQuickBuyService;
	
	/**
	 * 获取广告页面
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:38:33
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	private String getIndex(
			@RequestParam(value = "type") String type,
			@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType,
			Model model, ServletRequest request) {
		/*if ("preferential".equals(type)) {
			Map<String, Object> searchParams = new HashMap<String, Object>();
			searchParams.put("EQ_type", type);
			Page<Advert> adverts = advertService.getAdvertList(searchParams,
					pageNumber, pageSize, sortType);
			model.addAttribute("adverts", adverts);
		}
		model.addAttribute("type", type);
		return "advert/" + type;*/
		
		return "advert/advertmain";
		
	}

	/**
	 * 跳转到微信首页
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-24 下午1:23:00
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wxindex")
	private String getWxIndexs(Model model, ServletRequest request) {
		List<Advert> adverts = advertService.getListTitle("carousel");
		model.addAttribute("adverts", adverts);
		model.addAttribute("size",adverts.size());
		
		CategoryType categoryType = categoryTypeService.getCategoryTypeByValue(
				"商家标签").get(0);
		List<CategoryValue> list = categoryValueService
				.getCategoryValueListByCid(categoryType.getId(), 0);
		
		if(list != null && list.size() > 0) {
			StringBuilder sb = new StringBuilder();
			sb.append("[");
			for(CategoryValue cv : list) {
				String cvstr = "{\"id\":" + cv.getId() +"," +"\"value\":\"" + cv.getValue() +"\"},";
				sb.append(cvstr);
			}
			
			String jsonstr = sb.substring(0, sb.length()-1) + "]";
			
			model.addAttribute("cvjsonstr", jsonstr);
		}else{
			model.addAttribute("cvjsonstr", "");
		}
		
		return "advert/wxadvert";
	}

	/**
	 * 微信首页广告详情页面
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-24 下午1:25:13
	 * @param id
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getDetail/{id}", method = RequestMethod.GET)
	private String getWxDetail(@PathVariable("id") String id, Model model,
			ServletRequest request) {
		Advert advert = advertService.findOne(id);
		model.addAttribute("advert", advert);
		return "advert/detail";
	}

	/**
	 * 获取广告信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-24 下午1:14:57
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> getList(
			@RequestParam(value = "type") String type) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Advert> adverts = advertService.getList(type);
		if (adverts.size() > 0) {
			map.put("data", adverts);
			map.put("result", true);
		} else {
			map.put("result", false);
		}
		return map;
	}

	/**
	 * 获取单个广告信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-25 上午11:12:01
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/getOne", method = RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> getOne(@RequestParam(value = "id") String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Advert  advert= advertService.findOne(id);
		if (advert!=null) {
			map.put("data", advert);
			map.put("result", true);
		} else {
			map.put("result", false);
		}
		return map;
	}

	/**
	 * 创建信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午2:32:49
	 * @param advert
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String create(@Valid Advert advert,
			RedirectAttributes redirectAttributes, HttpServletRequest request,@RequestParam(value = "type2", required=false) Integer type2) {
		
		if(type2 != null) {
			if(type2 == 1) {
				 advert.setTitle("");
				 advert.setContent("");
			}else if(type2 == 0) {
				advert.setUrl("");
			}
		}
		
		User user = (User) request.getSession().getAttribute("user");
		advert.setUser(user);
		advert.setCreatetime(new Date());
		advertService.SaveOrUpdate(advert);
		redirectAttributes.addFlashAttribute("message", "更新成功");
		if ("preferential".equals(advert.getType())) {
			return "redirect:/advert?type=preferential";
		}
		return "advert/" + advert.getType();

	}

	/**
	 * 判断广告名称是否存在
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-15 上午11:36:00
	 * @param id
	 * @param name
	 * @param cid
	 * @return
	 */
	/*
	 * @RequestMapping(value = "/checkname", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public Map<String, Object> CheckCategoryValue(
	 * 
	 * @RequestParam(value = "id") Long id,
	 * 
	 * @RequestParam(value = "title") String title) { Map<String, Object> map =
	 * new HashMap<String, Object>(); List<Advert> adverts =
	 * advertService.getAdvertByTitle(title); if (adverts.size() == 0) {
	 * map.put("result", true); } else if (adverts.get(0).getId().equals(id)) {
	 * map.put("result", true); } else { map.put("result", false);
	 * map.put("msg", "商圈名称已存在"); } return map; }
	 */

	/**
	 * 删除Advert对象。
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-15 上午11:35:53
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteAdvert(
			@RequestParam(value = "id") String id, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		  boolean result=advertService.delete(id);
		  if(result){
			  map.put("result", true);
		  }else{
			  map.put("result", false);
		      map.put("msg", "删除失败");  
		  }
		/*Advert advert = advertService.findOne(id);
		advert.setContent("");
		advert.setImg("");
		advert.setTitle("");
		advert.setCreatetime(new Date());
		User user = (User) request.getSession().getAttribute("user");
		advert.setUser(user);
		advertService.SaveOrUpdate(advert);
		map.put("result", true);*/
		return map;
	}

	/**
	 * 删除Advert对象。
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-15 上午11:35:53
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/deletePreferential", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deletePreferential(
			@RequestParam(value = "ids") String ids, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = advertService.delete(ids);
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	/**
	 * 上传图片
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午7:53:00
	 * @param request
	 * @param file
	 * @return
	 */
	@RequestMapping(value = "upfile")
	@ResponseBody
	public String upfile(
			HttpServletRequest request,
			@RequestParam(value = "fileToUpload", required = false) MultipartFile file) {
		Date now = new Date(); // 获取当前时间
		int uid = (int) (Math.random() * 10000); // 创建随机的id
		int filewidth, fileheight; // 文件的实际宽高
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String pbasepath = request.getSession().getServletContext().getRealPath("/");// 获取到文件的根路径

		String mybasepath = pbasepath + File.separator + "upload" + File.separator + "picture" + File.separator + sdf.format(now);
		File imgpath = new File(mybasepath + File.separator);// 原图
		if (!imgpath.exists()) {
			imgpath.mkdirs();
		}
		try {
			String filename = file.getOriginalFilename();
			String filetype = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
			// 验证后缀名
			if (filetype.equals("PNG") || filetype.equals("JPG")) {
				String newpath = imgpath.getPath() + File.separator + now.getTime() + uid + ".jpg";
				file.transferTo(new File(newpath));
				BufferedImage src = ImageIO.read(new File(newpath));
				filewidth = src.getWidth();
				fileheight = src.getHeight();
			} else {
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return "{'path':'" + "upload/picture/" + sdf.format(now) + "/"
				+ now.getTime() + uid + ".jpg" + "','result':'1','width':'"
				+ filewidth + "','height':'" + fileheight + "'}";
	}
	
	
	/*******************************2016-02-18新增******************************/
	
	@RequestMapping(value="advertmain")
	public String advertMain() {
		return "advert/advertmain";
	}
	
	@RequestMapping(value = "getadbytype", method = RequestMethod.POST)
	@ResponseBody
	private List<Advert> getAdByType(@RequestParam(value = "type") String type) {
		
		List<Advert> adverts = advertService.getAdListByType(type);
		
		return adverts;
	}
	
	@RequestMapping(value = "getadbyid", method = RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> getAdById(@RequestParam(value = "id") String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Advert advert= advertService.findOne(id);
		if (advert!=null) {
			map.put("data", advert);
			map.put("result", "1");
		} else {
			map.put("result", "0");
		}
		return map;
	}
	
	@RequestMapping(value = "saveorupdate", method = RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> createAdvert(
			@RequestParam(value = "type2") String type2,
			@RequestParam(value = "name") String name,
			@RequestParam(value = "content") String content,
			@RequestParam(value = "adcontentlink") String adcontentlink,
			@RequestParam(value = "adcontentdesc") String adcontentdesc,
			@RequestParam(value = "adurl") String adurl,
			@RequestParam(value = "id") String id,
			@RequestParam(value = "advertimg") String advertimg,
			@RequestParam(value = "adtype") String adtype,
			@RequestParam(value = "adpos") String adpos,
			HttpServletRequest request) {
	
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User user = (User) request.getSession().getAttribute("user");
			
			Advert advert = new Advert();
			
			
			if(id == null || "".equals(id)) {
				
			}else{
				advert = advertService.findOne(id);
			}
			
			advert.setUser(user);
			advert.setCreatetime(new Date());
			
			advert.setTitle(name);
			advert.setImg(advertimg);
			
			if(adpos == null || "".equals(adpos)) {
				advert.setPosition(null);
			}else{
				advert.setPosition(Integer.valueOf(adpos));
			}
			
			advert.setType(adtype);
			advert.setType2(Integer.valueOf(type2));
			
			if("carousel".equals(adtype)) {
				if("0".equals(type2)) {
					advert.setContent(content);
					advert.setUrl(null);
				}else{
					advert.setUrl(adurl);
					advert.setTitle("");
					advert.setContent("");
				}
			}else if ("nominate".equals(adtype)) {
				advert.setContent(adcontentlink);
			}else if("preferential".equals(adtype)) {
				if("0".equals(type2)) {
					advert.setContent(content);
					advert.setUrl(null);
				}else{
					advert.setUrl(adurl);
					advert.setTitle("");
					advert.setContent("");
				}
			}else if("commlunbo".equals(adtype)) {
				if("0".equals(type2)) {
					advert.setContent(content);
					advert.setUrl(null);
				}else{
					advert.setUrl(adurl);
					advert.setTitle("");
					advert.setContent("");
				}
			}else if("commhuodong".equals(adtype)) {
				if("0".equals(type2)) {
					advert.setContent(content);
					advert.setUrl(null);
				}else{
					advert.setUrl(adurl);
					advert.setTitle("");
					advert.setContent("");
				}
			}else{
				advert.setContent(adcontentdesc);
			}
			
			advertService.SaveOrUpdate(advert);
			
			map.put("result", "1");
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "0");
		}
		
		return map;
		
	}
	
	@RequestMapping(value="deladv")
	@ResponseBody
	public Map<String, Object> deleteAdvert(@RequestParam(value="advid") String advid) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Advert advert = advertService.findOne(advid);
		
		advertService.delete(advid);
		
		map.put("result", "1");
		map.put("pos", advert.getPosition());
		return map;
	}
	
	/*******************************2016-04-18新增******************************/
	
	@RequestMapping(value="comadvert")
	public String commAdvertMain() {
		return "advert/comadvert";
	}
	
	@RequestMapping(value="goback")
	public String goBack(Model model) {
		model.addAttribute("acttab", "qianggou");
		return "advert/comadvert";
	}
	
	@RequestMapping(value="getquickbuylist")
	@ResponseBody
	public List<Sq_QuickBuy> getQuickBuyList() {
		
		List<Sq_QuickBuy> sqlist = sqQuickBuyService.getSq_QuickBuyList();
		
		return sqlist;
	}
	
	@RequestMapping(value="addqianggou/{position}")
	public String addQG(@PathVariable(value="position") Integer positon,Model model) {
		model.addAttribute("position", positon);
		
		List<WXCard> cardlist = wXCardService.getQiangGouActCard();
		model.addAttribute("cardlist", cardlist);
		
		return "advert/qianggouForm";
	}
	
	@RequestMapping(value="updateqianggou/{id}")
	public String updateQG(@PathVariable(value="id") Long id,Model model) {
		Sq_QuickBuy sqg = sqQuickBuyService.get(id);
		Date starttime = sqg.getStarttime();
		Date endtime = sqg.getEndtime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startstr = sdf.format(starttime);
		String endstr = sdf.format(endtime);
		String[] startstrarr = startstr.split(" ");
		String[] endstrarr = endstr.split(" ");
		String startdate = startstrarr[0];
		String stime = startstrarr[1].substring(0, 5);
		String enddate = endstrarr[0];
		String etime = endstrarr[1].substring(0, 5);
		model.addAttribute("startdate", startdate);
		model.addAttribute("stime", stime);
		model.addAttribute("enddate", enddate);
		model.addAttribute("etime", etime);
		model.addAttribute("sqg", sqg);
		
		Integer state = sqg.getState();
		Integer sold = sqg.getSoldamount();
		if(state == 1) {
			model.addAttribute("canedit", "1");
		}else if(state == 2) {
			model.addAttribute("canedit", "0");
		}else if(state == 3) {
			model.addAttribute("canedit", "0");
		}else if(state == 4) {
			if(sold == null || sold == 0) {
				model.addAttribute("canedit", "1");
			}else{
				model.addAttribute("canedit", "0");
			}
		}else if(state == 5) {
			model.addAttribute("canedit", "0");
		}
		
		List<WXCard> cardlist = wXCardService.getQiangGouActCard();
		model.addAttribute("cardlist", cardlist);
		
		return "advert/qianggouUpdateForm";
	}
	
	@RequestMapping(value="viewqianggou/{id}")
	public String showQG(@PathVariable(value="id") Long id,Model model) {
		Sq_QuickBuy sqg = sqQuickBuyService.get(id);
		Date starttime = sqg.getStarttime();
		Date endtime = sqg.getEndtime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startstr = sdf.format(starttime);
		String endstr = sdf.format(endtime);
		String[] startstrarr = startstr.split(" ");
		String[] endstrarr = endstr.split(" ");
		String startdate = startstrarr[0];
		String stime = startstrarr[1].substring(0, 5);
		String enddate = endstrarr[0];
		String etime = endstrarr[1].substring(0, 5);
		model.addAttribute("startdate", startdate);
		model.addAttribute("stime", stime);
		model.addAttribute("enddate", enddate);
		model.addAttribute("etime", etime);
		model.addAttribute("sqg", sqg);
		
		List<WXCard> cardlist = wXCardService.getQiangGouActCard();
		model.addAttribute("cardlist", cardlist);
		
		return "advert/qianggouViewForm";
	}
	
	@RequestMapping(value="savequickbuy", method=RequestMethod.POST)
	public String quickBuy(@Valid Sq_QuickBuy sqbuy,
			@RequestParam(value="startdate") String startdate,
			@RequestParam(value="stime") String stime,
			@RequestParam(value="enddate") String enddate,
			@RequestParam(value="etime") String etime,
			@RequestParam(value="paymoney2") String paymoney,
			Model model) {
		
		Date starttime = new Date();
		Date endtime = new Date();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			starttime = sdf.parse(startdate + " " + stime + ":00");
			endtime = sdf.parse(enddate + " " + etime + ":00");
			
			sqbuy.setStarttime(starttime);
			sqbuy.setEndtime(endtime);
			float moneyint = Float.valueOf(paymoney)*100;
			sqbuy.setPaymoney((int)moneyint);
			
			WXCard card = wXCardService.get(sqbuy.getCardid());
			sqbuy.setCardnum(card.getCardid());
			sqbuy.setSoldamount(0);
			sqbuy.setState(4);
			
			sqQuickBuyService.save(sqbuy);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("acttab", "qianggou");
		
		return "advert/comadvert";
	}
	
	@RequestMapping(value="savaupdateqg", method=RequestMethod.POST)
	public String savaUpdateQG(@Valid Sq_QuickBuy sqbuy,
			@RequestParam(value="startdate",required=false) String startdate,
			@RequestParam(value="stime",required=false) String stime,
			@RequestParam(value="enddate",required=false) String enddate,
			@RequestParam(value="etime",required=false) String etime,
			@RequestParam(value="paymoney2") String paymoney,
			Model model) {
		
		Sq_QuickBuy sqgdb = sqQuickBuyService.get(sqbuy.getId());
		
		if(sqgdb.getState() == 1) {
			Date starttime = new Date();
			Date endtime = new Date();
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				starttime = sdf.parse(startdate + " " + stime + ":00");
				endtime = sdf.parse(enddate + " " + etime + ":00");
				
				sqbuy.setStarttime(starttime);
				sqbuy.setEndtime(endtime);
				float moneyint = Float.valueOf(paymoney)*100;
				sqbuy.setPaymoney((int)moneyint);
				
				WXCard card = wXCardService.get(sqbuy.getCardid());
				sqbuy.setCardnum(card.getCardid());
				sqbuy.setSoldamount(0);
				sqbuy.setState(4);
				
				sqQuickBuyService.save(sqbuy);
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(sqgdb.getState() == 2) {
			sqgdb.setImgurl(sqbuy.getImgurl());
			sqgdb.setPaymoney(sqbuy.getPaymoney());
			sqgdb.setTitle(sqbuy.getTitle());
			sqgdb.setSubtitle(sqbuy.getSubtitle());
			sqgdb.setButtontext(sqbuy.getButtontext());
			sqgdb.setContent(sqbuy.getContent());
			float moneyint = Float.valueOf(paymoney)*100;
			sqbuy.setPaymoney((int)moneyint);
			
			sqgdb.setState(4);
			sqQuickBuyService.save(sqgdb);
		}else if(sqgdb.getState() == 3) {
			
		}else if(sqgdb.getState() == 4) {
			Integer soldamount = sqgdb.getSoldamount();
			if(soldamount == null || soldamount == 0) {
				Date starttime = new Date();
				Date endtime = new Date();
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					starttime = sdf.parse(startdate + " " + stime + ":00");
					endtime = sdf.parse(enddate + " " + etime + ":00");
					
					sqbuy.setStarttime(starttime);
					sqbuy.setEndtime(endtime);
					float moneyint = Float.valueOf(paymoney)*100;
					sqbuy.setPaymoney((int)moneyint);
					
					WXCard card = wXCardService.get(sqbuy.getCardid());
					sqbuy.setCardnum(card.getCardid());
					sqbuy.setSoldamount(0);
					sqbuy.setState(4);
					
					sqQuickBuyService.save(sqbuy);
					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				sqgdb.setImgurl(sqbuy.getImgurl());
				sqgdb.setPaymoney(sqbuy.getPaymoney());
				sqgdb.setTitle(sqbuy.getTitle());
				sqgdb.setSubtitle(sqbuy.getSubtitle());
				sqgdb.setButtontext(sqbuy.getButtontext());
				sqgdb.setContent(sqbuy.getContent());
				float moneyint = Float.valueOf(paymoney)*100;
				sqbuy.setPaymoney((int)moneyint);
				
				sqgdb.setState(4);
				sqQuickBuyService.save(sqgdb);
			}
		}else if(sqgdb.getState() == 5) {
			
		}
		
		model.addAttribute("acttab", "qianggou");
		
		return "advert/comadvert";
	}
	
	@RequestMapping(value="online/{id}")
	@ResponseBody
	public Map<String, Object> online(@PathVariable(value="id") Long id,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_QuickBuy sqg = sqQuickBuyService.get(id);
		Date starttime = sqg.getStarttime();
		Date endtime = sqg.getEndtime();
		Date now = new Date();
		
		Integer all = sqg.getAmount();
		Integer sold = sqg.getSoldamount();
		
		if(sold >= all) {
			map.put("result", "0");
			map.put("msg", "上线失败，活动商品已经售完");
			return map;
		}
		
		if(now.getTime() > endtime.getTime()) {
			map.put("result", "0");
			map.put("msg", "上线失败，活动已经结束");
			return map;
		}
		
		if(now.getTime() < starttime.getTime()) {
			sqg.setState(1);
			sqQuickBuyService.save(sqg);
			map.put("result", "1");
			map.put("msg", "上线成功，活动尚未开始");
			return map;
		}else{
			sqg.setState(2);
			sqQuickBuyService.save(sqg);
			map.put("result", "1");
			map.put("msg", "上线成功，活动进入进行状态");
			return map;
		}
		
	}
	
	@RequestMapping(value="offline/{id}")
	@ResponseBody
	public Map<String, Object> offline(@PathVariable(value="id") Long id,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_QuickBuy sqg = sqQuickBuyService.get(id);
		
		sqg.setState(4);
		sqQuickBuyService.save(sqg);
		map.put("result", "1");
		map.put("msg", "活动下线成功");
		return map;
		
	}
	
	@RequestMapping(value="deleteqg/{id}")
	@ResponseBody
	public Map<String, Object> deleteQG(@PathVariable(value="id") Long id,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		Sq_QuickBuy sqg = sqQuickBuyService.get(id);
		
		sqg.setPosition(null);
		sqQuickBuyService.save(sqg);
		map.put("result", "1");
		map.put("msg", "抢购活动删除成功");
		return map;
	}
	
	
}
 