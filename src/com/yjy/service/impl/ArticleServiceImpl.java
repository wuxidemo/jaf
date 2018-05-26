package com.yjy.service.impl;

import java.util.HashMap;
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

import com.yjy.entity.Article;
import com.yjy.repository.ArticleDao;
import com.yjy.service.ArticleService;
import com.yjy.utils.Util;

@Component
@Transactional
public class ArticleServiceImpl implements ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public Page<Article> getList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);

		Specification<Article> spec = Util.buildSpecification(searchParams,
				Article.class);
		return articleDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		// TODO Auto-generated method stub
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Article save(Article art) {
		return articleDao.save(art);
	}

	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			articleDao.delete(Long.parseLong(i));
		}
		return true;
	}

	public Article find(Long id) {

		return articleDao.findOne(id);
	}
	
	public List<Article> getArticleListByUrl(String url) {
		if(url == null) {
			return null;
		}
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("EQ_url", url.trim());
		Specification<Article> spec = Util.buildSpecification(map,
				Article.class);
		return articleDao.findAll(spec);
	}
	
	public List<Article> getArticleListByCreatorid(Long userid) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("EQ_user.id", userid);
		Specification<Article> spec = Util.buildSpecification(map,
				Article.class);
		return articleDao.findAll(spec);
	}
}
