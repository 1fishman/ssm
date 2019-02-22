package com.spj.Dao;

import com.spj.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ArticleDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public boolean insertArticle(Article article){
        String sql = "insert into article values(?,?,?,?)";
        int f = jdbcTemplate.update(sql,article.getObj());
        return f>0;
    }

    public boolean deleteArticle(String username,String title){

        String sql = "delete from article where username =? and title=?";
        int f = jdbcTemplate.update(sql,username,title);
        return f>0;
    }

    public boolean updataArticle(String username, String content,Article article){
        ArticleDao dao = new ArticleDao();
        if(dao.deleteArticle(username,content)){
            return dao.insertArticle(article);
        }else{
            return false;
        }
    }

    public List<Article> queryArticleByUserName(String userName){
        String sql = "select * from article where username=? order by publishTime desc";
        RowMapper<Article> rm = new BeanPropertyRowMapper<>(Article.class);
        List<Article> ls = jdbcTemplate.query(sql,rm,userName);
        return ls;
    }

    public List<Article> queryArticleBytitle(String title){
        String sql = "select * from article where title=?" ;
        RowMapper<Article> rm = new BeanPropertyRowMapper<>(Article.class);
        List<Article> ls = jdbcTemplate.query(sql,rm,title);
        return ls;
    }

    public List<String> getAllTitle(){
        String sql ="select title from article order by publishTime desc";
        RowMapper<String> rm = new BeanPropertyRowMapper<>(String.class);
        List<String> ls = jdbcTemplate.query(sql,rm);
        return ls;
    }

    public  List<Article> getAllArticle(){
        String sql ="select * from article order by publishTime desc";
        RowMapper<Article> rm = new BeanPropertyRowMapper<>(Article.class);
        List<Article> ls = jdbcTemplate.query(sql,rm);
        return ls;
    }

}
