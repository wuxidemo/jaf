package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.Encodes;

import com.yjy.entity.User;
import com.yjy.repository.UserDao;
import com.yjy.utils.Util;

/**
 * 类UserService.java的实现描述：实现user的增删改查
 * 
 * @author zhangmengmeng 2015-4-20 上午10:22:55
 */
@Component
// 类中所有public函数都纳入事务管理的标识.
@Transactional
public class UserService {

	@Autowired
	private UserDao userDao;

	public static final int HASH_INTERATIONS = 1024;
	public static final String HASH_ALGORITHM = "SHA-1";
	private static final int SALT_SIZE = 8;

	public Page<User> getUser(Map<String, Object> searchParams, int pageNumber,
			int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<User> spec = Util.buildSpecification(searchParams,
				User.class);
		return userDao.findAll(spec, pageRequest);
	}

	/**
	 * 添加用户或者修改密码时使用
	 * 
	 * @param user
	 * @return
	 */
	public User saveorupdate(User user) {
		entryptPassword(user);
		return userDao.save(user);
	}

	/**
	 * 修改验证码
	 * 
	 * @param repair
	 * @return
	 */
	public User saveCaptcha(User user) {
		return userDao.save(user);
	}

	/**
	 * 判断该用户名是否已存在
	 * 
	 * @param loginName
	 * @return
	 */

	public User findByName(String name) {
		List<User> byNameList = userDao.findByName(name);
		if (byNameList != null && byNameList.size() > 0) {
			return byNameList.get(0);
		}
		return null;
	}
	
	public User findByTelephone(String telephone) {
		List<User> byTelephoneList = userDao.findByTelephone(telephone);
		if (byTelephoneList != null && byTelephoneList.size() > 0) {
			return byTelephoneList.get(0);
		}
		return null;
	}

	/**
	 * 根据ID跟 登录名查找用户 ，用户编辑时判断登陆名是否重复
	 * 
	 * @param loginName
	 * @param id
	 * @return
	 */
	public int findByNameAndId(String name, Long id) {
		return userDao.findByNameAndId(name, id);
	}
	
	public boolean findByCaptchaAndId(String captcha, Long id) {
		List<User> userlist = userDao.findByCaptchaAndId(captcha, id);
		if(userlist != null && userlist.size() > 0) {
			return true;
		}
		return false;
	}
	
	/** 
	 * 根据ID跟手机号码查找用户 ，用户编辑时判断手机号码是否已被注册
	 * @author yigang
	 * @date 2015年7月16日 下午1:49:05
	 * @param telephone
	 * @param id
	 * @return
	 */
	public int findByTelephoneAndId(String telephone, Long id) {
		return userDao.findByTelephoneAndId(telephone, id);
	}

	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void delete(Long id) {
		userDao.delete(id);
	}

	/**
	 * 分页排序
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	/**
	 * 根据ID获取repair
	 * 
	 * @param id
	 * @return
	 */
	public User get(Long id) {
		return userDao.findOne(id);
	}

	/**
	 * 更新
	 * 
	 * @param r
	 */
	public void update(User r) {
		userDao.save(r);
	}

	/**
	 * 通过角色Role的id来查找所有具有这个角色的用户
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午2:45:55
	 * @param id
	 * @return
	 */
	public List<User> findByRole(Long id) {
		return userDao.findByRole(id);
	}

	/**
	 * 将用户的密码加密处理
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午2:46:27
	 * @param user
	 */
	private void entryptPassword(User user) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		user.setSalt(Encodes.encodeHex(salt));

		byte[] hashPassword = Digests.sha1(user.getPassword().getBytes(), salt,
				HASH_INTERATIONS);
		user.setPassword(Encodes.encodeHex(hashPassword));
	}
	
	public String entryptPasswordStr(String salt, String password) {
		byte[] deByte = Encodes.decodeHex(salt);
		byte[] hashPassword = Digests.sha1(password.getBytes(), deByte,
				HASH_INTERATIONS);
		return Encodes.encodeHex(hashPassword);
	}

	/**
	 * 将用户的密码做解密处理
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午2:46:42
	 * @param user
	 * @param inputPassword
	 * @return
	 */
	public boolean decryptPassword(User user, String inputPassword) {
		String dbSalt = user.getSalt();
		String dbPassword = user.getPassword();
		byte[] deByte = Encodes.decodeHex(dbSalt);
		byte[] dePassword = Digests.sha1(inputPassword.getBytes(), deByte,
				HASH_INTERATIONS);
		String dePasswordStr = Encodes.encodeHex(dePassword);
		if (dePasswordStr.equals(dbPassword)) {
			return true;
		}
		return false;
	}

	/**
	 * 通过登录名和验证码来查找用户
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午2:47:46
	 * @param name
	 * @param captcha
	 * @return
	 */
	public User findByLoginNameAndCaptcha(String name, String captcha) {
		// TODO Auto-generated method stub
		return userDao.findByNameAndCaptcha(name, captcha);
	}

	/**
	 * 查询该用户是否有效，>0有效，=0无效
	 * 
	 * @param loginName
	 * @return
	 */
	public int findEffectUser(String loginName) {
		return userDao.findEffectUser(loginName);
	}

	/**
	 * 通过Role来查找所有具有此角色的User列表
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午2:48:08
	 * @param id
	 * @return
	 */
	public List<User> findUseByRole(Long id) {
		return userDao.findUseByRole(id);
	}

	/**
	 * 通过用户的id来查找User
	 * 
	 * @author yigang
	 * @date 2015年4月20日 下午2:48:45
	 * @param userid
	 * @return
	 */
	public User findUser(Long userid) {
		// TODO Auto-generated method stub
		return userDao.findOne(userid);
	}

	/**
	 * 
	 * 根据电话查用户
	 * 
	 * @author lyf
	 * @date 2015年6月23日 下午1:20:28
	 * @param telephone
	 * @return
	 */
	public User findBytelephone(String telephone) {
		List<User> lu = userDao.findBytelephone(telephone);
		if (lu.size() == 1) {
			return lu.get(0);
		} else {
			return null;
		}
	}

	public List<User> findUserByRoleAndMerchantid() {
		return userDao.findUserByRoleAndMerchantid();
	}

	public List<User> findByMerchantid(Long id) {
		return userDao.findByMerchantid(id);
	}
	
	public void setCaptchaNullValueById(Long id) {
		userDao.setCaptchaNullValueById(id);
	}
	
	public List<User> getUsersByCommunityid(Long commid) {
		return userDao.getUsersByCommunityid(commid);
	}
	
}
