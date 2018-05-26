package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "refundorder")
@Entity
public class RefundOrder {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Date createtime;
	private String refundcode; // 退款单号
	private int state; // 1处理中2 已退款3失败
	private String failreason;// 失败原因
	private int refundfee;// 退款金额
	private String ordernum;// 支付订单
	private String opuser;// 操作员
	private String translatenum;// 微信/支付宝订单
	private String submchid; // 子商户ID
	private String openid;
	private Long merchantid;
	private Long payorderid;

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

	public String getRefundcode() {
		return refundcode;
	}

	public void setRefundcode(String refundcode) {
		this.refundcode = refundcode;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getRefundfee() {
		return refundfee;
	}

	public void setRefundfee(int refundfee) {
		this.refundfee = refundfee;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public String getOpuser() {
		return opuser;
	}

	public void setOpuser(String opuser) {
		this.opuser = opuser;
	}

	public String getTranslatenum() {
		return translatenum;
	}

	public void setTranslatenum(String translatenum) {
		this.translatenum = translatenum;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public Long getMerchantid() {
		return merchantid;
	}

	public void setMerchantid(Long merchantid) {
		this.merchantid = merchantid;
	}

	public String getSubmchid() {
		return submchid;
	}

	public void setSubmchid(String submchid) {
		this.submchid = submchid;
	}

	public Long getPayorderid() {
		return payorderid;
	}

	public void setPayorderid(Long payorderid) {
		this.payorderid = payorderid;
	}

	public String getFailreason() {
		return failreason;
	}

	public void setFailreason(String failreason) {
		this.failreason = failreason;
	}
}
