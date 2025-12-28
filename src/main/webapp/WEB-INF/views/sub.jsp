<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>ODA</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <!-- JS -->
    <script defer src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="${pageContext.request.contextPath}/assets/js/ui.js"></script>
</head>

<body>
<div id="wrap" class="wrapper">

    <!-- header -->
    <div id="header" class="header">
        <h1 class="logo">
            <a href="#">St. Johnsbury Academy Jeju</a>
        </h1>
        <button>
            <span>Hera Kim</span>
            <img src="${pageContext.request.contextPath}/assets/img/user.png" alt="">
        </button>
    </div>
    <!-- //header -->

    <!-- container -->
    <div id="container" class="container">

        <!-- 상단 테이블 -->
        <div class="tblBox col">
            <table class="tbl blue">
                <caption></caption>
                <colgroup>
                    <col style="width:20%;">
                    <col style="width:20%;">
                    <col style="width:20%;">
                    <col style="width:20%;">
                    <col style="width:20%;">
                </colgroup>
                <thead>
                <tr>
                    <th>A</th>
                    <th>B</th>
                    <th>C</th>
                    <th>D</th>
                    <th>E</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <c:forEach begin="1" end="5">
                        <td>
                            <p>Course name Course name</p>
                            <button type="button" class="btn accordion"></button>
                        </td>
                    </c:forEach>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 하단 테이블 -->
        <div class="tblBox col">
            <table class="tbl">
                <caption></caption>
                <colgroup>
                    <col style="width:60%;">
                    <col style="width:20%;">
                    <col style="width:20%;">
                </colgroup>
                <thead>
                <tr>
                    <th>Course name</th>
                    <th>Date</th>
                    <th>Swap</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach begin="1" end="6">
                    <tr>
                        <td>Course name Course name</td>
                        <td class="sub">2025.06.11</td>
                        <td>
                            <button type="button" class="btn">Swap</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="btn-wrap">
            <button type="button" class="btn pt">Next</button>
        </div>

    </div>
    <!-- //container -->

</div>
</body>
</html>
