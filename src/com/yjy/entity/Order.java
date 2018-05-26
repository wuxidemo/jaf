package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "myorder")
@Entity
public class Order {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String code;
	private Long merchantid; // 商户ID
	private String merhchantname;
	private String createopenid;
	private String payopenid;
	private String payname; // 支付微信号昵称
	private Date createtime;
	private Date paytime;
	private String wxcode;// 微信订单号
	private int state;// 0未支付 1 支付 2 取消
	private int price;
	private int payprice; // 支付金额
	private String banktype;
	private String cwxcode;// 与微信订单关联编号
	private int needprice;// 需要支付金额
	private Integer isusecard;//是否使用卡券

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getPaytime() {
		return paytime;
	}

	public void setPaytime(Date paytime) {
		this.paytime = paytime;
	}

	public String getWxcode() {
		return wxcode;
	}

	public void setWxcode(String wxcode) {
		this.wxcode = wxcode;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getBanktype() {
		return banktype;
	}

	public void setBanktype(String banktype) {
		this.banktype = banktype;
	}

	public Long getMerchantid() {
		return merchantid;
	}

	public void setMerchantid(Long merchantid) {
		this.merchantid = merchantid;
	}

	public String getMerhchantname() {
		return merhchantname;
	}

	public void setMerhchantname(String merhchantname) {
		this.merhchantname = merhchantname;
	}

	public String getCwxcode() {
		return cwxcode;
	}

	public void setCwxcode(String cwxcode) {
		this.cwxcode = cwxcode;
	}

	public String getCreateopenid() {
		return createopenid;
	}

	public void setCreateopenid(String createopenid) {
		this.createopenid = createopenid;
	}

	public String getPayopenid() {
		return payopenid;
	}

	public void setPayopenid(String payopenid) {
		this.payopenid = payopenid;
	}

	public int getPayprice() {
		return payprice;
	}

	public void setPayprice(int payprice) {
		this.payprice = payprice;
	}

	public String getPayname() {
		return payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

	public int getNeedprice() {
		return needprice;
	}

	public void setNeedprice(int needprice) {
		this.needprice = needprice;
	}

	public Integer getIsusecard() {
		return isusecard;
	}

	public void setIsusecard(Integer isusecard) {
		this.isusecard = isusecard;
	}
}
