<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/ui.js"></script>
</head>

<body>
<div id="wrap" class="wrapper">

    <!-- header -->
    <div id="header" class="header">
        <h1 class="logo">
            <a href="#">St. Johnsbury Academy Jeju</a>
        </h1>
        <button>
            <span>${loginUserName}</span>
            <img src="${pageContext.request.contextPath}/img/user.png" alt="">
        </button>
    </div>
    <!-- //header -->

    <!-- container -->
    <div id="container" class="container">

        <!-- 상단 테이블 -->
        <div class="tblBox col">
            <table class="tbl blue">
                <colgroup>
                    <col style="width:20%">
                    <col style="width:20%">
                    <col style="width:20%">
                    <col style="width:20%">
                    <col style="width:20%">
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
                    <td data-period="A">
                        <p class="top-course-name">-</p>
                        <div class="btn-wrap">
                            <button type="button" class="btn accordion drop-btn" data-period="A">Drop</button>
                        </div>
                    </td>
                    <td data-period="B">
                        <p class="top-course-name">-</p>
                        <div class="btn-wrap">
                            <button type="button" class="btn accordion drop-btn" data-period="B">Drop</button>
                        </div>
                    </td>
                    <td data-period="C">
                        <p class="top-course-name">-</p>
                        <div class="btn-wrap">
                            <button type="button" class="btn accordion drop-btn" data-period="C">Drop</button>
                        </div>
                    </td>
                    <td data-period="D">
                        <p class="top-course-name">-</p>
                        <div class="btn-wrap">
                            <button type="button" class="btn accordion drop-btn" data-period="D">Drop</button>
                        </div>
                    </td>
                    <td data-period="E">
                        <p class="top-course-name">-</p>
                        <div class="btn-wrap">
                            <button type="button" class="btn accordion drop-btn" data-period="E">Drop</button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 하단 리스트 -->
        <div class="tabCont">
            <c:forEach var="i" begin="0" end="4">
                <!-- 🔽 하단 리스트 하나 -->
                <div class="tblBox col bottom-list"
                     data-period="${'ABCDE'.charAt(i)}"
                     style="display:none;">
                    <table class="tbl">
                        <colgroup>
                            <col style="width:60%">
                            <col style="width:20%">
                            <col style="width:20%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>Course name</th>
                            <th>Date</th>
                            <th>Swap</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="j" begin="1" end="6">
                            <tr>
                                <td class="tL">Course ${i}-${j}</td>
                                <td class="sub">2025.06.11</td>
                                <td>
                                    <button type="button" class="btn blue swap-btn">
                                        Swap
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>

        </div>

        <div class="btn-wrap">
            <button type="button" class="btn pt" onclick="sendMail()">Next</button>
        </div>

    </div>
    <!-- //container -->

</div>
<script>
    $(function () {
        selectMyCourse();
    });

    function selectMyCourse() {
        $.ajax({
            url: "/course/myFutureCourse",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {

                // 초기화
                $(".top-course-name").text("-");

                // period 기준으로 상단 채우기
                res.forEach(function (item) {
                    console.log(item);
                    const period = item.period;          // A/B/C/D/E
                    const courseName = item.course_name;

                    $("td[data-period='" + period + "']")
                        .find(".top-course-name")
                        .text(courseName);
                });
            },
            error: function () {
                alert("내 수업 정보를 불러오지 못했습니다.");
            }
        });
    }

    /*
    function sendMail() {
        $.ajax({
            url: "/mail/send",
            type: "POST",
            xhrFields: {
                withCredentials: true   // 로그인 세션 유지
            },
            success: function (res) {
                if (res.success) {
                    alert("메일이 전송되었습니다.");
                    // 필요하면 다음 단계 이동
                    // location.href = "/nextStep";
                }
            },
            error: function (xhr) {
                alert("메일 전송 중 오류가 발생했습니다.");
            }
        });
    }
    */

    $(".drop-btn").on("click", function () {
        const period = $(this).data("period");

        // 모든 하단 리스트 숨김
        $(".bottom-list").hide();

        // 해당 period 리스트만 표시
        $(".bottom-list[data-period='" + period + "']").fadeIn(300);

        // 버튼 active 처리
        $(".drop-btn").removeClass("active");
        $(this).addClass("active");
    });
</script>
</body>
</html>
