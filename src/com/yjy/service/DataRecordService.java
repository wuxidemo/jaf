package com.yjy.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Inrecord;

public interface DataRecordService {

	

	public Page<Inrecord> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);


}
