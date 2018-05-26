package com.yjy.web.controller;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.yjy.entity.LoginInfo;
import com.yjy.entity.User;
import com.yjy.service.LoginInfoService;
import com.yjy.service.UserService;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，
 * 
 * 真正登录的POST请求由Filter完成,
 * 
 * @author calvin
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@Autowired
	private UserService userService;

	@Autowired
	private LoginInfoService loginInfoService;

	private Logger logger = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 用户登录
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:07:42
	 * @param username
	 * @param password
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST)
	public String login(String username, String password,
			HttpServletRequest request, String issave, Model model,
			HttpServletResponse response) {
		
		User user = userService.findByTelephone(username);
		if (user != null) {
			Integer enabled = user.getEnabled();
			if (enabled == 0) {
				model.addAttribute("message", "账号已被冻结!");
				return "account/login";
			}
			boolean flag = userService.decryptPassword(user, password);
			if (!flag) {
				model.addAttribute("message", "您输入的密码和账户不匹配,请重新输入!");
				return "account/login";
			}
			if (user.getRole() == null) {
				model.addAttribute("message", "暂时无权限登陆!");
				return "account/login";
			}
		} else {
			model.addAttribute("message", "您输入的账号不存在,请重新输入!");
			return "account/login";
		}
		if (issave != null) {
			Cookie ck = new Cookie("user", user.getId().toString());
			ck.setMaxAge(999999999);
			response.addCookie(ck);
		}

		String loginIp = request.getRemoteAddr();
		logger.error("用户" + user.getName() + "登陆的ip为    : " + loginIp);
		System.out.println("登陆的ip为    : " + loginIp);

		if (loginIp.equals("0:0:0:0:0:0:0:1")) {
			loginIp = "127.0.0.1";
		}

		LoginInfo logininfo = new LoginInfo();
		logininfo.setLoginip(loginIp);
		logininfo.setLogintime(new Date());
		logininfo.setName(user.getName());
		logininfo.setRealname(user.getRealname());
		logininfo.setRole(user.getRole());
		loginInfoService.save(logininfo);

		//
		// 登陆成功 user放入缓存
		HttpSession session = request.getSession();
		// session.setMaxInactiveInterval(60*5);
		session.setAttribute("user", user);
		session.removeAttribute("menuList");
		//

		return "redirect:/menu";
	}

	/**
	 * 用户登录的GET方法
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午1:26:03
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String login(HttpServletRequest request, Model model) {
		return "account/login";
	}

	@RequestMapping(value = "autologin")
	public String autoLogin(HttpServletRequest request,
			@RequestParam(value = "uid") Long uid) {
		User u = userService.get(uid);
		if (u != null) {
			{
				if (u.getEnabled() != 0) {
					System.out.println("自动登陆");
					request.getSession().setAttribute("user", u);
				}
			}
		}
		return "redirect:/menu";
	}

}
