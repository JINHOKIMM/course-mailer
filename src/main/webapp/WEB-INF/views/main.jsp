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
        <button class="user-btn">
            <span id="userNm"></span>
            <img id="userPicture" src="${pageContext.request.contextPath}/assets/img/user.png" alt="">
        </button>
    </div>
    <!-- //header -->

    <!-- container -->
    <div id="container" class="container">
        <div class="list">
            <ul>
                <li>
                    <p class="tit">Grade</p>


                    <ul class="item">
                        <li>
                            <input type="radio" id="rdo01" name="grade" value="9th Grade" checked>
                            <label for="rdo01">9th Grade</label>
                        </li>
                        <li>
                            <input type="radio" id="rdo02" name="grade" value="10th Grade">
                            <label for="rdo02">10th Grade</label>
                        </li>
                        <li>
                            <input type="radio" id="rdo03" name="grade" value="11th Grade">
                            <label for="rdo03">11th Grade</label>
                        </li>
                        <li>
                            <input type="radio" id="rdo04" name="grade" value="12th Grade">
                            <label for="rdo04">12th Grade</label>
                        </li>
                    </ul>

                    <div class="btn-wrap">
                        <button type="button" class="btn">Clear</button>
                        <button type="button" class="btn blue">Done</button>
                    </div>
                </li>

                <!-- Previously taken courses -->
                <li>
                    <p class="tit">Previously taken courses</p>
                    <div class="sch">
                        <input type="text">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <ul class="item">
                        <li><input type="checkbox" id="chk01-01"><label for="chk01-01">English 9</label></li>
                        <li><input type="checkbox" id="chk01-02"><label for="chk01-02">English 10</label></li>
                        <li><input type="checkbox" id="chk01-03" disabled><label for="chk01-03">AP Seminar</label></li>
                        <li><input type="checkbox" id="chk01-04"><label for="chk01-04">AP Research</label></li>
                        <li><input type="checkbox" id="chk01-05"><label for="chk01-05">AP English Language and Composition</label></li>
                        <li><input type="checkbox" id="chk01-06"><label for="chk01-06">AP English Literature and Composition</label></li>
                        <li><input type="checkbox" id="chk01-07"><label for="chk01-07">Algebra I</label></li>
                        <li><input type="checkbox" id="chk01-08"><label for="chk01-08">Geometry</label></li>
                        <li><input type="checkbox" id="chk01-09"><label for="chk01-09">Algebra II</label></li>
                        <li><input type="checkbox" id="chk01-10"><label for="chk01-10">Pre-Calculus A</label></li>
                        <li><input type="checkbox" id="chk01-11"><label for="chk01-11">Pre-Calculus B</label></li>
                    </ul>

                    <div class="btn-wrap">
                        <button type="button" class="btn">Clear</button>
                        <button type="button" class="btn blue">Done</button>
                    </div>
                </li>
                <li>
                    <p class="tit">Subjects to be taken in the future</p>
                    <div class="sch">
                        <input type="text">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <ul class="item">
                        <li><input type="checkbox" id="chk02-01"><label for="chk02-01">English 9</label></li>
                        <li><input type="checkbox" id="chk02-02"><label for="chk02-02">English 10</label></li>
                        <li><input type="checkbox" id="chk02-03"><label for="chk02-03">AP Seminar</label></li>
                        <li><input type="checkbox" id="chk02-04"><label for="chk02-04">AP Research</label></li>
                        <li><input type="checkbox" id="chk02-05"><label for="chk02-05">AP English Language and Composition</label></li>
                        <li><input type="checkbox" id="chk02-06"><label for="chk02-06">AP English Literature and Composition</label></li>
                        <li><input type="checkbox" id="chk02-07"><label for="chk02-07">Algebra I</label></li>
                        <li><input type="checkbox" id="chk02-08"><label for="chk02-08">Geometry</label></li>
                        <li><input type="checkbox" id="chk02-09"><label for="chk02-09">Algebra II</label></li>
                        <li><input type="checkbox" id="chk02-10"><label for="chk02-10">Pre-Calculus A</label></li>
                        <li><input type="checkbox" id="chk02-11"><label for="chk02-11">Pre-Calculus B</label></li>
                    </ul>

                    <div class="btn-wrap">
                        <button type="button" class="btn">Clear</button>
                        <button type="button" class="btn blue">Done</button>
                    </div>
                </li>
            </ul>

            <div class="btn-wrap">
                <button type="button" class="btn pt">Next</button>
            </div>
        </div>
    </div>
    <!-- //container -->

    <!-- popup -->
    <div class="popup-wrap" style="display:none;">
        <div class="popup">
            <h2 class="popup-title">
                Are you changing your class schedule<br>
                because of graduation credits?
            </h2>

            <p class="popup-desc">
                If you select "Yes," an email will be sent to your counselor.<br>
                If you select "No," you'll be redirected to the schedule change website.
            </p>

            <div class="popup-btns">
                <button type="button" class="btn yes" onclick="updateGrade('13');">Yes</button>
                <button type="button" class="btn no" onclick="closeGradeModal();">No</button>
            </div>

            <p class="popup-footer">
                Created by Minseo (Hera) Kim<br>
                Site managed by Minseo (Hera) Kim
            </p>
        </div>
    </div>

</div>
<script>
    $(function () {
        loginChk();
    });

    function loginChk(){
        $.ajax({
            url: "/student/me",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function(user) {
                console.log(user);

                $("#userNm").text(user.name);
                $("#userPicture").attr("src", user.picture || "/assets/img/user.png");

                if (!user.grade) {
                    openGradeModal();
                    return;
                }

                getCourseData();
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    alert("로그인 후 이용해주세요.");
                    location.href = "/login";
                } else {
                    alert("사용자 정보를 불러오지 못했습니다.");
                }
            }
        });
    }

    function getCourseData(){
       /*
        $.ajax({
            url: "/course",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function(data) {
                console.log(data);

            },
            error: function(xhr) {

            }
        });
        */
    }

    function updateGrade(grade){
        $.ajax({
            url: "/student/userInfo",
            type: "PUT",
            data: {grade:grade},
            xhrFields: {
                withCredentials: true
            },
            success: function(res) {
                if (res.success) {
                    closeGradeModal();
                }
            },
            error: function(xhr) {

            }
        });
    }

    function openGradeModal() {
        $(".popup-wrap").fadeIn(200);
    }

    function closeGradeModal() {
        $(".popup-wrap").fadeOut(200);
    }

</script>
</body>
</html>
