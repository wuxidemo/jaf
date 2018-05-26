package com.yjy.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Inrecord;
import com.yjy.repository.InrecordDao;
import com.yjy.service.InrecordService;

@Component
@Transactional
public class InrecordServiceImpl implements InrecordService{

	@Autowired
	private InrecordDao inrecordDao;

	/**
	 * 根據文件查找
	 * 
	 * @param record
	 * @return
	 */
	public Inrecord getre(String record) {

		return inrecordDao.findByrecord(record);
	}

	public Inrecord mysave(Inrecord inred){
		return inrecordDao.save(inred);
	}
}
