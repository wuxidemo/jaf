package com.yjy.service;

import java.util.Map;
import org.springframework.data.domain.Page;
import com.yjy.entity.PushMsg;

public interface PushMsgService {

	public Page<PushMsg> getPushMsg(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);

	public PushMsg save(PushMsg p);

	public void delete(Long id);

	public PushMsg getPushMsgById(Long id);
}
