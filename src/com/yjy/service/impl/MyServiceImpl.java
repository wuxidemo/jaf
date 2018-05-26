package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MyDao;
import com.yjy.entity.Sq_Propertyfee;
import com.yjy.entity.WXCard;
import com.yjy.service.MyService;

@Component
@Transactional
public class MyServiceImpl implements MyService {

	@Autowired
	MyDao myDao;

	public int getRebateRecordCountByParam(Map<String, Object> params) {
		return myDao.getRebateRecordCountByParam(params);
	}

	public int getRebateRecordSumByParam(Map<String, Object> params) {
		return myDao.getRebateRecordSumByParam(params);
	}

	public int getOrderCountByParam(Map<String, Object> params) {
		return myDao.getOrderCountByParam(params);
	}

	public int getOrderSumPriceByParam(Map<String, Object> params) {
		return myDao.getOrderSumPriceByParam(params);
	}

	public int getOrderSumPayPriceByParam(Map<String, Object> params) {
		return myDao.getOrderSumPayPriceByParam(params);
	}

	public int getCardCountByorder(Map<String, Object> params) {
		return myDao.getCardCountByorder(params);
	}

	public int getCardbankPriceByorder(Map<String, Object> params) {
		return myDao.getCardbankPriceByorder(params);
	}

	public int getCardshopPriceByorder(Map<String, Object> params) {
		return myDao.getCardshopPriceByorder(params);
	}

	public List<WXCard> getAllJFUserCard() {
		return myDao.getAllJFUserCard();
	}

	public int getTmpRecordCount(Map<String, Object> params) {
		return myDao.getTmpRecordCount(params);
	}

	public int getTmpRecordSumPrice(Map<String, Object> params) {
		return myDao.getTmpRecordSumPrice(params);
	}

	public int getTmpRecordSumRebatePrice(Map<String, Object> params) {
		return myDao.getTmpRecordSumRebatePrice(params);
	}

	public int getIntrgralRecordCountByParam(Map<String, Object> params) {
		return myDao.getIntrgralRecordCountByParam(params);
	}

	public int getIntrgralRecordPriceByParam(Map<String, Object> params) {
		return myDao.getIntrgralRecordPriceByParam(params);
	}

	public int getIntrgralRecordUsePriceByParam(Map<String, Object> params) {
		return myDao.getIntrgralRecordUsePriceByParam(params);
	}

	public int getIntrgralRecordUseCountByParam(Map<String, Object> params) {
		return myDao.getIntrgralRecordUseCountByParam(params);
	}

	public int getIntrgralRecordJFByParam(Map<String, Object> params) {
		return myDao.getIntrgralRecordJFByParam(params);
	}

	@Override
	public List<Object[]> getNearByMerchant(String lat, String lon, int start,
			int size) {
		// TODO Auto-generated method stub
		return myDao.getMerchantByDistance(lat, lon, start, size);
	}

	@Override
	public List<Object[]> getMerchantByClassify(String lat, String lon,
			int start, int size, String pid, String id) {
		// TODO Auto-generated method stub
		return myDao.getMerchantByClassify(lat, lon, start, size, pid, id);
	}

	@Override
	public List<Object[]> getMerchantByBusiness(String lat, String lon,
			int start, int size, String id) {
		// TODO Auto-generated method stub
		return myDao.getMerchantByBusiness(lat, lon, start, size, id);
	}

	@Override
	public List<Object[]> getMerchantByKeywords(String lat, String lon,
			int start, int size, String keywords) {
		// TODO Auto-generated method stub
		return myDao.getMerchantByKeywords(lat, lon, start, size, keywords);
	}

	@Override
	public List<Object[]> getWXCardByBusiness(String id, int start, int size) {
		// TODO Auto-generated method stub
		return myDao.getWXCardByBusiness(id, start, size);
	}

	@Override
	public List<Object[]> getMerchantByCommunity(String lat, String lon,
			int start, int size, String commid) {
		// TODO Auto-generated method stub
		return myDao.getMerchantByCommunity(lat, lon, start, size, commid);
	}

	@Override
	public List<Object[]> getPublishedFinanceInfo(Long commid, int start,
			int size) {
		// TODO Auto-generated method stub
		return myDao.getPublishedFinanceInfo(commid, start, size);
	}

	@Override
	public List<Object[]> getMerchantsByOption(String lat, String lon,
			int start, int size, String pid, String id, String bid) {
		// TODO Auto-generated method stub
		return myDao.getMerchantsByOption(lat,lon,start,size,pid,id,bid);
	}

	@Override
	public List<Object[]> getCardByOption(int start, int size,
			String businessid, String sort) {
		// TODO Auto-generated method stub
		return myDao.getCardByOption(start, size, businessid, sort);
	}

	@Override
	public List<Object[]> getYiCangRecordsByComid(Long comid) {
		// TODO Auto-generated method stub
		return myDao.getYiCangRecordsByComid(comid);
	}

	@Override
	public List<Object[]> getYiCangRecordsByComidWithPage(Long comid, String type, int start, int size) {
		// TODO Auto-generated method stub
		return myDao.getYiCangRecordsByComidWithPage(comid, type, start, size);
	}

	@Override
	public List<Object[]> getMyDonationsByPhone(String phone, int start, int size) {
		// TODO Auto-generated method stub
		return myDao.getMyDonationsByPhone(phone, start, size);
	}

	@Override
	public List<Object[]> getMygiftsByPhone(String phone, int start, int size) {
		// TODO Auto-generated method stub
		return myDao.getMygiftsByPhone(phone, start, size);
	}

	@Override
	public List<Sq_Propertyfee> getMyFeeListByOpenid(String openid, int start, int size) {
		// TODO Auto-generated method stub
		return myDao.getMyFeeListByOpenid(openid, start, size);
	}
}
