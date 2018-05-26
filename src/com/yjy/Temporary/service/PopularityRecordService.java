package com.yjy.Temporary.service;

import com.yjy.Temporary.entity.PopularityRecord;

public interface PopularityRecordService {
	/**
	 * 
	 * 查询已帮人分享了几次
	 * 
	 * @author lyf
	 * @date 2015年10月17日 上午11:09:21
	 * @param openid
	 * @return
	 */
	public int getFromCount(String openid);

	public PopularityRecord save(PopularityRecord pr);

	/**
	 * 
	 * 查询帮别人增加人气值记录
	 * 
	 * @author lyf
	 * @date 2015年10月17日 下午12:44:13
	 * @param openid
	 * @param score
	 * @return
	 */
	public PopularityRecord getByFromopenid(String openid, int score);

	public int getCountByOpenid(String openid);
}
