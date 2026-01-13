<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <li><button type="button" onclick="location.href='/mailHistory';" class="logout">history</button></li>
            </ul>
        </div>
    </div>
    <!-- //header -->

    <!-- container -->
    <div id="container" class="container">
        <div class="section-head">
            <h3 class="section-title">Original Courses</h3>
            <p class="section-desc">
                Courses you planned to take next semester. This section is read-only.
            </p>
        </div>

        <div class="tblBox col planned-table">
            <table class="tbl green">
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
                    <td data-period="A"><p class="top-course-name">-</p></td>
                    <td data-period="B"><p class="top-course-name">-</p></td>
                    <td data-period="C"><p class="top-course-name">-</p></td>
                    <td data-period="D"><p class="top-course-name">-</p></td>
                    <td data-period="E"><p class="top-course-name">-</p></td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- 상단 테이블 -->
        <div class="section-head">
            <h3 class="section-title">Final Course Selection</h3>
            <p class="section-desc">
                These courses will be included in the confirmation email.
                You may change courses below.
            </p>
        </div>

        <div class="tblBox col final-table">
            <table class="tbl green">
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
                            <col style="width:40%">
                            <col style="width:15%">
                            <col style="width:15%">
                            <col style="width:15%">
                            <col style="width:15%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>Course name</th>
                            <th>Room</th>
                            <th>Seats</th>
                            <th>period</th>
                            <th>Swap</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </c:forEach>
        </div>

        <div class="btn-wrap">
            <button type="button" class="btn pt" onclick="openPopup()">Send</button>
        </div>

    </div>
    <!-- //container -->
    <div class="popup-overlay" style="display:none;"></div>

    <!-- 팝업 -->
    <div class="dim"></div>
    <div class="popup" id="mailPopup" style="display:none;">
        <div class="send">

            <!-- X 닫기 버튼 -->
            <button type="button" class="popup-close" onclick="closePopup()">×</button>

            <p class="tit" id="title">Course Change Report</p>
            <p class="sub" id="receiver_email">hs_admin@sjajeju.kr</p>

            <div class="txtBox">
                <textarea id="content" placeholder="메일 내용을 입력하세요"></textarea>
            </div>

            <div class="btn-wrap">
                <button type="button" class="btn pt" id="sendMailBtn" onclick="sendMail();">Send</button>
            </div>
        </div>
    </div>

    <div class="loading-dim" style="display:none;">
        <div class="loading-box">
            <img src="/assets/img/mailSending.gif" alt="sending mail">
            <p>메일을 발송중입니다...</p>
        </div>
    </div>
</div>
<script>
    let userNm ='';
    let userEmail ='';
    let userGrade ='';

    $(function () {
        loginChk();
    });

    function loginChk() {
        $.ajax({
            url: "/student/me",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (user) {
                userNm = user.name;
                userEmail = user.google_email;
                userGrade = user.grade;
                $("#userNm").text(user.name);
                $("#userPicture").attr("src", user.picture || "/assets/img/user.png");

                selectMyCourse();
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

    function selectMyCourse() {
        $.ajax({
            url: "/course/myFutureCourse",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function (res) {

                const planned = res.planned; // O
                const finalList = res.final; // Y 우선 + O fallback

                /* =========================
                   초기화
                ========================= */
                $(".planned-table .top-course-name").text("-");
                $(".final-table .top-course-name").text("-");
                $(".final-table td").removeClass("locked");

                $(".final-table .drop-btn")
                    .prop("disabled", false)
                    .removeClass("lock active")
                    .text("Drop");

                /* =========================
                   🔹 Planned table (O 고정)
                ========================= */
                planned.forEach(item => {
                    $(".planned-table td[data-period='" + item.period + "']")
                        .find(".top-course-name")
                        .text(item.course_name);
                });

                /* =========================
                   🔹 Final table (Y 우선)
                ========================= */
                finalList.forEach(item => {
                    const period = item.period;
                    const courseName = item.course_name;
                    const lockYn = item.lock_yn;

                    const $cell = $(".final-table td[data-period='" + period + "']");
                    const $btn  = $cell.find(".drop-btn");

                    $cell.find(".top-course-name").text(courseName);

                    if (lockYn === "Y") {
                        $btn
                            .prop("disabled", true)
                            .addClass("lock")
                            .text("Locked");
                        $cell.addClass("locked");
                    }
                });
            },
            error: function () {
                alert("내 수업 정보를 불러오지 못했습니다.");
            }
        });
    }

    function onDropClick(period) {
        $.ajax({
            url: "/course/availableCourseList",
            type: "GET",
            data: {period:period},
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {

                var $bottom = $(".bottom-list[data-period='" + period + "']");
                var $tbody = $bottom.find("tbody");

                // 초기화
                $tbody.empty();

                // 데이터 없음
                if (!res || res.length === 0) {
                    var emptyRow = ""
                        + "<tr>"
                        + "<td colspan='5' style='text-align:center;'>Available course 없음</td>"
                        + "</tr>";
                    $tbody.append(emptyRow);
                    return;
                }

                // 리스트 렌더링
                res.forEach(function (item) {

                    var seatsText = item.student_count + " / " + item.max_seats;
                    var isFull = item.student_count >= item.max_seats;

                    var btnClass = isFull
                        ? "btn red swap-btn disabled"
                        : "btn green swap-btn";

                    var btnText = isFull ? "Full" : "Swap";
                    var disabledAttr = isFull ? " disabled" : "";

                    var row = ""
                        + "<tr class='" + (isFull ? "row-full" : "") + "'>"
                        + "  <td class='tL'>" + item.course_name + "</td>"
                        + "  <td class='sub'>" + (item.room || "-") + "</td>"
                        + "  <td class='sub'>" + seatsText + "</td>"
                        + "  <td class='sub'>" + item.period + "</td>"
                        + "  <td>"
                        + "    <button type='button' class='" + btnClass + "'"
                        + disabledAttr
                        + "            data-course-code='" + item.course_code + "'"
                        + "            data-period='" + period + "'"
                        + "            data-room='" + (item.room || "") + "'>"
                        + btnText
                        + "    </button>"
                        + "  </td>"
                        + "</tr>";

                    $tbody.append(row);
                });
            },
            error: function () {
                alert("내 수업 정보를 불러오지 못했습니다.");
            }
        });

        // 하단 리스트 열기
        $(".bottom-list").hide();
        $(".bottom-list[data-period='" + period + "']").fadeIn(300);

        // active 처리
        $(".final-table .drop-btn").removeClass("active");
        $(".drop-btn[data-period='" + period + "']").addClass("active");
    }


    function openPopup() {
        $.ajax({
            url: "/course/myFutureCourse",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function (res) {

                const planned = res.planned; // O
                const finalList = res.final; // Y 우선 + O fallback

                // period → 과목명 매핑
                const before = { A:'-', B:'-', C:'-', D:'-', E:'-' };
                const after  = { A:'-', B:'-', C:'-', D:'-', E:'-' };

                planned.forEach(function(item){
                    before[item.period] = item.course_name
                    if(item.room) before[item.period] += "("+item.room+")";
                });

                finalList.forEach(function(item){
                    after[item.period] = item.course_name;
                    if(item.room) after[item.period] += " ("+item.room+")";
                });

                var mailContent =
                    "This is to report that the following student has requested a course change at SJA Jeju.\n\n" +

                    "Student Name: [" + userNm + "]\n" +
                    "Student Email: [" + userEmail + "]\n" +
                    "Grade: [" + userGrade + "]\n\n" +

                    "Original Course: [" +
                    before.A + " A ], [" +
                    before.B + " B ], [" +
                    before.C + " C ], [" +
                    before.D + " D ], [" +
                    before.E + " E ]\n\n" +

                    "Revised Course: [" +
                    after.A + " A ], [" +
                    after.B + " B ], [" +
                    after.C + " C ], [" +
                    after.D + " D ], [" +
                    after.E + " E ]\n\n" +

                    "Please review and advise on the next steps.\n\n" +

                    "Sincerely,\n" +
                    "Hera Kim\n" +
                    "SJA Jeju";

                $("#content").val(mailContent);
            },
            error: function () {
                alert("The email has been sent.");
            }
        });

        $('.dim').fadeIn(200);
        $('.popup').fadeIn(200);
        $('body').addClass('lock');
    }


    function sendMailConfirm() {
        const content = $('#content').val();
    }

    $(".final-table").on("click", ".drop-btn", function () {
        var $cell = $(this).closest("td");

        if ($cell.hasClass("locked")) {
            return;
        }

        var period = $(this).data("period");
        highlightPeriod(period);
        onDropClick(period);
    });

    function highlightPeriod(period) {
        $(".final-table td[data-period]")
            .removeClass("period-active period-dim");
        $(".drop-btn").removeClass("active");

        // 선택된 period
        var $activeCell = $("td[data-period='" + period + "']");
        $activeCell.addClass("period-active");
        $activeCell.find(".drop-btn").addClass("active");

        // 나머지 period 흐리게
        $("td[data-period]").not($activeCell).addClass("period-dim");
    }

    $(document).on("click", ".swap-btn:not(.disabled)", function () {
        if(!confirm("Is this your representative?")){return;}

        var courseName = $(this)
            .closest("tr")
            .find("td:first")
            .text()
            .trim();

        var courseCode = $(this).data("course-code");
        var newPeriod  = $(this).data("period");
        var room       = $(this).data("room");

        // 현재 선택 중인 period (Drop으로 선택한)
        var oldPeriod = $(".drop-btn.active").data("period");


        var $topCell = $(".final-table td[data-period='" + oldPeriod + "']");
        var $row = $(this).closest("tr");

        // 🔥 스왑 애니메이션
        animateSwap($topCell, $row, function () {
            $.ajax({
                url: "/course/swap",
                type: "PUT",
                xhrFields: {
                    withCredentials: true   // 로그인 세션 유지
                },
                data: {
                    period: oldPeriod,
                    course_id: courseCode,
                    room: room
                },
                success: function (result) {
                    if (result.res !== '000') {
                        alert(result.msg);
                        return;
                    }

                    const text =
                        courseName +
                        (room ? " (" + room + ")" : "");

                    const $cell = $(".final-table td[data-period='" + oldPeriod + "']");
                    $cell.find(".top-course-name").text(text);

                    // UI 정리
                    $(".bottom-list").fadeOut(150);
                    $(".final-table td").removeClass("period-active period-dim");
                    $(".drop-btn").removeClass("active");

                    $cell.addClass("updated");
                    setTimeout(() => $cell.removeClass("updated"), 800);
                }
            });
        });
    });

    function animateSwap($topCell, $bottomRow, callback) {

        $topCell.addClass("swap-out");
        $bottomRow.addClass("swap-in");

        setTimeout(function () {
            $topCell.removeClass("swap-out");
            $bottomRow.removeClass("swap-in");

            if (callback) {
                callback();
            }
        }, 400);
    }

    function closePopup() {
        $('.popup').fadeOut(200);
        $('.dim').fadeOut(200);
        $('body').removeClass('lock');
    }

    function sendMail(){
        if (!confirm("Would you like to send the email?")) {
            return;
        }

        let content = $('#content').val();


        $.ajax({
            url: "/mail/send",
            type: "POST",
            xhrFields: {
                withCredentials: true   // 로그인 세션 유지
            },
            data: {
                content:content
            },
            beforeSend: function () {
                $("#sendMailBtn").prop("disabled", true);
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
                $("#sendMailBtn").prop("disabled", false);
                $(".loading-dim").fadeOut(200);
            }
        });


    }

</script>
</body>
</html>
