package com.yjy.Temporary.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.Popularity;

public interface PopularityDao
		extends PagingAndSortingRepository<Popularity, Long>, JpaSpecificationExecutor<Popularity> {

	@Query(value = " from Popularity where openid=?1")
	public Popularity getByOpenid(String openid);

	@Query(nativeQuery = true, value = " select count(*) from act_popularity where totalscore>?1 or (totalscore=?1 and createtime<?2)")
	public int getRankByOpenid(int count, Date time);

	@Query(nativeQuery = true, value = " SELECT wu.realname,wu.headimgurl,a.totalscore,wu.openid from (  select * from act_popularity ORDER BY totalscore DESC LIMIT 50 )a  LEFT JOIN wxuser wu on wu.openid=a.openid")
	public List<Object[]> getTop10By();

	@Query(nativeQuery = true, value = " update act_popularity set totalscore=totalscore+?2 where openid=?1")
	@Modifying
	public void updateTotalScore(String openid, int totalscore);

	@Query(nativeQuery = true, value = "select * from act_popularity order by totalscore desc limit 2")
	public List<Popularity> getTop2();

	@Query(nativeQuery = true, value = " select count(*) from act_popularity where totalscore>=500 and state is null")
	public int get500Count();

	@Query(nativeQuery = true, value = " select count(*) from act_popularity where totalscore>=1000 and state is null")
	public int get1000Count();

	@Query(nativeQuery = true, value = "SELECT ap.* from act_popularity ap LEFT JOIN ( SELECT count(*) as count,tkid FROM act_winningrecord aw where  aw.type='rqzhd'  GROUP BY aw.tkid)    aw on aw.tkid=ap.id where aw.count is null and totalscore>=500 and ap.state is null")
	public List<Popularity> get500();

	@Query(nativeQuery = true, value = "SELECT ap.* from act_popularity ap LEFT JOIN ( SELECT count(*) as count,tkid FROM act_winningrecord aw where  aw.type='rqzhd'  GROUP BY aw.tkid)    aw on aw.tkid=ap.id where aw.count is null and totalscore>=1000 and ap.state is null")
	public List<Popularity> get1000();
}
