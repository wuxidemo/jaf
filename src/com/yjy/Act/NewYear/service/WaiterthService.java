package com.yjy.Act.NewYear.service;

import java.util.List;

import com.yjy.Act.NewYear.entity.Waiterth;

public interface WaiterthService {
	
	public Waiterth save1(Waiterth waiterth);

	
	/* 判断同一个人当天有没有对同一个点过赞 */
	public List<Waiterth> panduan(String openid, int waiterid, String date1);
	
	
	/* 判断同一个人当天总共点击了多少次 */
	public int findsum(String openid,String date1);
	
	/* 判断同一个人总共点击了多少条 */
	public int findbyzon(String openid);

	
	/*根据一个waiterid判断被点击了多少次*/
	public int findliketh(int waiterid);

	
	public int findDiffWaiterthCount();

}
