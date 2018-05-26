package com.yjy.web.controller;

import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.entity.Order;
import com.yjy.entity.User;
import com.yjy.entity.WXCard;
import com.yjy.entity.WXCardRecord;
import com.yjy.service.MyService;
import com.yjy.service.OrderService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WXCardService;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private MyService myService;
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	@Autowired
	WXCardService wXCardService;
	@Autowired
	WXCardRecordService wXCardRecordService;

	static {
		sortTypes.put("auto", "自动");
	}

	String oderqrurl = "oderqrurl";

	@RequestMapping()
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "paytime") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		User u = (User) request.getSession().getAttribute("user");

		if (u.getMerchant() != null) {
			searchParams.put("EQ_merchantid", u.getMerchant().getId() + "");
		} else {// 非商户 或者商户账号 还未绑定商家时
			searchParams.put("EQ_merchantid", "-1");
		}
		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}
		if (searchParams.containsKey("LIKE_wxcode")) {
			String wxcode = (String) searchParams.get("LIKE_wxcode");
			String wxcodeTrim = wxcode.trim();
			if (wxcode == null || "".equals(wxcodeTrim) || "null".equals(wxcodeTrim)) {
				searchParams.remove("LIKE_wxcode");
			} else {
				model.addAttribute("wxcode", wxcode);
			}
		}

		if (searchParams.containsKey("LIKE_code")) {
			String code = (String) searchParams.get("LIKE_code");
			String codeTrim = code.trim();
			if (code == null || "".equals(codeTrim) || "null".equals(codeTrim)) {
				searchParams.remove("LIKE_code");
			} else {
				model.addAttribute("code", code);
			}
		}

		if (searchParams.containsKey("GTE_paytime")) {
			String startDate = ((String) searchParams.get("GTE_paytime")).trim();

			if (startDate.equals("null") || startDate.equals("")) {
				searchParams.remove("GTE_paytime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				searchParams.put("GTE_paytime", date);
			}
		}

		if (searchParams.containsKey("LTE_paytime")) {
			String endDate = ((String) searchParams.get("LTE_paytime")).trim();

			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_paytime");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_paytime", calendar.getTime());
			}
		}
		if (searchParams.containsKey("EQ_state")) {
			String state = (String) searchParams.get("EQ_state");
			String stateTrim = state.trim();
			if (state == null || "".equals(stateTrim) || stateTrim.equals("null") || stateTrim.equals("4")) {
				searchParams.remove("EQ_state");
			} else {
				model.addAttribute("state", state);
			}
		}

		Page<Object[]> dvlist = orderService.getOrderData(searchParams, pageNumber, pageSize, sortType);
		for (Object[] o : dvlist.getContent()) {
			o[6] = (o[6] != null ? ((BigDecimal) o[6]).intValue() : 0);
			o[10] = (o[10] != null ? ((BigDecimal) o[10]).intValue() : 0);
		}
		model.addAttribute("dvs", dvlist);
		model.addAttribute("totalcount", myService.getOrderCountByParam(searchParams));
		model.addAttribute("maxprice", myService.getOrderSumPriceByParam(searchParams) / 100.0);
		model.addAttribute("maxpayprice", myService.getOrderSumPayPriceByParam(searchParams) / 100.0);
		model.addAttribute("cardcount", myService.getCardCountByorder(searchParams));
		model.addAttribute("cardbankprice", myService.getCardbankPriceByorder(searchParams) / 100.0);

		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		// String type = (String) searchParams.get("type");
		// if (type.equals("bank")) {
		// return "order/bankorder";
		// } else {
		return "order/order";
	}

	@RequestMapping(value = "create")
	public String create() {
		return "order/create";
	}

	@RequestMapping(value = "createwithcard")
	public String createwithcard() {
		return "order/createwithcard";
	}

	@RequestMapping(value = "getpaycode")
	@ResponseBody
	public Map<String, String> getPayCode(@RequestParam(value = "price") Float price, HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		User u = (User) request.getSession().getAttribute("user");
		if (u == null) {
			result.put("result", "0");
			return result;
		}
		if (u.getMerchant() == null) {
			result.put("result", "0");
			return result;
		}
		Order or = new Order();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String daystr = sdf.format(now);
		or.setCreatetime(now);
		or.setState(0);
		or.setPrice((int) (price * 100));
		or.setPayprice(0);
		or.setCode(now.getTime() + Util.getRandomString(10));
		or.setMerchantid(u.getMerchant().getId());
		or.setMerhchantname(u.getMerchant().getName());
		orderService.update(or);
		request.getSession().setAttribute("mycode", or.getCode());
		WXManage.CodeState.put(or.getCode(), "0");
		String url = "";
		String baseurl = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
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
			File f = new File(Util.getRootPath() + File.separator + oderqrurl + File.separator + daystr + File.separator
					+ d.getTime() + ".png");
			MatrixToImageWriter.writeToFile(bitMatrix, "png", f);
			url = oderqrurl + "/" + daystr + "/" + d.getTime() + ".png";
			result.put("result", "1");
			result.put("url", baseurl + "/" + url);
		} catch (Exception e) {
			result.put("result", "0");
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "getpaycodecard")
	@ResponseBody
	public Map<String, String> getPayCodeCard(@RequestParam(value = "price") Float price,
			@RequestParam(value = "codes", required = false) List<String> codes, HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		User u = (User) request.getSession().getAttribute("user");
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
		if (codes != null) {
			for (String code : codes) {
				Map<String, Object> data = wXCardService.checkCard(code, u.getMerchant().getWxlocationid().toString());
				if (data.get("result").toString().equals("0")) {
					result.put("result", "0");
					result.put("msg", data.get("msg").toString());
					return result;
				} else {
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

		or.setCreatetime(now);
		or.setPrice((int) (price * 100));
		or.setPayprice(0);
		or.setCode(now.getTime() + Util.getRandomString(10));
		or.setMerchantid(u.getMerchant().getId());
		or.setMerhchantname(u.getMerchant().getName());
		if (payprice == 0) { // 当支付金额为0时 不需要支付
			or.setState(1);
			or.setPaytime(new Date());
			or.setPayprice(0);
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
			or.setNeedprice(payprice);
		}
		or = orderService.update(or);
		if (codes != null) {
			for (String code : codes) {
				wXCardRecordService.updateUseState(u.getMerchant().getId(), u.getMerchant().getName(), or.getId(),
						or.getCode(), code);
			}
		}
		if (payprice == 0) {
			wXCardRecordService.updateState(2, new Date(), or.getId());
		}
		request.getSession().setAttribute("mycode", or.getCode());
		if (payprice == 0) {
			result.put("result", "1");
		} else {
			WXManage.CodeState.put(or.getCode(), "0");
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

	@RequestMapping(value = "checkcard")
	@ResponseBody
	public Map<String, Object> checkcard(@RequestParam(value = "code") String code, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		User u = (User) request.getSession().getAttribute("user");
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

	@RequestMapping(value = "detail")
	@ResponseBody
	public Map<String, Object> getDetail(@RequestParam(value = "id") Long id) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("order", orderService.get(id));
		data.put("cards", wXCardRecordService.getWXCardRecordByOrderid(id));
		return data;
	}
}
