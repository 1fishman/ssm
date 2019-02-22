package com.spj.entity;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Component
public class Article {
    private String username;
    private String content;
    private String publishTime;
    private String title;

    public Article(){}

    public Object[] getObj(){
        Object[] objects= new Object[4];
        objects[0]=username;
        objects[1]=content;
        objects[2]=publishTime;
        objects[3]=title;
        return objects;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(String publishTime) {
        this.publishTime = publishTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }



    public Article(String username, String content, String publishTime, String title) {
        this.username = username;
        this.content = content;
        this.publishTime = publishTime;
        this.title = title;
    }







}
