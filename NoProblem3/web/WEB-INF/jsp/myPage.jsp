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

    ${user.name}<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../layui/layui.js"></script>
    <script src="<%=path %>/showdown-1.9.0/dist/showdown.min.js"></script>

    <title>主页</title>
    <script type="text/javascript">
        function delete1(){
            $('.delete').on('click',function(){
                var title=$(this).parents('.op-list').prevAll('h4.text-cont').text();
                $.ajax({
                    type:"POST",
                    url:"deletePro",
                    data:{"proName":title},
                    dataType: "json",
                    success:function(data){
                        alert(data.info);
                        window.location.reload()
                        $(this).parents('.item-box').remove();
                    },
                    error:function(data){
                        alert(data.info);
                    }
                })
            })
        }


        function off(){
            $('.off').on('click',function(){
                var off = $(this).attr('off');
                var chi = $(this).children('i');
                var text = $(this).children('span');
                var cont = $(this).parents('.item').siblings('.review-version');
                if(off){
                    $(text).html('展开');
                    $(chi).attr('class','layui-icon layui-icon-down');
                    $(this).attr('off','');
                    $(cont).addClass('layui-hide');
                }else{
                    $(text).html('收起');
                    $(chi).attr('class','layui-icon layui-icon-up')
                    $(this).attr('off','true')
                    $(cont).removeClass('layui-hide')
                }
            })
        }


        layui.config({
            base: '../js/util/'
        }).use(['element','laypage','form','menu'],function(){
            element = layui.element,laypage = layui.laypage,form = layui.form,menu = layui.menu;
            laypage.render({
                elem: 'demo'
                ,count: 70 //数据总数，从服务端得到
            });
            off();
            delete1();
            $('.layui-btn').on('click',function(){
                var item = $(this).parents('.item-box').children('.item');

                var titleClass = $(item).find("h4.text-cont");
                var title=$(titleClass).text();
                var content = $(this).parents(".layui-form-item").prev().children().children().val();

                $.ajax({
                    type: "Post",
                    //方法所在页面和方法名
                    data: {"title":title,"content":content},
                    contentType: "application/x-www-form-urlencoded",
                    url: "reply",
                    dataType: "json",
                    success:function(data){
                        alert(data.info);
                    },
                    error:function(data){
                        alert(data.info);
                    }
                });
            });
        })

        $(function () {
            $.ajax({
                //要用post方式
                type: "Post",
                //方法所在页面和方法名
                data: {"info":"abc"},
                contentType: "application/x-www-form-urlencoded",
                url: "getMyPro",
                dataType: "json",
                success: function (data) {
                    //返回的数据用data.d获取内容
                    var html="";
                    var allPro = document.getElementById('AllPro');
                    var countPro=0;
                    for (var pro in data) {
                        countPro++;
                        html+="<div style=\"background:#e4e4e4\" class=\"item-box\">"+
                            "<div class=\"item\">"+
                            "<div class=\"whisper-title\">"+
                            "<i class=\"layui-icon layui-icon-date\"></i><span class=\"hour\">"+data[pro][0].publishTime+"</span>"+
                            "</div>"+
                            "<h4 class=\"text-cont\">"+
                            data[pro][0].proName
                            +"</h4>"+

                            "<p class=\"text-cont\">"+data[pro][0].content+"</p>"+
                            "<div class=\"op-list\">"+
                            "<p class=\"edit\"><i class=\"layui-icon layui-icon-reply-fill\"></i><span>"+data[pro][1].length+"</span></p>"+"" +
                            "<p style=\"margin-top:5px;margin-left:50px;\"><span class=\"delete\">删除</span></p>"+
                            "<p class=\"off\"><span class=\"xiala\">展开</span><i class=\"layui-icon layui-icon-down\"></i></p>"+
                            "</div></div>"+
                            "<div id=\"answer\" class=\"review-version layui-hide\">"+
                            "<div class=\"form\">"+
                            "<form class=\"layui-form\" action=\"\">"+
                            "<div class=\"layui-form-item layui-form-text\">"+
                            "<div class=\"layui-input-block\">"+
                            "<textarea name=\"desc\" class=\"layui-textarea\"></textarea>"+
                            "</div></div>"+
                            "<div class=\"layui-form-item\">"+
                            "<div class=\"layui-input-block\" style=\"text-align: right;\">"+
                            "<button  type=\"button\" class=\"layui-btn definite\">確定</button>"+
                            "</div></div></form></div>";
                        if(data[pro][1].length!=0){
                            html +="<div class=\"list-cont\">";
                            var i =0;
                            for(i=0;i<data[pro][1].length;i++){
                                html += "<div class=\'cont\'>" +

                                    "<div class=\'text\'>\n" +
                                    "<p class=\'tit\'><span class=\'name\'>"+data[pro][1][i].answerName+
                                    "</span><span class=\"data\">"+data[pro][1][i].answerTime+"</span></p>" +

                                    "<p class=\"ct\">"+data[pro][1][i].content+"</p>" +
                                    "</div>" +
                                    "</div>";
                            }
                            html+='</div></div></div>';
                        }

                    }
                    html+="</div>  </div>";
                    $('#AllPro').append(html)
                    $('#countPro').html(countPro);
                },
                error: function (err) {
                    alert('failed' + err.info);
                }
            });
            //获取文章
            $.ajax({
                //要用post方式
                type: "Post",
                //方法所在页面和方法名
                data: {"info":"abc"},
                contentType: "application/x-www-form-urlencoded",
                url: "getMyArticle",
                dataType: "json",
                success: function (data) {
                    //返回的数据用data.d获取内容
                    var html="";
                    var allPro = document.getElementById('AllArticle');
                    var i=0;
                    for (i=0; i < data.length; i++) {
                        var converter = new showdown.Converter();
                        var content = converter.makeHtml(data[i].content);
                        html = "<div class=\'cont\'>" +
                            "<div class=\'text\'>\n" +
                            "<p class=\'tit\'><span class=\'name\'>"+data[i].username+
                            "</span><span class=\"data\">"+data[i].publishTime+"</span></p>" +
                            "<p class=\"ct\">"+data[i].title+"</p><br>" +
                            "<div class=\"ct\">"+content+"</div>" +
                            "</div>" +
                            "</div>" +
                             "<p></p>";
                        $('#AllArticle').append(html);
                    }
                    $('#countArticle').html(data.length);
                },
                error: function (err) {
                    alert('获取信息失败，请稍后重试' + err);
                }
            });
        });
    </script>


</head>

<body >
<div class="header">

    <div class="menu-btn">
        <div class="menu"></div>
    </div>
    <a href="index.html">
        <span>知乎</span>
    </a>
    <div class="nav">
        <a href="main">主页</a>
        <a href="article">文章</a>
        <a href="publishPro">提问</a>
        <a href="publishArticle">写文章</a>
        <a href="myPage" class="active">我的</a>
    </div>
    <ul class="layui-nav header-down-nav">
        <li class="layui-nav-item">
            <button onclick="gotoMain">主页</button>
        </li>
        <li class="layui-nav-item">
            <button onclick="article">文章</button>
        </li>
        <li class="layui-nav-item">
            <button onclick="none" class="active">我的</button>
        </li>
    </ul>
    <p class="welcome-text">
        欢迎来到<span class="name">${sessionScope.name}</span>的主页~
    </p>
</div>


<div class="content whisper-content leacots-content details-content">
    <div class="cont w1000">
        <div class="whisper-list">
                <div class="review-version">

                    <div class="volume">
                        我的问题<span id="countPro"></span>
                    </div>
                    <div id ="AllPro" class="whisper-list">

                    </div>
                    <div class="volume">
                        我的文章<span id="countArticle"></span>
                    </div>
                    <div id="AllArticle" class="list-cont">

                    </div>
                </div>
        </div>

    </div>
</div>
</body>
</html>