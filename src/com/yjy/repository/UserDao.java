package com.yjy.repository;

import java.util.List;

import com.yjy.entity.User;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 类UserDao.java的实现描述：User类的Dao层类
 * 
 * @author yigang 2015年4月1日 上午10:19:29
 */
public interface UserDao extends PagingAndSortingRepository<User, Long>,
		JpaSpecificationExecutor<User> {

	/**
	 * 根据用户名来查找用户列表
	 * 
	 * @author yigang
	 * @date 2015年4月1日 上午10:14:03
	 * @param name
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from user u where u.name = ?1")
	List<User> findByName(String name);
	
	/** 
	 * 根据生成新的用户账号时，填写的新的手机号码来查找用户列表以判断该手机号码是否已被注册过。
	 * @author yigang
	 * @date 2015年7月16日 下午1:45:20
	 * @param telephone
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from user u where u.telephone = ?1")
	List<User> findByTelephone(String telephone);

	/**
	 * 根据用户名和用户id来查找用户的数量
	 * 
	 * @author yigang
	 * @date 2015年4月1日 上午10:14:27
	 * @param name
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select count(*) from user u where u.name=?1 and u.id!=?2")
	int findByNameAndId(String name, Long id);
	
	/** 
	 * 通过验证码和用户id来查找用户列表
	 * @author yigang
	 * @date 2015年7月23日 下午2:42:24
	 * @param captcha
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from user u where u.captcha=?1 and u.id=?2")
	List<User> findByCaptchaAndId(String captcha, Long id);
	
	/** 
	 * 根据用户电话号码和用户id来查找用户的数量
	 * @author yigang
	 * @date 2015年7月16日 下午1:48:09
	 * @param telephone
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select count(*) from user u where u.telephone=?1 and u.id!=?2")
	int findByTelephoneAndId(String telephone, Long id);

	/**
	 * 根据roleId来查找所有的用户的列表
	 * 
	 * @author yigang
	 * @date 2015年4月1日 上午10:14:45
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from user u where role_id=?1")
	List<User> findByRole(Long id);

	/**
	 * 根据用户名和验证码的值来查找用户
	 * 
	 * @author yigang
	 * @date 2015年4月1日 上午10:15:24
	 * @param name
	 * @param captcha
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from user u where u.name = ?1 and u.captcha=?2")
	User findByNameAndCaptcha(String name, String captcha);

	/**
	 * 查找有效的用户的数量
	 * 
	 * @author yigang
	 * @date 2015年4月1日 上午10:15:52
	 * @param loginName
	 * @return
	 */
	@Query(nativeQuery = true, value = "SELECT count(*) from user where name=?1 and (((NOW()<endtime and NOW()>starttime) or starttime is null or endtime is null))")
	int findEffectUser(String loginName);

	/**
	 * 根据role来查找所有的有效的用户列表
	 * 
	 * @author yigang
	 * @date 2015年4月1日 上午10:16:24
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from user u where role_id=?1 and state=1 order by registertime desc")
	List<User> findUseByRole(Long id);

	/**
	 * 
	 * 根据
	 * @author lyf
	 * @date 2015年6月23日 下午1:17:39
	 * @param telephone
	 * @return
	 */
	@Query(value = "from User u where u.telephone = ?1")
	List<User> findBytelephone(String telephone);
	@Query(nativeQuery = true, value = "select * from user u where role_id=11 and state=1 and enabled=1")
	List<User> findUserByRoleAndMerchantid();
	
	@Query(nativeQuery = true, value = "select * from user u where merchantid=?1")
	List<User> findByMerchantid(Long id);
	
	@Modifying
	@Query(nativeQuery = true, value = "update user set captcha=null where id=?1")
	void setCaptchaNullValueById(Long id);

	@Query(nativeQuery = true, value = "select * from user u where communityid=?1 order by registertime asc")
	List<User> getUsersByCommunityid(Long commid);
	
}