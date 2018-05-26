package com.yjy.Temporary;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MyDao;
import com.yjy.entity.Activity;
import com.yjy.entity.Advert;
import com.yjy.entity.Business;
import com.yjy.entity.Order;
import com.yjy.repository.AdvertDao;
import com.yjy.utils.Util;

@Component
@Transactional
public class TmprecordService {

	@Autowired
	private TmprecordDao tmprecordDao;
	@Autowired
	MyDao myDao;

	public Tmprecord get(Long id) {
		return tmprecordDao.findOne(id);
	}

	public void SaveOrUpdate(Tmprecord t) {
		// TODO Auto-generated method stub
		tmprecordDao.save(t);
	}

	public List<Tmprecord> getTodayListByOpenid(String openid, Long actid) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			now = sdf.parse(sdf.format(now));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, 1);
		return tmprecordDao.getTodayListByOpenid(openid, now, c.getTime(), actid);
	}

	public List<Tmprecord> getTodayList(Long actid) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			now = sdf.parse(sdf.format(now));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, 1);
		return tmprecordDao.getTodayList(now, c.getTime(), actid);
	}

	public Tmprecord getByCode(String code) {
		List<Tmprecord> lt = tmprecordDao.getListByCode(code);
		if (lt.size() > 0) {
			return lt.get(0);
		} else {
			return null;
		}
	}

	public int getTodayCountByState(Long actid, int state) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			now = sdf.parse(sdf.format(now));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, 1);
		return tmprecordDao.getTodayCountByState(now, c.getTime(), actid, state);
	}

	public int getTodayCount(Date s, Date e, Long actid) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			now = sdf.parse(sdf.format(now));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, 1);
		return tmprecordDao.getTodayCount(now, c.getTime(), actid);
	}

	public int getTodayPayCount(Long actid) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			now = sdf.parse(sdf.format(now));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, 1);
		return tmprecordDao.getTodayPayCount(now, c.getTime(), actid);
	}

	public Page<Tmprecord> getTmprecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Tmprecord>(myDao.getTmprecordByParam(searchParams, pageNumber, pageSize, order),
				pageRequest, myDao.getTmpRecordCount(searchParams));
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
}
