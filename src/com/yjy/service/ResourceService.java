package com.yjy.service;

import java.util.ArrayList;
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
import com.yjy.repository.ResourceDao;
import com.yjy.utils.Util;

/**
 * 类ResourceService.java的实现描述：实现Resource的增删改查
 * @author zhangmengmeng 2015-4-20 上午10:24:56
 */
@Component
//类中所有public函数都纳入事务管理的标识.
@Transactional
public class ResourceService {
	
	@Autowired
	private ResourceDao resourceDao;
	
	/** 
	 * 获取资源列表
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:25:14
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Resource> getResources(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Resource> spec = Util.buildSpecification(searchParams,
				Resource.class);
		return resourceDao.findAll(spec, pageRequest);
	}

	/** 
	 * 保存
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:25:24
	 * @param resource
	 * @return
	 */
	public Resource save(Resource resource) {
		return resourceDao.save(resource);
	}

	/** 
	 * 更新
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:25:30
	 * @param resource
	 * @return
	 */
	public Resource update(Resource resource) {
		return resourceDao.save(resource);
	}

	/** 
	 * 删除
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:25:36
	 * @param id
	 */
	public void delete(Long id) {
		resourceDao.delete(id);
	}

	/** 
	 * 获取单个
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:25:43
	 * @param id
	 * @return
	 */
	public Resource get(Long id) {
		return resourceDao.findOne(id);
	}
	
	/** 
	 * 获取全部资源
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:25:51
	 * @return
	 */
	public List<Resource> findAllResources() {
		return resourceDao.findAllResources();
	}
	
	/** 
	 * 查找除指定名称之外的所有资源的列表
	 * @author yigang
	 * @date 2015年4月20日 下午2:07:25
	 * @param name
	 * @return
	 */
	public List<Resource> findOtherResources(String name) {
		return resourceDao.findOtherResources(name);
	}
	
	/** 
	 * 查找某个父资源下的，某个用户所具有权限的资源
	 * @author yigang
	 * @date 2015年4月20日 下午2:08:17
	 * @param id
	 * @param roleId
	 * @return
	 */
	public List<Resource> findSubResources(Long id,Long roleId) {
		return resourceDao.findSubResources(id,roleId);
	}
	
	/** 
	 * 查找某个资源的父资源
	 * @author yigang
	 * @date 2015年4月20日 下午2:08:45
	 * @param id
	 * @return
	 */
	public Resource findSupResources(Long id) {
		return resourceDao.findSupResources(id);
	}
	
	/** 
	 * 用来查找所有的父级资源
	 * @author yigang
	 * @date 2015年4月20日 下午2:09:25
	 * @return
	 */
	public List<Resource> findAllSupResources() {
		return resourceDao.findAllSupResources();
	}
	
	/**
	 * 判断该资源名是否已存在
	 * @param loginName
	 * @return
	 */
	
	public Resource findByName(String name) {
		List<Resource> byNameList = resourceDao.findByName(name);
		if(byNameList != null && byNameList.size() > 0) {
			return byNameList.get(0);
		}
		return null;
	}
	
	/**
	 * 根据ID跟 资源名查找用资源，资源编辑时判断资源名是否重复
	 * 
	 * @param loginName
	 * @param id
	 * @return
	 */
	public int findByNameAndId(String name, Long id) {
		return resourceDao.findByNameAndId(name, id);
	}
	
	/** 
	 * 通过角色id来查找角色资源表里面具有这种角色的所有的资源
	 * @author yigang
	 * @date 2015年4月20日 下午2:16:01
	 * @param id
	 * @return
	 */
	public List<Resource> findByRoleId(Long id) {
		List<Resource> rrList = new ArrayList<Resource>();
		List<Integer> rrIdList = resourceDao.findByRoleId(id);
		if(rrIdList != null && rrIdList.size() > 0) {
			for(Integer rid : rrIdList) {
				Resource res = resourceDao.findOne(rid.longValue());
				rrList.add(res);
			}
			return rrList;
		}
		return null;
	}
	
	/** 
	 * 通过资源的id来查找资源角色表里面的资源权限的id列表
	 * @author yigang
	 * @date 2015年4月20日 下午2:09:48
	 * @param id
	 * @return
	 */
	public List<Long> findResourceRoleIdByResourceId(Long id) {
		List<Long> longId = new ArrayList<Long>();
		List<Integer> intId = resourceDao.findResourceRoleIdByResourceId(id);
		if(intId != null) {
			for(Integer oneId : intId) {
				longId.add(oneId.longValue());
			}
			return longId;
		}
		return null;
	}
	
	/** 
	 * 查找不属于某个用户的资源的列表
	 * @author yigang
	 * @date 2015年4月20日 下午2:11:19
	 * @param id
	 * @return
	 */
	public List<Resource> findOtherResources(Long id) {
		List<Resource> rList = resourceDao.findOtherResources(id);
		if(rList != null && rList.size() >0) {
			return rList;
		}
		return null;
	}
	
	/** 
	 * 查找排序后的某个用户具有权限的资源
	 * @author yigang
	 * @date 2015年4月20日 下午2:14:04
	 * @param idList
	 * @return
	 */
	public List<Long> getSortedList(List<Long> idList) {
		List<Long> longList = new ArrayList<Long>();
		List<Integer> intList = resourceDao.findSortedList(idList);
		if(intList != null && intList.size() > 0) {
			for(Integer intL : intList) {
				longList.add(intL.longValue());
			}
		}
		return longList;
	}
	
	/** 
	 * 查找某个父菜单下的所有的排序后的资源的列表
	 * @author yigang
	 * @date 2015年4月20日 下午2:14:56
	 * @param id
	 * @return
	 */
	public List<Resource> findAllSortedSubResourcesByPid(Long id) {
		return resourceDao.findAllSortedSubResourcesByPid(id);
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
			sort = new Sort(Direction.ASC, "createtime");
		} else if ("name".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		} 

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
	
	/** 
	 * 获取所有资源的资源树
	 * @author yigang
	 * @date 2015年4月20日 下午2:15:30
	 * @return
	 */
	public String getTree() {
		List<Resource> supResList = resourceDao.findAllIdSortedSupResources();
		if(supResList != null && supResList.size() > 0) {
			StringBuilder allStr = new StringBuilder();
			allStr.append("[");
			for(Resource supres : supResList) {
				StringBuilder allSupStr = new StringBuilder();
				allSupStr.append("{");
				allSupStr.append("\"id\""+":"+"\""+supres.getId()+"\"");
				allSupStr.append(",");
				allSupStr.append("\"text\""+":"+"\""+supres.getName()+"\"");
				
				allSupStr.append(",");
				allSupStr.append("\"state\""+":"+"{\"opened\":true}");
				
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