package com.yjy.Temporary.service;

import java.util.Date;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.ShareRedbagRecord;

public interface ShareRedbagRecordService {
	public ShareRedbagRecord save(ShareRedbagRecord sr);

	public int getCountByOpenid(String openid);

	public Page<ShareRedbagRecord> getShareRedbagRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public int getCountBytime();

	public void refreshredbag();

	public int getCountByJDtime(Date jdtime);
}
