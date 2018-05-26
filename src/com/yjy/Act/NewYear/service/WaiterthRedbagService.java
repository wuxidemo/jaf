package com.yjy.Act.NewYear.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Act.NewYear.entity.WaiterthRedbag;

public interface WaiterthRedbagService {
	
	public Page<WaiterthRedbag> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public WaiterthRedbag save(WaiterthRedbag waiterthRedbag);
	
}
