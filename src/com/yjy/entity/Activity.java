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

@Entity
@Table(name = "activity")
public class Activity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String title;
	private String subtitle;
	private String url;
	private String imgurl;
	private String imgthumbnailurl;
	private String content;
	private Date starttime;
	private Date endtime;
	private Date createtime;
	private Date updatetime;
	@JoinColumn(name = "creatorid")
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	private User user;
	private String type;
	private Integer subtype; 
	private int state;
	private Integer tmpnum;// 限制数量 备用LYF
	private Integer payprice; //每次支付的金额单位是分
	private Integer rebateprice;  //每次返还的红包金额单位是分
	private String reporturl;  //查看报表统计数据的url

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	public String getImgthumbnailurl() {
		return imgthumbnailurl;
	}

	public void setImgthumbnailurl(String imgthumbnailurl) {
		this.imgthumbnailurl = imgthumbnailurl;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getSubtype() {
		return subtype;
	}

	public void setSubtype(Integer subtype) {
		this.subtype = subtype;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Integer getTmpnum() {
		return tmpnum;
	}

	public void setTmpnum(Integer tmpnum) {
		this.tmpnum = tmpnum;
	}

	public Integer getPayprice() {
		return payprice;
	}

	public void setPayprice(Integer payprice) {
		this.payprice = payprice;
	}

	public Integer getRebateprice() {
		return rebateprice;
	}

	public void setRebateprice(Integer rebateprice) {
		this.rebateprice = rebateprice;
	}

	public String getReporturl() {
		return reporturl;
	}

	public void setReporturl(String reporturl) {
		this.reporturl = reporturl;
	}

}
