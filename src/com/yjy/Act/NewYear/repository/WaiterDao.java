package com.yjy.Act.NewYear.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Act.NewYear.entity.Waiter;

public interface WaiterDao extends PagingAndSortingRepository<Waiter, Long>,JpaSpecificationExecutor<Waiter> {

	/*查找进入前五十的*/
	@Query(nativeQuery = true, value = "SELECT  p.*,(case when a.c is null then 0 else a.c end) as c1,(case when b.c is null then 0 else b.c end) as c2 FROM  waiter  p LEFT JOIN (SELECT count(*) as c,waiterid from waiterth WHERE openid=?1 and DATE_FORMAT(createtime,'%Y%m%d')=?2 GROUP BY waiterid ) a on a.waiterid= p.id LEFT JOIN (SELECT count(*) as c,waiterid from waiterth GROUP BY waiterid ) b on b.waiterid= p.id where state=2 order by senumber ASC")
	public List<Object> getbyall(String openid,String date1);
	/**
	 * 根据openid查找
	 * @param openid
	 * @return
	 */
	@Query(nativeQuery = true, value = "SELECT * FROM  waiter where openid=?1")
	public Waiter findbyone(String openid);

	@Query(nativeQuery = true, value = "SELECT * FROM  waiter where openid=?1")
	public List<Waiter> findByOpenid(String openid);
	
	@Query(nativeQuery = true, value = "SELECT * FROM  waiter where state=?1")
	public List<Waiter> findByState(int state);
	
	@Query(nativeQuery = true, value = "select id, wxname, name, likewaiter.total as wtotal, createtime,url,telephone,mername,senumber,state,context from waiter w left join (SELECT count(*) as total,waiterid from waiterth GROUP BY waiterid) likewaiter on w.id = likewaiter.waiterid where 1=1 and state=2 ORDER BY wtotal DESC,createtime ASC LIMIT 0, 50")
	public List<Object[]> getWinnerList();
	
	@Query(nativeQuery = true, value = "SELECT count(*) FROM  waiter")
	public int getAllWaiterCount();
	
	@Query(nativeQuery = true, value = "SELECT id,name,url,context,mername,(case when wth.total is null then 0 else wth.total end) as total from waiter w LEFT JOIN (SELECT count(*) as total,waiterid from waiterth GROUP BY waiterid) wth ON w.id = wth.waiterid where state>=2 ORDER BY total DESC,createtime ASC LIMIT 0,50")
	public List<Object[]> getTop50WinList();
	
	@Query(nativeQuery = true, value = " SELECT  w.id,w.senumber,w.name,w.url,w.mername,(case when a.c is null then 0 else a.c end) as c1,(case when b.c is null then 0 else b.c end) as c2 FROM waiter  w LEFT JOIN (SELECT count(*) as c,waiterid from waiterth GROUP BY waiterid ) a on a.waiterid= w.id LEFT JOIN (SELECT count(*) as c,waiterid from waiterth WHERE openid=?1 and DATE_FORMAT(createtime,'%Y%m%d')=?2 GROUP BY waiterid ) b on b.waiterid= w.id where state=2 order by senumber ASC")
	public List<Object[]> getChosenList(String openid, String datestr);

}
