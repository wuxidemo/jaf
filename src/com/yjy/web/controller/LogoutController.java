package com.yjy.web.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 类LogoutController.java的实现描述：用户账号退出系统调用的Controller
 * 
 * @author yigang 2015年4月20日 下午1:27:52
 */
@Controller
@RequestMapping(value = "/logout")
public class LogoutController {

	/**
	 * 用户退出
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:08:12
	 * @param request
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		// 从session里取的用户名信息
		session.removeAttribute("user");
		session.removeAttribute("menuList");
		session.invalidate();
		Cookie ck = new Cookie("user", null);
		ck.setMaxAge(0);
		response.addCookie(ck);
		return "account/login";
	}

	/**
	 * 账号退出系统时候的POST方法
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午1:28:16
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST)
	public String logout() {
		return "account/login";
	}
}
