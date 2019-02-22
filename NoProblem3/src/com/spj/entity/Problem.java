package com.spj.entity;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Problem {
    private String username;//发表者
    private String proName;//问题名称
    private String publishTime;//发布时间
    private String content;//内容

    public Problem(){

    }

    public Object[] getObj(){
        Object[] objects= new Object[4];
        objects[0]=username;
        objects[1]=proName;
        objects[2]=publishTime;
        objects[3]=content;
        return objects;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
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

    public Problem(String username, String proName, String publishTime, String content) {
        this.username = username;
        this.proName = proName;
        this.publishTime = publishTime;
        this.content = content;
    }
}



