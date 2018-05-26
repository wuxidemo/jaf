package com.yjy.Temporary.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.ShareRedbagRecord;

public interface ShareRedbagRecordDao
		extends PagingAndSortingRepository<ShareRedbagRecord, Long>, JpaSpecificationExecutor<ShareRedbagRecord> {

	@Query(nativeQuery = true, value = "select count(*) from act_shareredbagrecord where openid=?1 ")
	public int getCountByOpenid(String openid);

	@Query(nativeQuery = true, value = "select count(*) from act_shareredbagrecord where date_format(createtime,'%Y%m%d')=date_format(now(),'%Y%m%d')")
	public int getCountBytime();

	@Query(nativeQuery = true, value = "select count(*) from act_shareredbagrecord where createtime>?1")
	public int getCountByJDtime(Date jdtime);

	@Query(value = " from ShareRedbagRecord where state=2")
	public List<ShareRedbagRecord> getFailList();
}
