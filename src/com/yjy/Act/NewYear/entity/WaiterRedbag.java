package com.yjy.Act.NewYear.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="waiterredbag")
public class WaiterRedbag {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;  //主键id
	private String name;
	private String nickname;    //拉粉服务员的昵称
	private String telephone;
	private String mername;
	private String openid;    //拉粉服务员的openid
	private String fromnickname;   //为该服务员点赞的粉丝的昵称
	private String fromopenid;   //为该服务员点赞的粉丝的openid
	private String fromlat;   //粉丝第一次点赞的位置纬度
	private String fromlon;   //粉丝第一次点赞的位置经度
	private Date createtime;    //点赞时间
	private Integer sendstate;   //是否已经为该服务员发送过红包 1已发送，0未发送
	private Integer sendresult;    //如果发送，发送结果    0发送失败1发送成功null红包未发送
	private Date sendtime;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getFromnickname() {
		return fromnickname;
	}
	public void setFromnickname(String fromnickname) {
		this.fromnickname = fromnickname;
	}
	public String getFromopenid() {
		return fromopenid;
	}
	public void setFromopenid(String fromopenid) {
		this.fromopenid = fromopenid;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getMername() {
		return mername;
	}
	public void setMername(String mername) {
		this.mername = mername;
	}
	public String getFromlat() {
		return fromlat;
	}
	public void setFromlat(String fromlat) {
		this.fromlat = fromlat;
	}
	public String getFromlon() {
		return fromlon;
	}
	public void setFromlon(String fromlon) {
		this.fromlon = fromlon;
	}
	public Integer getSendstate() {
		return sendstate;
	}
	public void setSendstate(Integer sendstate) {
		this.sendstate = sendstate;
	}
	public Integer getSendresult() {
		return sendresult;
	}
	public void setSendresult(Integer sendresult) {
		this.sendresult = sendresult;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	
}
