package com.yjy.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="sq_qgorder")
public class Sq_QGOrder {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	private String wxcode;
	private String mycode;
	@JoinColumn(name = "actid")
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	private Sq_QuickBuy sqquickbuy;
	private Integer paymoney;
	private Date paytime;
	private String openid;
	private String nickname;
	private Integer hascard;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getWxcode() {
		return wxcode;
	}
	public void setWxcode(String wxcode) {
		this.wxcode = wxcode;
	}
	public String getMycode() {
		return mycode;
	}
	public void setMycode(String mycode) {
		this.mycode = mycode;
	}
	public Sq_QuickBuy getSqquickbuy() {
		return sqquickbuy;
	}
	public void setSqquickbuy(Sq_QuickBuy sqquickbuy) {
		this.sqquickbuy = sqquickbuy;
	}
	public Integer getPaymoney() {
		return paymoney;
	}
	public void setPaymoney(Integer paymoney) {
		this.paymoney = paymoney;
	}
	public Date getPaytime() {
		return paytime;
	}
	public void setPaytime(Date paytime) {
		this.paytime = paytime;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Integer getHascard() {
		return hascard;
	}
	public void setHascard(Integer hascard) {
		this.hascard = hascard;
	}
	
	
}
