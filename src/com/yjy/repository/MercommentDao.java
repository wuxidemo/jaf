package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Mercomment;

/**
 * 类MercommentDao.java的实现描述：对数据库进程操作
 * @author liping
 *
 */
public interface MercommentDao extends PagingAndSortingRepository<Mercomment, Long>,JpaSpecificationExecutor<Mercomment>{

	/**
	 * 查询所有的评论
	 * @return
	 */
	@Query(nativeQuery=true,value="select *from mercomment order createtime desc")
	List<Mercomment> getMercommentList();
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	@Query(nativeQuery=true,value="select *from mercomment where id=?1")
	Mercomment getMercommentById(Long id);
	
	
	/**
	 * 根据商家的id来查找该商家评分的平均值
	 * @param merid
	 * @return
	 */
	@Query(nativeQuery=true,value="SELECT (CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score),1) END ) AS avgscore  FROM mercomment where merid=?1")
	Float getAvgScoreByMerid(Long merid);
	
	/**
	 * 根据orderid查询
	 * @param id
	 * @return
	 */
	@Query(nativeQuery=true,value="select *from mercomment where orderid=?1")
	List<Mercomment> getMercommentByOrderid(Long orderid);
}
