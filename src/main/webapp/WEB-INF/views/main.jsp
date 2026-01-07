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
            <a href="/main">St. Johnsbury Academy Jeju</a>
        </h1>
        <button class="user"><span id="userNm">Hera Kim</span><img id="userPicture" src="#" alt=""></button>

        <div class="userBox">
            <ul>
                <li><button type="button" class="logout"  onclick="location.href='${pageContext.request.contextPath}/logout'">sign out</button></li>
                <li><button type="button" onclick="location.href='/mailHistory';" class="logout">history</button></li>
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
                        <button type="button" class="btn green" onclick="onClickDone()">Done</button>
                    </div>
                </li>

                <!-- Previously taken courses -->
                <li>
                    <p class="tit">Previously taken courses</p>
                    <div class="sch">
                        <input type="text" id="prevSearch" placeholder="Search course">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <div class="tbl-scroll">
                        <table class="course-table prev-table">
                            <thead>
                            <tr>
                                <th>Check</th>
                                <th>Course</th>
                            </tr>
                            </thead>
                            <tbody id="prevCourseBody">
                            </tbody>
                        </table>
                    </div>

                    <div class="btn-wrap">
                        <button type="button" class="btn" onclick="clearPrev();">Clear</button>
                        <button type="button" class="btn green" onclick="updateCourse('X');">Done</button>
                    </div>
                </li>
                <li>
                    <p class="tit">Subjects to be taken in the future</p>
                    <div class="sch">
                        <input type="text" id="futureSearch" placeholder="Search course">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <div class="tbl-scroll">
                        <table class="course-table future-table">
                            <thead>
                            <tr>
                                <th>Check</th>
                                <th>Course</th>
                                <th>Room</th>
                                <th>period</th>
                            </tr>
                            </thead>
                            <tbody id="futureCourseBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="btn-wrap">
                        <button type="button" class="btn" onclick="clearFuture();">Clear</button>
                        <button type="button" class="btn green" onclick="updateCourse('O');">Done</button>
                    </div>
                </li>
            </ul>

            <div class="btn-wrap">
                <button type="button" class="btn pt" onclick="nextPage();">Next</button>
            </div>
        </div>
    </div>
    <!-- //container -->
    <div class="grade-dim" style="display:none;"></div>
    <!-- popup -->
    <div class="popup grade-popup" style="display: none;">
        <p class="tit">Are you changing your class schedule<br>because of graduation credits?</p>
        <p>If you select "Yes," an email will be sent to your<br>counselor, and you'll just need to have a meeting.<br>If you select "No," you'll be redirected to the schedule<br>change website.</p>
        <div class="btn-wrap">
            <button type="button" class="btn pt" onclick="onGradeYes()">Yes</button>
            <button type="button" class="btn red" onclick="onGradeNo()">No</button>
        </div>
        <p class="sub">Created by Minseo (Hera) Kim<br>‘Site managed by Minseo (Hera) Kim</p>
    </div>

    <div class="loading-dim" style="display:none;">
        <div class="loading-box">
            <img src="/assets/img/mailSending.gif" alt="sending mail">
            <p>메일을 발송중입니다...</p>
        </div>
    </div>

</div>

<script>
    $(function () {
        loginChk();


        bindTableSearch("#prevSearch", "#prevCourseBody");
        bindTableSearch("#futureSearch", "#futureCourseBody");
    });

    function loginChk() {
        $.ajax({
            url: "/student/me",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (user) {
                console.log(user);

                $("#userNm").text(user.name);
                $("#userPicture").attr("src", user.picture || "/assets/img/user.png");

                // ✅ grade 라디오 체크 동기화
                if (user.grade === 13 && user.mail_seq) {
                    alert(
                        "An email regarding your course change due to graduation credit requirements has already been sent."
                    );
                    location.href = "/mailHistory";
                }else if (user.grade !== 13 && user.mail_seq) {
                    alert(
                        "Your course change request email has already been sent.\n" +
                        "You cannot send another request.\n\n" +
                        "Please check the mail history for details."
                    );
                    location.href = "/mailHistory";
                }else if (user.grade >= '9' && user.grade <= '12') {
                    const gradeText = user.grade + "th Grade";

                    $("input[name='grade']").prop("checked", false);
                    $("input[name='grade'][value='" + gradeText + "']").prop("checked", true);
                }
                else {
                    openGradeModal();
                }

                selectCourseList();
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    alert("Please log in to continue.");
                    location.href = "/login";
                } else {
                    alert("Failed to load List. Please try again later.");
                    location.href = "/login";
                }
            }
        });
    }

    function selectCourseList() {
        loadPrevCourseList();
        loadFutureCourseList();
    }

    function loadPrevCourseList() {
        $.ajax({
            url: "/course/courseList1",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function(res) {
                const $prev = $("#prevCourseBody");
                $prev.empty();

                res.forEach(course => {
                    $prev.append(createCourseRow(course, "prev"));
                });
            },
            error: function() {
                alert("Failed to load List. Please try again later.");
                location.href = "/login";
            }
        });
    }

    function loadFutureCourseList() {
        $.ajax({
            url: "/course/courseList2",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function(res) {
                const $future = $("#futureCourseBody");
                $future.empty();

                res.forEach(course => {
                    $future.append(createCourseRow(course, "future"));
                });

                // 기존 로직 유지
                selectMyCourse();
            },
            error: function() {
                alert("Failed to load List. Please try again later.");
                location.href = "/login";
            }
        });
    }


    function createCourseRow(course, prefix) {
        const tr = document.createElement("tr");
        const id = prefix + "_course_" + course.course_id;

        // checkbox
        const tdCheck = document.createElement("td");
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = id;

        const label = document.createElement("label");
        label.setAttribute("for", id);

        tdCheck.appendChild(checkbox);
        tdCheck.appendChild(label);

        // course name
        const tdName = document.createElement("td");
        tdName.textContent = course.course_name;

        tr.append(tdCheck, tdName);

        // ✅ 이후 과목일 때만 period 컬럼 생성
        if (prefix === "future") {

            /* ===== room 컬럼 ===== */
            const tdRoom = document.createElement("td");
            tdRoom.textContent = course.room || "-";
            tr.append(tdRoom);

            /* ===== period 컬럼 ===== */
            const tdPeriod = document.createElement("td");
            const select = document.createElement("select");

            // placeholder
            const placeholder = document.createElement("option");
            placeholder.value = "";
            placeholder.textContent = "Select period";
            placeholder.disabled = true;
            placeholder.selected = true;
            select.appendChild(placeholder);

            ["A", "B", "C", "D", "E"].forEach(v => {
                const opt = document.createElement("option");
                opt.value = v;
                opt.textContent = v;
                select.appendChild(opt);
            });

            select.disabled = true;
            tdPeriod.appendChild(select);
            tr.append(tdPeriod);

            /* ===== 데이터 보관 (핵심) ===== */
            tr.dataset.room = course.room || "";

            /* ===== checkbox ↔ period 연동 ===== */
            checkbox.addEventListener("change", function () {
                if (this.checked) {
                    select.disabled = false;
                } else {
                    select.disabled = true;
                    select.value = "";
                }
            });
        }
        return tr;
    }


    function onClickDone() {
        const selected = document.querySelector('input[name="grade"]:checked');

        if (!selected) {
            alert("Please select your grade.");
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
                    selectCourseList();
                }
            },
            error: function(xhr) {

            }
        });
    }

    function openGradeModal() {
        $('.grade-dim').fadeIn(200);     // ✅
        $('.grade-popup').fadeIn(200);   // ✅
        $('body').addClass('lock');
    }

    function closeGradeModal() {
        $('.grade-popup').fadeOut(200);
        $('.grade-dim').fadeOut(200);
        $('body').removeClass('lock');
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

    function bindTableSearch(inputSelector, tableBodySelector) {
        $(inputSelector).on("keyup", function () {
            const keyword = $(this).val().toLowerCase().trim();

            $(tableBodySelector).find("tr").each(function () {
                const courseName = $(this).find("td:nth-child(2)").text().toLowerCase();

                if (courseName.includes(keyword)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
    }

    function selectMyCourse() {
        $.ajax({
            url: "/course/myCourse",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {
                // res: 내가 저장한 과목 목록
                // [{ course_id, status, period, ... }]

                res.forEach(myCourse => {
                    const courseId = myCourse.course_id;
                    const status = myCourse.status;
                    const period = myCourse.period;

                    let $checkbox;
                    let $select;

                    if (status === 'X') {
                        $checkbox = $("#prev_course_" + courseId);
                    } else if (status === 'O') {
                        $checkbox = $("#future_course_" + courseId);
                    }

                    if (!$checkbox || $checkbox.length === 0) return;

                    // ✅ 체크
                    $checkbox.prop("checked", true);

                    // ✅ select 찾기
                    $select = $checkbox.closest("tr").find("select");

                    // ✅ select 활성화 + 값 세팅
                    if ($select.length > 0) {
                        $select.prop("disabled", false);
                        $select.val(period);
                    }
                });
            },
            error: function (xhr) {
                alert("Failed to load List. Please try again later.");
                location.href = "/login";
            }
        });
    }

    function updateCourse(status) {
        let selector;
        let prefix;

        if (status === 'X') {
            selector = "#prevCourseBody input[type='checkbox']:checked";
            prefix = "prev_course_";
        } else {
            selector = "#futureCourseBody input[type='checkbox']:checked";
            prefix = "future_course_";
        }

        const checked = $(selector);

        // ✅ 이후 과목만 검증
        if (status === 'O') {

            // 1️⃣ 정확히 5개 선택
            if (checked.length !== 5) {
                alert("You must select exactly five courses for the next semester.");
                return;
            }

            const usedPeriods = new Set();
            const courseList = [];

            for (let i = 0; i < checked.length; i++) {
                const $checkbox = $(checked[i]);
                const id = $checkbox.attr("id");
                const courseId = id.replace(prefix, "");

                const $tr = $checkbox.closest("tr");
                const courseName = $tr.find("td:nth-child(2)").text().trim();
                const room = $tr.data("room");
                const period = $tr.find("select").val();

                // 콘솔 출력 🔥
                console.log("체크박스 ID:", id);
                console.log("과목 ID:", courseId);
                console.log("과목명:", courseName);
                console.log("room:", room);
                console.log("period:", period);

                // 3️⃣ period 중복 검사
                if (usedPeriods.has(period)) {
                    alert(
                        "Period " + period + " has already been selected.\n" +
                        "Only one course can be selected for each period (A–E)."
                    );
                }


                usedPeriods.add(period);

                courseList.push({
                    course_id: courseId,
                    period: period,
                    room: room,
                    status: status
                });
            }

            sendCourse(courseList, status);
            return;
        }

        // ✅ 이전 과목 (period 무시)
        if (checked.length === 0) {
            alert("No courses have been selected.");
            return;
        }

        const courseList = [];
        checked.each(function () {
            const id = $(this).attr("id");
            const courseId = id.replace(prefix, "");

            courseList.push({
                course_id: courseId,
                status: status
            });
        });

        sendCourse(courseList, status);
    }

    function sendCourse(courseList, status) {
        const payload = {
            status: status,
            courses: courseList
        };

        $.ajax({
            url: "/course/myCourse",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
            xhrFields: {
                withCredentials: true
            },
            success: function () {
                alert("Saved successfully.");
                selectCourseList();
            },
            error: function () {
                alert("An error occurred while saving.");
            }
        });
    }



    $("#futureCourseBody").on("change", "input[type='checkbox']", function () {
        const checked = $("#futureCourseBody input[type='checkbox']:checked");

        if (checked.length > 5) {
            alert("You can select up to 5 future courses only.");
            this.checked = false;
        }
    });

    $("tbody").on("change", "select", function () {
        const selectedPeriods = new Set();

        $("#futureCourseBody select:enabled").each(function () {
            const val = $(this).val();
            if (!val) return;

            if (selectedPeriods.has(val)) {
                alert(`Period ${val} has already been selected.`);
                $(this).val("");
            } else {
                selectedPeriods.add(val);
            }
        });
    });

    // 🔹 이전 과목 Clear
    function clearPrev() {
        const $tbody = $("#prevCourseBody");

        // 체크박스 해제
        $tbody.find("input[type='checkbox']").prop("checked", false);
    }

    // 🔹 이후 과목 Clear
    function clearFuture() {
        const $tbody = $("#futureCourseBody");

        // 체크박스 해제
        $tbody.find("input[type='checkbox']").prop("checked", false);

        // select 초기화 + 비활성화
        $tbody.find("select").each(function () {
            $(this).val("");
            $(this).prop("disabled", true);
        });
    }

    function nextPage(){
        $.ajax({
            url: "/course/myCourse",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {
                let futureCnt = 0;
                res.forEach(myCourse => {
                    console.log(myCourse);
                    if(myCourse.status === 'O') futureCnt++;
                });
                if(futureCnt === 5) location.href = "/sub";
                else alert("Please select 5 future courses.");
            },
            error: function (xhr) {
                alert("Failed to load your course information.");
            }
        });
    }

    $('.grade-dim').on('click', function (e) {
        e.stopPropagation();
    });

    $(document).on("keydown", function (e) {
        if ($(".grade-popup:visible").length && e.key === "Escape") {
            e.preventDefault();
            return false;
        }
    });

    function onGradeYes() {
        $.ajax({
            url: "/mail/graduateMailSend",
            type: "POST",
            xhrFields: {
                withCredentials: true   // 로그인 세션 유지
            },
            beforeSend: function () {
                $(".loading-dim").css("display", "flex").hide().fadeIn(200);
            },
            success: function () {
                alert("The email has been sent.");
                location.href = "/mailHistory";
            },
            error: function (xhr) {
                alert("에러: " + (xhr.responseText || xhr.status));
            },
            complete: function () {
                $(".loading-dim").fadeOut(200);
            }
        });
    }

    function onGradeNo() {
        closeGradeModal();
    }

</script>
</body>
</html>
