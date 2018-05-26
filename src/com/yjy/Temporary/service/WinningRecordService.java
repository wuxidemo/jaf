package com.yjy.Temporary.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.WinningRecord;

public interface WinningRecordService {
	public WinningRecord save(WinningRecord tr);

	public int getCountByOpenidType(String openid, String type);

	public List<WinningRecord> getListByData(String time, String type, int winname);

	public void delByData(String time, String type, int winname);

	public List<WinningRecord> getByOpenidType(String openid, String type);

	public List<Object[]> getByTypeWinname(String type, int winname);

	public List<Object[]> getByTypeWinnameTop90(String type, int winname);

	public WinningRecord get(Long id);

	public Page<WinningRecord> getWinningRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public void updateState(Long id);

	public List<WinningRecord> getByTimeOpenidType(String openid, String type, String time);

	public List<String> getTimes(String type);

	public List<Object[]> getOUTData(String time, String type, int winname);

	public List<Object[]> getOUTData1(String time, String type, int winname);
}
