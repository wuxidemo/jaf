package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

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
import com.yjy.entity.FinanceInfo;
import com.yjy.service.FinanceInfoService;
import com.yjy.utils.ImageUtil;

@Controller
@RequestMapping(value = "/financeinfo")
public class FinanceInfoController {
	
	@Autowired
	private FinanceInfoService financeInfoService;
	
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
		Page<FinanceInfo> finances = financeInfoService.getFinanceInfo(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("finances", finances);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		return "finance/financeinfoList";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String createForm(Model model) {
		
		model.addAttribute("finance", new FinanceInfo());
		model.addAttribute("action", "create");
		
		return "finance/financeinfoForm";
	}
	
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String create(@ModelAttribute(value="finance") FinanceInfo financeInfo,
			RedirectAttributes redirectAttributes) {
		
		financeInfo.setCreatetime(new Date());
		financeInfo.setUpdatetime(new Date());
		financeInfo.setPublishtime(null);
		financeInfo.setState(0);
		
		financeInfoService.save(financeInfo);
		
		redirectAttributes.addFlashAttribute("message", "添加信息成功！");
		
		return "redirect:/financeinfo/";
	}
	
	@RequestMapping(value="update/{id}", method=RequestMethod.GET)
	public String updateForm(@PathVariable(value="id") Long id,
			Model model) {
		
		FinanceInfo financeInfo = financeInfoService.get(id);
		
		model.addAttribute("finance", financeInfo);
		model.addAttribute("action", "update");
		
		return "finance/financeinfoForm";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(@ModelAttribute(value="finance") FinanceInfo financeInfo,
			RedirectAttributes redirectAttributes) {
		
		FinanceInfo fidb = financeInfoService.get(financeInfo.getId());
		
		fidb.setTitle(financeInfo.getTitle());
		fidb.setThumburl(financeInfo.getThumburl());
		fidb.setUrl(financeInfo.getUrl());
		fidb.setContent(financeInfo.getContent());
		
		financeInfoService.save(fidb);
		
		redirectAttributes.addFlashAttribute("message", "修改信息成功！");
		
		return "redirect:/financeinfo/";
	}
	
	@RequestMapping(value="view/{id}", method=RequestMethod.GET)
	public String viewForm(@PathVariable(value="id") Long id,
			Model model) {
		
		FinanceInfo financeInfo = financeInfoService.get(id);
		
		model.addAttribute("finance", financeInfo);
		model.addAttribute("action", "view");
		
		return "finance/financeinfoForm";
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String delete(@RequestParam(value="") String ids,
			RedirectAttributes redirectAttributes) {
		
		String[] idarr = ids.split(",");
		for(String id : idarr) {
			financeInfoService.delete(Long.valueOf(id));
		}
		
		redirectAttributes.addFlashAttribute("message", "删除信息成功！");
		
		return "redirect:/financeinfo/";
	}
	
	@RequestMapping(value="online/{id}", method=RequestMethod.GET)
	public String online(@PathVariable(value="id") Long id,
			RedirectAttributes redirectAttributes) {
		
		FinanceInfo financeInfo = financeInfoService.get(id);
		
		financeInfo.setState(1);
		financeInfo.setPublishtime(new Date());
		financeInfoService.save(financeInfo);
		
		redirectAttributes.addFlashAttribute("message", "信息发布成功！");
		
		return "redirect:/financeinfo/";
	}
	
	@RequestMapping(value="offline/{id}", method=RequestMethod.GET)
	public String offline(@PathVariable(value="id") Long id,
			RedirectAttributes redirectAttributes) {
		
		FinanceInfo financeInfo = financeInfoService.get(id);
		
		financeInfo.setState(0);
		financeInfoService.save(financeInfo);
		
		redirectAttributes.addFlashAttribute("message", "信息下线成功！");
		
		return "redirect:/financeinfo/";
	}
	
	
	
	@RequestMapping(value = "upfile")
	@ResponseBody
	public String upfile(HttpServletRequest request,
			@RequestParam(value = "fileToUploadintro", required = false) MultipartFile fileupload) {
		
		Date nowDate = new Date();
		int uuid = (int) (Math.random() * 10000);
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
	
}
