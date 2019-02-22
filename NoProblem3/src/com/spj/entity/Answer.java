package com.spj.entity;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.Date;


@Component
public class Answer {
    private String answerName;
    private String proName;
    private String answerTime;
    private String content;

    public Answer(){}

    public Object[] getObj(){
        Object[] objects= new Object[4];
        objects[0]=answerName;
        objects[1]=answerTime;
        objects[2]=proName;
        objects[3]=content;
        return objects;
    }

    public Answer(String answerName, String proName, String answerTime, String content) {
        this.answerName = answerName;
        this.proName = proName;
        this.answerTime = answerTime;
        this.content = content;
    }


    public String getAnswerName() {
        return answerName;
    }

    public void setAnswerName(String answerName) {
        this.answerName = answerName;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getAnswerTime() {
        return answerTime;
    }

    public void setAnswerTime(String answerTime) {
        this.answerTime = answerTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
