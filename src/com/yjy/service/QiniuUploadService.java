package com.yjy.service;


import com.yjy.utils.QiniuUploadConfig;

import org.json.JSONException;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.qiniu.api.auth.digest.Mac;
import com.qiniu.api.io.IoApi;
import com.qiniu.api.io.PutExtra;
import com.qiniu.api.io.PutRet;
import com.qiniu.api.rs.PutPolicy;


/**
 * 七牛云上传服务
 * @author wangjinjun
 * 
 */
@Component
@Transactional
public class QiniuUploadService {

	
	
	/**
	 * 
	 * @param filePath 本地文件绝对路径
	 * @return 服务器文件名
	 * @throws Exception
	 * @throws JSONException
	 */
	public String uploadFile(String filePath,String key) throws Exception ,JSONException{
		
		Mac mac = new Mac(QiniuUploadConfig.ACCESS_KEY, QiniuUploadConfig.SECRET_KEY);
		// 请确保该bucket已经存在
		PutPolicy putPolicy = new PutPolicy(QiniuUploadConfig.bucketName);
		String uptoken = putPolicy.token(mac);
		PutExtra extra = new PutExtra();
		
		PutRet ret = IoApi.putFile(uptoken, key, filePath, extra);
		if (ret.ok()) {
			return ret.getKey();
		} else {
			return  "";
		}
	
	}
	
	public static void main(String args []){
		try {
			new QiniuUploadService().uploadFile("D:\\ab5.jpg","test");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
