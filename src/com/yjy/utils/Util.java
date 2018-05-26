package com.yjy.utils;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.activation.MimetypesFileTypeMap;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.shiro.codec.Base64;
import org.json.JSONObject;
import org.springframework.data.jpa.domain.Specification;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;
import org.springside.modules.persistence.SearchFilter.Operator;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.Encodes;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.service.ThreadSave;
import com.yjy.wechat.WXUtil;

import jxl.Workbook;
import jxl.write.Formula;
import jxl.write.Label;
import jxl.write.WritableHyperlink;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class Util {
	/**
	 * 生成一个唯一的编号，规则,长18位，整形13位时间值加5位随机数
	 * 
	 * @return
	 */
	public final static SimpleDateFormat timeformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public final static SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
	private static final int SALT_SIZE = 8;
	public static final int HASH_INTERATIONS = 1024;
	private final static int ITERATIONS = 20; // 加密深度 最大1000
	private final static String KEY = "yjy!@#";// 密码
	public final static String GET_ACCESS_TOKEN_URL = "http://soft.do-wi.cn/nsh/wxurl/getak";

	public static long ranKey() {
		long now = System.currentTimeMillis() * 100000;
		int i = new Random().nextInt(10000);
		return now + i;
	}

	public static String now() {
		return timeformat.format(new Date());
	}

	public static String datenow() {
		return dateformat.format(new Date());
	}

	/**
	 * 转换字符编码
	 */
	public static String formatUTFString(String str) {
		if ("".equals(str)) {
			return "";
		}
		if (str == null) {
			return "";
		}
		String result = "";
		try {
			result = new String(str.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 字符串验证
	 * 
	 * @param content
	 *            需要验证的内容
	 * @param minLength
	 *            最小长度
	 * @param maxLength
	 *            最大长度
	 * @param notNull
	 *            是否不为null(优先)
	 * @return
	 * 
	 * @author shan
	 */
	public static boolean verifyString(String content, int minLength, int maxLength, boolean notNull) {
		if (notNull && null == content)
			return false;
		if (!notNull && null == content)
			return true;
		if (content.length() < minLength || content.length() > maxLength)
			return false;
		return true;
	}

	/**
	 * 判断字符串是否为数字型,含小数
	 * 
	 * @param str
	 * @return
	 * @author shan
	 */
	public static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("^[0-9]*(\\.[0-9]+)?$");
		return pattern.matcher(str).matches();
	}

	public static String formUpload(String urlStr, Map<String, String> textMap, Map<String, String> fileMap) {
		String res = "";
		HttpURLConnection conn = null;
		String BOUNDARY = "---------------------------123821742118716"; // boundary就是request头和上传文件内容的分隔符
		try {
			URL url = new URL(urlStr);
			conn = (HttpURLConnection) url.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(30000);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

			OutputStream out = new DataOutputStream(conn.getOutputStream());
			// text
			if (textMap != null) {
				StringBuffer strBuf = new StringBuffer();
				Iterator iter = textMap.entrySet().iterator();
				while (iter.hasNext()) {
					Map.Entry entry = (Map.Entry) iter.next();
					String inputName = (String) entry.getKey();
					String inputValue = (String) entry.getValue();
					if (inputValue == null) {
						continue;
					}
					strBuf.append("\r\n").append("--").append(BOUNDARY).append("\r\n");
					strBuf.append("Content-Disposition: form-data; name=\"" + inputName + "\"\r\n\r\n");
					strBuf.append(inputValue);
				}
				out.write(strBuf.toString().getBytes());
			}

			// file
			if (fileMap != null) {
				Iterator iter = fileMap.entrySet().iterator();
				while (iter.hasNext()) {
					Map.Entry entry = (Map.Entry) iter.next();
					String inputName = (String) entry.getKey();
					String inputValue = (String) entry.getValue();
					if (inputValue == null) {
						continue;
					}
					File file = new File(inputValue);
					String filename = file.getName();
					String contentType = new MimetypesFileTypeMap().getContentType(file);
					if (filename.endsWith(".png")) {
						contentType = "image/png";
					}
					if (contentType == null || contentType.equals("")) {
						contentType = "application/octet-stream";
					}

					StringBuffer strBuf = new StringBuffer();
					strBuf.append("\r\n").append("--").append(BOUNDARY).append("\r\n");
					strBuf.append("Content-Disposition: form-data; name=\"" + inputName + "\"; filename=\"" + filename
							+ "\"\r\n");
					strBuf.append("Content-Type:" + contentType + "\r\n\r\n");

					out.write(strBuf.toString().getBytes());

					DataInputStream in = new DataInputStream(new FileInputStream(file));
					int bytes = 0;
					byte[] bufferOut = new byte[1024];
					while ((bytes = in.read(bufferOut)) != -1) {
						out.write(bufferOut, 0, bytes);
					}
					in.close();
				}
			}

			byte[] endData = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();
			out.write(endData);
			out.flush();
			out.close();

			// 读取返回数据
			StringBuffer strBuf = new StringBuffer();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				strBuf.append(line).append("\n");
			}
			res = strBuf.toString();
			reader.close();
			reader = null;
		} catch (Exception e) {
			System.out.println("发送POST请求出错。" + urlStr);
			e.printStackTrace();
		} finally {
			if (conn != null) {
				conn.disconnect();
				conn = null;
			}
		}
		return res;
	}

	public static String sendGet(String url, String param) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// System.out.println(conn.getContent().toString());
			// 设置通用的请求属性 注意Authorization生成
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			String sss = "{\"expire_seconds\": 1800, \"action_name\": \"QR_SCENE\", \"action_info\": {\"scene\": {\"scene_id\": 1234,\"aa\":\"123111\"}}}";
			JSONObject a = new JSONObject(sss);
			out.print(a);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
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
		// String result = "";
		// BufferedReader in = null;
		// try {
		// String urlNameString = url + "?" + param;
		// URL realUrl = new URL(urlNameString);
		// // 打开和URL之间的连接
		// URLConnection connection = realUrl.openConnection();
		// // 设置通用的请求属性
		// connection.setRequestProperty("Content-Type",
		// "application/x-www-form-urlencoded");
		// // connection.setRequestProperty("Authorization", "QBox "
		// // + QiniuUploadConfig.getUptoken());
		// // 建立实际的连接
		// connection.connect();
		// // 获取所有响应头字段
		// Map<String, List<String>> map = connection.getHeaderFields();
		// // 遍历所有的响应头字段
		// // for (String key : map.keySet()) {
		// // System.out.println(key + "--->" + map.get(key));
		// // }
		// // 定义 BufferedReader输入流来读取URL的响应
		// in = new BufferedReader(new InputStreamReader(
		// connection.getInputStream()));
		// String line;
		// while ((line = in.readLine()) != null) {
		// result += line;
		// }
		// } catch (Exception e) {
		// System.out.println("发送GET请求出现异常！" + e);
		// e.printStackTrace();
		// }
		// // 使用finally块来关闭输入流
		// finally {
		// try {
		// if (in != null) {
		// in.close();
		// }
		// } catch (Exception e2) {
		// e2.printStackTrace();
		// }
		// }
		// return result;
	}

	/**
	 * 获取指定长度的随机字符串
	 * 
	 * @param length
	 * @return
	 */
	public static String getRandomString(int length) {
		String randString = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append(randString.charAt((int) (Math.random() * 35 + 1)));
		}
		return sb.toString();
	}

	/**
	 * 返回6位随机数
	 *
	 * @author tmac
	 */
	public static String getCaptcha() {
		// TODO Auto-generated method stub
		Random random = new Random();
		String result = "";
		for (int i = 0; i < 6; i++) {
			result += random.nextInt(10);
		}
		return result;
	}

	/**
	 * 获取指定长度的随机数字序列
	 * 
	 * @param length
	 * @return
	 */
	public static String getRandomNumber(int length) {
		String randString = "0123456789";
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append(randString.charAt((int) (Math.random() * 9 + 1)));
		}
		return sb.toString();
	}

	/**
	 * 更改字符集编码 (luyf)
	 * 
	 * @param params
	 * @return
	 */
	public static Map<String, Object> changeEncoding(Map<String, Object> params) {
		for (String key : params.keySet()) {
			try {
				params.put(key, new String(params.get(key).toString().trim().getBytes("ISO-8859-1"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return params;
	}

	/**
	 * 更改字符集编码 (luyf)
	 * 
	 * @param params
	 * @return
	 */
	public static String changeEncoding(String params) {
		try {
			params = new String(params.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return params;
	}

	/**
	 * luyf 创建动态查询条件组合.
	 * 
	 * @param searchParams
	 *            搜索条件 EQ, LIKE, GT, LT, GTE, LTE (XX_xxxxx) eq相等 ne、neq不相等，
	 *            gt大于， lt小于 gte、ge大于等于 lte、le 小于等于 not非 mod求模
	 * @param lsf
	 * @param entityClazz
	 * @return
	 * 
	 */
	public static <T> Specification<T> buildSpecification(Map<String, Object> searchParams, Class<T> entityClazz) {
		Map<String, SearchFilter> filters = new HashMap<String, SearchFilter>();
		// SearchFilter.parse(searchParams);//直接转换不是string会报错
		SearchFilter searchFilter;
		for (Map.Entry<String, Object> entry : searchParams.entrySet()) {
			String key = entry.getKey();// EQ_state
			if ("EQ".equals(key.substring(0, 2))) {
				searchFilter = new SearchFilter(entry.getKey().substring(3), Operator.EQ, entry.getValue());
				filters.put(key, searchFilter);
			} else if ("LIKE".equals(key.substring(0, 4))) {
				searchFilter = new SearchFilter(entry.getKey().substring(5), Operator.LIKE, entry.getValue());
				filters.put(key, searchFilter);
			} else if ("GTE".equals(key.substring(0, 3))) {
				searchFilter = new SearchFilter(entry.getKey().substring(4), Operator.GTE, entry.getValue());
				filters.put(key, searchFilter);
			} else if ("LTE".equals(key.substring(0, 3))) {
				searchFilter = new SearchFilter(entry.getKey().substring(4), Operator.LTE, entry.getValue());
				filters.put(key, searchFilter);
			} else if ("GT".equals(key.substring(0, 2))) {
				searchFilter = new SearchFilter(entry.getKey().substring(3), Operator.GT, entry.getValue());
				filters.put(key, searchFilter);
			} else if ("LT".equals(key.substring(0, 2))) {
				searchFilter = new SearchFilter(entry.getKey().substring(3), Operator.LT, entry.getValue());
				filters.put(key, searchFilter);
			}
		}

		Specification<T> spec = DynamicSpecifications.bySearchFilter(filters.values(), entityClazz);
		return spec;
	}

	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */

	public static String validatePassword(String salt, String inputPassword) {

		if (salt != null && !salt.equals("") && inputPassword != null && !inputPassword.trim().equals("")) {
			String saltNew = "bp" + salt + "0";
			byte[] hashPassword = Digests.sha1(inputPassword.trim().getBytes(), saltNew.getBytes(), HASH_INTERATIONS);
			return Encodes.encodeHex(hashPassword);
		} else {
			return "";
		}
	}

	/**
	 * 获取配置文件中属性数据
	 * 
	 * @param name
	 * @return
	 */
	public static String getValueFromProperties(String name) {
		String value = "";
		try {
			Properties p = new Properties();
			InputStream in = Util.class.getClassLoader().getResourceAsStream("application.properties");
			p.load(in);
			value = p.getProperty(name);
		} catch (IOException e) {
			e.printStackTrace();
			value = null;
		}

		return value;
	}

	/**
	 * 加密
	 * 
	 * @param plainText
	 * @return
	 */
	public static String encrypt(String plainText) {
		try {
			byte[] salt = new byte[8];
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(KEY.getBytes());
			byte[] digest = md.digest();
			for (int i = 0; i < 8; i++) {
				salt[i] = digest[i];
			}
			PBEKeySpec pbeKeySpec = new PBEKeySpec(KEY.toCharArray());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithMD5AndDES");
			SecretKey skey = keyFactory.generateSecret(pbeKeySpec);
			PBEParameterSpec paramSpec = new PBEParameterSpec(salt, ITERATIONS);
			Cipher cipher = Cipher.getInstance("PBEWithMD5AndDES");
			cipher.init(Cipher.ENCRYPT_MODE, skey, paramSpec);
			byte[] cipherText = cipher.doFinal(plainText.getBytes());
			String saltString = new String(Base64.encode(salt));
			String ciphertextString = new String(Base64.encode(cipherText));
			return saltString + ciphertextString;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 解密
	 * 
	 * @param encryptTxt
	 * @return
	 */
	public static String decrypt(String encryptTxt) {
		int saltLength = 12;
		try {
			String salt = encryptTxt.substring(0, saltLength);
			String ciphertext = encryptTxt.substring(saltLength, encryptTxt.length());
			byte[] saltarray = Base64.decode(salt.getBytes());
			byte[] ciphertextArray = Base64.decode(ciphertext.getBytes());
			PBEKeySpec keySpec = new PBEKeySpec(KEY.toCharArray());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithMD5AndDES");
			SecretKey skey = keyFactory.generateSecret(keySpec);
			PBEParameterSpec paramSpec = new PBEParameterSpec(saltarray, ITERATIONS);
			Cipher cipher = Cipher.getInstance("PBEWithMD5AndDES");
			cipher.init(Cipher.DECRYPT_MODE, skey, paramSpec);
			byte[] plaintextArray = cipher.doFinal(ciphertextArray);
			return new String(plaintextArray);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public Map<String, String> GetQueryString(String queryString) {
		String[] queryStringSplit = queryString.split("&");
		Map<String, String> queryStringMap = new HashMap<String, String>(queryStringSplit.length);
		String[] queryStringParam;
		for (String qs : queryStringSplit) {
			queryStringParam = qs.split("=");
			queryStringMap.put(queryStringParam[0], queryStringParam[1]);
		}
		return queryStringMap;
	}

	/**
	 * 获取访问的IP
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 
	 * 往左填满数据
	 * 
	 * @author lyf
	 * @date 2015年3月6日 下午2:57:51
	 * @param input
	 * @param size
	 * @param symbol
	 * @return
	 */
	public static String fill(String input, int size, char symbol) {
		while (input.length() < size) {
			input = symbol + input;
		}
		return input;
	}

	/**
	 * 
	 * 获取项目本地路径
	 * 
	 * @author lyf
	 * @date 2015年4月9日 下午4:21:05
	 * @return
	 */
	public static String getRootPath() {
		String baseUrl = "";
		try {
			baseUrl = Util.class.getResource("").toURI().getPath();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return baseUrl.substring(0, baseUrl.indexOf("WEB-INF"));
	}

	/**
	 * 
	 * 特殊字符判断
	 * 
	 * @author lyf
	 * @date 2015年6月12日 下午2:21:10
	 * @param strName
	 * @return
	 */
	public static boolean isMessyCode(String strName) {
		Pattern p = Pattern.compile("\\s*|\t*|\r*|\n*");
		Matcher m = p.matcher(strName);
		String after = m.replaceAll("");
		String temp = after.replaceAll("\\p{P}", "");
		char[] ch = temp.trim().toCharArray();
		float chLength = ch.length;
		float count = 0;
		for (int i = 0; i < ch.length; i++) {
			char c = ch[i];
			if (!Character.isLetterOrDigit(c)) {
				if (!isChinese(c)) {
					count = count + 1;
				}
			}
		}
		float result = count / chLength;
		if (result > 0.4) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 判断字符是否是中文
	 *
	 * @param c
	 *            字符
	 * @return 是否是中文
	 */
	public static boolean isChinese(char c) {
		Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
		if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
				|| ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
				|| ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
				|| ub == Character.UnicodeBlock.GENERAL_PUNCTUATION
				|| ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
				|| ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS) {
			return true;
		}
		return false;
	}

	/**
	 * 
	 * 获取本机IP地址
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午4:20:48
	 * @return
	 */
	public static String getMyIp() {
		InetAddress addr;
		try {
			addr = InetAddress.getLocalHost();
			return addr.getHostAddress();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	public int radomPrice() {
		int rn = Integer.parseInt(Util.getRandomNumber(3)) % 3;
		if (rn == 0) {
			return 20;
		} else if (rn == 1) {
			return 10;
		} else {
			return 5;
		}
	}

	/**
	 * 
	 * 下载文件
	 * 
	 * @author lyf
	 * @date 2015年10月31日 下午3:15:43
	 * @param furl
	 * @param path
	 * @return
	 */
	public static String downloadNet(String furl, String path) {
		String filename = new Date().getTime() + ".jpg";
		try {
			// 下载网络文件
			int bytesum = 0;
			int byteread = 0;
			URL url = new URL(furl);
			URLConnection conn = url.openConnection();
			InputStream inStream = conn.getInputStream();
			FileOutputStream fs = new FileOutputStream(path + File.separator + filename);

			byte[] buffer = new byte[1204];
			int length;
			while ((byteread = inStream.read(buffer)) != -1) {
				bytesum += byteread;
				fs.write(buffer, 0, byteread);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return filename;
	}

	/**
	 * 
	 * 获取手机运营商
	 * 
	 * @author lyf
	 * @date 2015年10月31日 下午3:20:49
	 */
	public static String getYYS(String phone) {
		String httpUrl = "http://apis.baidu.com/apistore/mobilenumber/mobilenumber";
		String httpArg = "phone=" + phone;
		String jsonResult = request(httpUrl, httpArg);
		Map<String, Object> data = WXUtil.parseJSON2Map((decodeUnicode(jsonResult)));
		if (data.containsKey("retMsg") && data.get("retMsg").toString().equals("success")) {
			Map<String, String> d = (Map<String, String>) data.get("retData");
			return d.get("supplier") + "," + d.get("city");
		}
		return null;
	}

	public static String request(String httpUrl, String httpArg) {
		BufferedReader reader = null;
		String result = null;
		StringBuffer sbf = new StringBuffer();
		httpUrl = httpUrl + "?" + httpArg;

		try {
			URL url = new URL(httpUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			// 填入apikey到HTTP header
			connection.setRequestProperty("apikey", "87fd89d59b3dbbd2b5709d121fdcf5c8");
			connection.connect();
			InputStream is = connection.getInputStream();
			reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			String strRead = null;
			while ((strRead = reader.readLine()) != null) {
				sbf.append(strRead);
				sbf.append("\r\n");
			}
			reader.close();
			result = sbf.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String decodeUnicode(String theString) {
		char aChar;
		int len = theString.length();
		StringBuffer outBuffer = new StringBuffer(len);
		for (int x = 0; x < len;) {
			aChar = theString.charAt(x++);
			if (aChar == '\\') {
				aChar = theString.charAt(x++);
				if (aChar == 'u') {
					int value = 0;
					for (int i = 0; i < 4; i++) {
						aChar = theString.charAt(x++);
						switch (aChar) {
						case '0':
						case '1':
						case '2':
						case '3':
						case '4':
						case '5':
						case '6':
						case '7':
						case '8':
						case '9':
							value = (value << 4) + aChar - '0';
							break;
						case 'a':
						case 'b':
						case 'c':
						case 'd':
						case 'e':
						case 'f':
							value = (value << 4) + 10 + aChar - 'a';
							break;
						case 'A':
						case 'B':
						case 'C':
						case 'D':
						case 'E':
						case 'F':
							value = (value << 4) + 10 + aChar - 'A';
							break;
						default:
							throw new IllegalArgumentException("Malformed      encoding.");
						}
					}
					outBuffer.append((char) value);
				} else {
					if (aChar == 't') {
						aChar = '\t';
					} else if (aChar == 'r') {
						aChar = '\r';
					} else if (aChar == 'n') {
						aChar = '\n';
					} else if (aChar == 'f') {
						aChar = '\f';
					}
					outBuffer.append(aChar);
				}
			} else {
				outBuffer.append(aChar);
			}
		}
		return outBuffer.toString();
	}

	// 打包文件夹
	public static boolean makeFile_Zip(String outfile, String infile) {
		try {
			// 文件输出流
			FileOutputStream fout = new FileOutputStream(outfile);
			// zip文件输出流
			ZipOutputStream out = new ZipOutputStream(fout);
			// 要打包的文件
			File file = new File(infile);
			// 进行打包zip操作,第一次打包不指定文件夹,因为程序接口中指定了一级文件夹
			makeFile_Zip_Do(out, file, "");
			// 关闭zip输出流
			out.close();
			// 返回成功
			return true;
		} catch (FileNotFoundException e) {
			System.out.println("打包失败(指定的文件不存在)...");
			return false;
		} catch (Exception e) {
			System.out.println("打包失败(未知原因)...");
			return false;
		}
	}

	public static void makeFile_Zip_Do(ZipOutputStream out, File file, String dir) {
		try {
			// 如果当前打包的是目录
			if (file.isDirectory()) {
				// 输出进度信息
				System.out.println("当前正在打包文件夹:" + file + "...");
				// 文件列表
				File[] files = file.listFiles();
				// 添加下一个打包目录文件
				out.putNextEntry(new ZipEntry(dir + "/"));
				//
				dir = dir.length() == 0 ? "" : dir + "/";
				for (int i = 0; i < files.length; i++) {
					makeFile_Zip_Do(out, files[i], dir + files[i].getName());
				}
			}
			// 如果当前打包文件
			else {
				// 输出进度信息
				System.out.println("当前正在打包文件:" + file + "...");
				//
				out.putNextEntry(new ZipEntry(file.getName()));
				// 文件输入流
				FileInputStream in = new FileInputStream(file);
				// 进行写入
				byte[] readArr = new byte[8192];
				int len;
				while ((len = in.read(readArr)) != -1) {
					out.write(readArr, 0, len);
				}
				// 关闭输入流
				in.close();
				System.out.println("文件" + file + "打包完成！");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 
	 * 创建二维码
	 * 
	 * @author lyf
	 * @date 2015年11月5日 下午9:24:24
	 * @param path
	 *            项目绝对路径
	 * @param filename
	 *            文件名
	 * @param code
	 */
	public static void createCode(String path, String filename, String code) {
		MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
		Map hints = new HashMap();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		hints.put(EncodeHintType.MARGIN, 0);
		BitMatrix bitMatrix;
		try {
			bitMatrix = multiFormatWriter.encode(code, BarcodeFormat.QR_CODE, 400, 400, hints);
			File pf = new File(Util.getRootPath() + File.separator + path);
			if (!pf.exists()) {
				pf.mkdirs();
			}
			File f = new File(Util.getRootPath() + File.separator + path + File.separator + filename);
			MatrixToImageWriter.writeToFile(bitMatrix, "jpg", f);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {

	}
}
