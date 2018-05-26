package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 微信用户表
 * 
 * @author lyf
 *
 */
@Entity
@Table(name = "wxuser")
public class WXUser {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String openid;

	private String realname;

	private int sex; // 1男2女

	private int state;// 1关注2取消

	private String headimgurl;// 头像路径

	private int count;

	private String name;

	private Integer firstpay; // 是否第一次支付 1 已支付 0未支付

	private Date creattime;

	private String fromact; // 来源

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getHeadimgurl() {
		return headimgurl;
	}

	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getFirstpay() {
		return firstpay;
	}

	public void setFirstpay(Integer firstpay) {
		this.firstpay = firstpay;
	}

	public Date getCreattime() {
		return creattime;
	}

	public void setCreattime(Date creattime) {
		this.creattime = creattime;
	}

	public String getFromact() {
		return fromact;
	}

	public void setFromact(String fromact) {
		this.fromact = fromact;
	}

}
