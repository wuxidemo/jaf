package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "inuser")
@Entity
public class Inuser {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
    private String name;
    private String phone;
    private String cardnum;
    private int point;
    private int state;
    private Date createtime;
    private Date updatetime;
    private String openid;
    private String type;
    public Inuser () {
	}
	
	public Inuser (Long id, String name, String phone, String cardnum,
			int point, int state, Date createtime, Date updatetime,String openid,String type) {
		super();
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.cardnum = cardnum;
		this.point = point;
		this.state = state;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.openid=openid;
		this.type=type;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getCardnum() {
		return cardnum;
	}

	public void setCardnum(String cardnum) {
		this.cardnum = cardnum;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int  val) {
		this.point = val;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

 
}