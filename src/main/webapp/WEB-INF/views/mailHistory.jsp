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
        <h1 class="logo">
            <a href="/main">St. Johnsbury Academy Jeju</a>
        </h1>
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
        <div class="list">
            <ul>
                <li>
                    <div class="tit">Mail Send History</div>

                    <div class="tblBox col">
                        <table class="tbl green" id="mailHistoryTable">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Title</th>
                                <th>Sender</th>
                                <th>Sent At</th>
                                <th>View</th>
                            </tr>
                            </thead>
                            <tbody id="mailHistoryBody">
                            <!-- JS 렌더링 -->
                            </tbody>
                        </table>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="dim"></div>
    <div class="popup" id="mailPopup" style="display:none;">
        <div class="send">
            <button type="button" class="popup-close" onclick="closePopup()">×</button>

            <p class="tit" id="popupTitle"></p>
            <p class="sub" id="popupSender"></p>

            <div class="txtBox">
                <textarea id="popupContent" readonly></textarea>
            </div>

            <div class="btn-wrap">
                <button type="button" class="btn red" onclick="closePopup()">Close</button>
            </div>
        </div>
    </div>
</div>
<<script>
    $(function () {
        loginChk();
        loadMailHistory();
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
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    alert("Please log in to continue.");

                    location.href = "/login";
                } else {
                    alert("Failed to load user information.");
                }
            }
        });
    }

    function loadMailHistory() {
        $.ajax({
            url: "/mail/history",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function (list) {
                var $tbody = $("#mailHistoryBody");
                $tbody.empty();

                if (!list || list.length === 0) {
                    $tbody.append(
                        "<tr><td colspan='5'>No mail history.</td></tr>"
                    );
                    return;
                }

                for (var i = 0; i < list.length; i++) {
                    var mail = list[i];

                    $tbody.append(
                        "<tr>"
                        + "<td>" + (i + 1) + "</td>"
                        + "<td>" + escapeHtml(mail.title) + "</td>"
                        + "<td>" + escapeHtml(mail.google_email) + "</td>"
                        + "<td>" + formatDate(mail.sent_at) + "</td>"
                        + "<td>"
                        + "<button class='btn green view-btn'"
                        + " data-title=\"" + escapeAttr(mail.title) + "\""
                        + " data-receiver=\"" + escapeAttr(mail.receiver_email) + "\""
                        + " data-content=\"" + escapeAttr(mail.content) + "\">View</button>"
                        + "</td>"
                        + "</tr>"
                    );
                }
            }
        });
    }

    // 버튼 클릭 (이벤트 위임)
    $(document).on("click", ".view-btn", function () {
        openMailPopup(
            $(this).data("title"),
            $(this).data("receiver"),
            $(this).data("content")
        );
    });

    function openMailPopup(title, receiver, content) {
        $("#popupTitle").text(title);
        $("#popupSender").text(receiver);
        $("#popupContent").val(content);

        $(".dim").fadeIn(200);
        $(".popup").fadeIn(200);
        $("body").addClass("lock");
    }

    function closePopup() {
        $(".popup").fadeOut(200);
        $(".dim").fadeOut(200);
        $("body").removeClass("lock");
    }

    // --- 유틸 ---
    function escapeHtml(str) {
        if (!str) return "";
        return str.replace(/[&<>"']/g, function (m) {
            return {
                "&": "&amp;",
                "<": "&lt;",
                ">": "&gt;",
                "\"": "&quot;",
                "'": "&#39;"
            }[m];
        });
    }

    function escapeAttr(str) {
        if (!str) return "";
        return str
            .replace(/"/g, "&quot;")
            .replace(/\r/g, "");
    }

    function formatDate(dateStr) {
        if (!dateStr) return "";
        return dateStr.replace("T", " ").substring(0, 16);
    }
</script>
</body>
</html>
