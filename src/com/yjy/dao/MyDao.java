package com.yjy.dao;

import java.util.List;
import java.util.Map;

import com.yjy.Temporary.Tmprecord;
import com.yjy.entity.Community;
import com.yjy.entity.Order;
import com.yjy.entity.Sq_Propertyfee;
import com.yjy.entity.WXCard;

public interface MyDao {

	public int getRebateRecordCountByParam(Map<String, Object> params);

	public int getRebateRecordSumByParam(Map<String, Object> params);

	public int getOrderCountByParam(Map<String, Object> params);

	public int getOrderSumPriceByParam(Map<String, Object> params);

	public int getOrderSumPayPriceByParam(Map<String, Object> params);

	public List<WXCard> getCardByLocation(String id);

	public List<WXCard> getAllUserCard();

	public List<WXCard> getAllJFUserCard();

	public List<Order> getOrderByParam(Map<String, Object> params, int start, int count, String order);

	public int getCardCountByorder(Map<String, Object> params);

	public List<Object[]> getOrderData(Map<String, Object> params, int start, int count, String order);

	public int getCardbankPriceByorder(Map<String, Object> params);

	public int getCardshopPriceByorder(Map<String, Object> params);

	public int getTmpRecordCount(Map<String, Object> params);

	public int getTmpRecordSumPrice(Map<String, Object> params);

	public int getTmpRecordSumRebatePrice(Map<String, Object> params);

	public List<Tmprecord> getTmprecordByParam(Map<String, Object> params, int start, int count, String order);

	public int getTmprecordCountByParam(Map<String, Object> params);

	public int getIntrgralRecordCountByParam(Map<String, Object> params);

	public int getIntrgralRecordPriceByParam(Map<String, Object> params);

	public int getIntrgralRecordJFByParam(Map<String, Object> params);

	public int getIntrgralRecordUsePriceByParam(Map<String, Object> params);

	public int getIntrgralRecordUseCountByParam(Map<String, Object> params);
	
	/*******************************2016-01-15新增********************************************/
	
	public List<Object[]> getMerchantByDistance(String lat,String lon, int start, int size);
	
	public List<Object[]> getMerchantByArea( String key, String lat,String lon,int day,String time,int start, int size);
	
	public List<Object[]> getMerchantByClassify(String lat, String lon, int start, int size, String pid, String id);
	
	public List<Object[]> getMerchantByBusiness(String lat, String lon, int start, int size, String id);
	
	public List<Object[]> getMerchantByKeywords(String lat, String lon, int start, int size, String keywords);
	
	public List<Object[]> getMerchantByCommunity(String lat, String lon, int start, int size, String commid);
	
	public List<Object[]> getWXCardByBusiness(String id, int start, int size );
	
	public List<Object[]> getWXCardByOrder(String type, int start, int size );
	
	public List<Object[]> getPublishedFinanceInfo(Long commid, int start, int size);
	
	/***********************************2016-01-22新增*******************************************************/

	public List<Object[]> getMerchantsByOption(String lat, String lon,
			int start, int size, String pid, String id, String bid);

	public List<Object[]> getCardByOption(int start, int size,
			String businessid, String sort);
	
	/***********************************2016-03-26新增*******************************************************/
	
	public List<Object[]> getYiCangRecordsByComid(Long comid);

	public List<Object[]> getYiCangRecordsByComidWithPage(Long comid, String type, int start, int size);

	public List<Object[]> getMyDonationsByPhone(String phone, int start, int size);

	public List<Object[]> getMygiftsByPhone(String phone, int start, int size);
	
	/*************************2016-04-20添加****************************/

	public List<WXCard> getQiangGouActCard();

	public List<Sq_Propertyfee> getMyFeeListByOpenid(String openid, int start, int size);
	
	/*************************2016-04-22添加（活动报名）****************************/
	
	public List<Object[]> getSqPensionActDateByParams(Map<String, Object> params, int start, int size, String order);
	
	public Integer getSqPensionActCountByParams(Map<String, Object> params);
	
	public List<Object[]> getMyPensionApplyByOpenid(String openid, int start, int size);
}
