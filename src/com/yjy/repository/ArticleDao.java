package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Article;

public  interface ArticleDao extends PagingAndSortingRepository<Article, Long>,
JpaSpecificationExecutor<Article> {

}
