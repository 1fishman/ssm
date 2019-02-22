<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/12/25
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page language="java" import="com.spj.entity.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=path %>/editormd/examples/css/style.css" />
    <link rel="stylesheet" href="<%=path %>/editormd/css/editormd.css" />
    <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    <script src="<%=path %>/editormd/examples/js/jquery.min.js"></script>
    <script src="<%=path %>/editormd/editormd.min.js"></script>
    <title>主页</title>
    <script type="text/javascript">
        $(function() {
            testEditor = editormd("test-editormd", {
                width   : "90%",
                height  : 600,
                syncScrolling : "single",
                path    : "<%=path %>/editormd/lib/",
                imageUpload : true,
                imageFormats : ["jpg","jpeg","gif","png","bmp","webp"],
                imageUploadURL : "<%=basePath%>PicSvl",
                saveHTMLToTextarea : true
            });

            $("#btnOK").click(function() {
                var title=$(" input[ name='title' ] ").val();
                var content=$(" textarea[ name='content'] ").val();

                if(title=='')
                {
                    alert('请输入标题')
                    return
                }else if(content==''){
                    alert('请输入文章内容')
                    return
                }
                if(title.length>200){
                    alert("标题不能超过200")
                    return
                }
                if(content.length>10000){
                    alert("内容太长了，简洁点吧")
                    return
                }
                $.ajax({
                    //要用post方式
                    type: "Post",
                    //方法所在页面和方法名
                    data: {'title':title,'content':content},
                    contentType:"application/x-www-form-urlencoded",
                    url: "fabuArticle",
                    dataType: "json",
                    success: function(data) {
                        //返回的数据用data.d获取内容
                        alert('success'+data.info);
                    },
                    error: function(err) {
                        alert('failed'+err.info);
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
    <div class="nav">
        <a href="main" >主页</a>

        <a href="article" >文章</a>
        <a href="publishPro" >提问</a>
        <a href="publishArticle" class="active">写文章</a>
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
                                <h3>分享自己的文章吧</h3>
                            </div>
                        </div>
                        <div class="form">
                            <form:form action="/fabuArticle" method="post" role="form">
                                <input name="title" placeholder="标题" class ="layui-input"/>
                                <div id="test-editormd">

                                        <br>
                                        <textarea style="display:none;" name="content"  class="editormd-html-textarea" id="editormd"></textarea>
                                        <textarea class="editormd-html-textarea"   id="editormdhtml"></textarea>
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
