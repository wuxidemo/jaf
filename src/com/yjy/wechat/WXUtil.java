package com.yjy.wechat;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.activation.MimetypesFileTypeMap;
import javax.net.ssl.SSLContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.jdom.CDATA;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.yjy.utils.MD5;
import com.yjy.utils.MatrixToImageWriter;
import com.yjy.utils.SHA1;
import com.yjy.utils.Util;

/**
 * 微信工具类
 * 
 * @author lyf
 *
 */
@SuppressWarnings("deprecation")
public class WXUtil {

	// 微信公众平台填写URL的token
	private static String token = "NongShangHang";

	/**
	 * 解析微信提交信息XML
	 * 
	 * @param is
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> PushManageXml(InputStream is) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			SAXBuilder sax = new SAXBuilder();
			Document doc = sax.build(is);
			// 获得文件的根元素
			Element root = doc.getRootElement();
			// 获得根元素的第一级子节点
			List<Object> list = root.getChildren();
			for (int j = 0; j < list.size(); j++) {
				// 获得结点
				Element first = (Element) list.get(j);
				System.out.println(first.getName() + ":" + first.getValue());
				result.put(first.getName(), first.getValue().trim());
			}
		} catch (Exception e) {
			System.out.println("XML解析异常");
			// e.printStackTrace();
			return null;
			// 异常
		}

		return result;
	}

	public static Map<String, String> pushManageXml(String str) {
		Map<String, String> map = new HashMap<String, String>();
		org.dom4j.Document doc = null;
		try {
			doc = DocumentHelper.parseText(str);
		} catch (DocumentException e) {
			e.printStackTrace();
		} // 将字符串转为XML

		org.dom4j.Element rootElt = doc.getRootElement(); // 获取根节点

		Iterator<?> iter = rootElt.elementIterator(); // 获取根节点下的子节点head
		while (iter.hasNext()) {
			org.dom4j.Element recordEle = (org.dom4j.Element) iter.next();
			String key = recordEle.getName(); // 拿到t节点下的子节点entry的key值
			String value = recordEle.getText(); // 拿到t节点下的子节点entry的value值
			map.put(key, value);
		}
		return map;
	}

	/**
	 * 校验微信公众平台填写的URL和token是否匹配
	 * 
	 * @author yigang
	 * @date 2015年6月15日 下午8:04:43
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @return
	 */
	public static boolean checkSignature(String signature, String timestamp, String nonce) {
		String[] arr = new String[] { token, timestamp, nonce };

		Arrays.sort(arr);
		StringBuilder content = new StringBuilder();
		for (int i = 0; i < arr.length; i++) {
			content.append(arr[i]);
		}
		MessageDigest md = null;
		String tmpStr = null;

		try {
			md = MessageDigest.getInstance("SHA-1");
			// 将三个参数字符串拼接成一个字符串进行sha1加密
			byte[] digest = md.digest(content.toString().getBytes());
			tmpStr = byteToStr(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		content = null;
		// 将sha1加密后的字符串可与signature对比，标识该请求来源于微信
		return tmpStr != null ? tmpStr.equals(signature.toUpperCase()) : false;
	}

	/**
	 * 将字节数组转换为十六进制字符串
	 * 
	 * @param byteArray
	 * @return
	 */
	private static String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}

	/**
	 * 将字节转换为十六进制字符串
	 * 
	 * @param mByte
	 * @return
	 */
	private static String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
		tempArr[1] = Digit[mByte & 0X0F];

		String s = new String(tempArr);
		return s;
	}

	public static String getReStr(String inputStr) {

		String APIKEY = "9d4f97ff55b19d310e0a7de765e6bd9e";
		String returnStr = "";

		if (inputStr == null || inputStr.equals("")) {
			return "再逗我，就不跟你玩了！";
		}

		try {

			String INFO = URLEncoder.encode(inputStr, "utf-8");

			String getURL = "http://www.tuling123.com/openapi/api?key=" + APIKEY + "&info=" + INFO;
			URL getUrl = new URL(getURL);
			HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
			connection.connect();

			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
			StringBuffer sb = new StringBuffer();
			String line = "";
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
			reader.close();
			connection.disconnect();
			System.out.println(sb.toString());

			returnStr = sb.toString();

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "小维这会儿很忙，暂时无法和你说话！";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "小维这会儿很忙，暂时无法和你说话！";
		}

		return returnStr;

	}

	/**
	 * 
	 * GET请求
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:04:24
	 * @param url
	 * @param param
	 * @return
	 */
	public static String sendGet(String url, Object param) {
		String result = "";
		BufferedReader in = null;
		PrintWriter out = null;
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection connection = realUrl.openConnection();
			connection.setDoOutput(true);
			// 建立实际的连接
			connection.connect();
			out = new PrintWriter(connection.getOutputStream());
			// 发送请求参数
			out.print(param);
			// 定义 BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输入流
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 
	 * post 请求
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:05:18
	 * @param url
	 * @param param
	 * @return
	 */
	public static String sendPost(String url, Object param) {
		String result = "";
		HttpPost httpRequst = new HttpPost(url);// 创建HttpPost对象

		try {
			httpRequst.setEntity(new StringEntity(param.toString(), Charset.forName("UTF-8")));
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpRequst);
			if (httpResponse.getStatusLine().getStatusCode() == 200) {
				HttpEntity httpEntity = httpResponse.getEntity();
				result = EntityUtils.toString(httpEntity, "UTF-8");// 取出应答字符串
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = e.getMessage().toString();
		}
		return result;
	}

	/**
	 * 
	 * 根据参数获取签名
	 * 
	 * @author lyf
	 * @date 2015年3月10日 下午4:07:01
	 * @param map
	 * @return
	 */
	public static String getsign(Map<String, Object> map, String apikey) {

		Collection<String> keyset = map.keySet();
		List<String> list = new ArrayList<String>(keyset);

		// 对key键值按字典升序排序
		Collections.sort(list);
		String result = "";
		for (String s : list) {
			if (map.get(s) != null)
				result += s + "=" + map.get(s) + "&";
		}
		result += "key=" + apikey;
		// if (result.endsWith("&")) {
		// result = result.substring(0, result.length() - 1);
		// }
		result = MD5.GetMD5Code(result).toUpperCase();
		return result;
	}

	/**
	 * 
	 * 获取JS API 时签名
	 * 
	 * @author lyf
	 * @date 2015年6月15日 下午7:16:58
	 * @param map
	 * @return
	 */
	public static String getJSsign(Map<String, Object> map) {
		Collection<String> keyset = map.keySet();
		List<String> list = new ArrayList<String>(keyset);

		// 对key键值按字典升序排序
		Collections.sort(list);
		String result = "";
		for (String s : list) {
			if (map.get(s) != null)
				result += s + "=" + map.get(s) + "&";
		}
		if (result.endsWith("&")) {
			result = result.substring(0, result.length() - 1);
		}
		SHA1 sha1 = new SHA1();

		return sha1.Digest(result).toLowerCase();
	}

	/**
	 * 
	 * 获取XML格式的字符串
	 * 
	 * @author lyf
	 * @date 2015年3月10日 下午4:06:39
	 * @param map
	 * @return
	 */
	public static String getSendText(Map<String, Object> map) {
		StringBuilder sb2 = new StringBuilder();
		sb2.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><xml>");
		for (String key : map.keySet()) {
			sb2.append("<" + key + ">");
			sb2.append(map.get(key));
			sb2.append("</" + key + ">");
		}
		sb2.append("</xml>");

		return sb2.toString();
	}

	/**
	 * 
	 * TODO 证书认证的POST请求
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:17:02
	 * @param url
	 * @param param
	 * @param mchid
	 * @return
	 */
	public static Map<String, String> sendPostWithCA(String url, Object param, String mchid, String capath) {
		Map<String, String> result = null;
		try {
			KeyStore keyStore = KeyStore.getInstance("PKCS12");
			FileInputStream instream = new FileInputStream(new File(capath));
			try {
				keyStore.load(instream, mchid.toCharArray());
			} finally {
				instream.close();
			}
			// Trust own CA and all self-signed certs
			SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, mchid.toCharArray()).build();
			// Allow TLSv1 protocol only
			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" },
					null, SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
			CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
			try {

				HttpPost post = new HttpPost(url);

				StringEntity se = new StringEntity(param.toString(), Charset.forName("UTF-8"));
				post.setEntity(se);
				// System.out.println("executing request" +
				// post.getRequestLine());

				CloseableHttpResponse response = httpclient.execute(post);
				try {
					HttpEntity entity = response.getEntity();
					if (entity != null) {
						result = PushManageXml(entity.getContent());
					}
					EntityUtils.consume(entity);
				} finally {
					response.close();
				}
			} finally {
				httpclient.close();
			}

		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
		}
		return result;
	}

	/**
	 * 编译文本信息
	 * 
	 * @author xiaowu
	 * @since 2013-9-27
	 * @param toName
	 * @param FromName
	 * @param content
	 * @return
	 */
	public static String getBackXMLTypeText(String toName, String fromName, String content) {

		String returnStr = "";

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String times = format.format(new Date());

		Element rootXML = new Element("xml");

		rootXML.addContent(new Element("ToUserName").setText(fromName));
		rootXML.addContent(new Element("FromUserName").setText(toName));
		rootXML.addContent(new Element("CreateTime").setText(times));
		rootXML.addContent(new Element("MsgType").setText("text"));
		rootXML.addContent(new Element("Content").addContent(new CDATA(content)));

		Document doc = new Document(rootXML);

		XMLOutputter XMLOut = new XMLOutputter();
		returnStr = XMLOut.outputString(doc);

		return returnStr;
	}

	/**
	 * 编译图片信息(单图模式)
	 * 
	 * @author xiaowu
	 * @since 2013-9-27
	 * @param toName
	 * @param FromName
	 * @param content
	 * @return
	 */
	@SuppressWarnings("unused")
	public static String getBackXMLTypeImg(String toName, String fromName, String title, String content, String url,
			String pUrl) {
		String returnStr = "";
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String times = format.format(new Date());
		Element rootXML = new Element("xml");
		rootXML.addContent(new Element("ToUserName").setText(fromName));
		rootXML.addContent(new Element("FromUserName").setText(toName));
		rootXML.addContent(new Element("CreateTime").setText(times));
		rootXML.addContent(new Element("MsgType").setText("news"));
		rootXML.addContent(new Element("ArticleCount").setText("1"));
		Element fXML = new Element("Articles");
		Element mXML = null;
		mXML = new Element("item");
		mXML.addContent(new Element("Title").setText(title));
		mXML.addContent(new Element("Description").setText(content));
		mXML.addContent(new Element("PicUrl").setText(pUrl));
		mXML.addContent(new Element("Url").addContent(new CDATA(url)));
		fXML.addContent(mXML);
		rootXML.addContent(fXML);
		Document doc = new Document(rootXML);
		XMLOutputter XMLOut = new XMLOutputter();
		returnStr = XMLOut.outputString(doc);
		return returnStr;
	}

	/**
	 * 编译图片信息(多图文模式)
	 * 
	 * @author xiaowu
	 * @since 2013-9-27
	 * @param toName
	 * @param FromName
	 * @param content
	 * @return
	 */
	@SuppressWarnings("unused")
	public static String getBackXMLTypeImgS(String toName, String fromName, List<String> title, List<String> content,
			List<String> url, List<String> pUrl) {
		String returnStr = "";
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String times = format.format(new Date());
		Element rootXML = new Element("xml");
		rootXML.addContent(new Element("ToUserName").setText(fromName));
		rootXML.addContent(new Element("FromUserName").setText(toName));
		rootXML.addContent(new Element("CreateTime").setText(times));
		rootXML.addContent(new Element("MsgType").setText("news"));
		rootXML.addContent(new Element("ArticleCount").setText(title.size() + ""));
		Element fXML = new Element("Articles");
		Element mXML = null;
		for (int i = 0; i < title.size(); i++) {
			mXML = new Element("item");
			mXML.addContent(new Element("Title").setText(title.get(i)));
			mXML.addContent(new Element("Description").setText(content.get(i)));
			mXML.addContent(new Element("PicUrl").setText(pUrl.get(i)));
			mXML.addContent(new Element("Url").setText(url.get(i)));
			// mXML.addContent(new Element("Url").addContent(new
			// CDATA(url.get(i))));
			fXML.addContent(mXML);
		}
		rootXML.addContent(fXML);
		Document doc = new Document(rootXML);
		XMLOutputter XMLOut = new XMLOutputter();
		returnStr = XMLOut.outputString(doc);
		System.out.println(returnStr);
		return returnStr;
	}

	/**
	 * 编译图片信息(无图模式)
	 * 
	 * @author xiaowu
	 * @since 2013-9-27
	 * @param toName
	 * @param FromName
	 * @param content
	 * @return
	 */
	@SuppressWarnings("unused")
	private String getBackXMLTypeImg(String toName, String fromName, String title, String content, String url) {

		String returnStr = "";

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String times = format.format(new Date());

		Element rootXML = new Element("xml");

		rootXML.addContent(new Element("ToUserName").setText(fromName));
		rootXML.addContent(new Element("FromUserName").setText(toName));
		rootXML.addContent(new Element("CreateTime").setText(times));
		rootXML.addContent(new Element("MsgType").setText("news"));
		rootXML.addContent(new Element("ArticleCount").setText("1"));

		Element fXML = new Element("Articles");
		Element mXML = null;

		// String url = "";
		String ss = "";
		mXML = new Element("item");
		mXML.addContent(new Element("Title").setText(title));
		mXML.addContent(new Element("Description").setText(content));
		mXML.addContent(new Element("PicUrl").setText(ss));
		mXML.addContent(new Element("Url").setText(url));
		fXML.addContent(mXML);
		rootXML.addContent(fXML);

		Document doc = new Document(rootXML);

		XMLOutputter XMLOut = new XMLOutputter();
		returnStr = XMLOut.outputString(doc);

		return returnStr;
	}

	/**
	 * 编译音乐信息
	 * 
	 * @author xiaowu
	 * @since 2013-9-27
	 * @param toName
	 * @param FromName
	 * @param content
	 * @return
	 */
	@SuppressWarnings("unused")
	private String getBackXMLTypeMusic(String toName, String fromName, String content) {

		String returnStr = "";

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String times = format.format(new Date());

		Element rootXML = new Element("xml");

		rootXML.addContent(new Element("ToUserName").setText(fromName));
		rootXML.addContent(new Element("FromUserName").setText(toName));
		rootXML.addContent(new Element("CreateTime").setText(times));
		rootXML.addContent(new Element("MsgType").setText("music"));

		Element mXML = new Element("Music");

		mXML.addContent(new Element("Title").setText("音乐"));
		mXML.addContent(new Element("Description").setText("音乐让人心情舒畅！"));
		mXML.addContent(new Element("MusicUrl").setText(content));
		mXML.addContent(new Element("HQMusicUrl").setText(content));

		rootXML.addContent(mXML);

		Document doc = new Document(rootXML);

		XMLOutputter XMLOut = new XMLOutputter();
		returnStr = XMLOut.outputString(doc);

		return returnStr;
	}

	/**
	 * 上传图片
	 * 
	 * @param urlStr
	 * @param textMap
	 * @param fileMap
	 * @return
	 */
	@SuppressWarnings("rawtypes")
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
				Iterator<?> iter = textMap.entrySet().iterator();
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

	public static void main(String[] args) {
		System.out.println(getBackXMLTypeText("aa", "vvv", "a&n"));
	}

	/**
	 * 
	 * map转JSON字符串
	 * 
	 * @author lyf
	 * @date 2015年7月1日 上午10:22:14
	 * @param map
	 * @return
	 */
	public static String transMapToString(Map<?, ?> map) {
		return JSONObject.fromObject(map).toString();
	}

	/**
	 * 
	 * jsonarry 字符串转LIST
	 * 
	 * @author lyf
	 * @date 2015年7月1日 上午10:26:17
	 * @param jsonStr
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Object> parseJSON2List(String jsonStr) {
		List<Object> list = new ArrayList<Object>();
		Iterator<JSONObject> it = JSONArray.fromObject(jsonStr).iterator();
		while (it.hasNext()) {
			Object json2 = it.next();
			if (json2 instanceof JSONObject) {
				list.add(parseJSON2Map(json2.toString()));
			} else if (json2 instanceof JSONArray) {
				list.add(parseJSON2List(json2.toString()));
			} else {
				list.add(json2);
			}
		}
		return list;
	}

	/**
	 * 
	 * json字符串转MAP
	 * 
	 * @author lyf
	 * @date 2015年7月1日 上午10:26:41
	 * @param jsonStr
	 * @return
	 */
	public static Map<String, Object> parseJSON2Map(String jsonStr) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 最外层解析
		JSONObject json = JSONObject.fromObject(jsonStr);
		for (Object k : json.keySet()) {
			Object v = json.get(k);
			// 如果内层还是数组的话，继续解析
			if (v instanceof JSONArray) {
				map.put(k.toString(), parseJSON2List(v.toString()));
			} else if (v instanceof JSONObject) {
				map.put(k.toString(), parseJSON2Map(v.toString()));
			} else {
				map.put(k.toString(), v);
			}
		}
		return map;
	}

	/**
	 * 
	 * post 请求
	 * 
	 * @author lyf
	 * @date 2015年6月2日 下午2:05:18
	 * @param url
	 * @param param
	 * @return
	 */
	public static Map<String, Object> sendPostMap(String url, Object param) {
		HttpPost httpRequst = new HttpPost(url);// 创建HttpPost对象

		try {
			httpRequst.setEntity(new StringEntity(param.toString(), Charset.forName("UTF-8")));
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpRequst);
			if (httpResponse.getStatusLine().getStatusCode() == 200) {
				HttpEntity httpEntity = httpResponse.getEntity();
				return parseJSON2Map(EntityUtils.toString(httpEntity, "UTF-8"));// 取出应答字符串
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 
	 * 将卡券返回信息整理(不同类型卡券,返回的格式略有不同)
	 * 
	 * @author lyf
	 * @date 2015年7月2日 下午1:50:42
	 * @param data
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> changeInfo(Map<String, Object> data) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> card = (Map<String, Object>) data.get("card");
		String type = card.get("card_type").toString();
		Map<String, Object> kq = (Map<String, Object>) card.get(type.toLowerCase());
		if (type.equals("CASH")) {
			// 当为CASH时 朋友的券 满减门槛字段已朋友的券里面为准
			if (kq.containsKey("advanced_info")) {
				Map<String, Object> adinfo = (Map<String, Object>) kq.get("advanced_info");
				result.put("leastprice", adinfo.get("least_cost"));
			} else {
				result.put("leastprice", kq.get("least_cost"));
			}
			result.put("price", kq.get("reduce_cost"));
		} else if (type.equals("DISCOUNT")) {
			result.put("price", kq.get("discount"));
		}
		//判断朋友的券
		// if (kq.containsKey("advanced_info")) {
		// result.put("isfriend", "1");
		// } else {
		// result.put("isfriend", "0");
		// }
		result.put("isfriend", "0");
		Map<String, Object> baseinfo = (Map<String, Object>) kq.get("base_info");
		String title = baseinfo.get("title").toString();
		String status = baseinfo.get("status").toString();
		if (status.equals("CARD_STATUS_USER_DISPATCH") || status.equals("CARD_STATUS_VERIFY_OK")
				|| status.equals("CARD_STATUS_DISPATCH")) {
			result.put("state", 1);
		} else if (status.equals("CARD_STATUS_NOT_VERIFY")) {
			result.put("state", 2);
		} else if (status.equals("CARD_STATUS_VERIFY_FAIL")) {
			result.put("state", 3);
		} else if (status.equals("CARD_STATUS_USER_DELETE") || status.equals("CARD_STATUS_DELETE")) {
			result.put("state", 0);
		}
		List<Integer> locations = (List<Integer>) baseinfo.get("location_id_list");
		if (locations != null) {
			String ls = "";
			for (Integer l : locations) {
				ls += l + ",";
			}
			if (ls.endsWith(",")) {
				ls = ls.substring(0, ls.length() - 1);
			}
			result.put("locations", ls);
		}
		Map<String, Integer> sku = (Map<String, Integer>) baseinfo.get("sku");
		result.put("total", sku.get("total_quantity"));
		result.put("use", sku.get("quantity"));
		Map<String, Object> dateinfo = (Map<String, Object>) baseinfo.get("date_info");
		String datetype = dateinfo.get("type").toString();
		if (datetype.equals("DATE_TYPE_FIX_TIME_RANGE")) {
			result.put("datetype", 1);
			result.put("starttime", new Date(Long.parseLong(dateinfo.get("begin_timestamp") + "000")));
			result.put("endtime", new Date(Long.parseLong(dateinfo.get("end_timestamp") + "000")));
		} else {
			result.put("datetype", 2);
			result.put("delay", dateinfo.get("fixed_begin_term"));
			result.put("usetime", dateinfo.get("fixed_term"));

		}
		result.put("logourl", baseinfo.get("logo_url"));
		if (baseinfo.containsKey("sub_merchant_info")) {
			result.put("submerid", ((Map<String, Object>) baseinfo.get("sub_merchant_info")).get("merchant_id"));
		}
		result.put("title", title);
		result.put("type", type);

		return result;
	}

	public static String createQRImage(String targeturl, int width, int height) {

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String daystr = sdf.format(now);

		MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
		Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		hints.put(EncodeHintType.MARGIN, 0);
		BitMatrix bitMatrix;

		try {
			bitMatrix = multiFormatWriter.encode(targeturl, BarcodeFormat.QR_CODE, 400, 400, hints);
			System.out.println(Util.getRootPath());
			File pf = new File(Util.getRootPath() + File.separator + "merqr" + File.separator + daystr);
			if (!pf.exists()) {
				pf.mkdirs();
			}
			File f = new File(Util.getRootPath() + File.separator + "merqr" + File.separator + daystr + File.separator
					+ now.getTime() + ".png");

			MatrixToImageWriter.writeToFile(bitMatrix, "png", f);

			return "merqr" + "/" + daystr + "/" + now.getTime() + ".png";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("生成二维码出错");

			return null;
		}
	}

}
