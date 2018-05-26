package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Classify;

/**
 * 类ClassDao。java的实现描述：对数据库进程操作
 * 
 * @author liping
 * 
 */
public interface ClassifyDao extends
		PagingAndSortingRepository<Classify, Long>,
		JpaSpecificationExecutor<Classify> {
	/**
	 * 查询父分类集合
	 * 
	 * @return
	 */
	@Query(nativeQuery = true, value = "select*from classify where pid is null order by createtime DESC")
	List<Classify> getList();

	/**
	 * 查询所有分类集合
	 * 
	 * @return
	 */
	@Query(nativeQuery = true, value = "select*from classify order by createtime DESC")
	List<Classify> getListPid();

	/**
	 * 按照名字条件查询父集合
	 * 
	 * @return
	 */
	@Query(nativeQuery = true, value = "select*from classify where pid is null and name=?1 order by createtime DESC")
	List<Classify> getList1(String name);

	/**
	 * 按照名字查询所有分类集合
	 * 
	 * @return
	 */
	@Query(nativeQuery = true, value = "select*from classify where name=?1 order by createtime DESC")
	List<Classify> getListPid1(String name);

	/**
	 * 根据id删除分类集合
	 * 
	 * @param id
	 */
	@Query(nativeQuery = true, value = "delete from classify where id=?1")
	@Modifying
	void deleteClassify(Long id);

	/**
	 * 根据pid删除父分类集合
	 * 
	 * @param pid
	 */
	@Query(nativeQuery = true, value = "delete from classify where pid=?1")
	@Modifying
	void deleteClassifyByPid(Long pid);

	/**
	 * 获取指定pid集合，根据父类id，查子类
	 * 
	 * @param pid
	 */
	@Query(nativeQuery = true, value = "select * from classify where pid=?1")
	List<Classify> ClassifyListByPid(Long pid);

	/**
	 * 根据名字查分类
	 * 
	 * @param value
	 * @return
	 */
	@Query(nativeQuery = true, value = "select*from classify where name=?1")
	List<Classify> findByValue(String name);

	/**
	 * 根据id查分类
	 * 
	 * @param value
	 * @return
	 */
	@Query(nativeQuery = true, value = "select*from classify where id=?1")
	List<Classify> findById(Long id);

	@Query(nativeQuery = true, value = "select * from classify where pid is not null")
	List<Classify> getAllSubClassify();
}
