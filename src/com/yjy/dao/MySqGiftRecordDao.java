package com.yjy.dao;

import java.util.List;
import java.util.Map;

import com.yjy.entity.Community;

public interface MySqGiftRecordDao {

	public List<Object[]> getSqGiftRecordData(Map<String, Object> params, int start, int count, String order,
			Community c);

	public Integer getSqGiftRecordCountByParam(Map<String, Object> params, Community c);

	public Integer getGiftCountByParam(Map<String, Object> params, Community c);
}
