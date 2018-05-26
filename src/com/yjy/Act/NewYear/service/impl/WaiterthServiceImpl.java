package com.yjy.Act.NewYear.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Act.NewYear.entity.Waiterth;
import com.yjy.Act.NewYear.repository.WaiterthDao;
import com.yjy.Act.NewYear.service.WaiterthService;

@Component
@Transactional
public class WaiterthServiceImpl implements WaiterthService {

	@Autowired
	
	private WaiterthDao waiterthDao;
	
	/* 判断同一个人当天有没有对同一个点过赞 */
	public List<Waiterth> panduan(String openid, int waiterid, String date1) {
		
		return waiterthDao.findbyone(openid, waiterid, date1);
	}
	
	/* 判断同一个人当天总共点击了多少次 */
	public int findsum(String openid,String date1) {
		
		return waiterthDao.findbyone2(openid, date1);
	}	
	
	
	/* 判断同一个人总共点击了多少条 */
	public int findbyzon(String openid) {
		return waiterthDao.findbyone3(openid);
	}
	
	public Waiterth save1(Waiterth waiterth){
		return waiterthDao.save(waiterth);
	}

	
	/*根据一个productid判断被点击了多少次*/
	public int findliketh(int waiterid){
		return waiterthDao.findproliketh(waiterid);
	}
	


	@Override
	public int findDiffWaiterthCount() {
		// TODO Auto-generated method stub
		return waiterthDao.findDiffWaiterthCount();
	}

}

