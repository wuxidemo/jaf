package com.yjy.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Business;
import com.yjy.entity.User;
import com.yjy.service.BusinessService;
import com.yjy.service.RebateForFirstService;
import com.yjy.utils.Util;

/**
 * 类CategoryController.java的实现描述： 操作商圈
 * 
 * @author zhangmengmeng 2015-3-28 下午3:21:10
 */
@Controller
@RequestMapping(value = "/rff")
public class RebateForFirstController {

	@Autowired
	private RebateForFirstService rebateForFirstService;

}
