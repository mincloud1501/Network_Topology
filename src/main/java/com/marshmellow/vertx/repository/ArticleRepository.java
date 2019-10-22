package com.marshmellow.vertx.repository;

import com.marshmellow.vertx.entity.Article;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleRepository extends JpaRepository<Article, Long> {
	
}