package com.yjy.Temporary.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.ShareRecord;

public interface ShareRecordDao
		extends PagingAndSortingRepository<ShareRecord, Long>, JpaSpecificationExecutor<ShareRecord> {
	@Query(nativeQuery = true, value = " select count(*) from act_sharerecord where date_format(createtime,'%Y%m%d')=date_format(now(),'%Y%m%d')")
	public int getCountByTime();

	@Query(nativeQuery = true, value = " select count(*) from act_sharerecord where date_format(createtime,'%Y%m%d')=date_format(now(),'%Y%m%d') and openid=?1")
	public int getCountByOpenidTime(String openid);

	@Query(nativeQuery = true, value = "SELECT min(id),max(id) from act_sharerecord")
	public Object getMinMaxID();

	@Query(nativeQuery = true, value = "SELECT count(*) FROM `act_sharerecord` where DATE_FORMAT(createtime,'%Y-%m-%d')=?1 and state=1")
	public int getCountByData(String time);

	@Query(nativeQuery = true, value = "SELECT * FROM `act_sharerecord` where DATE_FORMAT(createtime,'%Y-%m-%d')=?2 and state=1 and id=?1")
	public ShareRecord getByData(Long id, String time);

	@Query(nativeQuery = true, value = "SELECT * FROM `act_sharerecord` where DATE_FORMAT(createtime,'%Y-%m-%d')=?1 and openid=?2")
	public List<ShareRecord> getByTimeOpenid(String time, String openid);
}
