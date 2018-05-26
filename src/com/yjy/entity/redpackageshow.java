package com.yjy.entity;

import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class redpackageshow {

	private String wishstring;// 红包祝福语
	private String nickname;// 提供方名称
	private String sendname;// 商户名称
	private String actname;// 支付返利活动
	private String remark;// 备注


	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSendname() {
		return sendname;
	}

	public void setSendname(String sendname) {
		this.sendname = sendname;
	}

	public String getActname() {
		return actname;
	}

	public void setActname(String actname) {
		this.actname = actname;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getWishstring() {
		return wishstring;
	}

	public void setWishstring(String wishstring) {
		this.wishstring = wishstring;
	}

}
