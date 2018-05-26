package com.yjy.dao;

import java.util.List;
import java.util.Map;

import com.yjy.entity.Community;

public interface MySq_DonationDao {

	/* 以下企业捐赠记录 */
	public List<Object[]> getCompanyDonations(Map<String, Object> params, int start, int size, String order,
			Community c);

	public Integer getCompanyCountbyParams(Map<String, Object> params, Community c);

	public Integer getPriceByParams(Map<String, Object> params, Community c);// 企业捐献钱财金额

	public Integer getDonationCountByParams(Map<String, Object> params, Community c);// 企业捐献物品数量

	/* 以下物品捐赠记录 */
	public List<Object[]> getGoodsDonations(Map<String, Object> params, int start, int size, String order, Community c);

	public Integer getGoodsCountbyParams(Map<String, Object> params, Community c);

	public Integer getDonationGoodsCountByParams(Map<String, Object> params, Community c);// 捐献物品数量（除企业）
	/* 以下个人捐赠记录 */

	public List<Object[]> getGeRenDonations(Map<String, Object> params, int start, int size, String order);

	public Integer getGeRenCountbyParams(Map<String, Object> params);
}
