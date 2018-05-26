package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
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
import com.yjy.entity.Article;
import com.yjy.entity.User;
import com.yjy.service.ArticleService;
import com.yjy.utils.ImageUtil;
import com.yjy.utils.Util;

@Controller
@RequestMapping(value = "/art")
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getvolunteers(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams = Util.changeEncoding(searchParams);
		if (searchParams.containsKey("LIKE_title")) {
			String real = (String) searchParams.get("LIKE_title");
			if (real == null || "".equals(real.trim())) {
				searchParams.remove("LIKE_title");
			}
		}
		
		User user = (User)request.getSession().getAttribute("user");
		searchParams.put("EQ_user.id", user.getId());

		Page<Article> articles = articleService.getList(searchParams,
				pageNumber, pageSize, sortType);
		model.addAttribute("articles", articles);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "shake/addactivitypagelist";
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	private String getatt(Model model) {

		model.addAttribute("article", new Article());
		model.addAttribute("action", "create");

		return "shake/addactivitypage";
	}

	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(Model model,
			@ModelAttribute(value = "article") Article article,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		User user = (User)request.getSession().getAttribute("user");
		article.setCreatetime(new Date());
		article.setUser(user);
		Article art = articleService.save(article);
		
		String httpUrl = "http://" + request.getLocalAddr() + ":"
				+ request.getLocalPort() + request.getContextPath() + "/";
		
		art.setUrl(httpUrl + "wxpage/actpage/" + art.getId());
		
		articleService.save(art);
		
		System.out.println(article);
		return "redirect:/art";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = articleService.delete(ids);
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
	 * 活动图片上传
	 * 
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
		int width = 290, height = 204; // z设置缩放文件的高度
		int filewidth, fileheight; // 文件的实际宽高

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String pbasepath = request.getSession().getServletContext()
				.getRealPath("/");// 获取到文件的根路径

		String mybasepath = pbasepath + File.separator + "upload"
				+ File.separator + "picture" + File.separator + sdf.format(now);
		File imgpath = new File(mybasepath + File.separator + "original");// 原图

		File thimgpath = new File(mybasepath + File.separator + "thumbnail"); // 缩略图

		if (!imgpath.exists()) {
			imgpath.mkdirs();
		}
		if (!thimgpath.exists()) {
			thimgpath.mkdirs();
		}

		try {
			String filename = file.getOriginalFilename();
			String filetype = filename.substring(filename.lastIndexOf(".") + 1)
					.toUpperCase();

			// 验证后缀名
			if (filetype.equals("PNG") || filetype.equals("JPG")) {
				String newpath = imgpath.getPath() + File.separator
						+ now.getTime() + uid + ".jpg";
				file.transferTo(new File(newpath));
				BufferedImage src = ImageIO.read(new File(newpath));
				ImageUtil.changeToSize(newpath, thimgpath.getPath()
						+ File.separator + now.getTime() + uid + ".jpg", width,
						height, "jpg");

				filewidth = src.getWidth();
				fileheight = src.getHeight();

			} else {
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return "{'path':'" + "upload/picture/" + sdf.format(now) + "/original/"
				+ now.getTime() + uid + ".jpg" + "','thumbnail':'"
				+ "upload/picture/" + sdf.format(now) + "/thumbnail/"
				+ now.getTime() + uid + ".jpg" + "','result':'1','width':'"
				+ filewidth + "','height':'" + fileheight + "','twidth':'"
				+ width + "','theight':'" + height + "'}";

	}

	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateform(@PathVariable("id") Long id, Model model) {
		/* Volunteers volunteers=volunteersService.find(id); */
		model.addAttribute("article", articleService.find(id));
		model.addAttribute("action", "update");

		return "shake/addactivitypage";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String create2(Model model,
			@ModelAttribute(value = "article") Article article,
			RedirectAttributes redirectAttributes) {
		
		Article art = articleService.find(article.getId());
				
				
		article.setUpdatetime(new Date());
		article.setUser(art.getUser());
		article.setCreatetime(art.getCreatetime());
		article.setUrl(art.getUrl());
		
		articleService.save(article);

		return "redirect:/art";
	}
	
	@RequestMapping(value="selecturl") 
	public String selectUrl(Model model,HttpServletRequest request){
		
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams = Util.changeEncoding(searchParams);
		User user = (User)request.getSession().getAttribute("user");
		
		List<Article> artList = null; 
		
		if(user != null) {
			artList = articleService.getArticleListByCreatorid(user.getId());
		}
		
		if(artList != null && artList.size() > 0) {
			model.addAttribute("artList", artList);
		}

		return "shake/selecturlpage";
		
	}
}
