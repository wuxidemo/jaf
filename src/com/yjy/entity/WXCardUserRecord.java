//package com.yjy.entity;
//
//import java.util.Date;
//
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.Table;
//
//@Entity
//@Table(name = "wxcarduserrecord")
//public class WXCardUserRecord {
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private Long id;
//	private Date createtime;
//	private Date usertime;
//	private String openid;// 使用人ID
//	private Long orderid; // 订单号
//	private String ordercode;// 订单编号
//	private String cardcord;// 卡券code
//	private String cardid;// 卡券ID
//	private Long merchantid;// 商户ID
//	private String merchantname;// 商户名称
//	private String cardname;// 卡券名称
//	private int state;// 状态 0未使用1已使用
//
//	public Long getId() {
//		return id;
//	}
//
//	public void setId(Long id) {
//		this.id = id;
//	}
//
//	public Date getCreatetime() {
//		return createtime;
//	}
//
//	public void setCreatetime(Date createtime) {
//		this.createtime = createtime;
//	}
//
//	public Date getUsertime() {
//		return usertime;
//	}
//
//	public void setUsertime(Date usertime) {
//		this.usertime = usertime;
//	}
//
//	public String getOpenid() {
//		return openid;
//	}
//
//	public void setOpenid(String openid) {
//		this.openid = openid;
//	}
//
//	public Long getOrderid() {
//		return orderid;
//	}
//
//	public void setOrderid(Long orderid) {
//		this.orderid = orderid;
//	}
//
//	public String getCardcord() {
//		return cardcord;
//	}
//
//	public void setCardcord(String cardcord) {
//		this.cardcord = cardcord;
//	}
//
//	public String getCardid() {
//		return cardid;
//	}
//
//	public void setCardid(String cardid) {
//		this.cardid = cardid;
//	}
//
//	public Long getMerchantid() {
//		return merchantid;
//	}
//
//	public void setMerchantid(Long merchantid) {
//		this.merchantid = merchantid;
//	}
//
//	public String getMerchantname() {
//		return merchantname;
//	}
//
//	public void setMerchantname(String merchantname) {
//		this.merchantname = merchantname;
//	}
//
//	public String getCardname() {
//		return cardname;
//	}
//
//	public void setCardname(String cardname) {
//		this.cardname = cardname;
//	}
//
//	public String getOrdercode() {
//		return ordercode;
//	}
//
//	public void setOrdercode(String ordercode) {
//		this.ordercode = ordercode;
//	}
//
//	public int getState() {
//		return state;
//	}
//
//	public void setState(int state) {
//		this.state = state;
//	}
//}
