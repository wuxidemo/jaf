package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Payorder;

public interface PayorderService {

	public Page<Payorder> getPayorder(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);

	public Payorder save(Payorder payorder);

	public List<Payorder> getPayorders(String createtime, Long merchantid, String paytype);

	public List<Payorder> getAllPayorders(String createtime, Long merchantid);

	public Payorder getOrNew(String ordernum, String type, String submchid, Long merchantid);

	public Payorder findByOrdernum(String ordernum);

	public Payorder get(Long id);
}
