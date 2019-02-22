package com.spj.controller;

import com.spj.Dao.ArticleDao;
import com.spj.entity.Article;
import org.apache.tomcat.util.http.parser.HttpParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jca.cci.InvalidResultSetAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ArticleController {

    @Autowired
    ArticleDao articleDao;

    @Autowired
    HttpServletRequest request;

    @RequestMapping(value = "ajax",method = RequestMethod.POST)
    public ModelAndView getArticle(HttpServletRequest request, HttpServletResponse response){
        return new ModelAndView("main");
    }

    @RequestMapping(value= "fabuArticle",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> fabuArticle(@ModelAttribute("name")String userName, String title, String content) throws UnsupportedEncodingException {
        java.util.Date date = new java.util.Date();
        Date date1= new Date(date.getTime());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Article article=new Article((String) request.getSession().getAttribute("name"),content,sdf.format(date),title);
        Map<String, Object> mm = new HashMap<>();
        System.out.println(article.getContent());
        try{
            articleDao.insertArticle(article);
            // 使用JdbcTemplate访问数据库
            mm.put("info", "成功");
        }catch (InvalidResultSetAccessException e){
            mm.put("info", "内容超出长度了，最好不要超过3000个字");
        }catch (DataAccessException e) {
            mm.put("info", "你已经发布过此问题了");
        }finally {
            return mm;
        }
    }

    @RequestMapping("allArticle")
    @ResponseBody
    public List<Article> getAllArticle(){
        List<Article> ls = articleDao.getAllArticle();
        Article article =new Article(String.valueOf(ls.size()),"","","");
        ls.add(article);
        return ls;
    }

    @RequestMapping("getMyArticle")
    @ResponseBody
    public List<Article> getMyArticle(){
        List<Article> ls = articleDao.queryArticleByUserName((String) request.getSession().getAttribute("name"));
        return ls;
    }
}
