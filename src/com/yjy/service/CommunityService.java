package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Community;

/**
 * 类CommunityService.java的 实现描述：Community下的增删改查操作
 * @author liping
 *
 */
public interface CommunityService {
	   /**
	    * 获取Community集合，分页
	    * @param searchParams
	    * @param pageNumber
	    * @param pageSize
	    * @param sortType
	    * @return
	    */
       public Page<Community> getCommunityList(Map<String,Object> searchParams,int pageNumber,int pageSize,String sortType);
      
       /**
        * 获取Community集合
        * @return
        */
       public List<Community> getCommunityList();
       
       /**
        * 根据社区名称，字典项id获取Community集合
        * @param value
        * @param cid
        * @return
        */
       public List<Community> getCommunityByName(String value,Long cid);
       
       /**
        * 更新Community对象
        * @param community
        */
       public void SaveOrUpdate(Community community);
       /**
        * 根据ids删除Community对象
        * @param ids
        * @return
        */
       public boolean delete(String ids);
       
       public Community get(Long id);
}
