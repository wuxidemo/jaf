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

import com.yjy.entity.Resource;
import com.yjy.entity.Role;
import com.yjy.repository.ResourceDao;
import com.yjy.repository.RoleDao;
import com.yjy.utils.Util;

/**
 * 类RoleService.java的实现描述：Role的Service层
 * @author yigang 2015年4月20日 下午2:17:25
 */
@Component
//类中所有public函数都纳入事务管理的标识.
@Transactional
public class RoleService {
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private ResourceDao resourceDao;
	
	/** 
	 * 获取所有的Role列表
	 * @author yigang
	 * @date 2015年4月20日 下午2:17:41
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Role> getRoles(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Role> spec = Util.buildSpecification(searchParams,
				Role.class);
		return roleDao.findAll(spec, pageRequest);
	}

	/** 
	 * 保存一个Role对象
	 * @author yigang
	 * @date 2015年4月20日 下午2:17:54
	 * @param role
	 * @return
	 */
	public Role save(Role role) {
		return roleDao.save(role);
	}

	/** 
	 * 修改Role
	 * @author yigang
	 * @date 2015年4月20日 下午2:18:07
	 * @param role
	 * @return
	 */
	public Role update(Role role) {
		return roleDao.save(role);
	}

	/** 
	 * 删除Role
	 * @author yigang
	 * @date 2015年4月20日 下午2:43:49
	 * @param id
	 */
	public void delete(Long id) {
		roleDao.delete(id);
	}

	/** 
	 * 通过id来获取某个Role
	 * @author yigang
	 * @date 2015年4月20日 下午2:43:59
	 * @param id
	 * @return
	 */
	public Role get(Long id) {
		return roleDao.findOne(id);
	}
	
	/** 
	 * 获取所有的Role
	 * @author yigang
	 * @date 2015年4月20日 下午2:44:16
	 * @return
	 */
	public List<Role> findAllRoles() {
		return roleDao.findAllRoles();
	}
	
	public List<Role> findAllRolesForAdd() {
		return roleDao.findAllRolesForAdd();
	}
	
	/**
	 * 判断该角色名是否已存在
	 * @param loginName
	 * @return
	 */
	
	public int findByName(String name) {
		List<Role> roleList = roleDao.findByName(name);
		if(roleList != null) {
			if(roleList.size() == 0) {
				return 1;
			}else{
				return 0;
			}
		}else{
			return 0;
		}
	}
	
	/**
	 * 根据ID跟 角色名查找用角色，角色编辑时判断角色名是否重复
	 * 
	 * @param loginName
	 * @param id
	 * @return
	 */
	public int findByNameAndId(String name, Long id) {
		return roleDao.findByNameAndId(name, id);
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
			sort = new Sort(Direction.ASC, "id");
		} else if ("name".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} 

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
	
	
	/** 
	 * 获取所有的某个用户具有权限的资源列表
	 * @author yigang
	 * @date 2015年4月20日 下午2:44:35
	 * @param roleId
	 * @return
	 */
	public String getTree(Long roleId) {
		List<Resource> supResList = resourceDao.findAllIdSortedSupResources();
		List<Integer> hasId = resourceDao.findByRoleId(roleId);
		if(supResList != null && supResList.size() > 0) {
			StringBuilder allStr = new StringBuilder();
			allStr.append("[");
			for(Resource supres : supResList) {
				StringBuilder allSupStr = new StringBuilder();
				allSupStr.append("{");
				allSupStr.append("\"id\""+":"+"\""+supres.getId()+"\"");
				allSupStr.append(",");
				allSupStr.append("\"text\""+":"+"\""+supres.getName()+"\"");
				
				for(Integer in : hasId) {
					if(supres.getId() == (long)in) {
						allSupStr.append(",");
						allSupStr.append("\"state\""+":"+"{\"opened\":true,\"selected\":true}");
						continue;
					}
				}
				
				List<Resource> subResList = resourceDao.findAllSortedSubResourcesByPid(supres.getId());
				if(subResList != null && subResList.size() > 0) {
					allSupStr.append(",");
					StringBuilder allSubStr = new StringBuilder();
					allSubStr.append("[");
					for(Resource subres : subResList) {
						StringBuilder smallSubStr = new StringBuilder();
						smallSubStr.append("{");
						smallSubStr.append("\"id\""+":"+"\""+subres.getId()+"\"");
						smallSubStr.append(",");
						smallSubStr.append("\"text\""+":"+"\""+subres.getName()+"\"");
						smallSubStr.append(",");
						smallSubStr.append("\"icon\""+":"+"\"fa fa-folder icon-state-default\"");
						
						for(Integer in : hasId) {
							if(subres.getId() == (long)in) {
								smallSubStr.append(",");
								smallSubStr.append("\"state\""+":"+"{\"selected\":true}");
								continue;
							}
						}
						
						smallSubStr.append("}");
						smallSubStr.append(",");
						allSubStr.append(smallSubStr);
					}
					String allSubStrToStr = allSubStr.toString();
					int length = allSubStrToStr.length();
					StringBuilder allSubStrTemp = new StringBuilder(allSubStrToStr.substring(0, length-1));
					allSubStrTemp.append("]");
					
					allSupStr.append("\"children\""+":"+allSubStrTemp.toString());
				}
				allSupStr.append("}");
				allSupStr.append(",");
				allStr.append(allSupStr);
			}
			String allStrToStr = allStr.toString();
			int allLength = allStrToStr.length();
			StringBuilder allStrTemp = new StringBuilder(allStrToStr.substring(0,allLength-1));
			allStrTemp.append("]");
			String str = allStrTemp.toString();
			//System.out.println(str);
			return str;
		}
		return null;
	}
	
}
