package com.yjy.Temporary.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.ShareRecord;

public interface ShareRecordService {
	public ShareRecord save(ShareRecord sr);

	public boolean JudgeRedbag(String openid);

	public boolean JudgeLuck(String openid);

	public Page<ShareRecord> getShareRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public List<ShareRecord> getwindata(String time, int count, String ids);

	public ShareRecord get(Long id);

	public List<ShareRecord> getByTimeOpenid(String time, String openid);

	public boolean getIsCountBytime();

	public boolean getIsCountByOpenid(String openid);
}
