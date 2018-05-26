package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.WeChatAccount;

public interface WeChatAccountDao extends
		PagingAndSortingRepository<WeChatAccount, Long>,
		JpaSpecificationExecutor<WeChatAccount> {
	@Query(value = "from WeChatAccount where main =1 ")
	List<WeChatAccount> getMainWeChat();

	@Query(value = " from WeChatAccount where appid=?1")
	WeChatAccount getByAppid(String appid);
}
