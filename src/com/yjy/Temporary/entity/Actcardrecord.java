package com.yjy.Temporary.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "act_cardrecord")
public class Actcardrecord {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private int winname;

	private String code;

	private Date createtime;

	private Long merid;

	private String mername;// 商户名称

	private Date usedate;// 使用时间

	private int state; // 状态 1正常2使用3过期

	private Date starttime;// 开始时间

	private Date endtime;// 结束时间

	private String url;

	private String openid;

	private String nickname;// 昵称

	private Long trid;

	private Date wintime; // 获奖时间

	private String fromact;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getWinname() {
		return winname;
	}

	public void setWinname(int winname) {
		this.winname = winname;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getMerid() {
		return merid;
	}

	public void setMerid(Long merid) {
		this.merid = merid;
	}

	public String getMername() {
		return mername;
	}

	public void setMername(String mername) {
		this.mername = mername;
	}

	public Date getUsedate() {
		return usedate;
	}

	public void setUsedate(Date usedate) {
		this.usedate = usedate;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Long getTrid() {
		return trid;
	}

	public void setTrid(Long trid) {
		this.trid = trid;
	}

	public Date getWintime() {
		return wintime;
	}

	public void setWintime(Date wintime) {
		this.wintime = wintime;
	}

	public String getFromact() {
		return fromact;
	}

	public void setFromact(String fromact) {
		this.fromact = fromact;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
