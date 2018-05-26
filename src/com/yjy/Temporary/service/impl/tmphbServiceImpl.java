package com.yjy.Temporary.service.impl;

import java.util.Date;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Temporary.TmprecordDao;
import com.yjy.Temporary.entity.Actcardrecord;
import com.yjy.Temporary.entity.tmphb;
import com.yjy.Temporary.repository.ActcardrecordDao;
import com.yjy.Temporary.repository.tmphbDao;
import com.yjy.Temporary.service.ActcardrecordService;
import com.yjy.Temporary.service.tmphbService;
import com.yjy.entity.Merchant;
import com.yjy.entity.WXCardRecord;

import java.util.Calendar;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;

import com.yjy.entity.Activity;
import com.yjy.repository.ActivityDao;
import com.yjy.service.ActivityService;
import com.yjy.utils.Util;

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

import com.yjy.entity.WXCardRecord;
import com.yjy.repository.WXCardRecordDao;
import com.yjy.utils.Util;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class tmphbServiceImpl implements tmphbService {

	@Autowired
	private tmphbDao tmphbDao;

	public tmphb save(tmphb t) {
		return tmphbDao.save(t);
	}

	public List<tmphb> getList() {
		return tmphbDao.getList();
	}
}
