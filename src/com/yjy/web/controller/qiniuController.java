package com.yjy.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjy.utils.QiniuUploadConfig;

/**
 * 类qiniuController.java的实现描述：用来获取七牛的uptoken
 * @author yigang 2015年4月20日 下午2:02:22
 */
@Controller
@RequestMapping(value = "/qiniu")
public class qiniuController {

	/**
	 * 上传七牛获取token
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:09:24
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/uptoken")
	public Map<String, String> uptoken() {
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("uptoken", QiniuUploadConfig.getUptoken());
			return map;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
