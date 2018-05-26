package com.yjy.web.controller;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.entity.User;
import com.yjy.service.UserService;
import com.yjy.utils.SendMessage;
import com.yjy.utils.Util;

@Controller
@RequestMapping(value = "/forget")
public class ForgetPasswordController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(method = RequestMethod.POST)
	public String stepOne(@RequestParam(value="token") String token,
			HttpServletRequest request, HttpServletResponse response){
		if(token == null || token.equals("") || !token.equals("nshpwd")) {
			response.setStatus(403);
			return null;
		}
		return "account/forgetpwdone";
	}
	
	@RequestMapping(value = "checktelephone")
	@ResponseBody
	public boolean checkTelephone(@RequestParam("telephone") String telephone) {
		
		if(userService.findByTelephone(telephone) == null){
			return false;
		} else {
			return true;
		}
		
	}
	
	@RequestMapping(value="/getcaptcha")
	@ResponseBody
	public boolean getCaptcha(@RequestParam("telephone") String telephone){
		
		User user=userService.findByTelephone(telephone);
		
		String captcha = Util.getCaptcha();
		user.setCaptcha(captcha);
		user.setStarttime(new Date());
		userService.saveCaptcha(user);
		SendMessage.sendYZMSMS(user.getTelephone(),"您好，您的验证码是:"+captcha+"【金阿福e服务】","");
		// 线程120秒后使验证码失效
		/*Thread.sleep(60000);*/
		 /*catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}*/
		return true;
	}
	
	
	@RequestMapping(value="/checkcaptcha")
	@ResponseBody
	public Map<String, Object> checkCaptcha(@RequestParam(value="telephone")String telephone,
			@RequestParam(value="captcha")String captcha){
		User user = userService.findByTelephone(telephone);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (user == null) {
			map.put("result", "0");
			map.put("msg", "手机号码未注册");
			return map;
		} else {
			
			long nowdatelong = new Date().getTime();
			
			Date capcreatetime = user.getStarttime();
			
			if(capcreatetime == null) {
				map.put("result", "0");
				map.put("msg", "验证码错误或已失效，请重新获取验证码");
				return map;
			}else{
				long capcreatelong = capcreatetime.getTime();
				
				long cha = nowdatelong - capcreatelong;
				
				if(cha > 60000) {
					map.put("result", "0");
					map.put("msg", "验证码已失效，请重新获取验证码");
					return map;
				}else {
					
					if (!captcha.equals(user.getCaptcha())) {
						map.put("result", "0");
						map.put("msg", "验证码错误");
						return map;
					} else {
						map.put("result", "1");
						map.put("msg", "验证成功");
						return map;
						/*user.setCaptcha(null);
						userService.saveCaptcha(user);*/
					}
				}
			}
		}
	}
	
	@RequestMapping(value="/gonext")
	public String goNext(@RequestParam(value="tel")String tel,
			HttpServletRequest request, HttpServletResponse response, Model model){
		
		if(tel == null || tel.equals("")) {
			response.setStatus(403);
			return null;
		}
		model.addAttribute("tel", tel);
		
		System.out.println(tel);
		return "account/forgetpwdtwo";
	}
	
	@RequestMapping(value="/password/changenewpassword",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> changeNewPassword(@RequestParam(value="telephone")String telephone,
			@RequestParam(value="newpassword")String newpassword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			User user = userService.findByTelephone(telephone);
			user.setPassword(newpassword);
			userService.saveorupdate(user);
			
			map.put("result", "1");
			map.put("msg", "密码修改成功,请重新登录");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "0");
			map.put("msg", "系统错误，密码修改失败，请稍后重试！");
		}
		
		return map;
	}
}
