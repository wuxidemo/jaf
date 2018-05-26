package com.yjy.service.impl;

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

import com.yjy.entity.Community;
import com.yjy.entity.Sq_Advert;
import com.yjy.repository.CommunityDao;
import com.yjy.repository.SqAdvertDao;
import com.yjy.service.CommunityService;
import com.yjy.utils.Util;
/**
 * 类CommunityService。java的实现描述：Community下的增删改查
 * @author liping
 *
 */
@Component
@Transactional
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	private CommunityDao communityDao;
	
	@Autowired
	private SqAdvertDao sqAdvertDao;
    
	@Override
	/**
	 * 获取Community集合
	 */
	public Page<Community> getCommunityList(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest=buildPageRequest(pageNumber,pageSize,sortType);
		Specification<Community> spec=Util.buildSpecification(searchParams, Community.class);
		return communityDao.findAll(spec, pageRequest);
	}
    /**
     * 分页查询方法
     * @param pageNumber
     * @param pageSize
     * @param sortType
     * @return
     */
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort=null;
		if("auto".equals(sortType)){
			sort=new Sort(Direction.DESC, "id");
		}else if("createtime".equals(sortType)){
			sort=new Sort(Direction.DESC,"createtime");
		}
		sort=new Sort(Direction.DESC,"createtime").and(new Sort(Direction.ASC,"categoryValue.id"));
		return new PageRequest(pageNumber-1, pageSize, sort);
	}

	@Override
	/**
	 * 获取社区Community集合
	 */
	public List<Community> getCommunityList(){
		List<Community> list=communityDao.getCommunityList();
		return list;
	}

	@Override
	/**
	 * 根据社区名称，字典项id获取Community集合
	 */
	public List<Community> getCommunityByName(String value, Long cid) {
		return communityDao.getCommunityByName(value, cid);
	}

	@Override
	/**
	 * 更新Community对象
	 */
	public void SaveOrUpdate(Community community) {
		communityDao.save(community);
	}
	@Override
	/**
	 * 根据ids删除满足条件的所有Community
	 */
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for(String i:id){
			sqAdvertDao.deleteByComid(Long.valueOf(i));
			communityDao.delete(Long.parseLong(i));
		}
		return true;
		
	}
	@Override
	public Community get(Long id) {
		// TODO Auto-generated method stub
		return communityDao.findOne(id);
	}

}
