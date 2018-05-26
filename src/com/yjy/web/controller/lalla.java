package com.yjy.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value="/ds")
public class lalla {
   
public String create() {
   return "staticpage/mypage";
}
	
}
