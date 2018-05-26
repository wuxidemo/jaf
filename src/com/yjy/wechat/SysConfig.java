package com.yjy.wechat;

public class SysConfig {
	public static String BASEURL = "http://ts.do-wi.cn/nsh";
	public static String NSHCode = "XXXX";
	public static String redirect_uri = "http%3A%2F%2Fts.do-wi.cn%2Fnsh%2Fwxurl%2Fsavecode";
	// 接收微信支付异步通知回调地址
	public static String notify_url = BASEURL + "/wxurl/payback";
}
