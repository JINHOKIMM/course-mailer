<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>SJAJEJU</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/ui.js"></script>
</head>
<body>
<div id="wrap" class="wrapper">
    <div id="header" class="header">
        <div style="
            position: relative;
        ">
            <h1 class="logo">
                <a href="/main">St. Johnsbury Academy Jeju</a>
            </h1>
            <p class="sub" style="
            color: #c3c3c3;
            font-size: 11px;
            position: absolute;
            top: 43px;
            left: 57px;
        ">Created by Minseo (Hera) Kim<br>‘Site managed by Minseo (Hera) Kim</p>
        </div>
        <button class="user"><span id="userNm">Hera Kim</span><img id="userPicture" src="#" alt=""></button>
        <div class="userBox">
            <ul>
                <li><button type="button" class="logout"  onclick="location.href='${pageContext.request.contextPath}/logout'">sign out</button></li>
            </ul>
            <!--
            <ul>
                <li><button type="button" class="logout">history</button></li>
            </ul>
            -->
        </div>
    </div>
    <div id="container" class="container">


    </div>
</div>
<script>

</script>
</body>
</html>
