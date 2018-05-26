package com.yjy.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

//微信平台开发微信页面配置：
//  一、微信平台
//			1.服务器配置       		  	微信平台->开发者中心->配置项->服务器配置  (启用配置后,微信后台页面自定义菜单失效)
//    		2.OAuth2.0网页授权配置      微信平台->开发者中心->配置项->网页服务->网页账号 (网页服务在下面的列表中)
//          3.JS接口安全域名                        微信平台->公众号设置->功能设置->JS接口安全域名  (用于JS-SDK配置)
//          4.支付配置                                      微信平台->微信支付->开发配置->支付配置(支付授权目录、支付请求类型的配置,主要用于支付.详情查看相应文档)
//  二、商户平台
//          1.API密钥                                     商户平台->账户设置->API安全
//
//
//

/**
 * 微信平台/商户平台 基本信息
 * 
 * @author lyf
 *
 */
@Table(name = "wechataccount")
@Entity
public class WeChatAccount {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	// 微信信息 开发者中心->配置项
	private String appid; // 应用ID
	private String appsecret;// 应用密钥

	// 系统更新信息
	private String accesstoken;// 公众号的全局唯一票据

	private String jsapiticket;// JSAPI_TICKET 获取js-sdk票据

	private String jsapiticketforcard;// JSAPI_TICKET 获取js-sdk票据 (领取优惠券)

	// 商户信息
	private String mcid; // 微信支付商户号 商户平台->账户设置->账户信息
	private String apikey;// API密钥 商户平台->账户设置->API安全
	private String fwsmcid; // 服务商ID
	private int state;// 账户状态 1正常0停用
	private int main;// 是否为微信主平台
	private String cafilepath; // 安全文件路径
	private String fwscafilepath;// 服务商证书地址

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getAppsecret() {
		return appsecret;
	}

	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}

	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}

	public String getJsapiticket() {
		return jsapiticket;
	}

	public void setJsapiticket(String jsapiticket) {
		this.jsapiticket = jsapiticket;
	}

	public String getMcid() {
		return mcid;
	}

	public void setMcid(String mcid) {
		this.mcid = mcid;
	}

	public String getApikey() {
		return apikey;
	}

	public void setApikey(String apikey) {
		this.apikey = apikey;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getMain() {
		return main;
	}

	public void setMain(int main) {
		this.main = main;
	}

	public String getCafilepath() {
		return cafilepath;
	}

	public void setCafilepath(String cafilepath) {
		this.cafilepath = cafilepath;
	}

	public String getJsapiticketforcard() {
		return jsapiticketforcard;
	}

	public void setJsapiticketforcard(String jsapiticketforcard) {
		this.jsapiticketforcard = jsapiticketforcard;
	}

	public String getFwsmcid() {
		return fwsmcid;
	}

	public void setFwsmcid(String fwsmcid) {
		this.fwsmcid = fwsmcid;
	}

	public String getFwscafilepath() {
		return fwscafilepath;
	}

	public void setFwscafilepath(String fwscafilepath) {
		this.fwscafilepath = fwscafilepath;
	}
}
