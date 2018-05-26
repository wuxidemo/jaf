package com.yjy.Act.NewYear.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Act.NewYear.entity.Like;

public interface LikeDao extends PagingAndSortingRepository<Like, Long>,
		JpaSpecificationExecutor<Like> {

	@Query(nativeQuery = true, value = "delete from liketh where openid=?1 and productid=?2")
	public boolean delete1(String openid, int productid);

	/* 判断同一个人当天有没有对同一个人投过票 */
	@Query(nativeQuery = true, value = "SELECT * FROM  liketh where openid=?1 and productid=?2 and DATE_FORMAT(createtime,'%Y%m%d')=?3")
	public List<Like> findbyone(String openid, int productid, String date1);

	/* 判断同一个人当天总共点击了多少次 */
	@Query(nativeQuery = true, value = "SELECT count(*) from ( SELECT count(*) as times,openid, productid FROM  liketh where openid=?1  and DATE_FORMAT(createtime,'%Y%m%d')=?2 GROUP BY productid ) plike LEFT JOIN product p on plike.productid = p.id WHERE p.collegestate = ?3")
	public int findbyone2(String openid, String date1,int collegestate);

	/* 判断同一个人总共点击了多少条 */
	@Query(nativeQuery = true, value = "SELECT  count(*) FROM  liketh where openid=?1")
	public int findbyone3(String openid);
	
	@Query(nativeQuery = true, value = "select id, name,college,tclass,telephone,title,url,context,senumber,collegestate,wxname,likepro.total as ptotal from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where collegestate=?1 and state>=2 ORDER BY ptotal DESC limit 0,50")
	public List<Object[]> getWinList(int collegestate);
	
	
	/*判断有多少个人参与了投票*/
	@Query(nativeQuery = true, value = "select count(distinct(openid)) from liketh")
	public int findlikesum();
	
	/*根据productid查找被点击过多少次*/
	@Query(nativeQuery = true, value = "select count(*) from liketh where productid=?1")
	public int findproliketh(int productid);
	
	@Query(nativeQuery = true, value = "SELECT * FROM liketh where productid=?1")
	public List<Like> getLikeByProid(Long productid);
}
