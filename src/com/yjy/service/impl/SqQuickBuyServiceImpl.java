package com.yjy.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Sq_QuickBuy;
import com.yjy.repository.SqQuickBuyDao;
import com.yjy.service.SqQuickBuyService;
@Component
@Transactional
public class SqQuickBuyServiceImpl implements SqQuickBuyService{
	
	@Autowired
	private SqQuickBuyDao sqQuickBuyDao;

	@Override
	public Sq_QuickBuy save(Sq_QuickBuy sq_QuickBuy) {
		// TODO Auto-generated method stub
		return sqQuickBuyDao.save(sq_QuickBuy);
	}

	@Override
	public Sq_QuickBuy get(Long id) {
		// TODO Auto-generated method stub
		return sqQuickBuyDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		sqQuickBuyDao.delete(id);
	}

	@Override
	public List<Sq_QuickBuy> getSq_QuickBuyList() {
		// TODO Auto-generated method stub
		return sqQuickBuyDao.getSq_QuickBuyList();
	}

	@Override
	public void updateState() {
		// TODO Auto-generated method stub
		List<Sq_QuickBuy> sqlist = sqQuickBuyDao.getSq_QuickBuyList();
		Date now = new Date();
		Long nowtime = now.getTime();
		for(Sq_QuickBuy sq : sqlist) {
			Date starttime = sq.getStarttime();
			Date endtime = sq.getEndtime();
			if(nowtime >= endtime.getTime()) {
				sq.setState(5);
				save(sq);
			}else if(nowtime < endtime.getTime() && nowtime >= starttime.getTime() && sq.getState() == 1) {
				sq.setState(2);
				save(sq);
			}
		}
		
	}

	@Override
	public List<Sq_QuickBuy> getOnlineQuickBuyList() {
		// TODO Auto-generated method stub
		return sqQuickBuyDao.getOnlineQuickBuyList();
	}

}
