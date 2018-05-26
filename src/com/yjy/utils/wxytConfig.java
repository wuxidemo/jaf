package com.yjy.utils;

import java.io.FileInputStream;

import com.yjy.qcloud.wxyt.PicCloud;
import com.yjy.qcloud.wxyt.UploadResult;

public class wxytConfig {
	public static final int APP_ID_V2 = 10017813;
	public static final String SECRET_ID_V2 = "AKIDEHI945PWO9QSdNtEYHXCYMuf4nsiss2a";
	public static final String SECRET_KEY_V2 = "GryDUS1PoMQG8sM7rdPGKqZstYSKLrrN";
	public static final String BUCKET = "lyfts2"; // 空间�?

	public static void main(String[] args) throws Exception {
		System.out.println(upload("D:\\11\\d.jpg"));
	}

	/**
	 * 
	 * 获取签名 不指定文件ID
	 * 
	 * @author lyf
	 * @date 2015年12月4日 上午10:55:16
	 * @return
	 */
	public static String getSign() {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		return pc.getSign(System.currentTimeMillis() / 1000 + 3600);
	}

	/**
	 * 
	 * 上传URL
	 * 
	 * @author lyf
	 * @date 2015年12月4日 上午10:55:49
	 * @return
	 */
	public static String getUrl() {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		return pc.getUrl("0", "");
	}

	/**
	 * 
	 * 管理地址
	 * 
	 * @author lyf
	 * @date 2015年12月4日 上午10:56:13
	 * @param filed
	 * @return
	 */
	public static String getViewUrl(String filed) {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		return pc.getUrl("0", filed);
	}

	/**
	 * 
	 * 获取签名 指定文件ID 只能使用一次
	 * 
	 * @author lyf
	 * @date 2015年12月4日 上午10:56:23
	 * @param fileId
	 * @return
	 */
	public static String getSignOnce(String fileId) {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		return pc.getSignOnce(fileId);
	}

	/**
	 * 
	 * 复制URL地址
	 * 
	 * @author lyf
	 * @date 2015年12月4日 上午10:57:49
	 * @param fileId
	 * @return
	 */
	public static String getCopyUrl(String fileId) {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		return pc.getUrl("0", fileId) + "/copy";
	}

	/**
	 * 
	 * 获取删除URL
	 * 
	 * @author lyf
	 * @date 2015年12月4日 上午10:59:01
	 * @param fileId
	 * @return
	 */
	public static String getDelUrl(String fileId) {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		return pc.getUrl("0", fileId) + "/del";
	}

	/**
	 * 
	 * 上传文件
	 * 
	 * @author lyf
	 * @date 2015年12月8日 上午10:21:40
	 * @param pic
	 * @return
	 * @throws Exception
	 */
	public static String upload(String pic) throws Exception {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		UploadResult result = pc.upload(pic);
		if (result != null) {
			return result.downloadUrl;
		} else
			return null;
	}

	/**
	 * 
	 * 删除
	 * 
	 * @author lyf
	 * @date 2015年12月8日 上午10:24:15
	 * @param fileId
	 */
	public static void delete(String fileId) {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		pc.delete(fileId);
	}

	/**
	 * 
	 * 上传文件
	 * 
	 * @author lyf
	 * @date 2015年12月8日 上午10:21:40
	 * @param pic
	 * @return
	 * @throws Exception
	 */
	public static String upload(FileInputStream fileStream) throws Exception {
		PicCloud pc = new PicCloud(APP_ID_V2, SECRET_ID_V2, SECRET_KEY_V2, BUCKET);
		UploadResult result = pc.upload(fileStream);
		if (result != null) {
			return result.downloadUrl;
		} else
			return null;
	}

}
