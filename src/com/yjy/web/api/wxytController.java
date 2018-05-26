package com.yjy.web.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.utils.wxytConfig;

/**
 * 万象优图
 * 
 * @author lyf
 * @date 2015年12月4日 上午9:24:44
 */
@Controller
@RequestMapping(value = "/wxyt")
public class wxytController {

	@RequestMapping(value = "config")
	@ResponseBody
	public Map<String, String> getConfig() {
		Map<String, String> result = new HashMap<String, String>();
		String sign = wxytConfig.getSign();
		if (sign == null) {
			result.put("result", "0");
			result.put("msg", "获取签名失败");
			return result;
		} else {
			result.put("sign", sign);
		}
		result.put("url", wxytConfig.getUrl());
		result.put("result", "1");
		return result;
	}

	@RequestMapping(value = "test")
	public String test() {
		return "wxyt/test";
	}
}
