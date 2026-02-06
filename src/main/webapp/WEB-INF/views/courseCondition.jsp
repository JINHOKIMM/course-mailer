<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/common/head.jsp" %>

<body>
<div id="wrap" class="wrapper">

    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <!-- container -->
    <div id="container" class="container">
        <div class="list">
            <ul>
                <li>
                    <div class="tit">Course Conditions</div>
                    <div class="sch">
                        <input type="text" id="condSearch" placeholder="Search course">
                        <button type="button" class="btn-sch"></button>
                    </div>
                    <div class="tblBox col">
                        <table class="tbl green">
                            <colgroup>
                                <col style="width:30%">
                                <col style="width:15%">
                                <col style="width:55%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>Course</th>
                                <th>Grade</th>
                                <th>Prerequisites</th>
                            </tr>
                            </thead>
                            <tbody id="conditionBody">
                            </tbody>
                        </table>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <!-- //container -->
</div>

<style>
    .prereq-group {
        display: inline-block;
        background: #f0f4ff;
        border: 1px solid #c8d8f8;
        border-radius: 4px;
        padding: 2px 8px;
        margin: 2px 0;
        font-size: 13px;
    }
    .or-badge {
        display: inline-block;
        background: #E71825;
        color: #fff;
        border-radius: 3px;
        padding: 1px 5px;
        font-size: 11px;
        font-weight: bold;
        margin: 0 4px;
    }
    .prereq-cell {
        text-align: left !important;
        padding: 8px 12px !important;
    }
</style>

<script>
    $(function () {
        loginChk();
        loadConditions();
        bindTableSearch("#condSearch", "#conditionBody");
    });

    function loginChk() {
        $.ajax({
            url: "/student/me",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function (user) {
                $("#userNm").text(user.name);

                const adminEmails = [
                    "zachariah.fromme@sjajeju.kr",
                    "s22270836@sjajeju.kr",
                    "sja.adddrop.hera@gmail.com",
                    "jimho0419@gmail.com"
                ];
                if (adminEmails.includes(user.google_email)) {
                    $("#adminMenu").show();
                }
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    alert("Please log in to continue.");
                    location.href = "/login";
                } else {
                    alert("Failed to load user information.");
                    location.href = "/login";
                }
            }
        });
    }

    function loadConditions() {
        $.ajax({
            url: "/course/conditions",
            type: "GET",
            xhrFields: { withCredentials: true },
            success: function (res) {
                var gradeMap = {};
                var prereqMap = {};

                // 학년 조건 정리 (과목명 → "9th" / "10~12th")
                res.gradeConditions.forEach(function (g) {
                    gradeMap[g.target_course_name] =
                        g.min_grade === g.max_grade
                            ? g.min_grade + "th"
                            : g.min_grade + "~" + g.max_grade + "th";
                });

                // 선수과목 조건 정리 (과목명 → [group1, group2, ...])
                res.prerequisites.forEach(function (p) {
                    if (!prereqMap[p.target_course_name]) prereqMap[p.target_course_name] = [];
                    prereqMap[p.target_course_name].push(p.required_courses);
                });

                // 조건이 있는 과목 전체 (학년 + 선수과목 union)
                var courseSet = new Set([...Object.keys(gradeMap), ...Object.keys(prereqMap)]);
                var sortedCourses = [...courseSet].sort();

                var $tbody = $("#conditionBody");
                $tbody.empty();

                if (sortedCourses.length === 0) {
                    $tbody.append("<tr><td colspan='3' style='text-align:center;'>No conditions found.</td></tr>");
                    return;
                }

                sortedCourses.forEach(function (name) {
                    var gradeText = gradeMap[name] || "-";
                    var prereqHtml = "-";

                    if (prereqMap[name] && prereqMap[name].length > 0) {
                        prereqHtml = prereqMap[name]
                            .map(function (group) {
                                return '<span class="prereq-group">' + escapeHtml(group) + '</span>';
                            })
                            .join(' <span class="or-badge">OR</span> ');
                    }

                    $tbody.append(
                        "<tr>" +
                        "  <td class='tL'>" + escapeHtml(name) + "</td>" +
                        "  <td class='sub'>" + gradeText + "</td>" +
                        "  <td class='prereq-cell'>" + prereqHtml + "</td>" +
                        "</tr>"
                    );
                });
            },
            error: function () {
                alert("Failed to load course conditions.");
            }
        });
    }

    function bindTableSearch(inputSelector, tableBodySelector) {
        $(inputSelector).on("keyup", function () {
            var keyword = $(this).val().toLowerCase().trim();
            $(tableBodySelector).find("tr").each(function () {
                var courseName = $(this).find("td:first").text().toLowerCase();
                if (courseName.includes(keyword)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
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

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
