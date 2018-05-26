package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Activity;
import com.yjy.entity.FatherChildActivity;
import com.yjy.entity.User;
import com.yjy.service.ActivityService;
import com.yjy.service.FatherChildActivityService;
import com.yjy.utils.ImageUtil;

@Controller
@RequestMapping(value = "/activity")
public class ActivityController {
	
	@Autowired
	private ActivityService activityService;
	
	@Autowired
	private FatherChildActivityService fatherChildActivityService;
	
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	private String getIndex(
			@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType,
			Model model, ServletRequest request) {
		
		Map<String, Object> searchParams = new HashMap<String, Object>();
		Page<Activity> activitys = activityService.getActivity(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("activitys", activitys);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		return "activity/activityList";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String createForm(Model model) {
		
		return "activity/activityForm";
	}
	
	@RequestMapping(value="urlcreate", method=RequestMethod.POST)
	public String urlCreate(@RequestParam(value="imgurl") String imgurl, 
			@RequestParam(value="imgthumbnailurl") String imgthumbnailurl, 
			@RequestParam(value="type") String type, 
			@RequestParam(value="starttime") String starttime, 
			@RequestParam(value="endtime") String endtime, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="subtitle") String subtitle, 
			@RequestParam(value="url") String url, 
			@RequestParam(value="reporturl") String reporturl, 
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		User user = (User) request.getSession().getAttribute("user");
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(starttime);
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("message", "系统错误保存失败，请稍后重试");
			return "redirect:/activity/";
			
		}
		
		Activity act = new Activity();
		act.setUrl(url);
		act.setReporturl(reporturl);
		act.setCreatetime(new Date());
		act.setImgurl(imgurl);
		act.setImgthumbnailurl(imgthumbnailurl);
		act.setStarttime(startDate);
		act.setEndtime(endDate);
		act.setTitle(title);
		act.setSubtitle(subtitle);
		act.setType(type);
		act.setUser(user);
		act.setState(0);

		activityService.save(act);
		
		redirectAttributes.addFlashAttribute("message", "创建活动成功");
		
		return "redirect:/activity/";
	}
	
	@RequestMapping(value="tuwencreate", method=RequestMethod.POST)
	public String tuwenCreate(@RequestParam(value="imgurl") String imgurl, 
			@RequestParam(value="imgthumbnailurl") String imgthumbnailurl, 
			@RequestParam(value="type") String type, 
			@RequestParam(value="starttime") String starttime, 
			@RequestParam(value="endtime") String endtime, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="subtitle") String subtitle, 
			@RequestParam(value="content") String content, 
			@RequestParam(value="reporturl") String reporturl, 
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		User user = (User) request.getSession().getAttribute("user");
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(starttime);
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("message", "系统错误保存失败，请稍后重试");
			return "redirect:/activity/";
			
		}
		
		Activity act = new Activity();
		act.setCreatetime(new Date());
		act.setImgurl(imgurl);
		act.setImgthumbnailurl(imgthumbnailurl);
		act.setStarttime(startDate);
		act.setEndtime(endDate);
		act.setType(type);
		act.setUser(user);
		act.setState(0);
		act.setTitle(title);
		act.setSubtitle(subtitle);
		act.setReporturl(reporturl);
		act.setContent(content);

		activityService.save(act);
		
		redirectAttributes.addFlashAttribute("message", "创建活动成功");
		
		return "redirect:/activity/";
	}
	
	@RequestMapping(value="mubancreate", method=RequestMethod.POST)
	public String mobanCreate(@RequestParam(value="imgurl") String imgurl, 
			@RequestParam(value="imgthumbnailurl") String imgthumbnailurl, 
			@RequestParam(value="type") String type, 
			@RequestParam(value="subtype") Integer subtype, 
			@RequestParam(value="starttime") String starttime, 
			@RequestParam(value="endtime") String endtime, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="subtitle") String subtitle, 
			@RequestParam(value="url") String url, 
			@RequestParam(value="payprice") String payprice, 
			@RequestParam(value="rebateprice") String rebateprice, 
			@RequestParam(value="tmpnum") Integer tmpnum, 
			@RequestParam(value="reporturl") String reporturl, 
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		User user = (User) request.getSession().getAttribute("user");
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(starttime);
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("message", "系统错误保存失败，请稍后重试");
			return "redirect:/activity/";
			
		}
		
		Activity act = new Activity();
		act.setCreatetime(new Date());
		act.setImgurl(imgurl);
		act.setImgthumbnailurl(imgthumbnailurl);
		act.setStarttime(startDate);
		act.setEndtime(endDate);
		act.setType(type);
		act.setSubtype(subtype);
		act.setUser(user);
		act.setState(0);
		act.setTitle(title);
		act.setSubtitle(subtitle);
		act.setUrl(url);
		
		Float pf = Float.valueOf(payprice)*100;
		Integer pfInt = pf.intValue();
		act.setPayprice(pfInt);
		
		Float rpf = Float.valueOf(rebateprice)*100;
		Integer rpfInt = rpf.intValue();
		act.setRebateprice(rpfInt);
		
		act.setTmpnum(tmpnum);
		act.setReporturl(reporturl);

		activityService.save(act);
		
		redirectAttributes.addFlashAttribute("message", "创建模板活动成功");
		
		return "redirect:/activity/";
	}
	
	@RequestMapping(value="update/{id}", method=RequestMethod.GET)
	public String updateForm(@PathVariable(value="id") Long id, Model model) {
		
		Activity act = activityService.get(id);
		
		Integer pfInt = act.getPayprice();
		Integer rpfInt = act.getRebateprice();
		if(pfInt != null) {
			int zhengshupf = pfInt/100;
			int yushupf = pfInt-zhengshupf*100;
			model.addAttribute("payprice", zhengshupf + "." + yushupf);
			
			int zhengshurpf = rpfInt/100;
			int yushurpf = rpfInt-zhengshurpf*100;
			model.addAttribute("rebateprice", zhengshurpf + "." + yushurpf);
		}
		
		model.addAttribute("activity", act);
		
		String type = act.getType();
		if(type.equals("muban")) {
			return "activity/mubanupdate";
		}else if(type.equals("url")) {
			return "activity/urlupdate";
		}else if(type.equals("tuwen")){
			return "activity/tuwenupdate";
		}else{
			return null;
		}
	}
	
	
	@RequestMapping(value="urlupdate", method=RequestMethod.POST)
	public String urlUpdate(
			@RequestParam(value="id") Long id, 
			@RequestParam(value="imgurl") String imgurl, 
			@RequestParam(value="imgthumbnailurl") String imgthumbnailurl, 
			@RequestParam(value="starttime") String starttime, 
			@RequestParam(value="endtime") String endtime, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="subtitle") String subtitle, 
			@RequestParam(value="url") String url, 
			@RequestParam(value="reporturl") String reporturl, 
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		Activity act = activityService.get(id);
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(starttime);
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("message", "系统错误保存失败，请稍后重试");
			return "redirect:/activity/";
			
		}
		
		act.setUrl(url);
		act.setImgurl(imgurl);
		act.setImgthumbnailurl(imgthumbnailurl);
		act.setStarttime(startDate);
		act.setEndtime(endDate);
		act.setTitle(title);
		act.setSubtitle(subtitle);
		act.setReporturl(reporturl);
		act.setUpdatetime(new Date());
		/*act.setState(0);*/

		activityService.save(act);
		
		redirectAttributes.addFlashAttribute("message", "修改活动成功");
		
		return "redirect:/activity/";
	}
	
	@RequestMapping(value="tuwenupdate", method=RequestMethod.POST)
	public String tuwenUpdate(
			@RequestParam(value="id") Long id, 
			@RequestParam(value="imgurl") String imgurl, 
			@RequestParam(value="imgthumbnailurl") String imgthumbnailurl, 
			@RequestParam(value="starttime") String starttime, 
			@RequestParam(value="endtime") String endtime, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="subtitle") String subtitle, 
			@RequestParam(value="reporturl") String reporturl, 
			@RequestParam(value="content") String content, 
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		Activity act = activityService.get(id);
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(starttime);
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("message", "系统错误保存失败，请稍后重试");
			return "redirect:/activity/";
			
		}
		
		act.setImgurl(imgurl);
		act.setImgthumbnailurl(imgthumbnailurl);
		act.setStarttime(startDate);
		act.setEndtime(endDate);
		/*act.setState(0);*/
		act.setTitle(title);
		act.setSubtitle(subtitle);
		act.setReporturl(reporturl);
		act.setContent(content);
		act.setUpdatetime(new Date());

		activityService.save(act);
		
		redirectAttributes.addFlashAttribute("message", "修改活动成功");
		
		return "redirect:/activity/";
	}
	
	@RequestMapping(value="mubanupdate", method=RequestMethod.POST)
	public String mubanUpdate(
			@RequestParam(value="id") Long id, 
			@RequestParam(value="imgurl") String imgurl, 
			@RequestParam(value="imgthumbnailurl") String imgthumbnailurl, 
			@RequestParam(value="starttime") String starttime, 
			@RequestParam(value="endtime") String endtime, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="subtitle") String subtitle, 
			@RequestParam(value="url") String url, 
			@RequestParam(value="payprice") String payprice, 
			@RequestParam(value="rebateprice") String rebateprice, 
			@RequestParam(value="tmpnum") Integer tmpnum, 
			@RequestParam(value="reporturl") String reporturl, 
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		Activity act = activityService.get(id);
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(starttime);
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("message", "系统错误保存失败，请稍后重试");
			return "redirect:/activity/";
			
		}
		
		act.setCreatetime(new Date());
		act.setImgurl(imgurl);
		act.setImgthumbnailurl(imgthumbnailurl);
		act.setStarttime(startDate);
		act.setEndtime(endDate);
		/*act.setState(0);*/
		act.setTitle(title);
		act.setSubtitle(subtitle);
		act.setUrl(url);
		Float pf = Float.valueOf(payprice)*100;
		Integer pfInt = pf.intValue();
		act.setPayprice(pfInt);
		
		Float rpf = Float.valueOf(rebateprice)*100;
		Integer rpfInt = rpf.intValue();
		act.setRebateprice(rpfInt);
		act.setTmpnum(tmpnum);
		act.setReporturl(reporturl);

		activityService.save(act);
		
		redirectAttributes.addFlashAttribute("message", "修改活动成功");
		
		return "redirect:/activity/";
	}
	
	@RequestMapping(value="view/{id}", method=RequestMethod.GET)
	public String view(@PathVariable(value="id") Long id, Model model) {
		
		Activity act = activityService.get(id);
		Integer pfInt = act.getPayprice();
		Integer rpfInt = act.getRebateprice();
		if(pfInt != null) {
			int zhengshupf = pfInt/100;
			int yushupf = pfInt-zhengshupf*100;
			model.addAttribute("payprice", zhengshupf + "." + yushupf);
			
			int zhengshurpf = rpfInt/100;
			int yushurpf = rpfInt-zhengshurpf*100;
			model.addAttribute("rebateprice", zhengshurpf + "." + yushurpf);
		}
		
		model.addAttribute("activity", act);
		model.addAttribute("action", "view");
		
		String type = act.getType();
		if(type.equals("muban")) {
			return "activity/mubanupdate";
		}else if(type.equals("url")) {
			return "activity/urlupdate";
		}else if(type.equals("tuwen")){
			return "activity/tuwenupdate";
		}else{
			return null;
		}
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String delete(@RequestParam(value="delstr") String delstr,
			RedirectAttributes redirectAttributes) {
		
		String[] strarr = delstr.split(",");
		
		for(String str : strarr) {
			List<FatherChildActivity> fcalist = fatherChildActivityService.findByChildid(Long.valueOf(str));
			if(fcalist != null && fcalist.size() > 0) {
				for(FatherChildActivity fca : fcalist) {
					fatherChildActivityService.delete(fca.getId());
				}
			}
			activityService.delete(Long.valueOf(str));
		}
		
		redirectAttributes.addFlashAttribute("message", "删除活动成功");
		
		return "redirect:/activity/";
		
	}
	
	@RequestMapping(value="ongoing/{id}", method=RequestMethod.GET)
	public String onGoing(@PathVariable(value="id") Long id, Model model,
			RedirectAttributes redirectAttributes) {
		Activity act = activityService.get(id);
		Date nowdate = new Date();
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(act.getEndtime());
		calendar.add(Calendar.HOUR, +24);
		if (calendar.getTime().after(nowdate)) {
			if (nowdate.before(act.getStarttime())) {
				act.setState(3);
				activityService.save(act);
				redirectAttributes.addFlashAttribute("message", "上线成功");
				return "redirect:/activity/";
			} else {
				act.setState(1);
				activityService.save(act);
				redirectAttributes.addFlashAttribute("message", "上线成功");
				return "redirect:/activity/";
			}

		} else {
			redirectAttributes.addFlashAttribute("message", "上线失败，活动截止日期已过");
			return "redirect:/activity/";
		}
		
		
	}
	
	@RequestMapping(value="offgoing/{id}", method=RequestMethod.GET)
	public String offGoing(@PathVariable(value="id") Long id, Model model,
			RedirectAttributes redirectAttributes) {
		Activity act = activityService.get(id);
		act.setState(2);
		activityService.save(act);
		redirectAttributes.addFlashAttribute("message", "下线成功");
		return "redirect:/activity/";
	}
	
	@RequestMapping(value = "upfile")
	@ResponseBody
	public String upfile(HttpServletRequest request,
			@RequestParam(value = "type") String type,
			@RequestParam(value = "fileToUpload", required = false) MultipartFile file,
			@RequestParam(value = "fileToUploadTwo", required = false) MultipartFile filetwo,
			@RequestParam(value = "fileToUploadThree", required = false) MultipartFile filethree) {
		
		Date nowDate = new Date();
		int uuid = (int) (Math.random() * 10000);
		MultipartFile fileupload = null;
		if(type.equals("url")) {
			fileupload = file;
		}else if(type.equals("tuwen")){
			fileupload = filetwo;
		}else if(type.equals("muban")){
			fileupload = filethree;
		}
		int width=300;
		int height=200;
		int filewidth, fileheight; // 文件实际宽高
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String pbasepath = request.getSession().getServletContext().getRealPath("/");
		String mybasepath = pbasepath + File.separator + "upload" + File.separator + "picture" + File.separator + sdf.format(nowDate);
		File imgpath = new File(mybasepath + File.separator + "original");
		File thimgpath = new File(mybasepath + File.separator + "thumbnail");
		if (!imgpath.exists()) {
			imgpath.mkdirs();
		}
		if (!thimgpath.exists()) {
			thimgpath.mkdirs();
		}
		String fileoritype = ".jpg";
		try {
			String filename = fileupload.getOriginalFilename();
			fileoritype = filename.substring(filename.lastIndexOf("."));
			String filetype = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
			if (filetype.equals("PNG") || filetype.equals("JPG")) {
				String newpath = imgpath.getPath() + File.separator + nowDate.getTime() + uuid + fileoritype;
				fileupload.transferTo(new File(newpath));
				BufferedImage src = ImageIO.read(new File(newpath));
				filewidth = src.getWidth();
				fileheight = src.getHeight();
				ImageUtil.changeToSize(newpath, thimgpath.getPath() + File.separator + nowDate.getTime() + uuid + fileoritype, width, height, filetype);
				
			}  else {
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return "{'path':'" + "upload/picture/" + sdf.format(nowDate)
				+ "/original/" + nowDate.getTime() + uuid + fileoritype
				+ "','thumbnail':'" + "upload/picture/" + sdf.format(nowDate)
				+ "/thumbnail/" + nowDate.getTime() + uuid + fileoritype
				+ "','result':'1','width':'" + filewidth + "','height':'"
				+ fileheight + "','twidth':'"+width+"','theight':'"+height+"'}";
		
	}
	
	@RequestMapping(value="getallactivity")
	@ResponseBody
	public Map<String, Object> getAllAct() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Activity> actlist = activityService.getAllActivity();
		if(actlist != null && actlist.size() > 0) {
			map.put("result", "1");
			map.put("data", actlist);
		}else{
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}
	
}
