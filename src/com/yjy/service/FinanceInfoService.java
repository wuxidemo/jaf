package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.FinanceInfo;

public interface FinanceInfoService {

	public Page<FinanceInfo> getFinanceInfo(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public FinanceInfo save(FinanceInfo financeInfo);

	public FinanceInfo get(Long id);

	public void delete(Long id);

	public List<FinanceInfo> getAllFinanceInfo();

	public List<FinanceInfo> getPublishedFinanceInfo();

	void updateCount(Long id, int count);

}
