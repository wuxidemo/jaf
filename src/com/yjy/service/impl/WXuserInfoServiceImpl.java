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
import com.yjy.entity.WXuserInfo;
import com.yjy.repository.ActivityDao;
import com.yjy.repository.WXuserInfoDao;
import com.yjy.service.ActivityService;
import com.yjy.service.WXuserInfoService;
import com.yjy.utils.Util;

@Component
@Transactional
public class WXuserInfoServiceImpl implements WXuserInfoService {

	@Autowired
	private WXuserInfoDao wxuserInfoDao;

	@Override
	public WXuserInfo getInfoByOpenid(String openid) {
		List<WXuserInfo> lwui = wxuserInfoDao.getInfoByOpenid(openid);
		if (lwui.size() > 0) {
			return lwui.get(0);
		}
		return null;
	}

	@Override
	public WXuserInfo save(WXuserInfo wui) {
		return wxuserInfoDao.save(wui);
	}

	@Override
	public WXuserInfo modifyWXuserInfo(String name,String commid, String phone, Long id) {
		// TODO Auto-generated method stub
		return wxuserInfoDao.modifyWXuserInfo(name, phone, commid, id);
	}

}
