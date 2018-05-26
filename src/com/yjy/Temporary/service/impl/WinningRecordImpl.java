package com.yjy.Temporary.service.impl;

import java.util.Date;
import java.util.Iterator;
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

import com.yjy.Temporary.entity.Popularity;
import com.yjy.Temporary.entity.PopularityRecord;
import com.yjy.Temporary.entity.TicketRecord;
import com.yjy.Temporary.entity.WinningRecord;
import com.yjy.Temporary.repository.PopularityDao;
import com.yjy.Temporary.repository.PopularityRecordDao;
import com.yjy.Temporary.repository.TicketRecordDao;
import com.yjy.Temporary.repository.WinningRecordDao;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.Temporary.service.WinningRecordService;
import com.yjy.service.WXUserService;
import com.yjy.utils.Util;

@Component
@Transactional
public class WinningRecordImpl implements WinningRecordService {
	@Autowired
	WinningRecordDao winningRecordDao;

	public WinningRecord save(WinningRecord tr) {
		return winningRecordDao.save(tr);
	}

	public int getCountByOpenidType(String openid, String type) {
		return winningRecordDao.getCountByOpenidType(openid, type);
	}

	public List<WinningRecord> getListByData(String time, String type, int winname) {
		return winningRecordDao.getListByData(time, type, winname);
	}

	public void delByData(String time, String type, int winname) {
		winningRecordDao.delByData(time, type, winname);
	}

	public List<WinningRecord> getByOpenidType(String openid, String type) {
		return winningRecordDao.getByOpenidType(openid, type);
	}

	public List<Object[]> getByTypeWinname(String type, int winname) {
		return winningRecordDao.getByTypeWinname(type, winname);
	}

	public List<Object[]> getByTypeWinnameTop90(String type, int winname) {
		return winningRecordDao.getByTypeWinnameTop90(type, winname);
	}

	public WinningRecord get(Long id) {
		return winningRecordDao.findOne(id);
	}

	public Page<WinningRecord> getWinningRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<WinningRecord> spec = Util.buildSpecification(searchParams, WinningRecord.class);
		return winningRecordDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public void updateState(Long id) {
		winningRecordDao.updateState(id);
	}

	public List<WinningRecord> getByTimeOpenidType(String openid, String type, String time) {
		return winningRecordDao.getByTimeOpenidType(openid, type, time);
	}

	public List<String> getTimes(String type) {
		return winningRecordDao.getTimes(type);
	}

	public List<Object[]> getOUTData(String time, String type, int winname) {
		return winningRecordDao.getOUTData(time, type, winname);
	}

	public List<Object[]> getOUTData1(String time, String type, int winname) {
		return winningRecordDao.getOUTData1(time, type, winname);
	}
}
