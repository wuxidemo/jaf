package com.yjy.Act.NewYear.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;




import com.yjy.Act.NewYear.entity.Waiterth;

public interface WaiterthDao extends PagingAndSortingRepository<Waiterth, Long>,
		JpaSpecificationExecutor<Waiterth> {
   
	/* 判断同一个人当天有没有对同一个人投过票 */
	@Query(nativeQuery = true, value = "SELECT * FROM  waiterth where openid=?1 and waiterid=?2 and DATE_FORMAT(createtime,'%Y%m%d')=?3")
	public List<Waiterth> findbyone(String openid, int waiterid, String date1);
	
	/* 判断同一个人当天总共点击了多少次 */
	@Query(nativeQuery = true, value = "SELECT count(*) from ( SELECT count(*) as times,openid, waiterid FROM  waiterth where openid=?1  and DATE_FORMAT(createtime,'%Y%m%d')=?2 GROUP BY waiterid ) plike LEFT JOIN  waiter p on plike.waiterid = p.id")
	public int findbyone2(String openid, String date1);
	
	/* 判断同一个人总共点击了多少条 */
	@Query(nativeQuery = true, value = "SELECT  count(*) FROM  waiterth where openid=?1")
	public int findbyone3(String openid);
	
	@Query(nativeQuery = true, value = "SELECT * FROM  waiterth where waiterid=?1")
	public List<Waiterth> getWaiterthByWaiterid(Long waiterid);

	@Query(nativeQuery = true, value = "SELECT count(distinct openid) FROM  waiterth")
	public int findDiffWaiterthCount();
	
	/*根据waiterid查找被点击过多少次*/
	@Query(nativeQuery = true, value = "select count(*) from waiterth where waiterid=?1")
	public int findproliketh(int waiterid);

}
