package com.marshmellow.vertx.service;

import com.marshmellow.vertx.entity.Article;
import com.marshmellow.vertx.repository.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleService {

    @Autowired
    private ArticleRepository articleRepository;

    public List<Article> getAllArticle() {
        return articleRepository.findAll();
    }

}