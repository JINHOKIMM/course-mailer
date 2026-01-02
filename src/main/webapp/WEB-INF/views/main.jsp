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
                        <button type="button" class="btn blue" onclick="updateCourse('X');">Done</button>
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
                                <th>period</th>
                            </tr>
                            </thead>
                            <tbody id="futureCourseBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="btn-wrap">
                        <button type="button" class="btn" onclick="clearFuture();">Clear</button>
                        <button type="button" class="btn blue" onclick="updateCourse('O');">Done</button>
                    </div>
                </li>
            </ul>

            <div class="btn-wrap">
                <button type="button" class="btn pt" onclick="nextPage();">Next</button>
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
                if (user.grade) {
                    const gradeText = user.grade + "th Grade";

                    $("input[name='grade']").prop("checked", false);
                    $("input[name='grade'][value='" + gradeText + "']").prop("checked", true);
                } else {
                    openGradeModal();
                }
                selectCourseList();
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

    function selectCourseList() {
        $.ajax({
            url: "/course/courseList",
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

                selectMyCourse();
            },
            error: function(xhr) {
                alert("수업 조건을 불러오지 못했습니다.");
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

            // 체크박스 ↔ select 연동
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
                    selectCourseList();
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
                alert("내 수업 정보를 불러오지 못했습니다.");
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
                alert("이후 과목은 반드시 5개를 선택해야 합니다.");
                return;
            }

            const usedPeriods = new Set();
            const courseList = [];

            for (let i = 0; i < checked.length; i++) {
                const $checkbox = $(checked[i]);
                const id = $checkbox.attr("id");
                const courseId = id.replace(prefix, "");

                const $select = $checkbox.closest("tr").find("select");
                const period = $select.val();

                // 2️⃣ period 선택 여부
                if (!period) {
                    alert("선택한 과목의 period를 모두 선택해주세요.");
                    return;
                }

                // 3️⃣ period 중복 검사
                if (usedPeriods.has(period)) {
                    alert(`period ${period} 는 이미 선택되었습니다.\nA~E는 각각 하나씩만 선택 가능합니다.`);
                    return;
                }

                usedPeriods.add(period);

                courseList.push({
                    course_id: courseId,
                    period: period,
                    status: status
                });
            }

            sendCourse(courseList, status);
            return;
        }

        // ✅ 이전 과목 (period 무시)
        if (checked.length === 0) {
            alert("선택된 과목이 없습니다.");
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
                alert("저장되었습니다.");
                selectCourseList();
            },
            error: function () {
                alert("저장 중 오류가 발생했습니다.");
            }
        });
    }



    $("#futureCourseBody").on("change", "input[type='checkbox']", function () {
        const checked = $("#futureCourseBody input[type='checkbox']:checked");

        if (checked.length > 5) {
            alert("이후 과목은 최대 5개까지만 선택할 수 있습니다.");
            this.checked = false;
        }
    });

    $("tbody").on("change", "select", function () {
        const selectedPeriods = new Set();

        $("#futureCourseBody select:enabled").each(function () {
            const val = $(this).val();
            if (!val) return;

            if (selectedPeriods.has(val)) {
                alert(`period ${val} 는 이미 선택되었습니다.`);
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
                else alert("future course를 5개 선택해주세요.");
            },
            error: function (xhr) {
                alert("내 수업 정보를 불러오지 못했습니다.");
            }
        });
    }


</script>
</body>
</html>
