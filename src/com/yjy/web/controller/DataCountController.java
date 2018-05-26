package com.yjy.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "datacount")
public class DataCountController {

	@RequestMapping(value = "menucount")
	public String menuCount() {
		return "datacount/menucount";
	}
}
