package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Activity;
import com.yjy.entity.SqTmpOrder;

public interface SqTmpOrderService {
	public SqTmpOrder save(SqTmpOrder sto);

	public SqTmpOrder get(Long id);

	public SqTmpOrder getByMycode(String mycode);
}
