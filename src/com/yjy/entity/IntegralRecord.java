package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 积分使用记录表
 * 
 * @author luyf
 *
 */
@Entity
@Table(name = "integralrecord")
public class IntegralRecord {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Date createtime;
	private int count; // 分数
	private int type;// 使用类型 1换卡券
	private String openid;
	private String name;
	private String phone;
	private String cardcode;
	private String cardname;
	private String cardtype;
	private String cardnum;
	private Long inuserid;
	
	public IntegralRecord(){
		
	}
	

	public IntegralRecord(Long id, Date createtime, int count, int type2, String openid, String name, String phone,
			String cardcode, String cardname, String cardtype, String cardnum, Long inuserid) {
		super();
		this.id = id;
		this.createtime = createtime;
		this.count = count;
		this.type = type2;
		this.openid = openid;
		this.name = name;
		this.phone = phone;
		this.cardcode = cardcode;
		this.cardname = cardname;
		this.cardtype = cardtype;
		this.cardnum = cardnum;
		this.inuserid = (long) inuserid;
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

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
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

	public String getCardcode() {
		return cardcode;
	}

	public void setCardcode(String cardcode) {
		this.cardcode = cardcode;
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

	public String getCardnum() {
		return cardnum;
	}

	public void setCardnum(String cardnum) {
		this.cardnum = cardnum;
	}

	public Long getInuserid() {
		return inuserid;
	}

	public void setInuserid(Long inuserid) {
		this.inuserid = inuserid;
	}

}
