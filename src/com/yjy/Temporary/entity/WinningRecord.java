package com.yjy.Temporary.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "act_winningrecord")
public class WinningRecord {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private String openid;
	private Date createtime;
	private String type; // 类型
	private int state; // 1正常2已领取
	private Date wintime;// 抽奖记录的时间
	private int winname; // 几等奖
	private Integer subname;// 当奖项有细分
	private String phone;
	private Long tkid;

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getWintime() {
		return wintime;
	}

	public void setWintime(Date wintime) {
		this.wintime = wintime;
	}

	public int getWinname() {
		return winname;
	}

	public void setWinname(int winname) {
		this.winname = winname;
	}

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

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getTkid() {
		return tkid;
	}

	public void setTkid(Long tkid) {
		this.tkid = tkid;
	}

	public Integer getSubname() {
		return subname;
	}

	public void setSubname(Integer subname) {
		this.subname = subname;
	}

}
