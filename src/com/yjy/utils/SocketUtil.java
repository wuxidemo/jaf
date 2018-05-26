package com.yjy.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;

public class SocketUtil {

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
			in = new BufferedReader(new InputStreamReader(
					connection.getInputStream(),"UTF-8"));
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

	public static String sendPost(String url, Object param) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置通用的请求属性 注意Authorization生成
			// conn.setRequestProperty("Content-Type",
			// "application/x-www-form-urlencoded");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(new OutputStreamWriter(conn.getOutputStream(),"utf-8"));
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream(),"utf-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
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
			}
		}
		return result;
	}

	public static void main(String args[]) throws UnknownHostException,
			IOException {
		// try {
		// Socket socket = new Socket("127.0.0.1", 5566);
		// // 向本机的4700端口发出客户请求
		// BufferedReader sin = new BufferedReader(new InputStreamReader(
		// System.in));
		// // 由系统标准输入设备构造BufferedReader对象
		// PrintWriter os = new PrintWriter(socket.getOutputStream());
		// // 由Socket对象得到输出流，并构造PrintWriter对象
		// BufferedReader is = new BufferedReader(new InputStreamReader(
		// socket.getInputStream()));
		// // 由Socket对象得到输入流，并构造相应的BufferedReader对象
		//
		// os.println("asdasdf");
		// os.flush();
		// System.out.println(is.readLine());
		// os.close(); // 关闭Socket输出流
		// is.close()·; // 关闭Socket输入流
		// socket.close(); // 关闭Socket
		// } catch (Exception e) {
		// System.out.println("Error" + e); // 出错，则打印出错信息
		// }

//		WXManage.getUserInfo("ovu93uJNPklMs7vO-R2ari58qBSc");
	}
	
	public static String getak(String requestURL){
		StringBuffer buffer=null;
		try {
			//建立连接
			URL  url=new URL(requestURL);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoInput(true);
			httpUrlConn.setRequestMethod("GET");
			
			// 获取输入流
						InputStream inputStream = httpUrlConn.getInputStream();
						InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
						BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

						
		    //读取返回结果
					   buffer=new StringBuffer();
					   String str=null;
					   while((str = bufferedReader.readLine()) != null){
					   buffer.append(str);
					   }
					   
					// 释放资源
						bufferedReader.close();
						inputStreamReader.close();
						inputStream.close();
						httpUrlConn.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return  buffer.toString();
	}
}
