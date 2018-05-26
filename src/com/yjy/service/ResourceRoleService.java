package com.yjy.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.ResourceRole;
import com.yjy.repository.ResourceRoleDao;

/**
 * 类ResourceRoleService.java的实现描述：实现 ResourceRole的增删改查
 * 
 * @author zhangmengmeng 2015-4-20 上午10:23:17
 */
@Component
// 类中所有public函数都纳入事务管理的标识.
@Transactional
public class ResourceRoleService {

	@Autowired
	private ResourceRoleDao resourceRoleDao;

	/**
	 * 保存
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:23:42
	 * @param resourceRole
	 * @return
	 */
	public ResourceRole save(ResourceRole resourceRole) {
		return resourceRoleDao.save(resourceRole);
	}

	/**
	 * 更新
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:23:47
	 * @param resourceRole
	 * @return
	 */
	public ResourceRole update(ResourceRole resourceRole) {
		return resourceRoleDao.save(resourceRole);
	}

	/**
	 * 删除
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:23:54
	 * @param id
	 */
	public void delete(Long id) {
		resourceRoleDao.delete(id);
	}

	/**
	 * 获取单个信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:23:59
	 * @param id
	 * @return
	 */
	public ResourceRole get(Long id) {
		return resourceRoleDao.findOne(id);
	}

	/**
	 * 根据权限删除
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:24:06
	 * @param roleId
	 * @param resourceId
	 */
	public void deleteByRoleAndResource(Long roleId, Long resourceId) {
		resourceRoleDao.deleteByRoleAndResource(roleId, resourceId);
	}

	/**
	 * 获取权限及权限列表
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:24:15
	 * @param id
	 * @return
	 */
	public List<Long> findResourceRoleIdByRoleId(Long id) {
		List<Long> longList = new ArrayList<Long>();
		List<Integer> intList = resourceRoleDao.findResourceRoleIdByRoleId(id);
		if (intList != null && intList.size() > 0) {
			for (Integer intOne : intList) {
				longList.add(intOne.longValue());
			}
			return longList;
		}
		return null;
	}

	/**
	 * 根据权限删除资源列表
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:24:31
	 * @param roleId
	 */
	public void deleteByRoleId(Long roleId) {
		resourceRoleDao.deleteByRoleId(roleId);
	}
}
