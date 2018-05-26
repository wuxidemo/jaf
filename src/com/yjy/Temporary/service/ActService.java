package com.yjy.Temporary.service;

import java.util.Date;

import com.yjy.Temporary.ACTConfig;
import com.yjy.Temporary.entity.PopularityRecord;

/**
 * 活动状态 判断业务逻辑
 * 
 * @author lyf
 * @date 2015年10月24日 下午12:45:34
 */
public interface ActService {
	public String getRQZState();

	public void refreshRQZState();

	/**
	 * 
	 * 人气值活动是否进行判断
	 * 
	 * @author lyf
	 * @date 2015年10月24日 下午12:55:29
	 * @return
	 */
	public boolean isRQZ();

	/**
	 * 
	 * 结束人气值活动
	 * 
	 * @author lyf
	 * @date 2015年10月24日 下午1:28:16
	 */
	public void stopRQZ();

	public String getGZFXState();

	public void refreshGZFXState();

	public boolean isGZFX();

	public void stopGZFX();

	public String getQCCJState();

	public void refreshQCCJState();

	public boolean isQCCJ();

	public void stopQCCJ();
}
