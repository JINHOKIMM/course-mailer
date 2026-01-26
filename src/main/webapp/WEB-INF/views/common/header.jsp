<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-- header -->
<div id="header" class="header">
    <div style="
            position: relative;
        ">
        <h1 class="logo">
            <a href="/main">St. Johnsbury Academy Jeju</a>
        </h1>
    </div>

    <button class="user"><span id="userNm">Hera Kim</span><img id="userPicture" src="#" alt="" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/user.png';"></button>

    <div class="userBox">
        <ul>
            <li><button type="button" onclick="location.href='/mailHistory';" class="mail">history</button></li>
            <li id="adminMenu" style="display:none;"><button type="button" onclick="location.href='/admin';" class="admin">admin mode</button></li>
            <li><button type="button" class="logout"  onclick="location.href='${pageContext.request.contextPath}/logout'">sign out</button></li>
        </ul>
    </div>
</div>
<!-- //header -->