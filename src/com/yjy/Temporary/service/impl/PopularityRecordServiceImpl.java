package com.yjy.Temporary.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Temporary.entity.PopularityRecord;
import com.yjy.Temporary.repository.PopularityRecordDao;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;

@Component
@Transactional
public class PopularityRecordServiceImpl implements PopularityRecordService {
	@Autowired
	PopularityRecordDao popularityRecordDao;

	public int getFromCount(String openid) {
		return popularityRecordDao.getFromCount(openid);
	}

	public PopularityRecord save(PopularityRecord pr) {
		return popularityRecordDao.save(pr);
	}

	public PopularityRecord getByFromopenid(String openid, int score) {
		return popularityRecordDao.getByFromopenid(openid, score);
	}

	public int getCountByOpenid(String openid) {
		return popularityRecordDao.getCountByOpenid(openid);
	}
}
