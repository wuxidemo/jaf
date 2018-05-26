package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Community;
import com.yjy.entity.Sq_Donation;

public interface Sq_DonationService {

	public Page<Sq_Donation> getSqDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public Sq_Donation get(Long id);

	public Sq_Donation save(Sq_Donation sq_Donation);

	public void delete(Long id);

	public boolean delete1(String ids);

	/* 以下企业捐赠记录 */
	public Page<Object[]> getCompanyDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType, Community c);

	public Integer getPriceByParams(Map<String, Object> params, Community c);

	public Integer getDonationCountByParams(Map<String, Object> params, Community c);

	/* 以下物品捐赠记录 */
	public Page<Object[]> getGoodsDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType, Community c);

	public Integer getDonationGoodsCountByParams(Map<String, Object> params, Community c);

	/* 以下个人捐赠记录 */
	public Page<Object[]> getGenRenDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public Sq_Donation getDonationByNum(String num);

	public List<Sq_Donation> getSqDonationByComid(Long comid);

	public List<Sq_Donation> getSqDonationByPhoneNo(String phoneno);

	public List<Sq_Donation> getSqDonationByOpenid(String openid);

	public Sq_Donation getOnlineListBynum(String num);

	public void deleteDonationGoodsByDonationId(Long id);
}
