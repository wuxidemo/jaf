package com.yjy.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 卡券记录
 * 
 * @author lyf
 *
 */
@Entity
@Table(name = "wxcard")
public class WXCard {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String cardid;
	private String name;
	private String type; // 类型
	private Integer bankper;// 银行分担百分比
	private Integer shopper;// 商户分担百分比
	private Date createtime;
	private int state; // 1正常(通过审核/待投放，在公众平台投放过/已投放)2待审核3审核失败0已删除4已过期
	private Integer price; // 价格 单位分
	private Integer leastprice;// 满多少 单位分
	private String locationids; // 可用门店IDS
	private String logourl;
	private Integer isonly;// 是否一家
	private String merchantname;
	private Integer datetype;// 时间类型 1时间段 2 领取后多少天
	private Integer delaytime;// 多少天后生效
	private Integer usetime;// 有效时间
	private Date starttime;
	private Date endtime;
	private Integer totalnum;// 总共数量
	private Integer nownum;// 当前数量
	private Integer mytype;// 系统中卡券类型0未分类 1正常领取卡券2银行积分换取卡券3抢购活动卡券
	private Integer count;// 积分券 换取所需积分
	private Long wxmerchantid; // 卡券子商户ID
	private String wxmerchantname;// 卡券子商户名
	private Integer isbank; // 支付农商行
	private Integer wxtype; // 微信卡券类型 空/0 默认卡券 ；1朋友的券

	public Integer getDatetype() {
		return datetype;
	}

	public void setDatetype(Integer datetype) {
		this.datetype = datetype;
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

	public Integer getTotalnum() {
		return totalnum;
	}

	public void setTotalnum(Integer totalnum) {
		this.totalnum = totalnum;
	}

	public Integer getNownum() {
		return nownum;
	}

	public void setNownum(Integer nownum) {
		this.nownum = nownum;
	}

	public Integer getBankper() {
		return bankper;
	}

	public void setBankper(Integer bankper) {
		this.bankper = bankper;
	}

	public Integer getShopper() {
		return shopper;
	}

	public void setShopper(Integer shopper) {
		this.shopper = shopper;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
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

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getLeastprice() {
		return leastprice;
	}

	public void setLeastprice(Integer leastprice) {
		this.leastprice = leastprice;
	}

	public String getLocationids() {
		return locationids;
	}

	public void setLocationids(String locationids) {
		this.locationids = locationids;
	}

	public String getLogourl() {
		return logourl;
	}

	public void setLogourl(String logourl) {
		this.logourl = logourl;
	}

	public Integer getIsonly() {
		return isonly;
	}

	public void setIsonly(Integer isonly) {
		this.isonly = isonly;
	}

	public String getMerchantname() {
		return merchantname;
	}

	public void setMerchantname(String merchantname) {
		this.merchantname = merchantname;
	}

	public Integer getDelaytime() {
		return delaytime;
	}

	public void setDelaytime(Integer delaytime) {
		this.delaytime = delaytime;
	}

	public Integer getUsetime() {
		return usetime;
	}

	public void setUsetime(Integer usetime) {
		this.usetime = usetime;
	}

	public Integer getMytype() {
		return mytype;
	}

	public void setMytype(Integer mytype) {
		this.mytype = mytype;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Long getWxmerchantid() {
		return wxmerchantid;
	}

	public void setWxmerchantid(Long wxmerchantid) {
		this.wxmerchantid = wxmerchantid;
	}

	public String getWxmerchantname() {
		return wxmerchantname;
	}

	public void setWxmerchantname(String wxmerchantname) {
		this.wxmerchantname = wxmerchantname;
	}

	public Integer getIsbank() {
		return isbank;
	}

	public void setIsbank(Integer isbank) {
		this.isbank = isbank;
	}

	public Integer getWxtype() {
		return wxtype;
	}

	public void setWxtype(Integer wxtype) {
		this.wxtype = wxtype;
	}

}
