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
        <h1 class="logo">
            <a href="/main">St. Johnsbury Academy Jeju</a>
        </h1>
        <button class="user"><span id="userNm">Hera Kim</span><img id="userPicture" src="#" alt=""></button>

        <div class="userBox">
            <ul>
                <li><button type="button" class="logout">sign out</button></li>
            </ul>
            <ul>
                <li><button type="button" class="logout">history/button></li>
            </ul>
        </div>
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
            <button type="button" class="btn pt" onclick="openPopup()">Send</button>
        </div>

    </div>
    <!-- //container -->
    <<div class="popup-overlay" style="display:none;"></div>

    <!-- 팝업 -->
    <div class="dim"></div>
    <div class="popup" style="display:none;">
        <div class="send">

            <!-- X 닫기 버튼 -->
            <button type="button" class="popup-close" onclick="closePopup()">×</button>

            <p class="tit" id="title">[SJA]과목변경</p>
            <p class="sub" id="receiver_email">kjh55514@naver.com</p>

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
                console.log(user);

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
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {

                // 초기화
                $(".top-course-name").text("-");
                $(".drop-btn")
                    .prop("disabled", false)
                    .removeClass("lock")
                    .text("Drop");

                $(".bottom-list tr").removeClass("locked");

                res.forEach(function (item) {
                    const period = item.period;          // A/B/C/D/E
                    const courseName = item.course_name;
                    const lockYn = item.lock_yn;

                    const $cell = $("td[data-period='" + period + "']");
                    const $btn = $cell.find(".drop-btn");

                    // 상단 과목명
                    $cell.find(".top-course-name").text(courseName);

                    // 🔒 잠금 처리
                    if (lockYn === "Y") {
                        // 상단 버튼 잠금
                        $btn
                            .prop("disabled", true)
                            .addClass("lock")
                            .text("Locked");

                        // ✅ td 배경 회색 처리
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
                        ? "btn gray swap-btn disabled"
                        : "btn blue swap-btn";

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
                        + "            data-period='" + period + "'>"
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
        $(".drop-btn").removeClass("active");
        $(".drop-btn[data-period='" + period + "']").addClass("active");
    }


    function openPopup() {
        $('.dim').fadeIn(200);
        $('.popup').fadeIn(200);
        $('body').addClass('lock');
    }

    function sendMailConfirm() {
        const content = $('#content').val();
        console.log(content);
    }

    $(".drop-btn").on("click", function () {
        var $cell = $(this).closest("td");

        if ($cell.hasClass("locked")) {
            return;
        }

        var period = $(this).data("period");
        highlightPeriod(period);
        onDropClick(period);
    });

    function highlightPeriod(period) {
        $("td[data-period]").removeClass("period-active period-dim");
        $(".drop-btn").removeClass("active");

        // 선택된 period
        var $activeCell = $("td[data-period='" + period + "']");
        $activeCell.addClass("period-active");
        $activeCell.find(".drop-btn").addClass("active");

        // 나머지 period 흐리게
        $("td[data-period]").not($activeCell).addClass("period-dim");
    }

    $(document).on("click", ".swap-btn:not(.disabled)", function () {
        if(!confirm("정말 바꾸시겠습니까?")){return;}
        var courseCode = $(this).data("course-code");
        var newPeriod  = $(this).data("period");
        var room       = $(this).data("room");

        // 현재 선택 중인 period (Drop으로 선택한)
        var oldPeriod = $(".drop-btn.active").data("period");

        console.log("기존 period:", oldPeriod);
        console.log("새 period:", newPeriod);
        console.log("새 course_code:", courseCode);
        console.log("room:", room);

        var $topCell = $("td[data-period='" + oldPeriod + "']");
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
                    if(result.res === '010'){
                        alert(result.msg);
                        location.reload();
                    }else{
                        setTimeout(function () {
                            location.reload();
                            //onDropClick(oldPeriod);
                        }, 400);
                    }
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
        if(!confirm("메일을 발송 하시겠습니까?")){
            return;
        }

        let title = $('#title').text();
        let receiver_email = $('#receiver_email').text();
        let content = $('#content').val();

        console.log("content === "+ content);

        $.ajax({
            url: "/mail/send",
            type: "POST",
            xhrFields: {
                withCredentials: true   // 로그인 세션 유지
            },
            data: {
                content:content,
                receiver_email:receiver_email
            },
            beforeSend: function () {
                $("#sendMailBtn").prop("disabled", true);
                $(".loading-dim").css("display", "flex").hide().fadeIn(200);
            },
            success: function () {
                alert("메일을 전송했습니다.");
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
