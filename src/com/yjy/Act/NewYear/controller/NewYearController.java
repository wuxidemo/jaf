package com.yjy.Act.NewYear.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Act.NewYear.entity.Like;
import com.yjy.Act.NewYear.entity.Product;
import com.yjy.Act.NewYear.entity.Redbag;
import com.yjy.Act.NewYear.entity.Vote;
import com.yjy.Act.NewYear.service.LikeService;
import com.yjy.Act.NewYear.service.ProductService;
import com.yjy.Act.NewYear.service.RedbagService;
import com.yjy.Act.NewYear.service.VoteService;
import com.yjy.entity.WXUser;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.Util;
import com.yjy.utils.wxytConfig;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/newyearact")
public class NewYearController {

	@Autowired
	WXUserService wXUserService;

	@Autowired
	private ProductService productService;
	@Autowired
	private VoteService voteService;

	@Autowired
	private LikeService likeService;

	@Autowired
	private RedbagService redbagService;
	@Autowired
	WeChatAccountService weChatAccountService;
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	public static int PROBABILITY = 20;

	@RequestMapping(method = RequestMethod.GET)
	public String main(Model model, HttpServletRequest request) {
		model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/newyearact/"));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		int state = voteService.getNewYearStage();
		if (state == 1) {
			Object openid = request.getSession().getAttribute("openid");
			if (openid == null) {
				return "redirect:/wxurl/redirect?url=newyearact/";
			}
			if (productService.findbyone(openid.toString()).get("result").toString().equals("1")) {
				return "newyear/mainedit";
			} else {
				return "newyear/main";
			}
		} else if (state == 2) {
			return "newyear/mainfx";
		} else if (state == 3) {
			return "newyear/maintp";
		} else if (state == 4) {
			return "newyear/mainwin";
		}
		return "newyear/main";
	}

	/**
	 * 根据openid判断用户是否关注了金阿福e服务公众号
	 * 
	 * @author yigang
	 * @date 2015年12月18日 下午2:29:47
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

	@RequestMapping(value = "teststart")
	public String showMask(Model model, HttpServletRequest request) {
		model.addAttribute("config",
				WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/newyearact/teststart"));
		model.addAttribute("baseurl", SysConfig.BASEURL);
		return "newyear/teststart";
	}

	/* =====================================参与活动and编辑个人信息=================== */

	/*
	 * 查找状态为复赛的作品
	 */
	@RequestMapping(value = "/find")
	@ResponseBody
	public List<Object> findbypro(@RequestParam(value = "collegestate") int collegestate, HttpServletRequest request) {
		List<Object> list = new ArrayList<Object>();
		Date a = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
		String date1 = dd.format(a);
		list = productService.findbyall(request.getSession().getAttribute("openid").toString(), date1, collegestate);
		return list; // request.getSession().getAttribute("openid").toString()
	}

	/* 数据过来保存 */
	@RequestMapping(value = "/cersave")
	@ResponseBody
	public Map<String, Object> getbysave(@Valid Product pro, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getNewYearStage();
		if (a == 1) {
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");

			} else {
				Product product = productService.findbyopenid(oid);
				if (product == null) {
					pro.setOpenid(oid);
					WXUser wxuser = wXUserService.getOrNewWXUser(oid);
					pro.setWxname(wxuser.getRealname());
					Date dt = new Date();
					pro.setCreatetime(dt);
					pro.setState(1);
					productService.save1(pro);
					map.put("result", "1");
					map.put("msg", "保存成功");
				} else {
					map.put("result", "2");
					map.put("msg", "请勿重复上传");
				}
			}
		} else {
			map.put("result", "2");
			map.put("msg", "当前活动状态不正确");
		}
		return map;
	}

	/* 数据的修改 */
	@RequestMapping(value = "update")
	@ResponseBody
	public Map<String, Object> updatefrom(HttpServletRequest request, Model model) {
		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getNewYearStage();
		Map<String, Object> map = new HashMap<String, Object>();
		if (a == 1) {
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");
				return map;
			} else {
				Product pro = productService.findbyopenid(oid);
				if (pro != null) {
					map.put("product", pro);
					map.put("result", "1");
				} else {

					map.put("result", "2");
					map.put("msg", "数据库中无记录");
					return map;
				}

			}
		} else {
			map.put("result", "2");
			map.put("msg", "当前活动状态不正确");
		}

		return map;
	}

	@RequestMapping(value = "/upsave")
	@ResponseBody
	public Map<String, Object> getupsave(@Valid Product pro, HttpServletRequest request) {
		String oid = (String) request.getSession().getAttribute("openid");
		Map<String, Object> map = new HashMap<String, Object>();
		int a = voteService.getNewYearStage();
		if (a == 1) {
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");
				return map;
			} else {
				Product product = productService.findbyopenid(oid);

				product.setName(pro.getName());
				product.setCollege(pro.getCollege());
				product.setTclass(pro.getTclass());
				product.setTelephone(pro.getTelephone());
				product.setTitle(pro.getTitle());
				product.setContext(pro.getContext());
				product.setUrl(pro.getUrl());
				productService.save1(product);
				map.put("result", "1");
			}
		} else {
			map.put("result", "2");
			map.put("msg", "当前活动状态不正确");
		}
		return map;
	}

	/* 点赞 */
	@RequestMapping(value = "/Thup")
	@ResponseBody
	public Map<String, Object> getbyth(@RequestParam(value = "productid") int productid,
			@RequestParam(value = "collegestate") int collegestate, Model model, HttpServletRequest request) {
		int a = voteService.getNewYearStage();
		Map<String, Object> map = new HashMap<String, Object>();
		Date d = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
		String date1 = dd.format(d);
		if (a == 3) {
			String oid = (String) request.getSession().getAttribute("openid");
			if (oid == null || oid == "") {
				map.put("result", "0");
				map.put("msg", "openid不存在");
				return map;
			} else {
				/* 判断当天 */
				List<Like> likelist = likeService.panduan(oid, productid, date1);
				/* 当天点击了多少次 */
				int daysum = likeService.findsum(oid, date1, collegestate);
				/* 判断总共点击了多少次 */
				int datesum = likeService.findbyzon(oid);

				if (daysum == 0) {
					int oneint = (int) ((Math.random()) * PROBABILITY + 1);
					if (oneint == 8) {
						WXUser wxuser = wXUserService.getOrNewWXUser(oid);
						Redbag redbag = new Redbag();
						redbag.setNickname(wxuser.getRealname());
						redbag.setOpenid(oid);
						redbag.setCreatetime(new Date());
						redbag.setProduct(productService.find((long) productid));

						int price = 100;
						Date now = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						String billno = WXManage.WCA.getMcid() + sdf.format(now)
								+ (now.getTime() + "").substring(2, 12);
						boolean sendresult = WXManage.sendPrize(WXManage.WCA, oid, price, "参与投票领取红包", "点击关注,获取更多优惠",
								"金阿福e服务", "金阿福e服务", "最美校园", billno);
						if (sendresult) {
							redbagService.save(redbag);
						}
					}
				}

				if (likelist != null && likelist.size() > 0) {
					map.put("result", "2");
					map.put("msg", "您已为他投过票！请把票投给其他人吧！");
					return map;
				}
				if (daysum < 3) {
					Like lik = new Like();
					lik.setOpenid(oid);
					Product pro = productService.find((long) productid);
					lik.setProcuct(pro);
					lik.setCreatetime(new Date());
					likeService.save1(lik);
					map.put("daysum", daysum + 1);
					map.put("datesum", datesum + 1);
					map.put("result", "1");
					map.put("msg", "保存成功");
				} else {
					map.put("result", "2");
					map.put("msg", "您今天的投票机会已用完，请明天再来！");

				}

			}
		} else {
			map.put("result", "2");
			map.put("msg", "投票已经结束");
		}
		return map;
	}

	/**
	 * 上传跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/jump")
	public String getjump(HttpServletRequest request, @RequestParam(value = "col") int col, Model model) {

		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getNewYearStage();
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=newyearact/";
		} else {
			WXUser wxsuer = wXUserService.getOrNewWXUser(oid);
			int sta = wxsuer.getState();
			if (sta == 1) {
				if (a == 1) {
					Product aa = productService.findbyopenid(oid);
					if (aa == null) {
						model.addAttribute("config", WXManage.getConfig(weChatAccountService.getJsapi_ticket(),
								"/newyearact/jump?col=" + col));
						model.addAttribute("col", col);
						return "newyear/personalinformation";
					} else {
						model.addAttribute("pro", aa);
						return "newyear/previewpersonalinformation";
					}
				} else {
					return "redirect:/wxurl/redirect?url=newyearact/";
				}
			} else {
				return "redirect:/wxurl/redirect?url=newyearact/";
			}
		}

	}

	@RequestMapping(value = "/editsc")
	public String editsc(HttpServletRequest request, Model model) {
		String oid = (String) request.getSession().getAttribute("openid");
		int a = voteService.getNewYearStage();
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=newyearact/";
		} else {
			WXUser wxsuer = wXUserService.getOrNewWXUser(oid);
			int sta = wxsuer.getState();
			if (sta == 1) {
				if (a == 1) {
					Product aa = productService.findbyopenid(oid);
					if (aa == null) {
						model.addAttribute("config",
								WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/newyearact/editsc"));
						return "newyear/personalinformation";
					} else {
						model.addAttribute("pro", aa);
						model.addAttribute("config",
								WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/newyearact/editsc"));
						return "newyear/editpersonalinformation";
					}
				} else {
					return "redirect:/wxurl/redirect?url=newyearact/";
				}
			} else {
				return "redirect:/wxurl/redirect?url=newyearact/";
			}
		}

	}

	/**
	 * 
	 * 投票跳转
	 * 
	 * @author lyf
	 * @date 2015年12月23日 上午9:58:40
	 * @param request
	 * @param col
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "vote")
	public String totoupiao(HttpServletRequest request, @RequestParam(value = "col") int col, Model model) {
		String oid = (String) request.getSession().getAttribute("openid");
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=newyearact/";
		} else {
			int sta = wXUserService.getOrNewWXUser(oid).getState();
			if (sta == 1) {
				if (voteService.getNewYearStage() == 3) {
					model.addAttribute("config",
							WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/newyearact/vote?col=" + col));
					model.addAttribute("baseurl", SysConfig.BASEURL);
					model.addAttribute("col", col);
					return "newyear/toupiao";
				} else {
					return "redirect:/wxurl/redirect?url=newyearact/";
				}
			} else {
				return "redirect:/wxurl/redirect?url=newyearact/";
			}
		}
	}

	@RequestMapping(value = "winresult")
	public String winresult(Model model, @RequestParam(value = "col") int col) {
		model.addAttribute("col", col);
		return "newyear/winresult";
	}

	@RequestMapping(value = "detail")
	public String detail(Model model, @RequestParam(value = "id") Long id, HttpServletRequest request) {
		String oid = (String) request.getSession().getAttribute("openid");
		if (oid == null || oid == "") {
			return "redirect:/wxurl/redirect?url=newyearact/";
		} else {
			Product p = productService.find(id);
			if (p == null) {
				return "redirect:/wxurl/redirect?url=newyearact/";
			} else {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				model.addAttribute("config",
						WXManage.getConfig(weChatAccountService.getJsapi_ticket(), "/newyearact/detail?id=" + id));
				model.addAttribute("iscount", likeService.panduan(oid, id.intValue(), sdf.format(new Date())).size());
				model.addAttribute("allcount", likeService.findliketh(id.intValue()));
				model.addAttribute("baseurl", SysConfig.BASEURL);
				model.addAttribute("p", p);
				return "newyear/xangqing";
			}
		}

	}

	/**
	 * 消赞
	 */
	/*
	 * @RequestMapping(value = "/nations")
	 * 
	 * @ResponseBody public Map<String, Object> getnations(@RequestParam(value =
	 * "productid") int productid, Model model, HttpServletRequest request) {
	 * 
	 * int a = voteService.getNewYearStage(); Map<String, Object> map = new
	 * HashMap<String, Object>(); if (a == 3) { String oid = (String)
	 * request.getSession().getAttribute("openid"); Boolean b =
	 * likeService.delete(oid, productid); if (b) { map.put("result", "1");
	 * map.put("msg", "删除成功"); } } else { map.put("result", "0"); map.put("msg",
	 * "不是当前活动状态"); }
	 * 
	 * return map; }
	 */

	@RequestMapping("/listpro")
	public String listPro(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_wxname")) {
			String wxname = ((String) searchParams.get("LIKE_wxname")).trim();
			if ("".equals(wxname) || "null".equals(wxname)) {
				searchParams.remove("LIKE_wxname");
			} else {
				searchParams.put("LIKE_wxname", wxname);
				model.addAttribute("LIKE_wxname", wxname);
			}
		}

		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime")).trim();
			if ("null".equals(startDate) || "".equals(startDate)) {
				searchParams.remove("GTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				searchParams.put("GTE_createtime", calendar.getTime());
				model.addAttribute("GTE_createtime", startDate);
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime")).trim();
			if ("null".equals(endDate) || "".equals(endDate)) {
				searchParams.remove("LTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_createtime", calendar.getTime());
				model.addAttribute("LTE_createtime", endDate);
			}
		}

		if (searchParams.containsKey("EQ_state")) {
			String state = ((String) searchParams.get("EQ_state")).trim();
			if ("".equals(state) || "null".equals(state) || "-1".equals(state)) {
				searchParams.remove("EQ_state");
			} else {
				searchParams.put("EQ_state", state);
				model.addAttribute("EQ_state", state);
			}
		}

		if (searchParams.containsKey("LIKE_name")) {
			String name = ((String) searchParams.get("LIKE_name")).trim();
			if ("".equals(name) || "null".equals(name)) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", name);
				model.addAttribute("LIKE_name", name);
			}
		}

		if (searchParams.containsKey("EQ_collegestate")) {
			String collegestate = ((String) searchParams.get("EQ_collegestate")).trim();
			if ("".equals(collegestate) || "null".equals(collegestate) || "-1".equals(collegestate)) {
				searchParams.remove("EQ_collegestate");
			} else {
				searchParams.put("EQ_collegestate", collegestate);
				model.addAttribute("EQ_collegestate", collegestate);
			}
		}
		Page<Object[]> productlist = productService.getProList(searchParams, pageNumber, pageSize, sortType);

		/* 查找参与活动人数 */
		int sum = productService.findbysum();
		model.addAttribute("cansum", sum);

		/* 查找参与活动的人数 */
		int likesum = likeService.getlikesum();
		model.addAttribute("likesum", likesum);

		int votestage = voteService.getNewYearStage();
		model.addAttribute("actstage", votestage);

		model.addAttribute("prolist", productlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "newyear/newlist";
	}

	/**************************************************** 江南大学 *****************************************************/
	@RequestMapping("/listjdpro")
	public String listJDPro(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_wxname")) {
			String wxname = ((String) searchParams.get("LIKE_wxname")).trim();
			if ("".equals(wxname) || "null".equals(wxname)) {
				searchParams.remove("LIKE_wxname");
			} else {
				searchParams.put("LIKE_wxname", wxname);
				model.addAttribute("LIKE_wxname", wxname);
			}
		}

		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime")).trim();
			if ("null".equals(startDate) || "".equals(startDate)) {
				searchParams.remove("GTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				searchParams.put("GTE_createtime", calendar.getTime());
				model.addAttribute("GTE_createtime", startDate);
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime")).trim();
			if ("null".equals(endDate) || "".equals(endDate)) {
				searchParams.remove("LTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_createtime", calendar.getTime());
				model.addAttribute("LTE_createtime", endDate);
			}
		}

		if (searchParams.containsKey("LIKE_name")) {
			String name = ((String) searchParams.get("LIKE_name")).trim();
			if ("".equals(name) || "null".equals(name)) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", name);
				model.addAttribute("LIKE_name", name);
			}
		}

		searchParams.put("EQ_collegestate", 1);

		Page<Object[]> productlist = productService.getJDProList(searchParams, pageNumber, pageSize, sortType);

		int votestage = voteService.getNewYearStage();
		model.addAttribute("actstage", votestage);

		model.addAttribute("prolist", productlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "newyear/newjdlist";
	}
	/**************************************************** 江南大学 *****************************************************/

	/**************************************************** 太湖学院 *****************************************************/
	@RequestMapping("/listthpro")
	public String listTHPro(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		if (searchParams.containsKey("LIKE_wxname")) {
			String wxname = ((String) searchParams.get("LIKE_wxname")).trim();
			if ("".equals(wxname) || "null".equals(wxname)) {
				searchParams.remove("LIKE_wxname");
			} else {
				searchParams.put("LIKE_wxname", wxname);
				model.addAttribute("LIKE_wxname", wxname);
			}
		}

		if (searchParams.containsKey("GTE_createtime")) {
			String startDate = ((String) searchParams.get("GTE_createtime")).trim();
			if ("null".equals(startDate) || "".equals(startDate)) {
				searchParams.remove("GTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				searchParams.put("GTE_createtime", calendar.getTime());
				model.addAttribute("GTE_createtime", startDate);
			}
		}

		if (searchParams.containsKey("LTE_createtime")) {
			String endDate = ((String) searchParams.get("LTE_createtime")).trim();
			if ("null".equals(endDate) || "".equals(endDate)) {
				searchParams.remove("LTE_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_createtime", calendar.getTime());
				model.addAttribute("LTE_createtime", endDate);
			}
		}

		if (searchParams.containsKey("LIKE_name")) {
			String name = ((String) searchParams.get("LIKE_name")).trim();
			if ("".equals(name) || "null".equals(name)) {
				searchParams.remove("LIKE_name");
			} else {
				searchParams.put("LIKE_name", name);
				model.addAttribute("LIKE_name", name);
			}
		}

		searchParams.put("EQ_collegestate", 0);

		Page<Object[]> productlist = productService.getTHProList(searchParams, pageNumber, pageSize, sortType);

		int votestage = voteService.getNewYearStage();
		model.addAttribute("actstage", votestage);

		model.addAttribute("prolist", productlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "newyear/newthlist";
	}
	/**************************************************** 太湖学院 *****************************************************/

	/****** 获取当前活动总体状态 ********/
	@RequestMapping(value = "getactstage", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getActStage() {
		Map<String, Object> map = new HashMap<String, Object>();

		int stage = voteService.getNewYearStage();

		map.put("result", "1");
		map.put("msg", "获取状态成功");
		map.put("actstage", stage);

		return map;
	}

	/* 点击进入复赛阶段 */
	@RequestMapping(value = "changestage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> changVoteStage(@RequestParam(value = "stage") int stage) {
		Map<String, Object> map = new HashMap<String, Object>();
		Vote vote = voteService.changeVoteStage();
		if (vote == null) {
			map.put("result", "0");
			map.put("msg", "数据库中找不到要修改的对象数据");
			return map;
		}

		if (stage == 3) {
			Product pro = null;
			List<Product> jdprolist = productService.findProductByStateAndCollege(2, 1);
			List<Product> thprolist = productService.findProductByStateAndCollege(2, 0);

			if (jdprolist != null && jdprolist.size() > 0) {
				for (int i = 0; i < jdprolist.size(); i++) {
					pro = jdprolist.get(i);
					pro.setSenumber(i + 1);
					productService.save1(pro);
				}
			}

			if (thprolist != null && thprolist.size() > 0) {
				for (int i = 0; i < thprolist.size(); i++) {
					pro = thprolist.get(i);
					pro.setSenumber(i + 1);
					productService.save1(pro);
				}
			}
		}

		if (stage == 4) {
			List<Object[]> jdwinner = productService.getTopThreeWinner(1);
			List<Object[]> thwinner = productService.getTopThreeWinner(0);

			if (jdwinner != null && jdwinner.size() > 0) {
				Product jdpro = null;
				for (int i = 0; i < jdwinner.size(); i++) {
					jdpro = productService.find(Long.valueOf(jdwinner.get(i)[0].toString()));
					if (i == 0) {
						jdpro.setState(3);
					} else if (i == 1 || i == 2) {
						jdpro.setState(4);
					} else if (i == 3 || i == 4 || i == 5) {
						jdpro.setState(5);
					}

					productService.save1(jdpro);
				}
			}

			if (thwinner != null && thwinner.size() > 0) {
				Product thpro = null;
				for (int j = 0; j < thwinner.size(); j++) {
					thpro = productService.find(Long.valueOf(thwinner.get(j)[0].toString()));

					if (j == 0) {
						thpro.setState(3);
					} else if (j == 1 || j == 2) {
						thpro.setState(4);
					} else if (j == 3 || j == 4 || j == 5) {
						thpro.setState(5);
					}

					productService.save1(thpro);
				}
			}
		}

		vote.setStage(stage);
		voteService.save(vote);

		map.put("result", "1");
		if (stage == 1) {
			map.put("msg", "活动状态更新成功，活动进入作品上传阶段");
		} else if (stage == 2) {
			map.put("msg", "活动状态更新成功，活动进入审核阶段");
		} else if (stage == 3) {
			map.put("msg", "活动状态更新成功，活动进入投票阶段");
		} else if (stage == 4) {
			map.put("msg", "活动状态更新成功，活动进入中奖阶段");
		}
		return map;
	}

	/* 处理删除请求 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = productService.delete(ids);
		if (result) {
			map.put("result", true);

		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}

	/* 更改个人的状态（入选） */
	@RequestMapping(value = "bechosen", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> beChoosen(@RequestParam(value = "proid") Long proid) {
		Map<String, Object> map = new HashMap<String, Object>();
		Product pro = productService.find(proid);
		if (pro != null) {
			pro.setState(2);
			productService.save1(pro);
			map.put("result", "1");
			map.put("msg", "入选成功");
		} else {
			map.put("result", "0");
			map.put("msg", "入选失败");
		}

		return map;
	}

	/* 更改个人的状态（入选） */
	@RequestMapping(value = "nobechosen", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noBeChoosen(@RequestParam(value = "proid") Long proid) {
		Map<String, Object> map = new HashMap<String, Object>();
		Product pro = productService.find(proid);
		if (pro != null) {
			pro.setState(1);
			productService.save1(pro);
			map.put("result", "1");
			map.put("msg", "取消复赛资格成功");
		} else {
			map.put("result", "0");
			map.put("msg", "取消复赛资格失败");
		}

		return map;
	}

	/* 取消个人的状态（取消） */
	@RequestMapping(value = "mycancel", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findmyca(@RequestParam(value = "id") Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Product pro = productService.find(id);
		if (pro != null) {
			pro.setState(1);
			productService.save1(pro);
			map.put("result", true);
			map.put("msg", "取消成功");
		} else {
			map.put("result", false);
			map.put("msg", "取消出错");
		}

		return map;
	}

	/*** 获奖名单列表 ****/
	@RequestMapping(value = "getwinlist")
	@ResponseBody
	public Map<String, Object> getWinList(@RequestParam(value = "collegestate") Integer college) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> objlist = likeService.getWinList(college);
		if (objlist != null && objlist.size() > 0) {
			for (Object[] obj : objlist) {
				if (obj[11] == null) {
					obj[11] = 0;
				}
			}
			map.put("result", "1");
			map.put("msg", "获取数据成功");
			map.put("data", objlist);
		} else {
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}

		return map;
	}

	/****** 红包发放记录 **********/
	@RequestMapping("/redbagwin")
	public String redBagWin(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = searchParams.get(key).toString();
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}

		if (searchParams.containsKey("EQ_createtime")) {
			String startDate = ((String) searchParams.get("EQ_createtime")).trim();
			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("EQ_createtime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				searchParams.put("EQ_createtime", date);
			}
		}

		if (searchParams.containsKey("LIKE_nickname")) {
			String name = ((String) searchParams.get("LIKE_nickname")).trim();
			if ("".equals(name) || "null".equals(name)) {
				searchParams.remove("LIKE_nickname");
			} else {
				searchParams.put("LIKE_nickname", name);
			}
		}

		Page<Redbag> redbags = redbagService.getList(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("redbags", redbags);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "newyear/redbagwinlist";
	}

	@RequestMapping(value = "saveimg")
	@ResponseBody
	public String saveimg(@RequestParam(value = "sid") String sid) {
		String downurl = null;
		String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + WXManage.WCA.getAccesstoken()
				+ "&media_id=" + sid;
		String baespath = Util.getRootPath() + File.separator + "tmpimgforact" + File.separator;
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
}
