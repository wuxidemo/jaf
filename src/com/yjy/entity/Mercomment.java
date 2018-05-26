package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @author liping
 *类mercomment.java的实现描述 评价
 */
@Entity
@Table(name="mercomment")
public class Mercomment {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;//评论id
	private String openid;//微信码
	private String content;//评价内容
	private Long merid;//商家id
	private Integer score;//评价分数
	private Date createtime;//评论时间
	private Long orderid;//订单编号
	private String urls;//品论图片 多张逗号隔开
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Long getMerid() {
		return merid;
	}
	public void setMerid(Long merid) {
		this.merid = merid;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getOrderid() {
		return orderid;
	}
	public void setOrderid(Long orderid) {
		this.orderid = orderid;
	}
	public String getUrls() {
		return urls;
	}
	public void setUrls(String urls) {
		this.urls = urls;
	}
	
}
