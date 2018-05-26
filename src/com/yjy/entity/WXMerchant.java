package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "wxmerchant")
public class WXMerchant {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long merchantid;
	private Date createtime;
	private Date updatetime;
	private String brandname;
	private String logourl;
	private String status;// "CHECKING" 审核中, "APPROVED" , 已通过；"REJECTED"被驳回,
							// "EXPIRED"协议已过期
	private Date begintime;
	private Date endtime;
	private Long primarycategoryid;
	private Long secondarycategoryid;
	private Integer type;//类型 1商户发卡方2第三方

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getMerchantid() {
		return merchantid;
	}

	public void setMerchantid(Long merchantid) {
		this.merchantid = merchantid;
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

	public String getBrandname() {
		return brandname;
	}

	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}

	public String getLogourl() {
		return logourl;
	}

	public void setLogourl(String logourl) {
		this.logourl = logourl;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Long getPrimarycategoryid() {
		return primarycategoryid;
	}

	public void setPrimarycategoryid(Long primarycategoryid) {
		this.primarycategoryid = primarycategoryid;
	}

	public Long getSecondarycategoryid() {
		return secondarycategoryid;
	}

	public void setSecondarycategoryid(Long secondarycategoryid) {
		this.secondarycategoryid = secondarycategoryid;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}
