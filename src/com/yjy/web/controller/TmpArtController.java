package com.yjy.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.entity.Activity;
import com.yjy.entity.FatherChildActivity;
import com.yjy.entity.TmpArt;
import com.yjy.entity.User;
import com.yjy.service.ActivityService;
import com.yjy.service.FatherChildActivityService;
import com.yjy.service.TmpArtService;
import com.yjy.utils.ImageUtil;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;

import sun.misc.BASE64Encoder;

@Controller
@RequestMapping(value = "/tmpart")
public class TmpArtController {

	@Autowired
	private TmpArtService tmpArtService;
	String viewrurl = "viewrurl";

	@RequestMapping(value = "viewqrcode")
	@ResponseBody
	public String viewqrcode(@Valid TmpArt tmpart) {
		String url = SysConfig.BASEURL + "/wxcommunity/tmpshowview?tmpid=" + tmpArtService.save(tmpart).getId();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String daystr = sdf.format(new Date());
			MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
			Map hints = new HashMap();
			hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			BitMatrix bitMatrix = multiFormatWriter.encode(url, BarcodeFormat.QR_CODE, 400, 400, hints);
			Date d = new Date();
			File pf = new File(Util.getRootPath() + File.separator + viewrurl + File.separator + daystr);
			if (!pf.exists()) {
				pf.mkdirs();
			}
			File f = new File(Util.getRootPath() + File.separator + viewrurl + File.separator + daystr + File.separator
					+ d.getTime() + ".png");
			MatrixToImageWriter.writeToFile(bitMatrix, "png", f);
			InputStream in = null;
			byte[] data = null;
			try {
				in = new FileInputStream(f);
				data = new byte[in.available()];
				in.read(data);
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// 对字节数组Base64编码
			BASE64Encoder encoder = new BASE64Encoder();
			return encoder.encode(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@RequestMapping(value = "focusqrcode")
	@ResponseBody
	public String focusqrcode(@RequestParam(value="url") String url) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String daystr = sdf.format(new Date());
			MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
			Map hints = new HashMap();
			hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			BitMatrix bitMatrix = multiFormatWriter.encode(url, BarcodeFormat.QR_CODE, 400, 400, hints);
			Date d = new Date();
			File pf = new File(Util.getRootPath() + File.separator + viewrurl + File.separator + daystr);
			if (!pf.exists()) {
				pf.mkdirs();
			}
			File f = new File(Util.getRootPath() + File.separator + viewrurl + File.separator + daystr + File.separator
					+ d.getTime() + ".png");
			MatrixToImageWriter.writeToFile(bitMatrix, "png", f);
			InputStream in = null;
			byte[] data = null;
			try {
				in = new FileInputStream(f);
				data = new byte[in.available()];
				in.read(data);
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// 对字节数组Base64编码
			BASE64Encoder encoder = new BASE64Encoder();
			return encoder.encode(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

}
