package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 返利
 * 
 * @author lyf
 *
 */
@Table(name = "rebate")
@Entity
public class Rebate extends redpackageshow {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private Date starttime;
	private Date endtime;
	private int proportion; // 返利 1-100
	private Integer maxordernum; // 每天交易数量上限
	private Integer maxprice;// 每单返利金额 分
	private int mustbank;// 是否必须农商行卡
	private int state; // 1 正常 2过期 0停用/未激活

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


	public int getMustbank() {
		return mustbank;
	}

	public void setMustbank(int mustbank) {
		this.mustbank = mustbank;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getProportion() {
		return proportion;
	}

	public void setProportion(int proportion) {
		this.proportion = proportion;
	}

	public Integer getMaxordernum() {
		return maxordernum;
	}

	public void setMaxordernum(Integer maxordernum) {
		this.maxordernum = maxordernum;
	}

	public Integer getMaxprice() {
		return maxprice;
	}

	public void setMaxprice(Integer maxprice) {
		this.maxprice = maxprice;
	}

}
