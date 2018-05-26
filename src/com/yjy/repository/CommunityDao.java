package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Community;

/**
 * 类CommunityDao。java的实现描述：对数据库进程操作
 * 
 * @author liping
 *
 */
public interface CommunityDao extends PagingAndSortingRepository<Community, Long>, JpaSpecificationExecutor<Community> {
   /**
    * 查询社区所有集合
    * @return
    */
	@Query(nativeQuery=true,value="select * from community order by district asc, createtime desc")   
	List<Community> getCommunityList();
	
	/**
	 * 根据名字和categoryvalue的id查询社区集合
	 * @param name
	 * @param cid
	 * @return
	 */
    @Query(nativeQuery=true,value="select * from community where name=?1 and district=?2")
    List<Community> getCommunityByName(String name,Long cid);
}
