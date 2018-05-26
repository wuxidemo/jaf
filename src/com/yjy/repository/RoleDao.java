package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Role;

/**
 * 类RoleDao.java的实现描述：Role的Dao层类 
 * @author yigang 2015年4月1日 上午10:13:03
 */
public interface RoleDao extends PagingAndSortingRepository<Role, Long>,
	JpaSpecificationExecutor<Role>{
	
	/** 
	 * 查询所有的Role
	 * @author yigang
	 * @date 2015年4月1日 上午10:09:12
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from role")
	List<Role> findAllRoles();
	
	/** 
	 * 查找除了金阿福商户之外的所有的Role
	 * @author yigang
	 * @date 2015年10月27日 下午2:49:15
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from role where id!=11")
	List<Role> findAllRolesForAdd();
	
	/** 
	 * 根据Name来查询Role的列表
	 * @author yigang
	 * @date 2015年4月1日 上午10:09:28
	 * @param name
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from role r where r.name = ?1")
	List<Role> findByName(String name);

	/** 
	 * 根据Name和Id来查找Role的数量
	 * @author yigang
	 * @date 2015年4月1日 上午10:09:44
	 * @param name
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select count(*) from role r where r.name=?1 and r.id!=?2")
	int findByNameAndId(String name, Long id);
	
}
