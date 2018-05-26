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

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "merchant")
public class Merchant {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;                 //商户id
	private String name;             //商户名称
	private String ownername;	     //商户店长姓名
	private String email;	         //商户联系邮箱
	private String category;		 //商户标签主营类目(美食，休闲娱乐等)
	@JoinColumn(name = "businessid")
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	private Business business;	     //商户所属的商圈
	private String telephone;	     //商户联系电话
	private String address;	         //商户店铺详细地址
	private String bankaccount;	     //商户银行卡卡号
	private String thumbnailurl;	 //商户门店缩略图
	private String introduceurl;     //商户门店的介绍图
	private String detailurl;        //商户门店的详情图
	private String qrurl;            //商户二维码
	private String content;          //商户介绍详细图文内容
	private Integer recommend;       //商户是否被选中为推荐商户
	private Integer binduser;        //商户是否已经绑定后台账号1已绑定null未绑定
	private String wxpaynum;         //商户微信支付编号
	private String alipaynum;        //商户支付宝支付编号
	private String keywords;		 //商户的关键字，用户搜索商户时候使用
	private Float onecost;           //商户的人均消费金额
	private Integer classify;        //商户的分类，保存的是子分类的id
	private Integer pclassify;       //商户的父级分类，保存的是父分类的id
	private Integer community;       //商户所属社区的id
	private String specialcourse;    //商户的特色菜
	
	
	@JsonIgnore
	@JoinColumn(name = "creatorid")
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	private User user;               //商户信息的创建者关联一个后台账户
	private Date createtime;         //商户信息的创建时间
	private Date updatetime;         //商户信息的更新时间
	private int state;               //商户状态1正常状态0假删除
	private Long wxlocationid;       //微信门店ID，微信后台生成
	
	private String sid;
	private String business_name;
	private String branch_name;
	private String wxaddress;
	private String wxtelephone;
	private String wxcategories;
	private String city;
	private String province;
	private String district;
	private Integer offset_type;
	private String longitude;
	private String latitude;
	private String photo_list;
	private String introduction;
	private String wxrecommend;
	private String special;
	private String open_time;
	private Float avg_price;
	private String poi_id;
	private Integer available_state;
	private Integer update_status;
	
	
	

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

	public String getOwnername() {
		return ownername;
	}

	public void setOwnername(String ownername) {
		this.ownername = ownername;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Business getBusiness() {
		return business;
	}

	public void setBusiness(Business business) {
		this.business = business;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBankaccount() {
		return bankaccount;
	}

	public void setBankaccount(String bankaccount) {
		this.bankaccount = bankaccount;
	}

	public String getThumbnailurl() {
		return thumbnailurl;
	}

	public void setThumbnailurl(String thumbnailurl) {
		this.thumbnailurl = thumbnailurl;
	}

	public String getIntroduceurl() {
		return introduceurl;
	}

	public void setIntroduceurl(String introduceurl) {
		this.introduceurl = introduceurl;
	}

	public String getDetailurl() {
		return detailurl;
	}

	public void setDetailurl(String detailurl) {
		this.detailurl = detailurl;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getRecommend() {
		return recommend;
	}

	public void setRecommend(Integer recommend) {
		this.recommend = recommend;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Long getWxlocationid() {
		return wxlocationid;
	}

	public void setWxlocationid(Long wxlocationid) {
		this.wxlocationid = wxlocationid;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getBusiness_name() {
		return business_name;
	}

	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}

	public String getBranch_name() {
		return branch_name;
	}

	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}

	public String getWxaddress() {
		return wxaddress;
	}

	public void setWxaddress(String wxaddress) {
		this.wxaddress = wxaddress;
	}

	public String getWxtelephone() {
		return wxtelephone;
	}

	public void setWxtelephone(String wxtelephone) {
		this.wxtelephone = wxtelephone;
	}

	public String getWxcategories() {
		return wxcategories;
	}

	public void setWxcategories(String wxcategories) {
		this.wxcategories = wxcategories;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public int getOffset_type() {
		return offset_type;
	}

	public void setOffset_type(int offset_type) {
		this.offset_type = offset_type;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getPhoto_list() {
		return photo_list;
	}

	public void setPhoto_list(String photo_list) {
		this.photo_list = photo_list;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getWxrecommend() {
		return wxrecommend;
	}

	public void setWxrecommend(String wxrecommend) {
		this.wxrecommend = wxrecommend;
	}

	public String getSpecial() {
		return special;
	}

	public void setSpecial(String special) {
		this.special = special;
	}

	public String getOpen_time() {
		return open_time;
	}

	public void setOpen_time(String open_time) {
		this.open_time = open_time;
	}

	public Float getAvg_price() {
		return avg_price;
	}

	public void setAvg_price(Float avg_price) {
		this.avg_price = avg_price;
	}

	public String getPoi_id() {
		return poi_id;
	}

	public void setPoi_id(String poi_id) {
		this.poi_id = poi_id;
	}

	public Integer getAvailable_state() {
		return available_state;
	}

	public void setAvailable_state(Integer available_state) {
		this.available_state = available_state;
	}

	public Integer getUpdate_status() {
		return update_status;
	}

	public void setUpdate_status(Integer update_status) {
		this.update_status = update_status;
	}

	public String getQrurl() {
		return qrurl;
	}

	public void setQrurl(String qrurl) {
		this.qrurl = qrurl;
	}

	public void setOffset_type(Integer offset_type) {
		this.offset_type = offset_type;
	}

	public Integer getBinduser() {
		return binduser;
	}

	public void setBinduser(Integer binduser) {
		this.binduser = binduser;
	}

	public String getWxpaynum() {
		return wxpaynum;
	}

	public void setWxpaynum(String wxpaynum) {
		this.wxpaynum = wxpaynum;
	}

	public String getAlipaynum() {
		return alipaynum;
	}

	public void setAlipaynum(String alipaynum) {
		this.alipaynum = alipaynum;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public Float getOnecost() {
		return onecost;
	}

	public void setOnecost(Float onecost) {
		this.onecost = onecost;
	}

	public Integer getClassify() {
		return classify;
	}

	public void setClassify(Integer classify) {
		this.classify = classify;
	}

	public Integer getCommunity() {
		return community;
	}

	public void setCommunity(Integer community) {
		this.community = community;
	}

	public Integer getPclassify() {
		return pclassify;
	}

	public void setPclassify(Integer pclassify) {
		this.pclassify = pclassify;
	}
	
	public String getSpecialcourse() {
		return specialcourse;
	}

	public void setSpecialcourse(String specialcourse) {
		this.specialcourse = specialcourse;
	}
	
}
