package com.yjy.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yjy.entity.User;
import com.yjy.utils.Util;

public class RequestFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		// 从session里取的用户名信息
		User user = (User) session.getAttribute("user");
		String uri = req.getRequestURI();

		// WebApplicationContext wac =
		// WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());

		// UserService us = (UserService) wac.getBean("userService");

		// System.out.println(uri);
		// String controllerUrl = uri.substring(5);
		// System.out.println(controllerUrl);
		// 判断如果没有取到用户信息,就跳转到登陆页面
		/*
		 * if (!isExcludePages(uri) && user == null) { // 跳转到登陆页面
		 * res.sendRedirect(req.getContextPath() + "/login"); } else { //
		 * 已经登陆,继续此次请求 chain.doFilter(request, response); }
		 */

		if (!isExcludePages(uri) && user == null) {

			// 判断自动登录
			if (req.getCookies() != null) {
				Long uid = null;
				for (Cookie ck : req.getCookies()) {
					if (ck.getName().equals("user")) {
						uid = Long.parseLong(ck.getValue());
					}
				}
				if (uid != null) {
					res.sendRedirect(req.getContextPath()
							+ "/login/autologin?uid=" + uid);
					return;
				}
			}
			// 跳转到登陆页面
			res.sendRedirect(req.getContextPath() + "/login");
		} else if (!isExcludePages(uri) && user != null) {

			// if(us.get(user.getId()).getEnabled() == 0) {
			// res.sendRedirect(req.getContextPath() + "/login");
			// }

			/*
			 * String headerStr = req.getHeader("REFERER");
			 * 
			 * if(headerStr == null || "".equals(headerStr)) {
			 * if(uri.contains("/login") || uri.contains("/menu")) {
			 * chain.doFilter(request, response); }else{
			 * res.sendRedirect(req.getContextPath() + "/login"); } }else{
			 * chain.doFilter(request, response); }
			 */

			chain.doFilter(request, response);

			// chain.doFilter(request, response);
			// 已经登陆,继续此次请求

		} else {
			chain.doFilter(request, response);
		}

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

	private boolean isExcludePages(String url) {
		String[] regx = Util.getValueFromProperties("filter.url").split(",");
		for (int i = 0; i < regx.length; i++) {
			if (url.matches(regx[i])) {
				return true;
			}
		}
		return false;
	}
}
