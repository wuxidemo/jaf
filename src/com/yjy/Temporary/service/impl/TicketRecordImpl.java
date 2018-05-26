package com.yjy.Temporary.service.impl;

import java.util.ArrayList;
import java.util.Date;
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
import com.yjy.Temporary.repository.PopularityDao;
import com.yjy.Temporary.repository.PopularityRecordDao;
import com.yjy.Temporary.repository.TicketRecordDao;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.entity.Activity;
import com.yjy.service.WXUserService;
import com.yjy.utils.Util;

@Component
@Transactional
public class TicketRecordImpl implements TicketRecordService {
	@Autowired
	TicketRecordDao ticketRecordDao;

	public TicketRecord get(Long id) {
		return ticketRecordDao.findOne(id);
	}

	public TicketRecord save(TicketRecord tr) {
		return ticketRecordDao.save(tr);
	}

	public int getCountByopenid(String openid) {
		return ticketRecordDao.getCountByopenid(openid);
	}

	public Page<TicketRecord> getTicketRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<TicketRecord> spec = Util.buildSpecification(searchParams, TicketRecord.class);
		return ticketRecordDao.findAll(spec, pageRequest);
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

	public void updatestate(Long id, int state) {
		ticketRecordDao.updatestate(id, state);
	}

	public List<TicketRecord> getWinRecord(String time, int count, String ids, String openids) {
		List<Object> idss = ticketRecordDao.getIdsByData(time);
		int allcount = ticketRecordDao.getCountByData(time);
		String[] iis = null;
		String[] opens = null;
		if (!ids.equals("")) {
			iis = ids.split(",");
			allcount -= iis.length;
			count -= iis.length;
		}
		if (!openids.equals("")) {
			opens = openids.split(",");
		}
		count = Math.min(count, allcount);
		List<TicketRecord> ltr = new ArrayList<TicketRecord>();
		while (ltr.size() < count) {
			String aaaa = idss
					.get((Integer.parseInt(Util.getRandomNumber((idss.size() + "").length() + 2)) % idss.size()))
					.toString();
			// ;
			Long radomid = Long.parseLong(aaaa);
			// (Long.parseLong(Util.getRandomNumber(((maxid - minid + 1) +
			// "").length() + 2))
			// % (maxid - minid + 1)) + minid;
			boolean issame = false;
			for (TicketRecord t : ltr) {
				if (t.getId().equals(radomid)) {
					issame = true;
					break;
				}
			}
			if (iis != null) {
				for (String ii : iis) {
					if (ii.equals(radomid.toString())) {
						issame = true;
						break;
					}
				}
			}
			if (issame)
				continue;
			TicketRecord tr = ticketRecordDao.getByData(radomid, time);
			if (tr != null) {
				for (TicketRecord t : ltr) {
					if (t.getOpenid().equals(tr.getOpenid())) {
						issame = true;
						break;
					}
				}
				if (opens != null) {
					for (String op : opens) {
						if (op.equals(tr.getOpenid())) {
							issame = true;
							break;
						}
					}
				}
				if (issame)
					continue;
				ltr.add(tr);
			}
		}
		return ltr;
	}

	public List<TicketRecord> get11Data(String time) {
		return ticketRecordDao.get11Data(time);
	}

	public List<TicketRecord> getByTimeOpenid(String time, String openid) {
		return ticketRecordDao.getByTimeOpenid(time, openid);
	}
}
