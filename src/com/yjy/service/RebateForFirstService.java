package com.yjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.RebateForFirst;
import com.yjy.repository.RebateForFirstDao;

@Component
@Transactional
public class RebateForFirstService {

	@Autowired
	RebateForFirstDao rebateForFirstDao;

	public RebateForFirst get(Long id) {
		return rebateForFirstDao.findOne(id);
	}

	public RebateForFirst save(RebateForFirst rff) {
		return rebateForFirstDao.save(rff);
	}

	public RebateForFirst getFirstRebate() {
		List<RebateForFirst> irf = (List<RebateForFirst>) rebateForFirstDao
				.findAll();
		if (irf.size() == 1) {
			return irf.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 
	 * 查询是否有首次支付返利活动
	 * @author lyf
	 * @date 2015年6月23日 下午2:40:16
	 * @return
	 */
	public int getRFFState() {
		List<RebateForFirst> irf = (List<RebateForFirst>) rebateForFirstDao
				.findAll();
		if (irf.size() == 1) {
			if (irf.get(0).getState() == 1) {
				return 1;
			}
		}
		return 0;
	}

}
