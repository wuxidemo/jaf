package com.yjy.Temporary.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.yjy.Temporary.ACTConfig;
import com.yjy.Temporary.entity.Popularity;
import com.yjy.Temporary.entity.PopularityRecord;
import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.entity.ShareRedbagRecord;
import com.yjy.Temporary.entity.TicketRecord;
import com.yjy.Temporary.repository.PopularityDao;
import com.yjy.Temporary.repository.PopularityRecordDao;
import com.yjy.Temporary.repository.ShareRecordDao;
import com.yjy.Temporary.repository.ShareRedbagRecordDao;
import com.yjy.Temporary.repository.TicketRecordDao;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.ShareRecordService;
import com.yjy.Temporary.service.ShareRedbagRecordService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.entity.Activity;
import com.yjy.service.WXUserService;
import com.yjy.utils.Util;

@Component
@Transactional
public class ShareRecordImpl implements ShareRecordService {
	@Autowired
	ShareRecordDao shareRecordDao;
	@Autowired
	ShareRedbagRecordService shareRedbagRecordService;

	public ShareRecord get(Long id) {
		return shareRecordDao.findOne(id);
	}

	public ShareRecord save(ShareRecord sr) {
		return shareRecordDao.save(sr);
	}

	public boolean JudgeRedbag(String openid) {
		if (shareRedbagRecordService.getCountBytime() >= 3000) {
			return false;
		}
		if (shareRedbagRecordService.getCountByOpenid(openid) > 0) {
			return false;
		}
		return true;
	}

	public boolean getIsCountBytime() {
		String times[] = ACTConfig.getTimeS();
		SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HHmm");
		try {
			Date now = sdf.parse(sdfd.format(new Date()) + " " + times[0]);
			if (shareRedbagRecordService.getCountByJDtime(now) > Integer.parseInt(times[1])) {
				return false;
			} else {
				return true;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean getIsCountByOpenid(String openid) {
		if (shareRedbagRecordService.getCountByOpenid(openid) > 0) {
			return false;
		}
		return true;
	}

	public boolean JudgeLuck(String openid) {
		if (shareRecordDao.getCountByOpenidTime(openid) > 0) {
			return false;
		}
		return true;
	}

	public Page<ShareRecord> getShareRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<ShareRecord> spec = Util.buildSpecification(searchParams, ShareRecord.class);
		return shareRecordDao.findAll(spec, pageRequest);
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

	public List<ShareRecord> getwindata(String time, int count, String ids) {
		Object[] mmid = (Object[]) shareRecordDao.getMinMaxID();
		int minid = mmid[0] == null ? 0 : Integer.parseInt(mmid[0].toString());
		int maxid = mmid[1] == null ? 0 : Integer.parseInt(mmid[1].toString());
		int allcount = shareRecordDao.getCountByData(time);
		String[] iis = null;
		if (!ids.equals("")) {
			iis = ids.split(",");
			allcount -= iis.length;
			count -= iis.length;
		}
		count = Math.min(count, allcount);
		List<ShareRecord> ltr = new ArrayList<ShareRecord>();
		while (ltr.size() < count) {
			Long radomid = (Long.parseLong(Util.getRandomNumber(((maxid - minid + 1) + "").length() + 2))
					% (maxid - minid + 1)) + minid;
			boolean issame = false;
			for (ShareRecord t : ltr) {
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
			ShareRecord tr = shareRecordDao.getByData(radomid, time);
			if (tr != null) {
				for (ShareRecord t : ltr) {
					if (t.getOpenid().equals(tr.getOpenid())) {
						issame = true;
						break;
					}
				}
				if (issame)
					continue;
				ltr.add(tr);
			}
		}
		return ltr;
	}

	public List<ShareRecord> getByTimeOpenid(String time, String openid) {
		return shareRecordDao.getByTimeOpenid(time, openid);
	}
}
