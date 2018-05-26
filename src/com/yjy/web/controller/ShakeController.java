package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yjy.entity.Article;
import com.yjy.entity.Merchant;
import com.yjy.entity.MerchantDevice;
import com.yjy.entity.User;
import com.yjy.service.ArticleService;
import com.yjy.service.MerchantDeviceService;
import com.yjy.service.MerchantService;
import com.yjy.service.UserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.SocketUtil;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/shake")
public class ShakeController {

	@Autowired
	private MerchantService merchantService;

	@Autowired
	private MerchantDeviceService merchantDeviceService;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private UserService userService;

	@Autowired
	WeChatAccountService weChatAccountService;

	@RequestMapping(value = "pagelist")
	public String pageList(Model model) {

		String ak = weChatAccountService.getAccesstoken();

		String param = "{\"begin\":0,\"count\":50,\"type\":2}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);

		String count = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jocount = new JSONObject(dataStr);
			count = jocount.getString("total_count");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("count", count);

		return "shake/pageList";

	}

	@RequestMapping(value = "getpagelist")
	@ResponseBody
	public String getPageList(@RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
			@RequestParam(value = "pageIndex", defaultValue = "1") int pageIndex, Model model) {

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"begin\":" + (pageIndex - 1) * pageSize + ",\"count\":" + pageSize + ",\"type\":2}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);

		String pagedata = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("pages");

			pagedata = pagestr;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return pagedata;

	}

	@RequestMapping(value = "addpage")
	public String addPage(Model model) {

		model.addAttribute("action", "createpage");

		return "shake/addpage";
	}

	@RequestMapping(value = "createpage")
	public String createPage(@RequestParam(value = "title") String title,
			@RequestParam(value = "description") String description, @RequestParam(value = "comment") String comment,
			@RequestParam(value = "page_url") String page_url, @RequestParam(value = "imgurl") String imgurl,
			@RequestParam(value = "token", required = false) String token, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

		String ak = WXManage.WCA.getAccesstoken();

		// String filePath = "E:\\ad3.jpg";
		String filePath = imgurl;
		String sendUrl = "https://api.weixin.qq.com/shakearound/material/add?access_token=" + ak;
		String uploadimg = null;
		String dataurl = null;
		String icon_url = null;
		try {
			uploadimg = send(sendUrl, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			JSONObject jodata = new JSONObject(uploadimg);
			dataurl = jodata.getString("data");

			JSONObject jopic = new JSONObject(dataurl);
			icon_url = jopic.getString("pic_url");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String param = "{\"title\":\"" + title + "\"," + "\"description\":\"" + description + "\"," + "\"page_url\":\""
				+ page_url + "\"," + "\"comment\":\"" + comment + "\"," + "\"icon_url\":\"" + icon_url + "\"}";

		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/add?access_token=" + ak, param);

		if (result.contains("success")) {
			redirectAttributes.addFlashAttribute("message", "新增页面成功！");
		} else {
			redirectAttributes.addFlashAttribute("message", "新增页面失败！");
		}

		if (token != null) {
			return "redirect:/shake/msidepagelist";
		}

		return "redirect:/shake/pagelist/";

	}

	@RequestMapping(value = "updatepage")
	public String updatePage(@RequestParam(value = "pageid") String pageid, Model model) {
		String ak = WXManage.WCA.getAccesstoken();
		String param = "{\"page_ids\":[" + pageid + "],\"type\":1}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);
		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("pages");

			JSONObject contentstr = new JSONObject(pagestr.substring(1, pagestr.length() - 1));
			String title = contentstr.getString("title");

			String description = contentstr.getString("description");
			String comment = contentstr.getString("comment");
			String page_url = contentstr.getString("page_url");
			String icon_url = contentstr.getString("icon_url");

			model.addAttribute("title", title);
			model.addAttribute("description", description);
			model.addAttribute("comment", comment);
			model.addAttribute("page_url", page_url);
			model.addAttribute("icon_url", icon_url);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		model.addAttribute("pageid", pageid);
		model.addAttribute("action", "saveupdatepage");
		return "shake/addpage";
	}

	@RequestMapping(value = "saveupdatepage")
	public String savaUpdatePage(@RequestParam(value = "title") String title,
			@RequestParam(value = "description") String description, @RequestParam(value = "comment") String comment,
			@RequestParam(value = "page_url") String page_url, @RequestParam(value = "imgurl") String imgurl,
			@RequestParam(value = "pageid") String pageid,
			@RequestParam(value = "token", required = false) String token, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		String ak = WXManage.WCA.getAccesstoken();
		String filePath = imgurl;
		String sendUrl = "https://api.weixin.qq.com/shakearound/material/add?access_token=" + ak;

		String uploadimg = null;
		String dataurl = null;
		String icon_url = null;
		if (imgurl.contains("wxmedia")) {

			try {
				uploadimg = send(sendUrl, filePath);
			} catch (IOException e) {
				e.printStackTrace();
			}

			try {
				JSONObject jodata = new JSONObject(uploadimg);
				dataurl = jodata.getString("data");

				JSONObject jopic = new JSONObject(dataurl);
				icon_url = jopic.getString("pic_url");

			} catch (JSONException e) {
				e.printStackTrace();
			}
		} else {
			icon_url = imgurl;
		}
		String param = "{\"page_id\":" + pageid + "," + "\"title\":\"" + title + "\"," + "\"description\":\""
				+ description + "\"," + "\"page_url\":\"" + page_url + "\"," + "\"comment\":\"" + comment + "\","
				+ "\"icon_url\":\"" + icon_url + "\"}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/update?access_token=" + ak,
				param);

		if (result.contains("success")) {
			redirectAttributes.addFlashAttribute("message", "修改页面成功！");
		} else {
			redirectAttributes.addFlashAttribute("message", "修改页面失败！");
		}

		if (token != null) {
			return "redirect:/shake/msidepagelist";
		}

		return "redirect:/shake/pagelist";
	}

	@RequestMapping(value = "viewpage")
	public String viewPage(@RequestParam(value = "pageid") String pageid, Model model) {
		String ak = WXManage.WCA.getAccesstoken();
		String param = "{\"page_ids\":[" + pageid + "],\"type\":1}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);
		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("pages");

			JSONObject contentstr = new JSONObject(pagestr.substring(1, pagestr.length() - 1));
			String title = contentstr.getString("title");

			String page_id = contentstr.getString("page_id");
			String description = contentstr.getString("description");
			String comment = contentstr.getString("comment");
			String page_url = contentstr.getString("page_url");
			String icon_url = contentstr.getString("icon_url");

			model.addAttribute("page_id", page_id);
			model.addAttribute("title", title);
			model.addAttribute("description", description);
			model.addAttribute("comment", title);
			model.addAttribute("page_url", page_url);
			model.addAttribute("icon_url", icon_url);

			if (comment == null || comment.trim().equals("")) {
				model.addAttribute("mername", "未找到商户名称，可能是由微信后台用户手动添加！");
				return "shake/viewpage";
			}

			String userid = comment.substring(1, comment.length() - 1);

			User user = null;
			try {
				user = userService.get(Long.valueOf(userid));
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				model.addAttribute("mername", "未找到商户名称，可能是由微信后台用户手动添加！");
				return "shake/viewpage";
			}

			Merchant mer = null;

			if (user != null) {
				mer = user.getMerchant();
			}

			if (mer != null) {
				model.addAttribute("mername", mer.getName());
			} else {
				model.addAttribute("mername", "未找到商户名称，可能是由微信后台用户手动添加！");
			}

		} catch (JSONException e) {
			e.printStackTrace();
		}
		return "shake/viewpage";
	}

	@RequestMapping(value = "/viewactivitydetail")
	public String viewActDetail(@RequestParam(value = "artid") Long artid, Model model) {
		Article art = articleService.find(artid);
		model.addAttribute("content", art.getContent());
		return "shake/viewartdetail";
	}

	@RequestMapping(value = "deletepage")
	public String delPage(@RequestParam(value = "idstr") String idstr, @RequestParam(value = "token") String token,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"page_ids\":[" + idstr + "]}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/delete?access_token=" + ak,
				param);

		if (result.contains("success")) {

			redirectAttributes.addFlashAttribute("message", "删除页面成功！");
		} else {
			redirectAttributes.addFlashAttribute("message", "删除页面失败！");
		}

		if (token != null) {
			return "redirect:/shake/msidepagelist";
		}

		return "redirect:/shake/pagelist";
	}

	public String send(String url, String filePath) throws IOException {

		String result = null;

		String baseUrl = null;
		String dirpath = null;
		try {
			baseUrl = Util.class.getResource("").toURI().getPath();
			baseUrl = baseUrl.substring(0, baseUrl.indexOf("WEB-INF"));
			dirpath = baseUrl + filePath;
		} catch (URISyntaxException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		File file = new File(dirpath);

		if (!file.exists() || !file.isFile()) {
			throw new IOException("文件不存在");
		}

		/**
		 * 第一部分
		 */
		URL urlObj = new URL(url);
		// 连接
		HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();

		/**
		 * 设置关键值
		 */
		con.setRequestMethod("POST"); // 以Post方式提交表单，默认get方式
		con.setDoInput(true);
		con.setDoOutput(true);
		con.setUseCaches(false); // post方式不能使用缓存

		// 设置请求头信息
		con.setRequestProperty("Connection", "Keep-Alive");
		con.setRequestProperty("Charset", "UTF-8");

		// 设置边界
		String BOUNDARY = "----------" + System.currentTimeMillis();
		con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

		// 请求正文信息

		// 第一部分：
		StringBuilder sb = new StringBuilder();
		sb.append("--"); // 必须多两道线
		sb.append(BOUNDARY);
		sb.append("\r\n");
		sb.append("Content-Disposition: form-data;name=\"file\";filename=\"" + file.getName() + "\"\r\n");
		sb.append("Content-Type:application/octet-stream\r\n\r\n");

		byte[] head = sb.toString().getBytes("utf-8");

		// 获得输出流
		OutputStream out = new DataOutputStream(con.getOutputStream());
		// 输出表头
		out.write(head);

		// 文件正文部分
		// 把文件已流文件的方式 推入到url中
		DataInputStream in = new DataInputStream(new FileInputStream(file));
		int bytes = 0;
		byte[] bufferOut = new byte[1024];
		while ((bytes = in.read(bufferOut)) != -1) {
			out.write(bufferOut, 0, bytes);
		}
		in.close();

		// 结尾部分
		byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线

		out.write(foot);

		out.flush();
		out.close();

		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = null;
		try {
			// 定义BufferedReader输入流来读取URL的响应
			reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				// System.out.println(line);
				buffer.append(line);
			}
			if (result == null) {
				result = buffer.toString();
			}
		} catch (IOException e) {

			System.out.println("发送POST请求出现异常！" + e);
			e.printStackTrace();
			throw new IOException("数据读取异常");
		} finally {
			if (reader != null) {
				reader.close();
			}

		}

		return result;
	}

	@RequestMapping(value = "upfile")
	@ResponseBody
	public String upfile(HttpServletRequest request,
			@RequestParam(value = "fileToUpload", required = false) MultipartFile file) {
		int uuid = (int) (Math.random() * 1000);
		int fwidth;
		int fheight;
		Date nowdate = new Date();
		String pbasepath = request.getSession().getServletContext().getRealPath("/");
		String mybasepath = pbasepath + File.separator + "wxmedia";
		File appfilepath = new File(mybasepath);
		if (!appfilepath.exists()) {
			appfilepath.mkdirs();
		}
		String path = "";
		try {
			String filename = file.getOriginalFilename();
			String type = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
			String mediaformat = filename.substring(filename.lastIndexOf("."));

			if (type.equalsIgnoreCase("JPG") || type.equalsIgnoreCase("JPEG") || type.equalsIgnoreCase("PNG")
					|| type.equalsIgnoreCase("GIF")) {
				String newpath = appfilepath.getPath() + File.separator + uuid + nowdate.getTime() + mediaformat;
				file.transferTo(new File(newpath));
				BufferedImage src = ImageIO.read(new File(newpath));
				fwidth = src.getWidth();
				fheight = src.getHeight();
				path = "wxmedia/" + uuid + nowdate.getTime() + mediaformat;
			} else {
				System.out.println("文件格式不正确");
				return "{'format':'wrong','result':'0'}";
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
		return "{'path':'" + path + "','result':'1','fwidth':'" + fwidth + "','fheight':'" + fheight + "'}";
	}

	@RequestMapping(value = "devicelist")
	public String deviceList(@RequestParam(value = "mername", required = false) String mername, Model model) {

		if (mername == null) {
			model.addAttribute("mername", null);
		} else {
			model.addAttribute("mername", mername.trim());
		}

		/*
		 * if(mername != null) { mername = Util.formatUTFString(mername.trim());
		 * }
		 */

		String ak = weChatAccountService.getAccesstoken();

		String param = "{\"begin\":0,\"count\":10,\"type\":2}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak,
				param);
		String count = null;
		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jocunt = new JSONObject(dataStr);
			count = jocunt.getString("total_count");

		} catch (JSONException e) {
			e.printStackTrace();
		}

		model.addAttribute("count", count);

		List<MerchantDevice> merdevList = merchantDeviceService.getAllMerchantDevice(mername);

		if (merdevList != null && merdevList.size() > 0) {
			StringBuilder jsonstr = new StringBuilder();
			jsonstr.append("[");
			for (MerchantDevice md : merdevList) {
				jsonstr.append("{\"deviceid\"" + ":" + "\"" + md.getDeviceid() + "\",\"mername\"" + ":" + "\""
						+ md.getMerchant().getName() + "\" },");
			}
			jsonstr.delete(jsonstr.length() - 1, jsonstr.length());
			jsonstr.append("]");

			model.addAttribute("merdevList", jsonstr);

		}

		return "shake/deviceList";
	}

	@RequestMapping(value = "getdevicelist")
	@ResponseBody
	public String getDeviceceList(@RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
			@RequestParam(value = "pageIndex", defaultValue = "1") int pageIndex,
			@RequestParam(value = "mername", required = false) String mername, Model model) {

		String ak = WXManage.WCA.getAccesstoken();

		if (mername == null || mername.trim().equals("")) {
			String param = "{\"begin\":" + (pageIndex - 1) * pageSize + ",\"count\":" + pageSize + ",\"type\":2}";
			String result = SocketUtil
					.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak, param);

			String devicedata = null;
			try {
				JSONObject jodata = new JSONObject(result);
				String dataStr = jodata.getString("data");
				JSONObject jodevices = new JSONObject(dataStr);
				String devicestr = jodevices.getString("devices");
				devicedata = devicestr;
			} catch (JSONException e) {
				// TODO: handle exception
			}

			return devicedata;
		} else {

			String param = "{\"begin\":0,\"count\":50,\"type\":2}";
			String result = SocketUtil
					.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak, param);

			String count = null;

			try {
				JSONObject jodata = new JSONObject(result);
				String dataStr = jodata.getString("data");

				JSONObject jocount = new JSONObject(dataStr);
				count = jocount.getString("total_count");

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			int intCount = Integer.valueOf(count);

			int times = intCount / 50;

			int remain = intCount % 50;

			String pagedata = "";

			String param1 = null;

			String result1 = null;

			for (int i = 1; i <= times; i++) {

				param1 = "{\"begin\":" + (i - 1) * 50 + ",\"count\":50,\"type\":2}";
				result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak,
						param1);

				try {
					JSONObject jodata = new JSONObject(result1);
					String dataStr = jodata.getString("data");

					JSONObject jopages = new JSONObject(dataStr);
					String pagestr = jopages.getString("devices");

					pagedata += pagestr.substring(1, pagestr.length() - 1) + ",";

				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			param1 = "{\"begin\":" + times * 50 + ",\"count\":" + remain + ",\"type\":2}";
			result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak,
					param1);

			try {
				JSONObject jodata = new JSONObject(result1);
				String dataStr = jodata.getString("data");

				JSONObject jopages = new JSONObject(dataStr);
				String pagestr = jopages.getString("devices");

				pagedata += pagestr.substring(1, pagestr.length() - 1);

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String datastr = "[" + pagedata + "]";

			return datastr;

			/*
			 * String param = "{\"begin\":" + (pageIndex - 1) * pageSize +
			 * ",\"count\":" + pageSize + "}"; String result =
			 * SocketUtil.sendPost(
			 * "https://api.weixin.qq.com/shakearound/device/search?access_token="
			 * + ak, param); System.out.println(result);
			 * 
			 * String devicedata = null; try { JSONObject jodata = new
			 * JSONObject(result); String dataStr = jodata.getString("data");
			 * JSONObject jodevices = new JSONObject(dataStr); String devicestr
			 * = jodevices.getString("devices"); devicedata = devicestr; } catch
			 * (JSONException e) { // TODO: handle exception }
			 * System.out.println("++++" + devicedata); return devicedata;
			 */
		}

	}

	@RequestMapping(value = "bindmerchant", method = RequestMethod.GET)
	public String bindMerchant(@RequestParam(value = "deviceid") String deviceid, Model model) {

		List<Merchant> merchantList = merchantService.getAllMerchant();

		model.addAttribute("merchantList", merchantList);
		model.addAttribute("deviceid", deviceid);
		model.addAttribute("action", "savebindmerchant");
		model.addAttribute("merchantdevice", new MerchantDevice());

		return "shake/bindMerchant";

	}

	@RequestMapping(value = "savebindmerchant", method = RequestMethod.POST)
	public String saveBindMerchant(@ModelAttribute(value = "merchantdevice") MerchantDevice merchantDevice,
			Model model) {

		merchantDeviceService.save(merchantDevice);

		return "redirect:/shake/devicelist/";

	}

	@RequestMapping(value = "unbindmerchant", method = RequestMethod.GET)
	public String unBindMerchant(@RequestParam(value = "deviceid") String deviceid, Model model) {

		List<MerchantDevice> mdList = merchantDeviceService.getMerchantDeviceListByDeviceid(deviceid);

		MerchantDevice md = mdList.get(0);

		if (md != null) {
			merchantDeviceService.delete(md.getId());
		}

		return "redirect:/shake/devicelist/";

	}

	@RequestMapping(value = "msidedevicelist")
	public String merchantSideDeviceList(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		Merchant merchant = user.getMerchant();

		List<MerchantDevice> merdevList = null;

		if (merchant != null) {
			merdevList = merchantDeviceService.getMerchantDeviceListByMerchantid(merchant.getId());
		}

		if (merdevList != null && merdevList.size() > 0) {
			StringBuilder jsonstr = new StringBuilder();
			jsonstr.append("[");
			for (MerchantDevice md : merdevList) {
				jsonstr.append("{\"deviceid\"" + ":" + "\"" + md.getDeviceid() + "\",\"mername\"" + ":" + "\""
						+ md.getMerchant().getName() + "\" },");
			}
			jsonstr.delete(jsonstr.length() - 1, jsonstr.length());
			jsonstr.append("]");

			model.addAttribute("merdevList", jsonstr);

		}

		return "shake/msidedeviceList";
	}

	@RequestMapping(value = "getmsidedevicelist")
	@ResponseBody
	public String getMsideDeviceceList(Model model, HttpServletRequest request) {

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"begin\":0,\"count\":50,\"type\":2}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak,
				param);

		String count = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jocount = new JSONObject(dataStr);
			count = jocount.getString("total_count");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int intCount = Integer.valueOf(count);

		int times = intCount / 50;

		int remain = intCount % 50;

		String pagedata = "";

		String param1 = null;

		String result1 = null;

		for (int i = 1; i <= times; i++) {

			param1 = "{\"begin\":" + (i - 1) * 50 + ",\"count\":50,\"type\":2}";
			result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak,
					param1);

			try {
				JSONObject jodata = new JSONObject(result1);
				String dataStr = jodata.getString("data");

				JSONObject jopages = new JSONObject(dataStr);
				String pagestr = jopages.getString("devices");

				pagedata += pagestr.substring(1, pagestr.length() - 1) + ",";

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		param1 = "{\"begin\":" + times * 50 + ",\"count\":" + remain + ",\"type\":2}";
		result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/search?access_token=" + ak, param1);

		try {
			JSONObject jodata = new JSONObject(result1);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("devices");

			pagedata += pagestr.substring(1, pagestr.length() - 1);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String datastr = "[" + pagedata + "]";

		return datastr;

	}

	@RequestMapping(value = "msidepagelist")
	public String merchantSidePageList(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");

		model.addAttribute("pagecomment", "=" + user.getId() + "=");

		return "shake/msidepageList";

	}

	@RequestMapping(value = "getmsidepagelist")
	@ResponseBody
	public String getMerchantSidePageList(Model model) {

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"begin\":0,\"count\":50,\"type\":2}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);

		String count = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jocount = new JSONObject(dataStr);
			count = jocount.getString("total_count");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int intCount = Integer.valueOf(count);

		int times = intCount / 50;

		int remain = intCount % 50;

		String pagedata = "";

		String param1 = null;

		String result1 = null;

		for (int i = 1; i <= times; i++) {

			param1 = "{\"begin\":" + (i - 1) * 50 + ",\"count\":50,\"type\":2}";
			result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
					param1);

			try {
				JSONObject jodata = new JSONObject(result1);
				String dataStr = jodata.getString("data");

				JSONObject jopages = new JSONObject(dataStr);
				String pagestr = jopages.getString("pages");

				pagedata += pagestr.substring(1, pagestr.length() - 1) + ",";

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		param1 = "{\"begin\":" + times * 50 + ",\"count\":" + remain + ",\"type\":2}";
		result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak, param1);

		try {
			JSONObject jodata = new JSONObject(result1);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("pages");

			pagedata += pagestr.substring(1, pagestr.length() - 1);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String datastr = "[" + pagedata + "]";

		return datastr;

	}

	@RequestMapping(value = "addmsidepage")
	public String addMsidePage(Model model, HttpServletRequest request) {

		model.addAttribute("action", "createpage");

		/*
		 * String httpUrl = "http://" + request.getLocalAddr() + ":" +
		 * request.getLocalPort() + request.getContextPath() + "/";
		 */

		User user = (User) request.getSession().getAttribute("user");

		Merchant mer = user.getMerchant();

		model.addAttribute("mertitle", mer.getName() + "详情介绍");

		model.addAttribute("linkurl", SysConfig.BASEURL + "/wxpage/merdetail?id=" + mer.getId() + "&wechat_card_js=1");

		model.addAttribute("viewurl", SysConfig.BASEURL + "/wxpage/merdetail?id=" + mer.getId() + "&token=noshake");

		List<Article> artList = null;

		if (user != null) {
			artList = articleService.getArticleListByCreatorid(user.getId());
		}

		if (artList != null && artList.size() > 0) {
			model.addAttribute("artList", artList);
		}

		model.addAttribute("comment", "=" + user.getId() + "=");

		return "shake/msidecreatepage";
	}

	@RequestMapping(value = "updatemsidepage")
	public String updateMsidePage(@RequestParam(value = "pageid") String pageid, Model model,
			HttpServletRequest request) {
		String ak = WXManage.WCA.getAccesstoken();
		String param = "{\"page_ids\":[" + pageid + "],\"type\":1}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);
		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("pages");

			JSONObject contentstr = new JSONObject(pagestr.substring(1, pagestr.length() - 1));
			String title = contentstr.getString("title");

			String description = contentstr.getString("description");
			String comment = contentstr.getString("comment");
			String page_url = contentstr.getString("page_url");
			String icon_url = contentstr.getString("icon_url");

			model.addAttribute("title", title);
			model.addAttribute("description", description);
			model.addAttribute("comment", comment);
			model.addAttribute("page_url", page_url);
			model.addAttribute("icon_url", icon_url);
		} catch (JSONException e) {
			e.printStackTrace();
		}

		model.addAttribute("pageid", pageid);
		model.addAttribute("action", "saveupdatepage");

		/*
		 * String httpUrl = "http://" + request.getLocalAddr() + ":" +
		 * request.getLocalPort() + request.getContextPath() + "/";
		 */

		User user = (User) request.getSession().getAttribute("user");

		Merchant mer = user.getMerchant();

		model.addAttribute("mertitle", mer.getName() + "详情介绍");

		model.addAttribute("linkurl", SysConfig.BASEURL + "/wxpage/merdetail?id=" + mer.getId() + "&wechat_card_js=1");

		model.addAttribute("viewurl", SysConfig.BASEURL + "/wxpage/merdetail?id=" + mer.getId() + "&token=noshake");

		List<Article> artList = null;

		if (user != null) {
			artList = articleService.getArticleListByCreatorid(user.getId());
		}

		if (artList != null && artList.size() > 0) {
			model.addAttribute("artList", artList);
		}

		return "shake/msidecreatepage";
	}

	@RequestMapping(value = "msidebinddevice")
	public String mSideBindDevice(@RequestParam(value = "deviceid") String deviceid,
			@RequestParam(value = "uuid") String uuid, @RequestParam(value = "major") String major,
			@RequestParam(value = "minor") String minor, Model model, HttpServletRequest request) {

		model.addAttribute("deviceid", deviceid);
		model.addAttribute("uuid", uuid);
		model.addAttribute("major", major);
		model.addAttribute("minor", minor);

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"type\": 1,\"device_identifier\": {\"device_id\": " + deviceid + ",\"uuid\": \"" + uuid
				+ "\",\"major\": " + major + ",\"minor\": " + minor + "}}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/relation/search?access_token=" + ak,
				param);

		String relstr = "";

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jocount = new JSONObject(dataStr);
			relstr = jocount.getString("relations");

			JSONArray ja = new JSONArray(relstr);

			StringBuilder pageids = new StringBuilder();

			for (int i = 0; i < ja.length(); i++) {
				JSONObject jsonone = ja.getJSONObject(i);
				pageids.append("," + jsonone.get("page_id"));
			}

			if (pageids.length() > 0) {
				model.addAttribute("page_ids", pageids.substring(1));
			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		User user = (User) request.getSession().getAttribute("user");

		model.addAttribute("pagecomment", "=" + user.getId() + "=");

		return "shake/msidebinddevice";

	}

	@RequestMapping(value = "getmsidepagelistforbind")
	@ResponseBody
	public String getPageListForBind(@RequestParam(value = "hello") String hello, HttpServletRequest request) {

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"begin\":0,\"count\":50,\"type\":2}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
				param);

		String count = null;

		try {
			JSONObject jodata = new JSONObject(result);
			String dataStr = jodata.getString("data");

			JSONObject jocount = new JSONObject(dataStr);
			count = jocount.getString("total_count");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int intCount = Integer.valueOf(count);

		int times = intCount / 50;

		int remain = intCount % 50;

		String pagedata = "";

		String param1 = null;

		String result1 = null;

		for (int i = 1; i <= times; i++) {

			param1 = "{\"begin\":" + (i - 1) * 50 + ",\"count\":50,\"type\":2}";
			result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak,
					param1);

			try {
				JSONObject jodata = new JSONObject(result1);
				String dataStr = jodata.getString("data");

				JSONObject jopages = new JSONObject(dataStr);
				String pagestr = jopages.getString("pages");

				pagedata += pagestr.substring(1, pagestr.length() - 1) + ",";

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		param1 = "{\"begin\":" + times * 50 + ",\"count\":" + remain + ",\"type\":2}";
		result1 = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/page/search?access_token=" + ak, param1);

		try {
			JSONObject jodata = new JSONObject(result1);
			String dataStr = jodata.getString("data");

			JSONObject jopages = new JSONObject(dataStr);
			String pagestr = jopages.getString("pages");

			pagedata += pagestr.substring(1, pagestr.length() - 1);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String datastr = "[" + pagedata + "]";

		return datastr;

	}

	@RequestMapping(value = "savemsidebind")
	public String saveBind(@RequestParam(value = "idstr") String idstr,
			@RequestParam(value = "deviceid") String deviceid, @RequestParam(value = "uuid") String uuid,
			@RequestParam(value = "major") String major, @RequestParam(value = "minor") String minor,
			@RequestParam(value = "page_ids") String page_ids, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

		String ak = WXManage.WCA.getAccesstoken();

		String param = "{\"device_identifier\":" + "{\"device_id\":" + deviceid + ",\"uuid\":\"" + uuid
				+ "\",\"major\":" + major + ",\"minor\":" + minor + "},\"page_ids\":[" + idstr + "]}";
		String result = SocketUtil.sendPost("https://api.weixin.qq.com/shakearound/device/bindpage?access_token=" + ak,
				param);

		if (result.contains("success")) {
			redirectAttributes.addFlashAttribute("message", "关联页面成功！");
		} else {
			redirectAttributes.addFlashAttribute("message", "关联页面失败！");
		}

		return "redirect:/shake/msidedevicelist/";

	}

	@RequestMapping(value = "createactivitypage")
	public String createActivityPage(Model model) {

		return "shake/addactivitypage";

	}

}
