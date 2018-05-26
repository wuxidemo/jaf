package com.yjy.Temporary.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.TicketRecord;

public interface TicketRecordService {

	public TicketRecord get(Long id);

	public TicketRecord save(TicketRecord tr);

	public int getCountByopenid(String openid);

	public Page<TicketRecord> getTicketRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public void updatestate(Long id, int state);

	public List<TicketRecord> getWinRecord(String time, int count, String ids, String openids);

	public List<TicketRecord> get11Data(String time);

	public List<TicketRecord> getByTimeOpenid(String time, String openid);
}
