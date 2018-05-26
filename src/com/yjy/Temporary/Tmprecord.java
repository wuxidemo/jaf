package com.yjy.Temporary;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tmprecord")
public class Tmprecord {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Date createtime;
	private String openid;
	private String name;
	private String qrcode;
	private int state; // 0未支付1支付未领取2已领取
	private String code;
	private String wxcode;
	private Long actid;
	private String rebatecode;
	private int price; // 支付金额
	private int rebateprice;// 红包金额
	private int rebatestate;// 0未发放1已发放-1 方法失败
	private Date paytime;

	public String getRebatecode() {
		return rebatecode;
	}

	public void setRebatecode(String rebatecode) {
		this.rebatecode = rebatecode;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getRebateprice() {
		return rebateprice;
	}

	public void setRebateprice(int rebateprice) {
		this.rebateprice = rebateprice;
	}

	public int getRebatestate() {
		return rebatestate;
	}

	public void setRebatestate(int rebatestate) {
		this.rebatestate = rebatestate;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getQrcode() {
		return qrcode;
	}

	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getWxcode() {
		return wxcode;
	}

	public void setWxcode(String wxcode) {
		this.wxcode = wxcode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getActid() {
		return actid;
	}

	public void setActid(Long actid) {
		this.actid = actid;
	}

	public Date getPaytime() {
		return paytime;
	}

	public void setPaytime(Date paytime) {
		this.paytime = paytime;
	}

}
