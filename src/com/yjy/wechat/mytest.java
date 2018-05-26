package com.yjy.wechat;

import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

public class mytest {
	public static void main(String[] args) {
		// "http://api.weixin.qq.com/cgi-bin/poi /getpoilist?access_token=TOKEN"
		// String param = "{\"begin\":0,\"limit\":10}";
		// System.out
		// .println(WXUtil
		// .sendPost(
		// "http://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=lEsxhWgpB5J84aPIoRVybNHA8nBjwBq9RgFXxwSy2kZ3DGd3oufLay3GZM1IPQDvCJbz8eQ6Qi8zJiA2cByUKQj9i58OPLIsFGfkdhUoA5I",
		// param));

		String str = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=NGvEt4VY--LnrX5C2KdYro4ZOIZhPiqS3vIY7qVkcKca5mThN2eDUp55GyqR1hu-xPHZvZ2xVrn59GA7qZlcs0Q7hq8fSYpv98zZPreQ73I";
		String filePath = "D:\\a.jpg";
		String fileName = "a.jpg";
		try {
			URL url = new URL(str);
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			connection.setDoInput(true);
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			connection.addRequestProperty("FileName", fileName);
			connection.setRequestProperty("content-type", "multipart/form-data;");
			BufferedOutputStream out = new BufferedOutputStream(
					connection.getOutputStream());

			// 读取文件上传到服务器
			File file = new File(filePath);
			FileInputStream fileInputStream = new FileInputStream(file);
			byte[] bytes = new byte[1024];
			int numReadByte = 0;
			while ((numReadByte = fileInputStream.read(bytes, 0, 1024)) > 0) {
				out.write(bytes, 0, numReadByte);
			}

			out.flush();
			fileInputStream.close();
			// 读取URLConnection的响应
			DataInputStream in = new DataInputStream(
					connection.getInputStream());
			String line;
			String result="";
			while ((line = in.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void setnum(int d) {
		num = d;
	}

	public static int num = 0;
}
