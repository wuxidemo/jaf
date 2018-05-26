package com.yjy.Temporary.service.impl;

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
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class ShareRedbagRecordImpl implements ShareRedbagRecordService {
	@Autowired
	ShareRedbagRecordDao shareRedbagRecordDao;

	public ShareRedbagRecord save(ShareRedbagRecord sr) {
		return shareRedbagRecordDao.save(sr);
	}

	public int getCountByOpenid(String openid) {
		return shareRedbagRecordDao.getCountByOpenid(openid);
	}

	public Page<ShareRedbagRecord> getShareRedbagRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<ShareRedbagRecord> spec = Util.buildSpecification(searchParams, ShareRedbagRecord.class);
		return shareRedbagRecordDao.findAll(spec, pageRequest);
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

	public int getCountBytime() {
		return shareRedbagRecordDao.getCountBytime();
	}

	public void refreshredbag() {
		List<ShareRedbagRecord> lsrr = shareRedbagRecordDao.getFailList();
		for (ShareRedbagRecord srr : lsrr) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
			if (WXManage.sendPrize(WXManage.WCA, srr.getOpenid(), 100, "请关注其他活动", "备注", "金阿福", "金阿福e服务", "关注分享红包",
					billno)) {
				srr.setState(1);
			} else {
				srr.setState(2);
			}
			srr.setBillno(billno);
			shareRedbagRecordDao.save(srr);
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public int getCountByJDtime(Date jdtime) {
		return shareRedbagRecordDao.getCountByJDtime(jdtime);
	}
}
