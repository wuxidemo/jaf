package com.yjy.Temporary.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.WinningRecord;

public interface WinningRecordDao
		extends PagingAndSortingRepository<WinningRecord, Long>, JpaSpecificationExecutor<WinningRecord> {
	@Query(nativeQuery = true, value = "select count(*) from act_winningrecord where openid=?1 and type=?2")
	public int getCountByOpenidType(String openid, String type);

	@Query(nativeQuery = true, value = " select * from act_winningrecord where date_format(wintime,'%Y-%m-%d')=?1 and type=?2 and winname=?3")
	public List<WinningRecord> getListByData(String time, String type, int winname);

	@Query(nativeQuery = true, value = " delete from act_winningrecord where date_format(wintime,'%Y-%m-%d')=?1 and type=?2 and winname=?3")
	@Modifying
	public void delByData(String time, String type, int winname);

	@Query(nativeQuery = true, value = "select * from act_winningrecord where openid=?1 and type=?2 order by winname asc")
	public List<WinningRecord> getByOpenidType(String openid, String type);

	@Query(nativeQuery = true, value = "select * from act_winningrecord where openid=?1 and type=?2 and date_format(wintime,'%Y-%m-%d')=?3 order by winname asc")
	public List<WinningRecord> getByTimeOpenidType(String openid, String type, String time);

	@Query(nativeQuery = true, value = "select aw.`name`,wu.headimgurl,ap.totalscore from act_winningrecord aw left join wxuser wu on wu.openid=aw.openid left join act_popularity ap on ap.id=aw.tkid where aw.type=?1 and aw.winname=?2")
	public List<Object[]> getByTypeWinname(String type, int winname);

	@Query(nativeQuery = true, value = "select aw.`name`,wu.headimgurl,ap.totalscore from act_winningrecord aw left join wxuser wu on wu.openid=aw.openid left join act_popularity ap on ap.id=aw.tkid where aw.type=?1 and aw.winname=?2 limit 90")
	public List<Object[]> getByTypeWinnameTop90(String type, int winname);

	@Query(nativeQuery = true, value = "update act_winningrecord set state=2 where id=?1")
	@Modifying
	public void updateState(Long id);

	@Query(nativeQuery = true, value = " select myvalue from act_config where mykey=?1")
	public String getValueByKey(String key);

	@Query(nativeQuery = true, value = "update act_config set myvalue=?2 where mykey=?1")
	@Modifying
	public void updateValue(String key, String value);

	@Query(nativeQuery = true, value = "SELECT DATE_FORMAT(wintime,'%Y-%m-%d') as time FROM `act_winningrecord`  where type=?1 GROUP BY DATE_FORMAT(wintime,'%Y-%m-%d')  ORDER BY DATE_FORMAT(wintime,'%Y-%m-%d') asc")
	public List<String> getTimes(String type);

	@Query(nativeQuery = true, value = " select aw.tkid,aw.name,aw.phone,aw.wintime,aw.winname,att.url,aw.subname from act_winningrecord aw left JOIN act_ticketrecord att on att.code=aw.tkid where date_format(aw.wintime,'%Y-%m-%d')=?1 and type=?2 and winname=?3")
	public List<Object[]> getOUTData(String time, String type, int winname);
	
	@Query(nativeQuery = true, value = " select aw.tkid,aw.name,aw.phone,aw.wintime,aw.winname,att.url,aw.subname,aw.id from act_winningrecord aw left JOIN act_ticketrecord att on att.code=aw.tkid where date_format(aw.wintime,'%Y-%m-%d')=?1 and type=?2 and winname=?3 and aw.state=1 and aw.phone is not null")
	public List<Object[]> getOUTData1(String time, String type, int winname);
}
