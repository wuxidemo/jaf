package com.yjy.utils;

import java.util.Map;

import com.yjy.wechat.WXUtil;

/**
 * 百度接口 根据IP查询 城市
 * 
 * @author lyf
 * @date 2015年9月2日 上午9:45:54
 */
public class IpUtils {
	public static String baidumapkey = "4N0PRohwPMkaZBEZRXXTeHmI";

	public static Map<String, Object> getAreaByIP(String ip) {
		String url = "http://api.map.baidu.com/location/ip?ip=" + ip + "&ak=" + baidumapkey;
		return WXUtil.sendPostMap(url, "");
	}

	public static Map<String, Object> getAreaByLocation(float lat, float lon) {
		String url = "http://api.map.baidu.com/geocoder?location=" + lat + "," + lon + "&ak=" + baidumapkey
				+ "&output=json";
		return WXUtil.sendPostMap(url, "");
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

	public static void main(String[] args) {
		System.out.println(decodeUnicode(
				"/*fgg_again*/phone({\"meta\":{\"result\":\"0\",\"result_info\":\"\",\"jump_url\":\"\"},\"data\":{\"operator\":\"\u79fb\u52a8\",\"area\":\"\u6c5f\u82cf\",\"area_operator\":\"\u6c5f\u82cf\u79fb\u52a8\",\"support_price\":{\"500\":\"507\",\"1000\":\"1004\",\"2000\":\"2008\"}}})"));
	}
	
	
	/***************************************************/
	
	public static String getLocation(float lat, float lon) {
		String url = "http://api.map.baidu.com/geocoder?location=" + lat + "," + lon + "&ak=" + baidumapkey
				+ "&output=json";
		return SocketUtil.sendGet(url, "");
	}
}
