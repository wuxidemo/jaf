package com.yjy.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import javax.crypto.spec.SecretKeySpec;
import org.json.JSONException;
import com.qiniu.api.auth.digest.Mac;
import com.qiniu.api.io.IoApi;
import com.qiniu.api.io.PutExtra;
import com.qiniu.api.io.PutRet;
import com.qiniu.api.net.CallRet;
import com.qiniu.api.net.EncodeUtils;
import com.qiniu.api.rs.Entry;
import com.qiniu.api.rs.PutPolicy;
import com.qiniu.api.rs.RSClient;

/**
 * 七牛云上传服务配置(用于大数据)
 * 
 */
public class QiniuDataConfig {

	public static final String ACCESS_KEY = "wFqFOBsGN8lTaj-vBUl2w0bFMmK7WHTPiXG8TLPX";// "wFqFOBsGN8lTaj-vBUl2w0bFMmK7WHTPiXG8TLPX";
	public static final String SECRET_KEY = "EXDSHOYYuJdFOX-tZNuina8vR2WUtLEgM5pdwwWd";// "EXDSHOYYuJdFOX-tZNuina8vR2WUtLEgM5pdwwWd";
	public static final String bucketName = "langgao";// "openduyexu";
	public static final String thumbnail_img = "?imageView2/1/w/100/h/100";// 缩略图
	public static final String video_thumbnail_img = "fops=vframe%2fjpg%2foffset%2f1%2fw%2f500%2fh%2f250"; // 七牛视频截图参数
	public static String video_img_callback = "/api/qiniucallback";// 七牛视频截图回调
	// (在application.properties中配置)
	public static String Host = "http://api.qiniu.com/"; // 七牛API HOST
	public static String video_img_path = "pfop/";// 持久化处理 path

	public static String getBucket() {
		return "http://" + bucketName + ".qiniudn.com/";
	}

	public static String getThumbnail_img(String x, String y) {
		return "?imageView2/1/w/" + x + "/h/" + y;
	}

	public static String uploadFile(String filePath, String key)
			throws Exception, JSONException {

		Mac mac = new Mac(QiniuDataConfig.ACCESS_KEY,
				QiniuDataConfig.SECRET_KEY);
		// 请确保该bucket已经存在
		PutPolicy putPolicy = new PutPolicy(QiniuDataConfig.bucketName);
		String uptoken = putPolicy.token(mac);
		System.out.println(uptoken);
		PutExtra extra = new PutExtra();

		PutRet ret = IoApi.putFile(uptoken, key, filePath, extra);
		if (ret.ok()) {
			return ret.getKey();
		} else {
			return "";
		}
	}

	public static String getUptoken() throws Exception {
		Mac mac = new Mac(QiniuDataConfig.ACCESS_KEY,
				QiniuDataConfig.SECRET_KEY);
		// 请确保该bucket已经存在
		PutPolicy putPolicy = new PutPolicy(QiniuDataConfig.bucketName);
		return putPolicy.token(mac);
	}

	/**
	 * 获取七牛accesstoken
	 * 
	 * @param str
	 *            七牛地址（如/pfop/实例化地址）
	 * @param body
	 *            参数
	 * @return
	 */
	public static String getAccessToken(String str, String body) {
		String sign = str + "\n" + body;
		javax.crypto.Mac mac = null;
		try {
			mac = javax.crypto.Mac.getInstance("HmacSHA1");
			byte[] secretKey = SECRET_KEY.getBytes();
			SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey,
					"HmacSHA1");
			mac.init(secretKeySpec);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String encodedSign = EncodeUtils.urlsafeEncodeString(mac.doFinal(sign
				.getBytes()));
		String accessToken = ACCESS_KEY + ":" + encodedSign;
		return accessToken;
	}

	public static void main(String args[]) {
		//System.out.println(getVideoIMG("lvQMh8s2fW0U22hAUccWfU90MyO_", 11l, 2));
		// http://zhijiabao.qiniudn.com/lvZzMJ7dbfjR2a8cCw0rS2nxwDhE

		// Frf0N9IWKI0wvylSSe1MgpQ9q4mQ
		// CallRet cr = deleteFile("Frf0N9IWKI0wvylSSe1MgpQ9q4mQ");
		// System.out.println(cr.statusCode);
		// System.out.println(cr.ok());
		// Entry e = getFileInfo("lvZzMJ7dbfjR2a8cCw0rS2nxwDhEaa");
		// System.out.println(e.getFsize());
	}

	/**
	 * 调用七牛获取视频截图 实例化 接口
	 * 
	 * @param key
	 *            视频的七牛HASH码
	 * @param id
	 *            对应数据库记录ID
	 * @param type
	 *            类型:1视频课程(media表)2盒子录像(devicevideo表)
	 * @return
	 */
	public static String getVideoIMG(String key, Long id, int type,String baseUrl) {
		return doQiniuPost(Host, video_img_path, "bucket=" + bucketName
				+ "&key=" + key + "&" + video_thumbnail_img + "&notifyURL="
				+ baseUrl+video_img_callback + "/" + type + "/" + id);
	}

	public static String doQiniuPost(String host, String path, String param) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(host + path);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// System.out.println(conn.getContent().toString());
			// 设置通用的请求属性 注意Authorization生成
			conn.setRequestProperty("Authorization", "QBox "
					+ QiniuDataConfig.getAccessToken("/" + path, param));
			conn.setRequestProperty("Host", host);
			conn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
			result = "-1";
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
				result = "-1";
			}
		}
		return result;
	}

	/**
	 * 获取文件信息
	 * 
	 * @param key
	 * @return
	 */
	public static Entry getFileInfo(String key) {
		Mac mac = new Mac(QiniuDataConfig.ACCESS_KEY,
				QiniuDataConfig.SECRET_KEY);
		RSClient client = new RSClient(mac);
		return client.stat(QiniuDataConfig.bucketName, key);
	}

	/**
	 * 删除文件
	 * 
	 * @param key
	 * @return
	 */
	public static CallRet deleteFile(String key) {
		Mac mac = new Mac(QiniuDataConfig.ACCESS_KEY,
				QiniuDataConfig.SECRET_KEY);
		RSClient client = new RSClient(mac);
		return client.delete(QiniuDataConfig.bucketName, key);

	}
}
