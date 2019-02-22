package com.spj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JumpController {

    @RequestMapping("article")
    public String gotoArticle(){
        return "article";
    }

    @RequestMapping("myPage")
    public String gotoMyPage(){
        return "myPage";
    }

    @RequestMapping("main")
    public String gotoMain(){
        return "main";
    }
    @RequestMapping("allProblem")
    public String gotoAllProblem(){
        return "allProblem";
    }

    @RequestMapping("publishPro")
    public String gotoPublishPro(){
        return "publishPro";
    }

    @RequestMapping("publishArticle")
    public String gotoPublishArticle()
    {
        return "publishArticle";
    }

}
