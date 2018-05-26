package com.yjy.Temporary.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.SumData;


public interface SumDataService {
	
	public SumData save(SumData sumdata);
	
	public SumData get(Long id);
	
	public void delete(Long id);
	
	public Page<SumData> getSumData(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public SumData findNumByName(String name); 
	
}
