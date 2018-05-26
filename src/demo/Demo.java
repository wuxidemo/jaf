package demo;


import java.util.ArrayList;
import java.util.List;

import com.gexin.rp.sdk.base.IIGtPush;
import com.gexin.rp.sdk.base.IPushResult;
import com.gexin.rp.sdk.base.impl.AppMessage;
import com.gexin.rp.sdk.http.IGtPush;
import com.gexin.rp.sdk.template.TransmissionTemplate;

public class Demo {
	private static final String APPID = "LMINYY9ciB6ZQs5jCONkw8";
	private static final String APPKEY = "IxSBqkIsy69Qon1cpKqUWA";
	private static final String MASTERSECRET = "W8hQAtOwxk5qpzDsqzTpy4";
//	private static final String CLIENTID = "97a199d6669f089a59f01615f7c2050d";
	private static final String API = "http://sdk.open.api.igexin.com/apiex.htm"; 	//OpenService接口地址

	public static void main(String[] args) {
		// 推送主类
		IIGtPush push = new IGtPush(API, APPKEY, MASTERSECRET);

		try {

			AppMessage message = new AppMessage();

			TransmissionTemplate template = new TransmissionTemplate();
			template.setAppId(APPID);
			template.setAppkey(APPKEY);
			template.setTransmissionContent("您需要透传的内容{}");
			
			//收到消息是否立即启动应用，1为立即启动，2则广播等待客户端自启动
			template.setTransmissionType(1);					

			message.setData(template);


			List<String> appIdList = new ArrayList<String>();
			appIdList.add(APPID);

			List<String> phoneTypeList = new ArrayList<String>();//通知接收者的手机操作系统类型，可选
			phoneTypeList.add("ANDROID");

//			List<String> provinceList = new ArrayList<String>();		//通知接收者所在省份，可选
//			provinceList.add("浙江");
//			provinceList.add("上海");
//			provinceList.add("北京");
			
//			List<String> tagList = new ArrayList<String>();			//通知接收者的标签用户，可选
//			tagList.add("填写tags名称");

			message.setAppIdList(appIdList);				
			message.setPhoneTypeList(phoneTypeList);
//			message.setProvinceList(provinceList);
//			message.setTagList(tagList);

			IPushResult ret = push.pushMessageToApp(message);	

			System.out.println(ret.getResponse().toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
