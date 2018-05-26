package com.yjy.Temporary.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.Actcardrecord;

public interface ActcardrecordDao
		extends PagingAndSortingRepository<Actcardrecord, Long>, JpaSpecificationExecutor<Actcardrecord> {

	@Query(nativeQuery = true, value = " select * from act_cardrecord where  code=?1 ")
	public List<Actcardrecord> getCountByCode(String code);

	@Query(nativeQuery = true, value = "select * from act_cardrecord where openid=?1 and fromact=?2 order by createtime desc")
	public List<Actcardrecord> getListByOpenidAct(String openid, String type);

	@Query(nativeQuery = true, value = " select url from act_cardrecord where openid=?1 and fromact=?2 and trid=?3")
	public String getUrl(String openid, String type, Long wrid);

	@Query(nativeQuery = true, value = "select * from act_cardrecord where openid=?1 and fromact=?2 and (winname=1 or winname=2 or winname=3) order by createtime desc")
	public List<Actcardrecord> getListByOpenidAct2(String openid, String type);

	@Query(nativeQuery = true, value = " select count(*) from act_cardrecord where trid=?1")
	public int getCountByTrid(Long trid);

	@Query(nativeQuery = true, value = "SELECT * FROM `act_cardrecord` where merid=?2 and DATE_FORMAT(usedate,'%Y%m%d')=?1 ")
	public List<Actcardrecord> getMerUsedRecord(String time, Long merid);
}
