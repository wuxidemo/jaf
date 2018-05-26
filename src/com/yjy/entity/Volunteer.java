package com.yjy.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
/**
 *@author liping
 * 类volunteer.java的实现描述
 *
 */
@Entity
@Table(name="volunteer")
public class Volunteer {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;//我能行id
	private String name;//我能行名字
	private String openid;//微信码
	private String nickname;//微信中的昵称
	private String ability;//才能
	private String phone;//电话
	private String servertime;//服务时间
	private String pay;//支付金额
	private Integer state;//状态
	private Date createtime;//创建时间
	private Integer paytype;//支付类型
	private Integer sex;//性别1男2女
	private Integer age;//年龄
	private String headimgurl;//头像
	private String abilitydescrib;//才能描述
	private Integer isshow;//是否展示 1展示0不展示创建时默认为null，审核通过后默认为1
	
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	@JoinColumn(name = "communityid")
	private Community community;
	
	private String failreason;
	
	public String getFailreason() {
		return failreason;
	}
	public void setFailreason(String failreason) {
		this.failreason = failreason;
	}
	public Integer getIsshow() {
		return isshow;
	}
	public Community getCommunity() {
		return community;
	}
	public void setCommunity(Community community) {
		this.community = community;
	}
	public void setIsshow(Integer isshow) {
		this.isshow = isshow;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public String getAbilitydescrib() {
		return abilitydescrib;
	}
	public void setAbilitydescrib(String abilitydescrib) {
		this.abilitydescrib = abilitydescrib;
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
	public String getAbility() {
		return ability;
	}
	public void setAbility(String ability) {
		this.ability = ability;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getServertime() {
		return servertime;
	}
	public void setServertime(String servertime) {
		this.servertime = servertime;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Integer getPaytype() {
		return paytype;
	}
	public void setPaytype(Integer paytype) {
		this.paytype = paytype;
	}
	
}
