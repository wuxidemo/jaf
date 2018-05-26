package com.yjy.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.yjy.entity.Article;
import com.yjy.entity.Merchant;
import com.yjy.service.ArticleService;
import com.yjy.service.MerchantService;

@Controller
@RequestMapping(value = "/show")
public class ShowMerchantsController {
	@Autowired
	private ArticleService articleService;

	@Autowired
	private MerchantService merchantService;

	@RequestMapping(method = RequestMethod.GET)
	public String getbianminwandian(@RequestParam(value = "id") Long id,
			Model model) {
		Article art = articleService.find(id);
		Merchant mer = null;
		if(art != null) {
			mer = art.getUser().getMerchant();
			model.addAttribute("art", art);
		}
		
		if(mer != null) {
			model.addAttribute("mer", mer);
		}
		
		return "template/showmerchants1";
	}
}
