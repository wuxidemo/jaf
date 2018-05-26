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

import com.yjy.Temporary.entity.Actcardrecord;
import com.yjy.Temporary.repository.ActcardrecordDao;
import com.yjy.Temporary.service.ActcardrecordService;
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
public class ActcardrecordServiceImpl implements ActcardrecordService {

	@Autowired
	private ActcardrecordDao actcardrecordDao;

	public Page<Actcardrecord> getList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Actcardrecord> spec = Util.buildSpecification(searchParams, Actcardrecord.class);
		return actcardrecordDao.findAll(spec, pageRequest);
	}

	public List<Actcardrecord> getDownRecord(Map<String, Object> searchParams) {
		Specification<Actcardrecord> spec = Util.buildSpecification(searchParams, Actcardrecord.class);
		return actcardrecordDao.findAll(spec, new Sort(Direction.DESC, "merid"));
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Actcardrecord save(Actcardrecord ar) {
		return actcardrecordDao.save(ar);
	}

	public List<Actcardrecord> getListByOpenidAct(String openid, String type) {
		return actcardrecordDao.getListByOpenidAct(openid, type);
	}

	public Map<String, Object> useWECard(String code, Merchant mer) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Actcardrecord> lar = actcardrecordDao.getCountByCode(code);
		if (lar == null) {
			result.put("result", "0");
			result.put("msg", "未找到该卡券");
		} else if (lar.size() == 0) {
			result.put("result", "0");
			result.put("msg", "未找到该卡券");
		} else {
			Actcardrecord ar = lar.get(0);
			if (ar.getState() == 2) {
				result.put("result", "0");
				result.put("msg", "卡券已被使用");
			} else if (ar.getState() == 3) {
				result.put("result", "0");
				result.put("msg", "卡券已过期");
			} else {
				Date now = new Date();
				if (ar.getStarttime().compareTo(now) > 0) {
					result.put("result", "0");
					result.put("msg", "卡券不在有效时间内");
				} else if (ar.getEndtime().compareTo(now) < 0) {
					result.put("result", "0");
					result.put("msg", "卡券已过期");
				} else {
					ar.setMerid(mer.getId());
					ar.setMername(mer.getName());
					ar.setState(2);
					ar.setUsedate(now);
					actcardrecordDao.save(ar);
					result.put("result", "1");
					result.put("msg", "'" + ar.getName() + "'核销成功!");
				}
			}
		}
		return result;
	}

	public String getUrl(String openid, String type, Long wrid) {
		return actcardrecordDao.getUrl(openid, type, wrid);
	}

	@Override
	public List<Actcardrecord> getListByOpenidAct2(String openid, String type) {
		return actcardrecordDao.getListByOpenidAct2(openid, type);
	}

	public int getCountByTrid(Long trid) {
		return actcardrecordDao.getCountByTrid(trid);
	}

	public List<Actcardrecord> getMerUsedRecord(String time, Long merid) {
		return actcardrecordDao.getMerUsedRecord(time, merid);
	}
}
