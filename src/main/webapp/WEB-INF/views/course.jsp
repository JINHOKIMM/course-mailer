<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Selection</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f4f6f8;
        }

        /* ===== Header ===== */
        .header {
            background-color: #0b2c4a;
            color: white;
            padding: 20px 40px;
            font-size: 22px;
            font-weight: bold;
        }

        /* ===== Layout ===== */
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .card h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 20px;
            border-left: 4px solid #0b2c4a;
            padding-left: 10px;
        }

        .course-list label {
            display: block;
            padding: 8px 0;
            cursor: pointer;
        }

        .course-list input {
            margin-right: 10px;
        }

        /* ===== Button ===== */
        .btn-area {
            text-align: right;
        }

        .btn-next {
            background-color: #0b2c4a;
            color: white;
            border: none;
            padding: 12px 28px;
            font-size: 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-next:hover {
            background-color: #093058;
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    세인트존스베리아카데미 제주
</div>

<div class="container">

    <!-- 이전 수강 과목 -->
    <div class="card">
        <h2>이전에 수강한 과목</h2>
        <div class="course-list" id="historyList"></div>
    </div>

    <!-- 다음 수강 과목 -->
    <div class="card">
        <h2>앞으로 수강할 과목</h2>
        <div class="course-list" id="nextList"></div>
    </div>

    <!-- 버튼 -->
    <div class="btn-area">
        <button class="btn-next" onclick="submitCourses()">다음</button>
    </div>

</div>

<script>
    let loginUser = null;

    // ======================
    // 로그인 사용자 정보 조회
    // ======================
    fetch("/student/me")
        .then(res => {
            if (!res.ok) {
                throw new Error("로그인 정보 조회 실패");
            }
            return res.json();
        })
        .then(data => {
            loginUser = data;
            console.log("로그인 사용자:", loginUser);

            // 예시
            // loginUser.email
            // loginUser.name
            // loginUser.sub (구글 고유 ID)
        })
        .catch(err => {
            console.error(err);
            alert("로그인이 필요합니다.");
            location.href = "/login";
        });
    /* ======================
       임시 데이터
    ====================== */
    const historyCourses = [
        { id: 1, name: "Java 기초" },
        { id: 2, name: "웹 프로그래밍 입문" },
        { id: 3, name: "데이터베이스 기본" }
    ];

    const nextCourses = [
        { id: 4, name: "Spring Boot" },
        { id: 5, name: "백엔드 심화 과정" },
        { id: 6, name: "클라우드 배포 실습" }
    ];

    /* ======================
       렌더링
    ====================== */
    function render(list, targetId, type) {
        const target = document.getElementById(targetId);
        list.forEach(c => {
            const label = document.createElement("label");
            label.innerHTML = `
            <input type="checkbox" data-type="${type}" value="${c.id}">
            ${c.name}
        `;
            target.appendChild(label);
        });
    }

    render(historyCourses, "historyList", "history");
    render(nextCourses, "nextList", "next");

    /* ======================
       REST 전송
    ====================== */
    function submitCourses() {
        const history = [...document.querySelectorAll('input[data-type="history"]:checked')]
            .map(e => Number(e.value));

        const next = [...document.querySelectorAll('input[data-type="next"]:checked')]
            .map(e => Number(e.value));

        const payload = {
            historyCourses: history,
            nextCourses: next
        };

        console.log("전송 데이터:", payload);

        // fetch("/api/courses", { ... })
        alert("다음 단계로 이동 (콘솔 확인)");


    }
</script>

</body>
</html>
