package com.yjy.utils;

import java.rmi.RemoteException;

import org.tempuri.LinkWSSoapProxy;

public class SendMessage {
	// LKSDK0003406 duwei@85959999
	public static String CorpID = "LKSDK0005600";// 短信平台用户名
	public static String Pwd = "dwkj@188";// 短信平台密码 yjy406@z dw@85959999

	public static String YZMCorpID = "LKSDK0003406";// 验证码账号
	public static String YZMPwd = "duwei@85959999";// 验证码密码

	/**
	 * 
	 * 发送验证码短信
	 * 
	 * @author lyf
	 * @date 2016年3月9日 下午2:30:30
	 * @param Mobile
	 * @param Content
	 * @param send_time
	 * @return
	 */
	public static boolean sendYZMSMS(String Mobile, String Content, String send_time) {
		return sendSMS(YZMCorpID, YZMPwd, Mobile, Content, send_time);
	}

	/**
	 * 
	 * 发送营销短信
	 * 
	 * @author lyf
	 * @date 2016年3月9日 下午2:30:44
	 * @param Mobile
	 * @param Content
	 * @param send_time
	 * @return
	 */
	public static boolean sendYXSMS(String Mobile, String Content, String send_time) {
		return sendSMS(CorpID, Pwd, Mobile, Content, send_time);
	}

	/**
	 * 短信发送功能
	 * 
	 * @author lyf
	 * @param Mobile,手机号码
	 * @param Content,发送内容
	 * @param send_time
	 *            发送时间
	 */
	public static boolean sendSMS(String corpid, String pwd, String Mobile, String Content, String send_time) {
		LinkWSSoapProxy l = new LinkWSSoapProxy();
		// String send_content = URLEncoder.encode(Content.replaceAll("<br/>", "
		// "), "GBK");
		int result = 0;
		try {
			result = l.batchSend(corpid, pwd, Mobile, Content, "", "");
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(result);
		if (result >= 0)
			return true;
		else
			return false;
	}

	/**
	 * 
	 * 查询短信余额
	 * 
	 * @author lyf
	 * @date 2016年3月2日 上午11:21:38
	 * @return
	 */
	public static int SelSum() {
		LinkWSSoapProxy l = new LinkWSSoapProxy();
		try {
			return l.selSum(CorpID, Pwd);
		} catch (RemoteException e) {
			e.printStackTrace();
			return -200;
		}
	}

	/**
	 * 
	 * 接收短信
	 * 
	 * @author lyf
	 * @date 2016年3月2日 上午11:34:24
	 * @return
	 */
	public static String getSMS() {
		LinkWSSoapProxy l = new LinkWSSoapProxy();
		try {
			return l.get(CorpID, Pwd);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "-200";
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(getSMS());
	}

	/**
	 * 短信发送功能
	 * 
	 * @author zmm
	 * @param Mobile,手机号码
	 * @param Content,发送内容
	 * @param send_time
	 *            发送时间
	 */
	/**
	 * public static int sendSMS(String Mobile, String Content, String
	 * send_time) throws MalformedURLException, UnsupportedEncodingException {
	 * URL url = null; String send_content =
	 * URLEncoder.encode(Content.replaceAll("<br/>", " "), "GBK"); url = new
	 * URL("http://mb345.com/WS/BatchSend.aspx?CorpID=" + CorpID + "&Pwd=" + Pwd
	 * + "&Mobile=" + Mobile + "&Content=" + send_content + "&Cell=&SendTime=" +
	 * send_time); BufferedReader in = null; int inputLine = 0; try {
	 * System.out.println("手机号码" + Mobile); in = new BufferedReader(new
	 * InputStreamReader(url.openStream())); inputLine = new
	 * Integer(in.readLine()).intValue(); } catch (Exception e) {
	 * System.out.println("短信发送异常"); inputLine = -2; } System.out.println(
	 * "inputLine " + inputLine); return inputLine; }
	 **/

}
