<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="com.spj.entity.*"%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <title>登录</title>
    <script type="text/javascript">
        function zhuce() {
            window.location.href = "ToRegister";
        }
    </script>
</head>
<body>
<div class="container ">
    <form class="form-horizontal" role="form" action="login.do" method="POST">
        <div class=" form-group ">
            <label for="firstname" class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-3 ">
                <input type="text" class="form-control" name="name" id="firstname" placeholder="请输入名字" value="${user.name}">
            </div>
        </div>
        <div class="form-group ">
            <label for="lastname" class="col-sm-2 control-label">密码</label>
            <div class="col-sm-3 ">
                <input type="password" class="form-control " name="pass" id="lastname" placeholder="请输入密码" value="${user.pass}">
            </div>
        </div>
        <div class="form-group pull-center">
            <div class=" col-sm-3">
                <button type="submit" class="btn btn-primary btn-lg btn-block">登录</button>
                <button type="button" onclick="zhuce()" class="btn btn-primary btn-lg btn-block">注册</button>
            </div>
            <p>${error}</p>
        </div>
    </form>

</div>
</body>
</html>
