package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Payorder;
import com.yjy.entity.RefundOrder;

public interface RefundOrderService {
	public RefundOrder save(RefundOrder ro);

	public void refreshrefundorder();
}
