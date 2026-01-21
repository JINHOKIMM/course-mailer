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
<style>
    input[readonly] {
        background-color: #f5f5f5;
        border-color: #ddd;
        cursor: not-allowed;
    }
</style>
<body>
<div id="wrap" class="wrapper">
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
        ">Created by Minseo (Hera) Kim<br>Site managed by Minseo (Hera) Kim</p>
        </div>
        <button class="user"><span id="userNm">Hera Kim</span><img id="userPicture" src="#" alt=""></button>
        <div class="userBox">
            <ul>
                <li><button type="button" onclick="location.href='/mailHistory';" class="logout">history</button></li>
                <li id="adminMenu" style="display:none;"><button type="button" onclick="location.href='/admin';" class="logout">admin mode</button></li>
                <li><button type="button" class="logout"  onclick="location.href='${pageContext.request.contextPath}/logout'">sign out</button></li>
            </ul>
        </div>
    </div>
    <div id="container" class="container">
        <div class="list">
            <ul>
                <li>
                    <div class="tit">Admin Course List</div>
                    <div class="sch">
                        <input type="text" id="adminSearch" placeholder="Search course">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <div class="tblBox col">
                        <table class="tbl green" id="adminTable">
                            <colgroup>
                                <col style="width:8%;">
                                <col style="width:31%;">
                                <col style="width:10%;">
                                <col style="width:11%;">
                                <col style="width:12%;">
                                <col style="width:12%;">
                                <col style="width:16%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Course Name</th>
                                <th>Period</th>
                                <th>Room</th>
                                <th>Student Count</th>
                                <th>Max Seats</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody id="courseListBody">
                            <!-- JS 렌더링 -->
                            </tbody>
                        </table>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>
    $(function () {
        loginChk();
        bindTableSearch("#adminSearch", "#courseListBody");
    });

    function loginChk() {
        $.ajax({
            url: "/student/me",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (user) {
                $("#userNm").text(user.name);
                $("#userPicture").attr("src", user.picture || "/assets/img/user.png");

                const adminEmails = [
                    "zachariah.fromme@sjajeju.kr",
                    "s22270836@sjajeju.kr",
                    "sja.adddrop.hera@gmail.com",
                    "jimho0419@gmail.com"
                ];

                // 🔹 admin 메뉴 노출 조건
                if (adminEmails.includes(user.google_email)) {
                    $("#adminMenu").show();
                }

                drawList();
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

    function drawList() {
        $.ajax({
            url: "/course/list",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {
                var $tbody = $("#courseListBody");
                $tbody.empty();

                if (!res || res.length === 0) {
                    $tbody.append(
                        "<tr>" +
                        "<td colspan='6' style='text-align:center;'>No data found.</td>" +
                        "</tr>"
                    );
                    return;
                }

                $.each(res, function (idx, course) {
                    var html = "";
                    html += "<tr id='row_" + course.course_seq + "' " +
                            "data-student='" + course.student_count + "' " +
                            "data-max='" + course.max_seats + "'>";

                    html += "  <td>" + (idx + 1) + "</td>";
                    html += "  <td><span class='display-mode'>" + course.course_name + "</span></td>";
                    html += "  <td><span class='display-mode'>" + course.period + "</span></td>";
                    html += "  <td><span class='display-mode'>" + (course.room || "-") + "</span></td>";

                    html += "  <td>";
                    html += "      <input type='number' class='ipt count-input' ";
                    html += "             value='" + course.student_count + "' readonly>";
                    html += "  </td>";

                    html += "  <td>";
                    html += "      <input type='number' class='ipt max-input' ";
                    html += "             value='" + course.max_seats + "' readonly>";
                    html += "  </td>";


                    html += "  <td>";
                    html += "      <button type='button' class='btn btn-edit' ";
                    html += "              onclick='enableEdit(" + course.course_seq + ")'>Edit</button>";
                    html += "      <button type='button' class='btn btn-save' style='display:none;' ";
                    html += "              onclick='saveRow(" + course.course_seq + ")'>Save</button>";
                    html += "      <button type='button' class='btn btn-cancel' style='display:none;' ";
                    html += "              onclick='cancelEdit(" + course.course_seq + ")'>Cancel</button>";
                    html += "  </td>";



                    html += "</tr>";

                    $tbody.append(html);
                });
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert("Please log in to continue.");
                    location.href = "/login";
                } else {
                    alert("Failed to load List. Please try again later.");
                }
            }
        });
    }

    function enableEdit(id) {
        var row = $("#row_" + id);

        row.find(".count-input, .max-input")
            .prop("readonly", false)
            .css("background-color", "#fff");

        row.find(".btn-edit").hide();
        row.find(".btn-save, .btn-cancel").show();
    }


    function cancelEdit(id) {
        var row = $("#row_" + id);

        // 원래 값으로 복구 (data-* 사용)
        row.find(".count-input").val(row.data("student"));
        row.find(".max-input").val(row.data("max"));

        row.find(".count-input, .max-input")
            .prop("readonly", true)
            .css("background-color", "#f5f5f5");

        row.find(".btn-save, .btn-cancel").hide();
        row.find(".btn-edit").show();
    }



    function saveRow(id) {
        var row = $("#row_" + id);

        var studentCount = Number(row.find(".count-input").val());
        var maxSeats = Number(row.find(".max-input").val());

        if (isNaN(studentCount) || isNaN(maxSeats)) {
            alert("Only numeric values are allowed.");
            return;
        }
        console.log(id,studentCount, maxSeats);
        if (!confirm("Do you want to update the capacity?")) return;

        $.ajax({
            url: "/course/update",
            type: "POST",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({
                course_seq: id,
                student_count: studentCount,
                max_seats: maxSeats
            }),
            xhrFields: { withCredentials: true },
            success: function () {
                alert("Capacity has been updated successfully.");

                // 기준값 갱신
                row.data("student", studentCount);
                row.data("max", maxSeats);

                row.find(".count-input, .max-input")
                    .prop("readonly", true)
                    .css("background-color", "#f5f5f5");

                row.find(".btn-save, .btn-cancel").hide();
                row.find(".btn-edit").show();
            },
            error: function () {
                alert("Failed to save changes. Please try again.");
            }
        });

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






</script>
</body>
</html>
