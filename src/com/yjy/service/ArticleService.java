package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Article;

public interface ArticleService {

	public Page<Article> getList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType);


	public Article save(Article art) ;

	public boolean delete(String ids);

	public Article find(Long id);
	
	public List<Article> getArticleListByUrl(String url);
	
	public List<Article> getArticleListByCreatorid(Long userid) ;
}
