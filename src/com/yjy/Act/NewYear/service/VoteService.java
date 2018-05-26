package com.yjy.Act.NewYear.service;

import com.yjy.Act.NewYear.entity.Vote;

public interface VoteService {

	/**
	 * 
	 * 获取双旦活动状态
	 * 
	 * @author lyf
	 * @date 2015年12月21日 下午2:41:11
	 * @return
	 */
	public int getNewYearStage();
	
	public int getWaiterStage();
	
	
	public Vote changeVoteStage();
	
	public Vote changeWaiterStage();
	
	public Vote save(Vote vote);
}
