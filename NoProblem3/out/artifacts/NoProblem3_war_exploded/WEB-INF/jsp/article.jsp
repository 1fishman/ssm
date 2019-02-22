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

    <link href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../layui/layui.js"></script>
    <script src="<%=path %>/showdown-1.9.0/dist/showdown.min.js"></script>
    <title>文章</title>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                //要用post方式
                type: "Post",
                //方法所在页面和方法名
                data: {"info":"abc"},
                contentType: "application/x-www-form-urlencoded",
                url: "allArticle",
                dataType: "json",
                success: function (data) {
                    //返回的数据用data.d获取内容
                    var html="";
                    var allPro = document.getElementById('AllArticle');
                    var i=0;
                    for (i=0; i < data.length-1; i++) {
                        var converter = new showdown.Converter();
                        var content = converter.makeHtml(data[i].content);
                        html = "<div class=\'cont\' style='background:#fff; margin-left:0px'>" +

                        "<div class=\'text\'>\n" +
                            "<p class=\'tit\'><span class=\'name\'>"+data[i].username+
                            "</span><span class=\"data\">"+data[i].publishTime+"</span></p>" +
                            "<p class=\"ct\">"+data[i].title+"</p><br>" +
                            "<div class=\"ct\">"+content+"</div>" +
                            "</div>" +
                            "</div>" +
                            "<p style='background:#000'><p>";
                        $('#AllArticle').append(html);
                    }
                    $('#count').html(data[i].username);
                },
                error: function (err) {
                    alert('刷新失败,请稍后重试' + err);
                }
            });
        });
    </script>


</head>

<body style="background:#eeeeee">
<div class="header">
    <div class="menu-btn">
        <div class="menu"></div>
    </div>
    <a href="#">
        <span>知乎</span>
    </a>
    <div class="nav">
        <a href="main" >主页</a>
        <a href="article" class="active">文章</a>
        <a href="publishPro">提问</a>
        <a href="publishArticle">写文章</a>
        <a href="myPage" >我的</a>
    </div>
    <ul class="layui-nav header-down-nav">
        <li class="layui-nav-item"><button onclick="gotoMain" >主页</button></li>
        <li class="layui-nav-item"><button onclick="none" class="active">文章</button></li>
        <li class="layui-nav-item"><button onclick="myPage">我的</button></li>
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
                    <div class="volume">
                        全部文章 <span id="count"></span>
                    </div>
                    <div id="AllArticle" class="list-cont">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
