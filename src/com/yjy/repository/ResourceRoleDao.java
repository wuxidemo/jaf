package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.ResourceRole;

/**
 * 类ResourceRoleDao.java的实现描述：Resource的Dao层实现类
 * @author yigang 2015年4月1日 上午10:13:33
 */
public interface ResourceRoleDao extends PagingAndSortingRepository<ResourceRole, Long>,
	JpaSpecificationExecutor<ResourceRole>{
	
	/** 
	 * 根据RoleId和ResourceId来删除resourcerole
	 * @author yigang
	 * @date 2015年4月1日 上午10:10:32
	 * @param roleId
	 * @param resourceId
	 */
	@Modifying
	@Query(nativeQuery = true, value = "delete from resourcerole where role_id=?1 and resource_id=?2")
	void deleteByRoleAndResource(Long roleId, Long resourceId);
	
	/** 
	 * 查询roleId为特定值的所有的resourcerole的Id
	 * @author yigang
	 * @date 2015年4月1日 上午10:11:06
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select rr.id from resourcerole rr where rr.role_id=?1")
	List<Integer> findResourceRoleIdByRoleId(Long id);
	
	/** 
	 * 删除roleId为特定值的所有的resourcerole
	 * @author yigang
	 * @date 2015年4月1日 上午10:11:41
	 * @param roleId
	 */
	@Modifying
	@Query(nativeQuery = true, value = "delete from resourcerole where role_id=?1")
	void deleteByRoleId(Long roleId);
	
}
