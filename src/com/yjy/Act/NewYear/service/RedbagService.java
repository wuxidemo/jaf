package com.yjy.Act.NewYear.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Act.NewYear.entity.Redbag;

public interface RedbagService {
	
	public Page<Redbag> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public Redbag save(Redbag redbag);
	
}
