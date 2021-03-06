package com.yjy.web.process;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("api/process")
public class processController {

	/**
	 * 获取上传进度
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:10:30
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "getprocess")
	@ResponseBody
	public Map<String, Object> doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = request.getSession(true);
		if (session == null) {
			System.out.println("Sorry, session is null"); // just to be safe
			return null;
		}

		FileUploadListener uploadProgressListener = (FileUploadListener) session
				.getAttribute("uploadProgressListener");
		if (uploadProgressListener == null) {
			System.out.println("Progress listener is null");
			return null;
		}
		int ret = uploadProgressListener.getPercentDone();
		System.out.println("new ->:" + String.valueOf(ret));
		map.put("total",
				changeUnit(uploadProgressListener.getTheContentLength()));
		map.put("process", ret);
		return map;
	}

	public String changeUnit(Long data) {
		if (data > (1000 * 1000 * 1000 * 1000l)) {
			return data / (1000 * 1000 * 1000 * 1000) + "TB";
		} else if (data > 1000 * 1000 * 1000l) {
			return data / (1000 * 1000 * 1000) + "G";
		} else if (data > 1000 * 1000l) {
			return data / (1000 * 1000) + "M";
		} else if (data > 1000l) {
			return data / (1000) + "K";
		} else {
			return data + "B";
		}
	}

}
