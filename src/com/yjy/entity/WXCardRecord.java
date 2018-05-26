package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 卡券记录
 * 
 * @author lyf
 *
 */
@Entity
@Table(name = "wxcardrecord")
public class WXCardRecord {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String cardid; // 卡券ID
	private String cardname;// 卡券名称
	private String cardtype;// 卡券类型
	private Date createtime;
	private int state; // 1 正常 2 已使用3删除4过期
	private String openid; // 所属人ID
	private String ownname;// 所有人昵称
	private String code; // 编号
	private Date starttime;
	private Date endtime;
	private Long merchantid;// 商户ID
	private String merchantname;// 商户名称
	private Date usetime;// 使用时间
	private Long orderid;// 订单ID
	private String ordercode;// 订单编号
	private Integer shopprice; // 商户金额
	private Integer bankprice;// 银行金额
	private Long wxmerchantid; // 卡券子商户ID
	private String wxmerchantname;// 卡券子商户名
	private Integer isbank;

	public Long getWxmerchantid() {
		return wxmerchantid;
	}

	public void setWxmerchantid(Long wxmerchantid) {
		this.wxmerchantid = wxmerchantid;
	}

	public Integer getShopprice() {
		return shopprice;
	}

	public void setShopprice(Integer shopprice) {
		this.shopprice = shopprice;
	}

	public Integer getBankprice() {
		return bankprice;
	}

	public void setBankprice(Integer bankprice) {
		this.bankprice = bankprice;
	}

	public Long getOrderid() {
		return orderid;
	}

	public void setOrderid(Long orderid) {
		this.orderid = orderid;
	}

	public String getOrdercode() {
		return ordercode;
	}

	public void setOrdercode(String ordercode) {
		this.ordercode = ordercode;
	}

	public Long getMerchantid() {
		return merchantid;
	}

	public void setMerchantid(Long merchantid) {
		this.merchantid = merchantid;
	}

	public String getMerchantname() {
		return merchantname;
	}

	public void setMerchantname(String merchantname) {
		this.merchantname = merchantname;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCardname() {
		return cardname;
	}

	public void setCardname(String cardname) {
		this.cardname = cardname;
	}

	public String getCardtype() {
		return cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}

	public String getOwnname() {
		return ownname;
	}

	public void setOwnname(String ownname) {
		this.ownname = ownname;
	}

	public Date getUsetime() {
		return usetime;
	}

	public void setUsetime(Date usetime) {
		this.usetime = usetime;
	}

	public String getWxmerchantname() {
		return wxmerchantname;
	}

	public void setWxmerchantname(String wxmerchantname) {
		this.wxmerchantname = wxmerchantname;
	}

	public Integer getIsbank() {
		return isbank;
	}

	public void setIsbank(Integer isbank) {
		this.isbank = isbank;
	}

}
