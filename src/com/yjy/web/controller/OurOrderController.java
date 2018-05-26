package com.yjy.web.controller;

import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.entity.Merchant;
import com.yjy.entity.Order;
import com.yjy.entity.User;
import com.yjy.service.MerchantService;
import com.yjy.service.MyService;
import com.yjy.service.OrderService;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

/**
 * 类OurOrderController.java的实现描述：该类用来对Order进行增删改查操作
 * 
 * @author wutao 2015年6月26日 下午1:36:24
 */
@Controller
@RequestMapping(value = "/ourorder")
public class OurOrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private MyService myService;
	@Autowired
	private MerchantService merchantService;
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	String oderqrurl = "oderqrurl";

	/**
	 * 获取所有的Order记录，得到Order的列表，提供前端展示，以及查询服务。
	 * 
	 * @author wutao
	 * @date 2015年6月26日 下午1:37:32
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return 视图映射字符串，供视图解析器解析
	 */
	@RequestMapping()
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		User u = (User) request.getSession().getAttribute("user");

		if (u.getMerchant() != null) {
			searchParams.put("EQ_merchantid", u.getMerchant().getId() + "");
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
				Date date = null;
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
		if (searchParams.containsKey("EQ_merchantid")) {
			String merhchantname = (String) searchParams.get("EQ_merchantid");
			String merhchantnameTrim = merhchantname.trim();
			if (merhchantname == null || "".equals(merhchantnameTrim) || merhchantnameTrim.equals("null")
					|| merhchantnameTrim.equals("0")) {
				searchParams.remove("EQ_merchantid");
			} else {
				model.addAttribute("merhchantname", merhchantname);
			}
		}
		List<Merchant> merchants = merchantService.getAllMerchant();
		Page<Object[]> dvlist = orderService.getOrderData(searchParams, pageNumber, pageSize, sortType);
		for (Object[] o : dvlist.getContent()) {
			o[6] = (o[6] != null ? ((BigDecimal) o[6]).intValue() : 0);
			o[10] = (o[10] != null ? ((BigDecimal) o[10]).intValue() : 0);
		}

		model.addAttribute("dvs", dvlist);
		model.addAttribute("merhchantname", merchants);
		model.addAttribute("totalcount", myService.getOrderCountByParam(searchParams));
		model.addAttribute("maxprice", myService.getOrderSumPriceByParam(searchParams) / 100.0);
		model.addAttribute("maxpayprice", myService.getOrderSumPayPriceByParam(searchParams) / 100.0);
		model.addAttribute("cardcount", myService.getCardCountByorder(searchParams));
		model.addAttribute("cardbankprice", myService.getCardbankPriceByorder(searchParams) / 100.0);
		model.addAttribute("cardshopprice", myService.getCardshopPriceByorder(searchParams) / 100.0);
		if (searchParams.containsKey("LTE_paytime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();

			calendar.setTime((Date) searchParams.get("LTE_paytime"));

			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
			String str = sdf.format(calendar.getTime());
			searchParams.put("LTE_paytime", str);
		}
		// if (searchParams.containsKey("LTE_paytime")) {
		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// Date date = null;
		// try {
		// date = new SimpleDateFormat("yyyy-MM-dd")
		// .parse((String) searchParams.get("LTE_paytime"));
		// } catch (ParseException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// Calendar calendar = Calendar.getInstance();
		//
		// calendar.setTime(date);
		//
		// calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
		//
		// String str = sdf.format(calendar.getTime());
		// searchParams.put("LTE_paytime", str);
		// }
		if (searchParams.containsKey("GTE_paytime")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_paytime", sdf.format(searchParams.get("GTE_paytime")));
		}

		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		// String type = (String) searchParams.get("type");
		// if (type.equals("bank")) {
		// return "order/bankorder";
		// } else {
		return "order/ourorder";
	}

	@RequestMapping(value = "create")
	public String create() {
		return "order/create";
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
		or.setPayprice((int) (price * 100));
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

	/**
	 * 保存从Ourorder页面传递过来的State更新之后的数据
	 * 
	 * @author wutao
	 * @date 2015年6月26日 下午1:39:29
	 * @param order
	 * @param State
	 * @return
	 */
	@RequestMapping(value = "upState/{type}")
	public String update(@PathVariable("type") String type, @RequestParam(value = "ids") List<Long> ids,
			RedirectAttributes redirectAttributes) {

		// redirectAttributes.addFlashAttribute("message", "删除用户成功");

		for (Long id : ids) {

			Order order = orderService.get(id);
			order.setState(3);
			// order.setUpdatetime(new Date());
			orderService.update(order);
		}
		return "redirect:/ourorder";
	}
}