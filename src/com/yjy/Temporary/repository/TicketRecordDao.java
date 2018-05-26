package com.yjy.Temporary.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.entity.TicketRecord;

public interface TicketRecordDao
		extends PagingAndSortingRepository<TicketRecord, Long>, JpaSpecificationExecutor<TicketRecord> {

	@Query(nativeQuery = true, value = "SELECT count(*) from act_ticketrecord at where  DATE_FORMAT(`at`.createtime,'%Y%m%d')= DATE_FORMAT(NOW(),'%Y%m%d') and openid =?1")
	public int getCountByopenid(String openid);

	@Query(nativeQuery = true, value = " update act_ticketrecord set state=?2 where id=?1")
	@Modifying
	public void updatestate(Long id, int state);

	@Query(nativeQuery = true, value = "SELECT atr.* from act_ticketrecord atr LEFT JOIN(SELECT COUNT(*)as num,openid FROM act_winningrecord where type='qccjhd' and DATE_FORMAT(wintime,'%Y-%m-%d')=?2 GROUP BY openid ) a on a.openid=atr.openid where id=?1 and num is null and DATE_FORMAT(createtime,'%Y-%m-%d')=?2 and state=1")
	public TicketRecord getByData(Long id, String time);

	@Query(nativeQuery = true, value = "select count(*) from ( SELECT atr.openid from act_ticketrecord atr LEFT JOIN(SELECT COUNT(*)as num,openid FROM act_winningrecord where type='qccjhd' and DATE_FORMAT(wintime,'%Y-%m-%d')=?1 GROUP BY openid ) a on a.openid=atr.openid where  num is null and DATE_FORMAT(createtime,'%Y-%m-%d')=?1 and state=1 GROUP BY atr.openid) b")
	public int getCountByData(String time);

	@Query(nativeQuery = true, value = " SELECT atr.id from act_ticketrecord atr LEFT JOIN(SELECT COUNT(*)as num,openid FROM act_winningrecord where type='qccjhd' and DATE_FORMAT(wintime,'%Y-%m-%d')=?1 GROUP BY openid ) a on a.openid=atr.openid where  num is null and DATE_FORMAT(createtime,'%Y-%m-%d')=?1 and state=1 GROUP BY atr.openid")
	public List<Object> getIdsByData(String time);

	@Query(nativeQuery = true, value = "SELECT min(id),max(id) from act_ticketrecord")
	public Object getMinMaxID();

	@Query(nativeQuery = true, value = "SELECT * from act_ticketrecord atr where DATE_FORMAT(createtime,'%Y-%m-%d')=?1  and code like '%11' and state=1 ")
	public List<TicketRecord> get11Data(String time);

	@Query(nativeQuery = true, value = "SELECT * FROM act_ticketrecord where DATE_FORMAT(createtime,'%Y-%m-%d')=?1 and openid=?2")
	public List<TicketRecord> getByTimeOpenid(String time, String openid);
}
