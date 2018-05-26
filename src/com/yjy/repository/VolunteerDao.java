package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Volunteer;
/**
 * 类VolunteerDao.java的实现描述：对数据进程操作
 *
 */
public interface VolunteerDao extends PagingAndSortingRepository<Volunteer, Long>, JpaSpecificationExecutor<Volunteer> {

	@Query(nativeQuery=true,value="select * from volunteer where id=?1")
	Volunteer getVolunteerById(Long id);
	
	@Query(nativeQuery=true,value="select * from volunteer where openid=?1")
	Volunteer getVolunteerByOpenid(String openid);

	/** 
	 * 这个是为了防止数据库出现两条记录拥有相同openid的情况，容错处理方式
	 * @author yigang
	 * @date 2016年3月22日 上午9:34:17
	 * @param openid
	 * @return
	 */
	@Query(nativeQuery=true,value="select * from volunteer where openid=?1")
	List<Volunteer> getVolunteersByOpenid(String openid);
}
