package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 返利记录
 * 
 * @author lyf
 *
 */
@Table(name = "rebaterecord")
@Entity
public class RebateRecord {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private int price; // 分
	private Date createdate;
	private String wxcode; // 微信订单
	private String mycode;// 系统订单
	private String receiveopenid;// 收红包ID
	private String receivename;// 收紅包昵称
	private Long merchantid; // 商户ID
	private String merhchantname; // 商户名称
	private Long rebateid; // 返利编号
	private String rebatename;// 返利名称
	private String rebatecode; // 返利编号 用户查询领取状态
	private int state; // 状态 1已发放2已领取3已退款
	private int type;// 类型 1首次红包2返利红包

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
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

	public String getReceiveopenid() {
		return receiveopenid;
	}

	public void setReceiveopenid(String receiveopenid) {
		this.receiveopenid = receiveopenid;
	}

	public String getReceivename() {
		return receivename;
	}

	public void setReceivename(String receivename) {
		this.receivename = receivename;
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

	public Long getRebateid() {
		return rebateid;
	}

	public void setRebateid(Long rebateid) {
		this.rebateid = rebateid;
	}

	public String getRebatename() {
		return rebatename;
	}

	public void setRebatename(String rebatename) {
		this.rebatename = rebatename;
	}

	public String getRebatecode() {
		return rebatecode;
	}

	public void setRebatecode(String rebatecode) {
		this.rebatecode = rebatecode;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
