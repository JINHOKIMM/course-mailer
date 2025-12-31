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
        <button class="user"><span id="userNm">Hera Kim</span><img id="userPicture" src="#" alt=""></button>

        <div class="userBox">
            <ul>
                <li><button type="button" class="logout">sign out</button></li>
            </ul>
        </div>
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
                        <button type="button" class="btn blue" onclick="onClickDone()">Done</button>
                    </div>
                </li>

                <!-- Previously taken courses -->
                <li>
                    <p class="tit">Previously taken courses</p>
                    <div class="sch">
                        <input type="text">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <div class="tbl-scroll">
                        <table class="course-table">
                            <thead>
                            <tr>
                                <th>Check</th>
                                <th>Course</th>
                                <th>Condition</th>
                                <th>Grade</th>
                            </tr>
                            </thead>
                            <tbody id="prevCourseBody">
                            </tbody>
                        </table>
                    </div>

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
                    <div class="tbl-scroll">
                        <table class="course-table">
                            <thead>
                            <tr>
                                <th>Check</th>
                                <th>Course</th>
                                <th>Condition</th>
                                <th>Grade</th>
                            </tr>
                            </thead>
                            <tbody id="futureCourseBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="btn-wrap">
                        <button type="button" class="btn">Clear</button>
                        <button type="button" class="btn blue">Done</button>
                    </div>
                </li>
            </ul>

            <div class="btn-wrap">
                <button type="button" class="btn pt" onclick="location.href='/sub'">Next</button>
            </div>
        </div>
    </div>
    <!-- //container -->

    <!-- popup -->
    <div class="popup" style="display: none;">
        <p class="tit">Are you changing your class schedule<br>because of graduation credits?</p>
        <p>If you select "Yes," an email will be sent to your<br>counselor, and you'll just need to have a meeting.<br>If you select "No," you'll be redirected to the schedule<br>change website.</p>
        <div class="btn-wrap">
            <button type="button" class="btn pt">Yes</button>
            <button type="button" class="btn gray">No</button>
        </div>
        <p class="sub">Created by Minseo (Hera) Kim<br>‘Site managed by Minseo (Hera) Kim</p>
    </div>

</div>
<div class="dim"></div>
<script>
    $(function () {
        loginChk();
        selectCourseCondList();
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

    function selectCourseCondList(){
        $.ajax({
            url: "/course/courseCond",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function(res) {
                const $prev = $("#prevCourseBody");
                const $future = $("#futureCourseBody");

                $prev.empty();
                $future.empty();

                res.forEach(course => {
                    $prev.append(createCourseRow(course, "prev"));
                    $future.append(createCourseRow(course, "future"));
                });
            },
            error: function(xhr) {
                alert("수업 조건을 불러오지 못했습니다.");
            }
        });
    }


    function createCourseRow(course, prefix) {
        const tr = document.createElement("tr");
        const id = prefix + "_course_" + course.condition_id;

        // checkbox
        const tdCheck = document.createElement("td");
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = id;

        const label = document.createElement("label");
        label.setAttribute("for", id);
        label.textContent = ""; // label 필수 (CSS용)

        tdCheck.appendChild(checkbox);
        tdCheck.appendChild(label);

        // course
        const tdName = document.createElement("td");
        tdName.textContent = course.course_name;

        // condition
        const tdCond = document.createElement("td");
        tdCond.textContent = course.condition_desc || "N/A";

        // grade
        const tdGrade = document.createElement("td");
        const select = document.createElement("select");

        ["A","B","C","D","E"].forEach(v => {
            const opt = document.createElement("option");
            opt.textContent = v;
            select.appendChild(opt);
        });

        tdGrade.appendChild(select);

        tr.append(tdCheck, tdName, tdCond, tdGrade);
        return tr;
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

    function onClickDone() {
        const selected = document.querySelector('input[name="grade"]:checked');

        if (!selected) {
            alert("학년을 선택하세요.");
            return;
        }

        // 숫자만 추출
        const gradeNum = selected.value.match(/\d+/)[0];

        console.log('gradeNum ===', gradeNum); // 9, 10, 11, 12

        updateGrade(gradeNum);
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

    function escapeHtml(str) {
        if (!str) return '';
        return str
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#39;");
    }



</script>
</body>
</html>
