<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/12/25
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page language="java" import="com.spj.entity.*" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <title>主页</title>
    <script type="text/javascript">
        $(function() {
            $("#btnOK").click(function() {
                var title=$(" input[ name='title' ] ").val();
                var content=$(" textarea[ name='content'] ").val();

                $.ajax({
                    //要用post方式
                    type: "Post",
                    //方法所在页面和方法名
                    data: {'title':title,'content':content},
                    contentType:"application/x-www-form-urlencoded",
                    url: "fabuPro",
                    dataType: "json",
                    success: function(data) {
                        //返回的数据用data.d获取内容
                        alert('success'+data.info);
                    },
                    error: function(data) {
                        alert('failed'+data.info);
                    }
                });
                //禁用按钮的提交
                return false;
            });
        });

    </script>


</head>

<body style="background:#e4e4e4">
<div class="header">
    <div class="menu-btn">
        <div class="menu"></div>
    </div>
    <a href="index.html">
        <span>知乎</span>
    </a>
    <div class="nav">
        <a href="main" >主页</a>
        <a href="article" >文章</a>
        <a href="publishPro" class="active">提问</a>
        <a href="publishArticle">写文章</a>
        <a href="myPage" >我的</a>
    </div>
    <ul class="layui-nav header-down-nav">
        <li class="layui-nav-item"><button onclick="gotoMain" >主页</button></li>
        <li class="layui-nav-item"><button onclick="article">文章</button></li>
        <li class="layui-nav-item"><button onclick="none" class="active">我的</button></li>
    </ul>
    <p class="welcome-text">
        欢迎来到<span class="name">${sessionScope.name}</span>的主页~
    </p>
</div>


<div class="content whisper-content leacots-content details-content">
    <div class="cont w1000">
        <div class="whisper-list">
            <div class="item-box">
                <div class="review-version">
                    <div class="form-box">
                        <div class="article-cont">
                            <div class="title">
                                <h3>请填写问题描述</h3>
                            </div>
                        </div>
                        <div class="form">
                            <form:form action="/fabuPro" method="post" role="form">

                                <div class="layui-form-item layui-form-text">

                                    <div class="layui-input-block">
                                        <input name="title" placeholder="标题" class ="layui-input"/>
                                        <br>
                                        <textarea name="content" placeholder="问题描述" class="layui-textarea"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block" style="text-align: right;">
                                        <button id="btnOK" type="button" class="layui-btn definite">確定</button>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
