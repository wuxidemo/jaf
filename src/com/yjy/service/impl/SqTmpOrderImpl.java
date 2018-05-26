package com.yjy.service.impl;

import java.util.Calendar;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Activity;
import com.yjy.entity.SqTmpOrder;
import com.yjy.repository.ActivityDao;
import com.yjy.repository.SqTmpOrderDao;
import com.yjy.service.ActivityService;
import com.yjy.service.SqTmpOrderService;
import com.yjy.utils.Util;

@Component
@Transactional
public class SqTmpOrderImpl implements SqTmpOrderService {

	@Autowired
	private SqTmpOrderDao sqTmpOrderDao;

	public SqTmpOrder save(SqTmpOrder sto) {
		return sqTmpOrderDao.save(sto);
	}

	public SqTmpOrder get(Long id) {
		return sqTmpOrderDao.findOne(id);
	}

	public SqTmpOrder getByMycode(String mycode) {
		List<SqTmpOrder> lsto = sqTmpOrderDao.getListByMycode(mycode);
		if (lsto.size() > 0) {
			return lsto.get(0);
		} else {
			return null;
		}
	}
}
