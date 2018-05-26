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

/**
 * 捐赠的所有的记录（包括线上线下企业）
 *
 */
@Entity
@Table(name = "sq_donation")
public class Sq_Donation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String num;
	private String name;
	private String phone;
	private Integer type;// 捐献方式 1线上2线下3企业
	private String context;// 捐献内容
	private Date createtime;
	@JoinColumn(name = "comid")
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	private Community community;
	private Integer price;// 金额（分）
	private String company;// 企业名称
	private Integer sex;// 性别 1男0女
	private String openid;
	private Integer contexttype;// 捐赠内容类型 1金钱2物品
	private String wxnum; // 微信订单编号(线上时有效)
	private String picurl;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Community getCommunity() {
		return community;
	}

	public void setCommunity(Community community) {
		this.community = community;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public Integer getContexttype() {
		return contexttype;
	}

	public void setContexttype(Integer contexttype) {
		this.contexttype = contexttype;
	}

	public String getWxnum() {
		return wxnum;
	}

	public void setWxnum(String wxnum) {
		this.wxnum = wxnum;
	}

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

}
