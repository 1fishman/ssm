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
    <script type="text/javascript" charset="utf-8" src="../layui/layui.js"></script>
    <title>主页</title>
    <script type="text/javascript">


        layui.config({
            base: '../js/util/'
        }).use(['element','laypage','form','menu'],function(){
            element = layui.element,laypage = layui.laypage,form = layui.form,menu = layui.menu;
            laypage.render();
            off();
            $('#search1').on('click',function(){
                element.init()
            })
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
                        window.location.reload()
                    },
                    error:function(data){
                        alert(data.info);
                    }
                });
            });
        })


        function zhankaipinglun(){
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
        }

        function search(){
            var content = $('#searchContent').val()
            alert(content)
            $('#AllPro').empty();
            $.ajax({
                //要用post方式
                type: "Post",
                //方法所在页面和方法名
                data: {"content":content},
                contentType: "application/x-www-form-urlencoded",
                url: "queryByMoHu",
                dataType: "json",
                success: function (data) {
                    //返回的数据用data.d获取内容
                    var html="";
                    var allPro = document.getElementById('AllPro');
                    var i=0;
                    var count=0;
                    for (var pro in data) {
                        count++;
                        html+="<div style=\"background:#e4e4e4\" class=\"item-box\">"+
                            "<div class=\"item\">"+
                            "<div class=\"whisper-title\">"+
                            "<i class=\"layui-icon layui-icon-date\"></i><span class=\"hour\">"+data[pro][0].publishTime+"</span>"+
                            "</div>"+
                            "<h4 class=\"text-cont\">"+
                            data[pro][0].proName
                            +"</h4>"+

                            "<p class=\"text-cont\">"+data[pro][0].content+"</p>"+
                            "<div class=\"img-box\">"+
                            "</div>"+
                            "<div class=\"op-list\">"+
                            "<p class=\"edit\"><i class=\"layui-icon layui-icon-reply-fill\"></i><span>"+data[pro][1].length+"</span></p>"+
                            "<p onclick=\"zhankaipinglun()\" class=\"off\"><span   class=\"xiala\">展开</span><i class=\"layui-icon layui-icon-down\"></i></p>"+
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

                                    "<p class=\"ct\">"+data[pro][1][i].content.substring(0,20)+"</p>" +
                                    "</div>" +
                                    "</div>";
                            }

                        }
                        html+='</div></div></div>';
                    }
                    if(count==0){
                        html+="<p>还没有关于此问题的数据</p>"
                        $('#AllPro').append(html)
                        $('#count').html(count);
                        return
                    }
                    html+="</div>  </div>";
                    $('#AllPro').append(html)
                    $('#count').html(count);

                    layui.config({
                        base: '../js/util/'
                    }).use(['element','laypage','form','menu'],function(){
                            element = layui.element,laypage = layui.laypage,form = layui.form,menu = layui.menu;
                            laypage.render();
                            off();})
                },
                error: function (err) {
                    alert('failed');
                }
            });
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






        $(function () {

            $.ajax({
                //要用post方式
                type: "Post",
                //方法所在页面和方法名
                data: {"info":"abc"},
                contentType: "application/x-www-form-urlencoded",
                url: "AllProblem",
                dataType: "json",
                success: function (data) {
                    //返回的数据用data.d获取内容
                    var html="";
                    var allPro = document.getElementById('AllPro');
                    var i=0;
                    var count=0;
                    for (var pro in data) {
                        count++;
                        html+="<div style=\"background:#e4e4e4\" class=\"item-box\">"+
                            "<div class=\"item\">"+
                                "<div class=\"whisper-title\">"+
                                    "<i class=\"layui-icon layui-icon-date\"></i><span class=\"hour\">"+data[pro][0].publishTime+"</span>"+
                                "</div>"+
                                "<h4 class=\"text-cont\">"+
                                    data[pro][0].proName
                                +"</h4>"+

                         "<p class=\"text-cont\">"+data[pro][0].content+"</p>"+
                        "<div class=\"img-box\">"+
                            "</div>"+
                            "<div class=\"op-list\">"+
                        "<p class=\"edit\"><i class=\"layui-icon layui-icon-reply-fill\"></i><span>"+data[pro][1].length+"</span></p>"+
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

                                    "<p class=\"ct\">"+data[pro][1][i].content.substring(0,20)+"</p>" +
                                    "</div>" +
                                    "</div>";
                            }

                        }
                        html+='</div></div></div>';
                    }
                    html+="</div>  </div>";
                    $('#AllPro').append(html)
                    $('#count').html(count);
                },
                error: function (err) {
                    alert('failed' + err.info);
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
            <a href="main" class="active">主页</a>
            <a href="article">文章</a>
            <a href="publishPro">提问</a>
            <a href="publishArticle">写文章</a>
            <a href="myPage" >我的</a>
        </div>




    <p class="welcome-text">
        欢迎来到<span class="name">${sessionScope.name}</span>的主页~
    </p>
</div>

<div  class="visible-lg-inline" >
    <div   style="width:300px; margin-left: auto; margin-right: auto;" >
        <input id="searchContent" type="text" placeholder="请输入要查找的关键词"  class="form-control"/>
        <button id="search1" style="height:30px; width:300px; margin-left: auto; margin-right: auto;"  onclick="search()" type="button">查询</button>
    </div>


</div>


<div class="content whisper-content">
    <div class="cont">
                    <div class="volume">
                        全部问题 <span id="count">0</span>
                    </div>
                    <div id ="AllPro" class="whisper-list">

                    </div>

    </div>
</div>
</body>
</html>
